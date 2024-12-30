// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import '../../../../../resources/api_constants.dart';
import 'StreamingService.dart';

class VideoAudioStreamWidget extends StatefulWidget {
  var matchId;

  VideoAudioStreamWidget({super.key, required this.matchId});

  @override
  _VideoAudioStreamWidgetState createState() => _VideoAudioStreamWidgetState();
}

class _VideoAudioStreamWidgetState extends State<VideoAudioStreamWidget> {
  final String backendUrl = '${ApiConstants.baseUrl}/token';

  final StreamingService _streamingservice = StreamingService();
  Map<String, dynamic> matchEntity = {};

  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  bool _isConnectedToRedis = false;
  Timer? _frameTimer;
  // final String redisHost = '3.6.250.12';
  // final int redisPort = 6380;
  String redisHost = '';
  int redisPort = 6380;
  bool _isStreaming = false;

  Future<void> getStartMatch() async {
    try {
      final fetchedEntities =
          await _streamingservice.getStartMatch(widget.matchId);
      print("last rec --$fetchedEntities");
      if (fetchedEntities != null && fetchedEntities.isNotEmpty) {
        setState(() {
          matchEntity = fetchedEntities;
          redisHost = matchEntity['farm_ip'];
          redisPort = matchEntity['container_port'];
        });
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
              'Failed to fetch : $e',
              style: const TextStyle(color: Colors.black),
            ),
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
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _connectToRedis();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _frameTimer?.cancel();
    _stopStreaming();
    super.dispose();
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

  Future<void> _connectToRedis() async {
    print('click conncet redis..');
    final response = await http.get(Uri.parse(
        '$backendUrl/subscribe1?hostName=$redisHost&portNumber=$redisPort'));
    if (response.statusCode == 200 && response.body == 'connected') {
      setState(() {
        _isConnectedToRedis = true;
      });
      print('Connected to Redis');
    } else {
      print('Error connecting to Redis: ${response.body}');
    }
  }

  // void _startStreaming() {
  //   if (_isCameraInitialized && _isConnectedToRedis) {
  //     _frameTimer = Timer.periodic(Duration(milliseconds: 100), (timer) async {
  //       try {
  //         final XFile? picture = await _cameraController.takePicture();
  //         if (picture != null) {
  //           Uint8List videoData = await picture.readAsBytes();
  //           _publishData(videoData);
  //         }
  //       } catch (e) {
  //         print('Error capturing frame: $e');
  //       }
  //     });
  //   } else {
  //     print('Camera not initialized or Redis not connected');
  //   }
  // }

  void _startStreaming() {
    if (_isCameraInitialized && _isConnectedToRedis) {
      _frameTimer = Timer.periodic(Duration(milliseconds: 100), (timer) async {
        try {
          final XFile? picture = await _cameraController.takePicture();
          if (picture != null) {
            Uint8List videoData = await picture.readAsBytes();
            await _publishData(videoData);
          }
        } catch (e) {
          print('Error capturing frame: $e');
          // timer.cancel(); // Stop the timer to prevent further capture attempts
        }
      });
    } else {
      print('Camera not initialized or Redis not connected');
    }
    setState(() {
      _isStreaming = true;
    });
  }

  void _stopStreaming() {
    _frameTimer?.cancel();
    print('Stopped streaming');
    setState(() {
      _isStreaming = false;
    });
  }

  Future<void> _publishData(Uint8List videoData) async {
    String videoBase64 = base64Encode(videoData);
    try {
      final response = await http.post(
        Uri.parse('$backendUrl/publish'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'channel': 'video_frames', 'data': videoBase64}),
      );
      if (response.statusCode == 200) {
        print('Published frame to Redis');
      } else {
        print('Error publishing data to Redis: ${response.body}');
      }
    } catch (e) {
      print('Error publishing data to Redis: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Audio Stream'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _cameraPreviewWidget(),
            ElevatedButton(
              onPressed: _connectToRedis,
              child: const Text(
                'Connect to Redis',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // ElevatedButton(
            //   onPressed: _startStreaming,
            //   child: const Text(
            //     'Start Streaming',
            //     style: TextStyle(color: Colors.black),
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // ElevatedButton(
            //   onPressed: _stopStreaming,
            //   child: const Text(
            //     'Stop Streaming',
            //     style: TextStyle(color: Colors.black),
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isStreaming ? _stopStreaming : _startStreaming,
        child: Icon(_isStreaming ? Icons.stop : Icons.play_arrow),
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    return SizedBox(
      width: 300,
      height: 300,
      child: _isCameraInitialized
          ? CameraPreview(_cameraController)
          : CircularProgressIndicator(),
    );
  }
}
