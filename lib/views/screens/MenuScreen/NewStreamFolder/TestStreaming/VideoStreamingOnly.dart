// ignore_for_file: use_build_context_synchronously

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
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';

import '../VideoPlayer/StreamingService.dart'; // for listEquals

class VideoStreamingOnly extends StatefulWidget {
  @override
  _VideoStreamingOnlyState createState() => _VideoStreamingOnlyState();
}

class _VideoStreamingOnlyState extends State<VideoStreamingOnly> {
  final String backendUrl = '${ApiConstants.baseUrl}/token/redis';
  final String videoChannelName = 'intial_frames';
  final Queue<Uint8List> framesQueue = Queue<Uint8List>();
  final Queue<String> videoQueue = Queue<String>();
  Timer? _fetchTimer;
  final int frameRate = 7; // Frames per second for video
  final int segmentDuration = 3; // Duration in seconds for each segment
  VideoPlayerController? _videoPlayerController;
  bool _isVideoReady = false;
  bool _isLoading = false;
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  bool isProcessing = false;
  Uint8List? lastFrameBytes;

  final StreamingService _streamingservice = StreamingService();
  Map<String, dynamic> matchEntity = {};
  String redisHost = '';
  int redisPort = 6380;
  var key = '3e0r-ghz0-v4uc-0rm6-d17s';
  String youtubeStreamUrl =
      'rtmp://a.rtmp.youtube.com/live2'; // Replace with your YouTube RTMP URL
  final FlutterFFmpegConfig _flutterFFmpegConfig = FlutterFFmpegConfig();

  // var frmstr =
  //     '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';
  Future<void> getStartMatch() async {
    try {
      final fetchedEntities = await _streamingservice.getStartMatch(14);
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
    getStartMatch();
    _startStreaming();
    requestPermissions();
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

  Future<void> requestPermissions() async {
    PermissionStatus status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      // Permissions are granted, proceed with accessing storage
      print("Granted");
    } else if (status.isDenied) {
      // Permissions are denied, show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage permission is required to pick videos'),
        ),
      );
    } else if (status.isPermanentlyDenied) {
      // Permissions are permanently denied, show a dialog guiding the user to settings
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Permission required'),
            content: const Text(
                'Storage permission is required to pick videos. Please enable it in the app settings.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Open Settings'),
                onPressed: () {
                  openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Cancel'),
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

  // Future<Directory> getCustomDirectory() async {
  //   Directory directory = Directory('/storage/emulated/0/cricyard');
  //   if (!await directory.exists()) {
  //     await directory.create(recursive: true);
  //     print('directory created..');
  //   }
  //   return directory;
  // }
  Future<Directory> getCustomDirectory() async {
    Directory directory = await getExternalStorageDirectory() ??
        await getApplicationDocumentsDirectory();
    directory = Directory('${directory.path}/cricyard');
    if (!await directory.exists()) {
      await directory.create(recursive: true);

      print('directory created..$directory');
    }
    return directory;
  }

  void _startStreaming() {
    _fetchFrames();
    _playVideosFromQueue();
    setState(() {});
  }

  Future<void> _stopStreaming() async {
    _fetchTimer?.cancel();
    setState(() {
      framesQueue.clear();
      videoQueue.clear();
    });

    // Kill the FFmpeg process to stop streaming
    await _flutterFFmpeg.cancel();
    print('Streaming stopped');
  }

  // Future<void> subscribeChannel() async {
  //   final videoResponse = await http.get(Uri.parse(
  //       '$backendUrl/subscribeAndStreamFrames?channelName=$videoChannelName&matchId=14'));

  //   // Show success message
  //   _showSuccessMessage('Successfully subscribed to audio and video channels');
  // }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _fetchFrames() {
    _fetchTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      try {
        final videoResponse = await http.get(Uri.parse(
            '$backendUrl/latest-message?channelName=$videoChannelName&matchId=14'));
        if (videoResponse.statusCode != 200 ||
            videoResponse.body == 'No message received yet') {
          print('error is ..No video message received yet');
          // subscribeChannel();
        } else if (videoResponse.statusCode == 200 &&
            videoResponse.body != 'No message received yet') {
          print('success is ..');
          Uint8List frameBytes = base64Decode(videoResponse.body);
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
          print('Error fetching frames: ${videoResponse.body}');
        }
      } catch (e) {
        print('Error fetching frames: $e');
      }
    });
  }

