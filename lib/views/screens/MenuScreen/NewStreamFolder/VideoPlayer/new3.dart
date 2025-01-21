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

class VideoCreatorWidget3 extends StatefulWidget {
  @override
  _VideoCreatorWidget3State createState() => _VideoCreatorWidget3State();
}

class _VideoCreatorWidget3State extends State<VideoCreatorWidget3> {
  final String backendUrl =
      '${ApiConstants.baseUrl}/token/livestreaming/latest-frame';
  final String channelName = 'video_frames';
  final Queue<Uint8List> framesQueue = Queue<Uint8List>();
  final Queue<String> videoQueue = Queue<String>();
  Timer? _fetchTimer;
  final int maxFramesToBuffer = 30;
  // final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  bool isProcessing = false;
  Uint8List? lastFrameBytes;

  VideoPlayerController? _videoPlayerController1;
  VideoPlayerController? _videoPlayerController2;
  bool useFirstPlayer = true;
  bool _isVideoReady = false;

  @override
  void dispose() {
    _fetchTimer?.cancel();
    _videoPlayerController1?.dispose();
    _videoPlayerController2?.dispose();
    super.dispose();
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
        '-framerate 7 -i $framesDir/frame_%d.jpg -c:v mpeg4 -q:v 5 -vf "fps=7" $videoPath';

    print('Running FFmpeg command: $ffmpegCommand');
    await FFmpegKit.execute(ffmpegCommand).then((rc) async {
      print("FFmpeg process exited with rc $rc");
      if (rc == 0) {
        print('Next video created successfully at $videoPath');
        setState(() {
          videoQueue.add(videoPath);
        });
        if (_videoPlayerController1 == null &&
            _videoPlayerController2 == null) {
          await _playNextVideo();
        }
      } else {
        print('FFmpeg command failed with rc $rc');
      }
      setState(() {
        isProcessing = false;
      });
    });
  }

  Future<void> _playNextVideo() async {
    if (videoQueue.isNotEmpty) {
      String nextVideoPath = videoQueue.removeFirst();

      if (useFirstPlayer) {
        if (_videoPlayerController1 != null) {
          await _videoPlayerController1!.dispose();
        }
        _videoPlayerController1 =
            VideoPlayerController.file(File(nextVideoPath));
        await _videoPlayerController1!.initialize();
        _videoPlayerController1!.setLooping(false);
        _videoPlayerController1!.play();
        setState(() {
          _isVideoReady = true;
        });
        _videoPlayerController1!.addListener(() async {
          if (_videoPlayerController1 != null &&
              _videoPlayerController1!.value.position >=
                  _videoPlayerController1!.value.duration) {
            _videoPlayerController1!.removeListener(() {});
            await _playNextVideo();
          }
        });
      } else {
        if (_videoPlayerController2 != null) {
          await _videoPlayerController2!.dispose();
        }
        _videoPlayerController2 =
            VideoPlayerController.file(File(nextVideoPath));
        await _videoPlayerController2!.initialize();
        _videoPlayerController2!.setLooping(false);
        _videoPlayerController2!.play();
        setState(() {
          _isVideoReady = true;
        });
        _videoPlayerController2!.addListener(() async {
          if (_videoPlayerController2 != null &&
              _videoPlayerController2!.value.position >=
                  _videoPlayerController2!.value.duration) {
            _videoPlayerController2!.removeListener(() {});
            await _playNextVideo();
          }
        });
      }

      useFirstPlayer = !useFirstPlayer;
    } else {
      setState(() {
        _isVideoReady = false;
      });
      await Future.delayed(const Duration(milliseconds: 100));
      _playVideosFromQueue();
    }
  }

  void _playVideosFromQueue() async {
    if (_videoPlayerController1 == null ||
        !_videoPlayerController1!.value.isInitialized) {
      await _playNextVideo();
    } else {
      _videoPlayerController1!.addListener(() async {
        if (_videoPlayerController1!.value.position >=
            _videoPlayerController1!.value.duration) {
          _videoPlayerController1!.removeListener(() {});
          await _playNextVideo();
        }
      });
    }

    if (_videoPlayerController2 == null ||
        !_videoPlayerController2!.value.isInitialized) {
      await _playNextVideo();
    } else {
      _videoPlayerController2!.addListener(() async {
        if (_videoPlayerController2!.value.position >=
            _videoPlayerController2!.value.duration) {
          _videoPlayerController2!.removeListener(() {});
          await _playNextVideo();
        }
      });
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
                      ((_videoPlayerController1 != null &&
                              _videoPlayerController1!.value.isInitialized) ||
                          (_videoPlayerController2 != null &&
                              _videoPlayerController2!.value.isInitialized)))
                    useFirstPlayer &&
                            _videoPlayerController1 != null &&
                            _videoPlayerController1!.value.isInitialized
                        ? VideoPlayer(_videoPlayerController1!)
                        : _videoPlayerController2 != null &&
                                _videoPlayerController2!.value.isInitialized
                            ? VideoPlayer(_videoPlayerController2!)
                            : Container(),
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
                    if (useFirstPlayer) {
                      _videoPlayerController1?.play();
                    } else {
                      _videoPlayerController2?.play();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () {
                    if (useFirstPlayer) {
                      _videoPlayerController1?.pause();
                    } else {
                      _videoPlayerController2?.pause();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () {
                    if (useFirstPlayer) {
                      _videoPlayerController1?.seekTo(Duration.zero);
                      _videoPlayerController1?.pause();
                    } else {
                      _videoPlayerController2?.seekTo(Duration.zero);
                      _videoPlayerController2?.pause();
                    }
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
