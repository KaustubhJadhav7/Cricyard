import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cricyard/resources/api_constants.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart'; // for listEquals

class VideoCreatorWidget2 extends StatefulWidget {
  @override
  _VideoCreatorWidget2State createState() => _VideoCreatorWidget2State();
}

class _VideoCreatorWidget2State extends State<VideoCreatorWidget2> {
  final String backendUrl =
      '${ApiConstants.baseUrl}/token/livestreaming/latest-frame';
  final String channelName = 'video_frames';
  final Queue<Uint8List> framesQueue = Queue<Uint8List>();
  final Queue<String> videoQueue = Queue<String>();
  Timer? _fetchTimer;
  final int maxFramesToBuffer = 30;
  VideoPlayerController? _videoPlayerController;
  bool _isVideoReady = false;
  bool _isLoading = false;
  // final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  bool isProcessing = false;
  Uint8List? lastFrameBytes;

  @override
  void dispose() {
    _fetchTimer?.cancel();
    super.dispose();
    _videoPlayerController?.dispose();
    _stopStreaming();
  }

  void _startStreaming() {
    _fetchFrames();
    _playVideosFromQueue();
    setState(() {});
  }

  void _stopStreaming() {
    _fetchTimer?.cancel();
    setState(() {
      framesQueue.clear();
      videoQueue.clear();
    });
  }

  void _fetchFrames() {
    _fetchTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      try {
        final response =
            await http.get(Uri.parse('$backendUrl?channelName=$channelName'));
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
        '-framerate 2 -i $framesDir/frame_%d.jpg -c:v mpeg4 -q:v 5 -vf "fps=2" $videoPath';

    print('Running FFmpeg command: $ffmpegCommand');
    await FFmpegKit.execute(ffmpegCommand).then((rc) async {
      print("FFmpeg process exited with rc $rc");
      if (rc == 0) {
        print('Next video created successfully at $videoPath');
        setState(() {
          videoQueue.add(videoPath);
        });
      } else {
        print('FFmpeg command failed with rc $rc');
      }
      setState(() {
        isProcessing = false;
      });
    });
  }

  void _playVideosFromQueue() async {
    while (true) {
      if (videoQueue.isNotEmpty) {
        String nextVideoPath = videoQueue.removeFirst();
        if (_videoPlayerController != null) {
          await _videoPlayerController!.dispose();
        }
        _videoPlayerController =
            VideoPlayerController.file(File(nextVideoPath));
        await _videoPlayerController!.initialize();
        _videoPlayerController!.setLooping(false);
        _videoPlayerController!.play();
        setState(() {
          _isVideoReady = true;
        });
        _videoPlayerController!.addListener(() async {
          if (_videoPlayerController != null &&
              _videoPlayerController!.value.position >=
                  _videoPlayerController!.value.duration) {
            _videoPlayerController!.removeListener(() {});
            _playVideosFromQueue();
          }
        });
        break;
      } else {
        setState(() {
          _isVideoReady = false;
        });
        await Future.delayed(const Duration(milliseconds: 100));
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
                  if (!_isVideoReady)
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
