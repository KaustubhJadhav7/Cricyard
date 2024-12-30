import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../../resources/api_constants.dart';
import '../VideoPlayer/StreamingService.dart';

class StreamVideoWidgetTest extends StatefulWidget {
  final int matchId;

  StreamVideoWidgetTest({super.key, required this.matchId});

  @override
  _StreamVideoWidgetTestState createState() => _StreamVideoWidgetTestState();
}

class _StreamVideoWidgetTestState extends State<StreamVideoWidgetTest> {
  final String backendUrl = '${ApiConstants.baseUrl}/token/redis';
  final String videoChannelName = 'intial_frames';
  final String audioChannelName = 'audio_frames';
  final Queue<Uint8List> framesQueue = Queue<Uint8List>();
  final Queue<String> videoQueue = Queue<String>();
  Timer? _fetchFramesTimer;
  final int frameRate = 24; // Frames per second for video
  final int segmentDuration = 3; // Duration in seconds for each segment
  VideoPlayerController? _videoPlayerController;
  bool _isVideoReady = false;
  bool _isLoading = false;
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  bool isProcessing = false;
  Uint8List? lastFrameBytes;

  var audioRes = '';
  var videoRes = '';

  final StreamingService _streamingservice = StreamingService();
  Map<String, dynamic> matchEntity = {};
  String redisHost = '';
  int redisPort = 6380;
  var key = '3e0r-ghz0-v4uc-0rm6-d17s';
  String youtubeStreamUrl =
      'rtmp://a.rtmp.youtube.com/live2'; // Replace with your YouTube RTMP URL
  // Future<void> subscribeChannel() async {
  //   subscribeVideoChannel();
  //   subscribeAudioChannel();
  //   // Show success message
  //   _showSuccessMessage('Successfully subscribed video And Audio channels');
  // }

  // Future<void> subscribeVideoChannel() async {
  //   final videoResponse = await http.get(Uri.parse(
  //       '$backendUrl/subscribeAndStreamFrames?channelName=$videoChannelName&matchId=$matchId'));
  //   if (videoResponse.statusCode <= 209) {
  //     videoRes = videoResponse.body;
  //   }
  //   // Show success message
  //   _showSuccessMessage(' Subscribed video channels again');
  // }

  // Future<void> subscribeAudioChannel() async {
  //   final audioResponse = await http.get(Uri.parse(
  //       '$backendUrl/subscribeAndStreamFrames?channelName=$audioChannelName&matchId=14'));
  //   if (audioResponse.statusCode <= 209) {
  //     audioRes = audioResponse.body;
  //   }
  //   // Show success message
  //   _showSuccessMessage(' Subscribed to audio Channel Again');
  // }

  Future<void> getStartMatch() async {
    try {
      // subscribe channel

      final fetchedEntities = await _streamingservice.getStartMatch(14);
      print("last rec --$fetchedEntities");
      if (fetchedEntities != null && fetchedEntities.isNotEmpty) {
        setState(() {
          matchEntity = fetchedEntities;
          redisHost = matchEntity['farm_ip'];
          redisPort = matchEntity['container_port'];
        });
        // Show success message
        _showSuccessMessage('Get start match');
      }
    } catch (e) {
      _showErrorDialog('Failed to fetch: $e');
    }
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    getStartMatch();
    // .then((_) => subscribeChannel());
    _startStreaming();
  }

  @override
  void dispose() {
    _fetchFramesTimer?.cancel();
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
    _fetchFramesTimer?.cancel();
    setState(() {
      framesQueue.clear();
      videoQueue.clear();
    });
  }

