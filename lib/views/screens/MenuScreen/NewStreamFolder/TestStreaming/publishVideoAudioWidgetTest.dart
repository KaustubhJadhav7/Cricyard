// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../resources/api_constants.dart';
import '../VideoPlayer/StreamingService.dart';

class PublishVideoAudioWidgetTest extends StatefulWidget {
  final int matchId;

  PublishVideoAudioWidgetTest({super.key, required this.matchId});

  @override
  _PublishVideoAudioWidgetTestState createState() =>
      _PublishVideoAudioWidgetTestState();
}

class _PublishVideoAudioWidgetTestState
    extends State<PublishVideoAudioWidgetTest> {
  final String backendUrl = '${ApiConstants.baseUrl}/token';

  final StreamingService _streamingService = StreamingService();
  Map<String, dynamic> matchEntity = {};

  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  bool _ismicrophoneInitialized = false;
  final String videoChannelName = 'intial_frames';
  final String audioChannelName = 'audio_frames';
  bool _isConnectedToRedis = false;
  Timer? _videoTimer;
  Timer? _audioTimer;
  String redisHost = '';
  int redisPort = 6379;
  bool _isStreaming = false;

  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  Directory? _tempDir;
  int _audioCounter = 0;
  int audiotime = 3;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    // getStartMatch().then((_) => _connectToRedis());
    _initializeCamera();
    _initializeAudioRecorder();
  }

  Future<void> getData() async {
    getStartMatch().then((_) => _connectToRedis());
    _requestPermissions().then((_) {
      _initializeCamera();
      _initializeAudioRecorder();
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _videoTimer?.cancel();
    _audioTimer?.cancel();
    _stopStreaming();
    _audioRecorder.closeRecorder();
    super.dispose();
  }

  Future<void> startWorkflow() async {
    print('start workflow..');
    try {
      final fetchedEntities =
          await _streamingService.startWorkflow(widget.matchId);
      print("last rec --$fetchedEntities");
      if (fetchedEntities != null && fetchedEntities.isNotEmpty) {
        print('workflow start..............\n\n\n\n');

        getStartMatch();
      }
    } catch (e) {
      _showErrorDialog('Failed to fetch: $e');
    }
  }

  Future<void> getStartMatch() async {
    try {
      final fetchedEntities =
          await _streamingService.getStartMatch(widget.matchId);
      print("last rec --$fetchedEntities");
      if (fetchedEntities != null && fetchedEntities.isNotEmpty) {
        setState(() {
          matchEntity = fetchedEntities;
          redisHost = matchEntity['farm_ip'];
          redisPort = matchEntity['container_port'];
        });
      }
    } catch (e) {
      _showErrorDialog('Failed to fetch: $e');
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);

    try {
      await _cameraController.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
    ].request();
  }
  // Future<void> _requestPermissions() async {
  //   var status = await Permission.camera.status;
  //   if (!status.isGranted) {
  //     await Permission.camera.request();
  //   }

  //   status = await Permission.microphone.status;
  //   if (!status.isGranted) {
  //     await Permission.microphone.request();
  //   }
  // }

  Future<void> _connectToRedis() async {
    print('click connect redis.. hostName=$redisHost&portNumber=$redisPort');
    final response = await http.get(Uri.parse(
        '$backendUrl/subscribe1?hostName=$redisHost&portNumber=$redisPort'));
    if (response.statusCode == 200 && response.body == 'connected') {
      setState(() {
        _isConnectedToRedis = true;
      });
      _showSnackBar('Connected to Redis', Colors.green);

      print('Connected to Redis');
    } else {
      getStartMatch();
      _showSnackBar('Error connecting to Redis: ${response.body}', Colors.red);

      print('Error connecting to Redis: ${response.body}');
    }
  }

  Future<void> _initializeAudioRecorder() async {
    await _audioRecorder.openRecorder();
    await Permission.microphone.request();
    _tempDir = await getTemporaryDirectory();
    setState(() {
      _ismicrophoneInitialized = true;
    });
  }

  void _startStreaming() {
    if (_isCameraInitialized &&
        _ismicrophoneInitialized &&
        _isConnectedToRedis) {
      _showSnackBar(
          'Publishing  audio And Video frame successfully', Colors.green);

      // Start capturing video frames
      _videoTimer =
          Timer.periodic(const Duration(milliseconds: 100), (timer) async {
        await _captureAndPublishVideoFrame();
      });

      // Start capturing audio frames
      _audioTimer = Timer.periodic(Duration(seconds: audiotime), (timer) async {
        await _captureAndPublishAudioFrame();
      });

      setState(() {
        _isStreaming = true;
      });
    } else {
      if (!_isCameraInitialized) {
        _initializeCamera();
        print('Camera not initialized or Redis not connected');
      }
      if (!_ismicrophoneInitialized) {
        _initializeAudioRecorder();

        print('microphone not initialized ');
      }
      if (!_isConnectedToRedis) {
        _connectToRedis();

        print(' Redis not connected');
      }
    }
  }

  void _stopStreaming() {
    _videoTimer?.cancel();
    _audioTimer?.cancel();
    _audioRecorder.stopRecorder();
    print('Stopped streaming');
    setState(() {
      _isStreaming = false;
    });
  }

  Future<void> _captureAndPublishVideoFrame() async {
    try {
      final XFile? picture = await _cameraController.takePicture();
      if (picture != null) {
        Uint8List videoData = await picture.readAsBytes();
        await _publishVideoData(videoData);
      }
    } catch (e) {
      print('Error capturing video frame: $e');
    }
  }

  Future<void> _captureAndPublishAudioFrame() async {
    try {
      _audioCounter++;
      String audioFilePath =
          '${_tempDir!.path}/audio_record_$_audioCounter.aac';
      await _audioRecorder.startRecorder(
        toFile: audioFilePath,
        codec: Codec.aacADTS,
      );

      // Capture audio for a short duration (e.g., 2 seconds)
      await Future.delayed(Duration(seconds: audiotime));
      await _audioRecorder.stopRecorder();

      File audioFile = File(audioFilePath);
      if (await audioFile.exists()) {
        Uint8List audioData = await audioFile.readAsBytes();
        if (audioData.isNotEmpty) {
          await _publishAudioData(audioData);
        }
        audioFile.deleteSync(); // Clear the file after reading
      }
    } catch (e) {
      print('Error capturing audio frame: $e');
    }
  }

  Future<void> _publishAudioData(Uint8List audioData) async {
    String base64AudioData = base64Encode(audioData);
    try {
      final response = await http.post(
        Uri.parse(
            '$backendUrl/livestreaming/publishMessage?matchId=${widget.matchId}'),
        headers: {'Content-Type': 'application/json'},
        body:
            jsonEncode({'channel': audioChannelName, 'data': base64AudioData}),
      );
      if (response.statusCode == 200) {
        // _showSnackBar('Published audio frame successfully', Colors.green);

        print('Published audio frames to Redis');
      } else {
        _showSnackBar('Error publishing audio data to Redis: ${response.body}',
            Colors.red);

        print('Error publishing audio data to Redis: ${response.body}');
      }
    } catch (e) {
      _showSnackBar('Error publishing audio data to Redis: $e', Colors.red);

      print('Error publishing audio data to Redis: $e');
    }
  }

  Future<void> _publishVideoData(Uint8List videoData) async {
    String base64VideoData = base64Encode(videoData);
    try {
      final response = await http.post(
        Uri.parse(
            '$backendUrl/livestreaming/publishMessage?matchId=${widget.matchId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'channel': videoChannelName,
          'data': base64VideoData,
        }),
      );
      if (response.statusCode == 200) {
        // _showSnackBar('Published video frame successfully', Colors.green);

        print('Published video frames to Redis');
      } else {
        _showSnackBar('Error publishing video data to Redis: ${response.body}',
            Colors.red);

        print('Error publishing video data to Redis: ${response.body}');
      }
    } catch (e) {
      _showSnackBar('Error publishing video data to Redis: $e', Colors.red);

      print('Error publishing video data to Redis: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message, style: const TextStyle(color: Colors.black)),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: _isFullscreen
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color(0xFF219ebc),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              title: Text(
                "Video Audio Stream",
                style: GoogleFonts.getFont('Roboto',
                    fontSize: 20, color: Colors.black),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.get_app),
                  onPressed: () {
                    getData();
                  },
                ),
                const SizedBox(height: 10),
                IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () {
                    startWorkflow();
                  },
                ),
              ],
            ),
      body: Center(
        child: Column(
          children: [
            _cameraPreviewWidget(),
            if (!_isFullscreen) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _connectToRedis,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Text(
                  'Connect to Redis',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
      floatingActionButton: _isFullscreen
          ? null
          : FloatingActionButton(
              onPressed: _isStreaming ? _stopStreaming : _startStreaming,
              backgroundColor: Colors.red,
              child: Icon(_isStreaming ? Icons.stop : Icons.play_arrow),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
      if (_isFullscreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft
        ]);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
    });
  }

  Widget _cameraPreviewWidget() {
    return Stack(
      children: [
        Container(
          height: _isFullscreen
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.height * 0.3,
          width: _isFullscreen
              ? MediaQuery.of(context).size.width
              : double.infinity,
          color: Colors.black,
          child: CameraPreview(_cameraController),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: IconButton(
            icon: Icon(
              _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
              color: Colors.white,
            ),
            onPressed: _toggleFullscreen,
          ),
        ),
      ],
    );
  }
}
