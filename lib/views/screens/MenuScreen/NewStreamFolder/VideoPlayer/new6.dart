import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:cricyard/resources/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart'; // for listEquals

class VideoCreatorWidget6 extends StatefulWidget {
  @override
  _VideoCreatorWidget6State createState() => _VideoCreatorWidget6State();
}

class _VideoCreatorWidget6State extends State<VideoCreatorWidget6> {
  final String backendUrl =
      '${ApiConstants.baseUrl}/token/livestreaming/latest-frame';
  final String channelName = 'video_frames';
  final Queue<Uint8List> framesQueue = Queue<Uint8List>();
  final Queue<String> videoQueue = Queue<String>();
  Timer? _fetchTimer;
  final int frameRate = 5; // Frames per second for video
  final int segmentDuration = 3; // Duration in seconds for each segment
  VideoPlayerController? _videoPlayerController;
  bool _isVideoReady = false;
  bool _isLoading = false;
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  bool isProcessing = false;
  Uint8List? lastFrameBytes;

  @override
  void initState() {
    super.initState();
    _startStreaming();
  }

  @override
  void dispose() {
    _fetchTimer?.cancel();
    _videoPlayerController?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]); // Reset to portrait when disposing
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
        final response = await http
            .get(Uri.parse('$backendUrl?channelName=$channelName&matchId=2'));
        if (response.statusCode == 200) {
          Uint8List frameBytes = base64Decode(response.body);
          // Ensure the frame is not repeated
          if (lastFrameBytes == null ||
              !listEquals(lastFrameBytes, frameBytes)) {
            setState(() {
              framesQueue.addLast(frameBytes);
              lastFrameBytes = frameBytes;
            });
            print('Frame length: ${framesQueue.length}');
          }

          int framesNeeded = frameRate * segmentDuration;
          if (framesQueue.length >= framesNeeded && !isProcessing) {
            isProcessing = true;
            createNextVideoSegment(framesNeeded);
          }
        } else {
          print('Error fetching frames: ${response.body}');
        }
      } catch (e) {
        print('Error fetching frames: $e');
      }
    });
  }

  Future<void> createNextVideoSegment(int framesNeeded) async {
    print('Creating next video segment from frames...');
    final Directory dir = await getTemporaryDirectory();
    final String framesDir = '${dir.path}/frames';
    await Directory(framesDir).create(recursive: true);

    List<Uint8List> framesToProcess = [];
    while (framesToProcess.length < framesNeeded && framesQueue.isNotEmpty) {
      framesToProcess.add(framesQueue.removeFirst());
    }

    for (int i = 0; i < framesToProcess.length; i++) {
      String framePath = '$framesDir/frame_$i.jpg';
      File(framePath).writeAsBytesSync(framesToProcess[i]);
    }

    final String segmentPath =
        '${dir.path}/segment_${DateTime.now().millisecondsSinceEpoch}.mp4';
    final String ffmpegCommand =
        '-framerate $frameRate -i $framesDir/frame_%d.jpg -c:v mpeg4 -q:v 5 -t $segmentDuration -vf "fps=$frameRate" $segmentPath';

    print('Running FFmpeg command: $ffmpegCommand');
    await _flutterFFmpeg.execute(ffmpegCommand).then((rc) async {
      print("FFmpeg process exited with rc $rc");
      if (rc == 0) {
        print('Next video segment created successfully at $segmentPath');
        setState(() {
          videoQueue.add(segmentPath);
        });
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
      print("Playing next video: $nextVideoPath");
      if (_videoPlayerController != null) {
        await _videoPlayerController!.dispose();
      }
      _videoPlayerController = VideoPlayerController.file(File(nextVideoPath));
      await _videoPlayerController!.initialize();
      _videoPlayerController!.setLooping(false);

      setState(() {
        _isVideoReady = true;
      });

      _videoPlayerController!.play();
      _videoPlayerController!.addListener(_videoEndListener);
    } else {
      setState(() {
        _isVideoReady = false;
      });
      await Future.delayed(const Duration(milliseconds: 100));
      _playNextVideo();
    }
  }

  void _videoEndListener() async {
    if (_videoPlayerController != null &&
        _videoPlayerController!.value.position >=
            _videoPlayerController!.value.duration) {
      print("Video segment ended. Playing next segment...");
      _videoPlayerController!.removeListener(_videoEndListener);
      _playNextVideo();
    }
  }

  void _playVideosFromQueue() async {
    if (_videoPlayerController == null ||
        !_videoPlayerController!.value.isInitialized) {
      await _playNextVideo();
    }
  }

  void _toggleFullScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoPlayer(_videoPlayerController!),
      ),
    );
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
        actions: [
          IconButton(
            icon: Icon(Icons.fullscreen),
            onPressed: _toggleFullScreen,
          ),
        ],
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
                    _videoPlayerController?.play();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () {
                    _videoPlayerController?.pause();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () {
                    _videoPlayerController?.seekTo(Duration.zero);
                    _videoPlayerController?.pause();
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

class FullScreenVideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  FullScreenVideoPlayer(this.videoPlayerController);

  @override
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  @override
  void initState() {
    super.initState();
    // Set preferred orientations to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    // Hide system UI for full-screen experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Reset preferred orientations and show system UI when exiting full-screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    // Dispose VideoPlayerController
    widget.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.screen_rotation_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: widget.videoPlayerController.value.isInitialized &&
                  widget.videoPlayerController.value.isPlaying
              ? VideoPlayer(widget.videoPlayerController)
              : Container(),
        ),
      ),
    );
  }
}