// Method to create the video segment
  Future<void> createNextVideoSegment(int framesNeeded) async {
    print('Creating next video segment from frames...');
    final Directory dir = await getCustomDirectory();
    final String framesDir = '${dir.path}/frames';
    await Directory(framesDir).create(recursive: true);

    final String youtubeframesDir = '${dir.path}/youtubeframes';
    await Directory(youtubeframesDir).create(recursive: true);

    List<Uint8List> framesToProcess = [];
    while (framesToProcess.length < framesNeeded && framesQueue.isNotEmpty) {
      framesToProcess.add(framesQueue.removeFirst());
    }

    for (int i = 0; i < framesToProcess.length; i++) {
      String framePath = '$framesDir/frame_$i.jpg';
      File(framePath).writeAsBytesSync(framesToProcess[i]);
    }
    for (int i = 0; i < framesToProcess.length; i++) {
      String framePath = '$youtubeframesDir/frame_$i.jpg';
      File(framePath).writeAsBytesSync(framesToProcess[i]);
    }
    final String segmentPath =
        '${dir.path}/segment_${DateTime.now().millisecondsSinceEpoch}.mp4';

    final String ffmpegCommand =
        '-framerate $frameRate -i $framesDir/frame_%d.jpg -c:v mpeg4 -q:v 5 -t $segmentDuration -vf "fps=$frameRate" $segmentPath';

    final String youtubesegmentPath =
        '${dir.path}/youtube_${DateTime.now().millisecondsSinceEpoch}.mp4'; // Change extension to .flv

    // final String ffmpegyouTubeCommand =
    //     '-framerate $frameRate -i $youtubeframesDir/frame_%d.jpg -c:v flv -q:v 5 -t $segmentDuration -vf "fps=$frameRate" $youtubesegmentPath';

    final String ffmpegyouTubeCommand =
        '-framerate $frameRate -i $youtubeframesDir/frame_%d.jpg -c:v mpeg4 -q:v 5 -t $segmentDuration -vf "fps=$frameRate" $youtubesegmentPath';

    await _flutterFFmpeg.execute(ffmpegyouTubeCommand).then((rc) async {
      print("FFmpeg process exited with rc $rc");
      if (rc == 0) {
        print('you  video segment created successfully at $youtubesegmentPath');

        await streamToYouTube(youtubesegmentPath);
      }
    });

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

  // Method to stream the video segment to YouTube

  Future<void> streamToYouTube(String segmentPath) async {
    // Construct the full RTMP URL
    final String fullRtmpUrl = '$youtubeStreamUrl/$key';
    print('Starting YouTube streaming with path: $segmentPath');

    // Ensure the input file exists
    if (!await File(segmentPath).exists()) {
      print('Input file does not exist: $segmentPath');
      return;
    }

    // Enable detailed FFmpeg logging
    _flutterFFmpegConfig.enableLogCallback((log) {
      print('FFmpeg log: ${log.message}');
    });
    _flutterFFmpegConfig.enableStatisticsCallback((statistics) {
      print('FFmpeg statistics: ${statistics.toString()}');
    });

    try {
      // Stream to YouTube
      final String ffmpegStreamCommand =
          '-re -i $segmentPath -f lavfi -t 1 -i anullsrc=channel_layout=stereo:sample_rate=44100 -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 50 -qmin 10 -qmax 51 -c:a aac -b:a 128k -ar 44100 -flvflags no_duration_filesize   -f flv $fullRtmpUrl';

      // Stream to YouTube
      // final String ffmpegStreamCommand =
      //     '-re -i $segmentPath -c:v copy -f flv $fullRtmpUrl';

      print(
          'Running FFmpeg command to stream to YouTube: $ffmpegStreamCommand');

      final int streamRc = await _flutterFFmpeg.execute(ffmpegStreamCommand);
      print("FFmpeg process for streaming exited with rc $streamRc");

      if (streamRc == 0) {
        print('Streaming to YouTube started successfully');
      } else {
        print('FFmpeg command to stream to YouTube failed with rc $streamRc');
        _showErrorMessage(
            'FFmpeg command to stream to YouTube failed with rc $streamRc');
      }
    } catch (error) {
      print('FFmpeg execution error: $error');
      _showErrorMessage('Streaming to YouTube failed: $error');
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

// Ensure you handle the error dialogs and success messages properly in your UI
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

  Future<void> _playNextVideo() async {
    if (videoQueue.isNotEmpty) {
      String nextVideoPath = videoQueue.removeFirst();
      // String nextVideoPath = videoQueue.first;

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
        title: Text('Video Stream'),
        leading: Row(
          children: [
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                _startStreaming();
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.perm_device_info_outlined),
            onPressed: () {
              requestPermissions();
            },
          ),
          IconButton(
            icon: Icon(Icons.stop_circle),
            onPressed: () {
              _stopStreaming();
            },
          ),
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
