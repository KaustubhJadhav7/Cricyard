import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cricyard/resources/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';

import 'StreamingService.dart';

class VideoCreatorWidget extends StatefulWidget {
  @override
  _VideoCreatorWidgetState createState() => _VideoCreatorWidgetState();
}

class _VideoCreatorWidgetState extends State<VideoCreatorWidget> {
  final String backendUrl = '${ApiConstants.baseUrl}';

  final String channelName = 'video_frames';
  Queue<Uint8List> framesQueue = Queue<Uint8List>();
  Timer? _fetchTimer;
  final int maxFramesToBuffer = 30;
  VideoPlayerController? _videoPlayerController;
  VideoPlayerController? _nextVideoPlayerController;
  bool _isVideoReady = false;
  bool _isLoading = false;
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  bool isProcessing = false;
  Uint8List? lastFrameBytes;
  String? nextVideoPath;

  final StreamingService _streamingservice = StreamingService();
  Map<String, dynamic> matchEntity = {};
  String redisHost = '';
  int redisPort = 6380;

  Future<void> getStartMatch() async {
    try {
      final fetchedEntities = await _streamingservice.getStartMatch(3);
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
  void dispose() {
    _fetchTimer?.cancel();
    super.dispose();
    _videoPlayerController?.dispose();
    _nextVideoPlayerController?.dispose();
    _stopStreaming();
  }

  void _startStreaming() {
    _fetchFrames();
    setState(() {});
  }

  void _stopStreaming() {
    _fetchTimer?.cancel();
    setState(() {
      framesQueue.clear();
    });
  }

  void _fetchFrames() {
    _fetchTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      try {
        final response = await http.get(Uri.parse(
            '$backendUrl/token/livestreaming/latest-frame?channelName=$channelName'));
        if (response.statusCode == 200) {
          Uint8List frameBytes = base64Decode(response.body);
          // Ensure the frame is not repeated
          if (lastFrameBytes == null ||
              !listEquals(lastFrameBytes, frameBytes)) {
            setState(() {
              framesQueue.addLast(frameBytes);
              lastFrameBytes = frameBytes;
            });
            print('frame length...${framesQueue.length}');
          }

          if (framesQueue.length >= maxFramesToBuffer && !isProcessing) {
            isProcessing = true;
            _isLoading = true;
            createNextVideo();
          }
        } else {
          print('Error fetching frames: ${response.body}');
        }
      } catch (e) {
        print('Error fetching frames: $e');
      }
    });
  }

  Future<void> createNextVideo() async {
    print('Creating next video from frames...');
    final Directory dir = await getTemporaryDirectory();
    final String framesDir = '${dir.path}/frames';
    await Directory(framesDir).create(recursive: true);

    List<Uint8List> framesToProcess = [];
    while (
        framesToProcess.length < maxFramesToBuffer && framesQueue.isNotEmpty) {
      framesToProcess.add(framesQueue.removeFirst());
    }

    for (int i = 0; i < framesToProcess.length; i++) {
      String framePath = '$framesDir/frame_$i.jpg';
      File(framePath).writeAsBytesSync(framesToProcess[i]);
    }

    final String videoPath =
        '${dir.path}/output_video_${DateTime.now().millisecondsSinceEpoch}.mp4';
    final String ffmpegCommand =
        '-framerate 7 -i $framesDir/frame_%d.jpg -c:v mpeg4 -q:v 5 -vf "fps=7" $videoPath';

    print('Running FFmpeg command: $ffmpegCommand');
    await _flutterFFmpeg.execute(ffmpegCommand).then((rc) async {
      print("FFmpeg process exited with rc $rc");
      if (rc == 0) {
        print('Next video created successfully at $videoPath');
        setState(() {
          nextVideoPath = videoPath;
          _isLoading = false;
        });
        if (_videoPlayerController == null ||
            !_videoPlayerController!.value.isInitialized) {
          await playNextVideo();
        } else {
          await preloadNextVideo();
        }
        isProcessing = false;
      } else {
        print('FFmpeg command failed with rc $rc');
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Future<void> preloadNextVideo() async {
    if (nextVideoPath != null) {
      if (_nextVideoPlayerController != null) {
        await _nextVideoPlayerController!.dispose();
      }
      _nextVideoPlayerController =
          VideoPlayerController.file(File(nextVideoPath!));
      await _nextVideoPlayerController!.initialize();
      _nextVideoPlayerController!.setLooping(false);
      setState(() {});
    }
  }

  Future<void> playNextVideo() async {
    if (nextVideoPath != null) {
      if (_videoPlayerController != null) {
        await _videoPlayerController!.dispose();
      }
      _videoPlayerController = VideoPlayerController.file(File(nextVideoPath!));
      await _videoPlayerController!.initialize();
      _videoPlayerController!.setLooping(false);
      _videoPlayerController!.play();
      _videoPlayerController!.addListener(_videoListener);
      setState(() {
        _isVideoReady = true;
      });
    }
  }

  void _videoListener() async {
    if (_videoPlayerController != null &&
        _videoPlayerController!.value.position >=
            _videoPlayerController!.value.duration) {
      _videoPlayerController!.removeListener(_videoListener);
      await playNextVideo();
      if (framesQueue.length >= maxFramesToBuffer && !isProcessing) {
        isProcessing = true;
        _isLoading = true;
        createNextVideo();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player Example'),
        leading: IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {
            _startStreaming();
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio:
                  16 / 9, // Define a fixed aspect ratio for the video area
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_isVideoReady &&
                      _videoPlayerController != null &&
                      _videoPlayerController!.value.isInitialized)
                    VideoPlayer(_videoPlayerController!),
                  if (_isLoading)
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    _videoPlayerController!.play();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () {
                    _videoPlayerController!.pause();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () {
                    _videoPlayerController!.seekTo(Duration.zero);
                    _videoPlayerController!.pause();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