  void _fetchFrames() {
    _fetchFramesTimer =
        Timer.periodic(const Duration(milliseconds: 200), (timer) async {
      try {
        final videoResponse = await http.get(Uri.parse(
            '$backendUrl/latest-message?channelName=$videoChannelName&matchId=${widget.matchId}'));

        if (videoResponse.body == 'No message received yet' &&
            !videoRes.contains('Subscribed')) {
          _showErrorMessage('Waiting for frames...');
          print('error is ..No video message received yet');
          // subscribeVideoChannel();
        } else if (videoResponse.statusCode == 200 &&
            videoResponse.body != 'No message received yet') {
          Uint8List videoFrameBytes = base64Decode(videoResponse.body);

          setState(() {
            framesQueue.addLast(videoFrameBytes);
          });
          print('framelength is .. ${framesQueue.length}');

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
        await fetchAudioSegment(segmentPath);
      } else {
        print('FFmpeg command failed with rc $rc');
        setState(() {
          isProcessing = false;
        });
      }
    });
  }

  Future<void> fetchAudioSegment(String videoSegmentPath) async {
    try {
      final audioResponse = await http.get(Uri.parse(
          '$backendUrl/latest-message?channelName=$audioChannelName&matchId=${widget.matchId}'));

      if (audioResponse.body == 'No message received yet' &&
          !audioRes.contains('Subscribed')) {
        print('error is ..No Audio message received yet');
        // subscribeAudioChannel();
      }
      if (audioResponse.statusCode == 200) {
        String audioFrameBase64 = audioResponse.body;
        final Directory dir = await getTemporaryDirectory();
        final String audioPath =
            '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac';
        await File(audioPath).writeAsBytes(base64Decode(audioFrameBase64));

        // Combine video and audio
        final String combinedSegmentPath =
            '${dir.path}/combined_segment_${DateTime.now().millisecondsSinceEpoch}.mp4';
        final String ffmpegCombineCommand =
            '-i $videoSegmentPath -i $audioPath -c:v copy -c:a aac $combinedSegmentPath';

        print(
            'Running FFmpeg command to combine video and audio: $ffmpegCombineCommand');
        await _flutterFFmpeg.execute(ffmpegCombineCommand).then((rc) async {
          print("FFmpeg process exited with rc $rc");
          if (rc == 0) {
            await streamToYouTube(combinedSegmentPath);

            print(
                'Combined segment created successfully at $combinedSegmentPath');
            setState(() {
              videoQueue.add(combinedSegmentPath);
            });
          } else {
            print(
                'FFmpeg command to combine video and audio failed with rc $rc');
          }
          setState(() {
            isProcessing = false;
          });
        });
      } else {
        print('Error fetching audio segment: ${audioResponse.body}');
        setState(() {
          isProcessing = false;
        });
      }
    } catch (e) {
      print('Error fetching audio segment: $e');
      setState(() {
        isProcessing = false;
      });
    }
  }

// stream on you tube
  Future<void> streamToYouTube(String segmentPath) async {
    // final String ffmpegStreamCommand =
    //     '-re -i $segmentPath -c copy -f flv $youtubeStreamUrl';
    // final String ffmpegStreamCommand =
    //     'ffmpeg -re -i $segmentPath -f lavfi -t 1 -i anullsrc=channel_layout=stereo:sample_rate=44100 -c:v libx264 -preset veryfast -b:v 3000k -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 160k -ac 2 -ar 44100 -shortest -f flv $youtubeStreamUrl';
    final String fullRtmpUrl = '$youtubeStreamUrl/$key';

    final String ffmpegStreamCommand =
        '-re -i $segmentPath -f lavfi -t 1 -i anullsrc=channel_layout=stereo:sample_rate=44100 -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 50 -qmin 10 -qmax 51 -c:a aac -b:a 128k -ar 44100 -flvflags no_duration_filesize   -f flv $fullRtmpUrl';

    print('Running FFmpeg command to stream to YouTube: $ffmpegStreamCommand');
    await _flutterFFmpeg.execute(ffmpegStreamCommand).then((rc) {
      print("FFmpeg process for streaming exited with rc $rc");
      if (rc == 0) {
        print('Streaming to YouTube started successfully');
      } else {
        print('FFmpeg command to stream to YouTube failed with rc $rc');
      }
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Video Player Example'),
  //       leading: GestureDetector(
  //         onTap: () {
  //           Navigator.pop(context);
  //         },
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Container(
  //             padding: const EdgeInsets.all(8),
  //             decoration: BoxDecoration(
  //                 color:const Color(0xFF219ebc),
  //                 borderRadius: BorderRadius.circular(12)
  //             ),
  //             child: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),
  //           ),
  //         ),
  //       ),
  //       actions: [
  //         IconButton(
  //           icon: const Icon(Icons.play_arrow),
  //           onPressed: () {
  //             _startStreaming();
  //           },
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.fullscreen),
  //           onPressed: _toggleFullScreen,
  //         ),
  //       ],
  //     ),
  //     body: Center(
  //       child: Column(
  //         children: [
  //           AspectRatio(
  //             aspectRatio:
  //                 16 / 9, // Define a fixed aspect ratio for the video area
  //             child: Stack(
  //               alignment: Alignment.center,
  //               children: [
  //                 if (_isVideoReady &&
  //                     _videoPlayerController != null &&
  //                     _videoPlayerController!.value.isInitialized)
  //                   VideoPlayer(_videoPlayerController!),
  //                 if (!_isVideoReady)
  //                   Positioned.fill(
  //                     child: BackdropFilter(
  //                       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  //                       child: const Column(
  //                         children: [
  //                           Center(
  //                               child: Text(
  //                             'Waiting for Videos...',
  //                             style: TextStyle(color: Colors.black),
  //                           )),
  //                           Center(
  //                             child: CircularProgressIndicator(),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //               ],
  //             ),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               IconButton(
  //                 icon: const Icon(Icons.play_arrow),
  //                 onPressed: () {
  //                   _videoPlayerController?.play();
  //                 },
  //               ),
  //               IconButton(
  //                 icon: const Icon(Icons.pause),
  //                 onPressed: () {
  //                   _videoPlayerController?.pause();
  //                 },
  //               ),
  //               IconButton(
  //                 icon: const Icon(Icons.stop),
  //                 onPressed: () {
  //                   _videoPlayerController?.seekTo(Duration.zero);
  //                   _videoPlayerController?.pause();
  //                   _stopStreaming();
  //                 },
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !_isFullscreen
          ? AppBar(
              title: const Text('Video Player Example'),
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          : null,
      body:
          _isFullscreen ? _buildVideoPlayer() : _buildVideoPlayerWithComments(),
    );
  }

  Widget _buildVideoPlayerWithComments() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _isVideoReady
                  ? _videoPreviewWidget()
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Waiting for Videos...',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                    _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen),
                onPressed: _toggleFullscreen,
              ),
            )
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return _commentBox(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _commentBox(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.1,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Comment $index",
                style: GoogleFonts.getFont('Poppins',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Hello this is comment $index",
                style: GoogleFonts.getFont('Poppins',
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: _isVideoReady
              ? _videoPreviewWidget()
              : const Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text(
                      'Waiting for Videos...',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon:
                Icon(_isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen),
            onPressed: _toggleFullscreen,
          ),
        )
      ],
    );
  }

  Widget _videoPreviewWidget() {
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
          child: VideoPlayer(_videoPlayerController!),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: Icon(
              _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
              color: Colors.black,
            ),
            onPressed: _toggleFullscreen,
          ),
        ),
      ],
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
          icon: const Icon(Icons.screen_rotation_rounded),
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
