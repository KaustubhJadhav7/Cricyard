import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cricyard/resources/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoStreamWidget extends StatefulWidget {
  @override
  _VideoStreamWidgetState createState() => _VideoStreamWidgetState();
}

class _VideoStreamWidgetState extends State<VideoStreamWidget> {
  // final String backendUrl = 'http://localhost:9595/token/latest-frame';
  final String backendUrl =
      '${ApiConstants.baseUrl}/token/livestreaming/latest-frame';

  final String channelName = 'video_frames';
  List<Uint8List> frames = [];
  int currentFrameIndex = 0;
  Timer? _fetchTimer;
  Timer? _displayTimer;
  bool _isStreaming = false;
  bool _isBuffering = true;
  final int maxFramesToBuffer = 50;
  final int minBufferLength = 30;
  VideoPlayerController? _videoPlayerController;
  bool _isVideoReady = false;
  int maxFrames = 30; // Changed to 50 frames
  Uint8List? currentFrame;
  Uint8List? nextFrame;
  List<Uint8List> failedFrames = [];
  bool isConnected = false;
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

  @override
  void dispose() {
    _fetchTimer?.cancel();
    _displayTimer?.cancel();
    super.dispose();
    _videoPlayerController?.dispose();
    _stopStreaming();
  }

  void _startStreaming() {
    _fetchFrames();
    // _displayFrames();
    setState(() {
      _isStreaming = true;
    });
  }

  void _stopStreaming() {
    _fetchTimer?.cancel();
    _displayTimer?.cancel();
    setState(() {
      _isStreaming = false;
      _isBuffering = true;
      frames.clear();
    });
  }

  void _fetchFrames() {
    _fetchTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      if (frames.length < maxFramesToBuffer) {
        try {
          final response =
              await http.get(Uri.parse('$backendUrl?channelName=$channelName'));
          if (response.statusCode == 200) {
            // List<dynamic> frameList = jsonDecode(response.body);
            // dynamic frameBase64 = jsonDecode(response.body);

            // for (String frameBase64 in frameList) {
            Uint8List frameBytes = base64Decode(response.body);
            setState(() {
              frames.add(frameBytes);
            });
            // }
            // if (frames.length >= minBufferLength) {
            //   setState(() {
            //     _isBuffering = false;
            //   });
            // }
            processFrame(response.body);
          } else {
            print('Error fetching frames: ${response.body}');
          }
        } catch (e) {
          print('Error fetching frames: $e');
        }
      }
    });
  }

  void processFrame(String base64Frame) async {
    // for (int i = 0; i < maxFrames; i++) {
    Uint8List bytes = base64Decode(base64Frame);
    setState(() {
      frames.add(bytes);
    });
    // }

    print('Frame count: ${frames.length}');
    if (frames.length >= maxFrames) {
      await createVideo();
    }
  }

  // Future<void> createVideo() async {
  //   print('Creating video from frames...');
  //   final Directory dir = await getTemporaryDirectory();
  //   final String framesDir = '${dir.path}/frames';
  //   await Directory(framesDir).create(recursive: true);

  //   for (int i = 0; i < frames.length; i++) {
  //     String framePath = '$framesDir/frame_$i.png';
  //     File(framePath).writeAsBytesSync(frames[i]);
  //   }

  //   final String videoPath = '${dir.path}/output_video.mp4';
  //   final String ffmpegCommand =
  //       '-framerate 10 -i $framesDir/frame_%d.png -c:v libx264 -pix_fmt yuv420p $videoPath';

  //   print('Running FFmpeg command: $ffmpegCommand');
  //   await _flutterFFmpeg.execute(ffmpegCommand).then((rc) async {
  //     print("FFmpeg process exited with rc $rc");
  //     if (rc == 0) {
  //       print('Video created successfully at $videoPath');
  //       setState(() {
  //         _isVideoReady = true;
  //         _videoPlayerController = VideoPlayerController.file(File(videoPath));
  //       });

  //       await _videoPlayerController!.initialize();
  //       setState(() {});
  //     } else {
  //       print('FFmpeg command failed with rc $rc');
  //     }
  //   });
  // }
  Future<void> createVideo() async {
    print('Creating video from frames...');
    final Directory dir = await getTemporaryDirectory();
    final String framesDir = '${dir.path}/frames';
    await Directory(framesDir).create(recursive: true);

    for (int i = 0; i < frames.length; i++) {
      String framePath = '$framesDir/frame_$i.png';
      File(framePath).writeAsBytesSync(frames[i]);
    }

    final String videoPath = '${dir.path}/output_video1.mp4';
    final String ffmpegCommand =
        '-framerate 10 -i $framesDir/frame_%d.png -c:v mpeg4 -q:v 5 $videoPath';

    print('Running FFmpeg command: $ffmpegCommand');
    await _flutterFFmpeg.execute(ffmpegCommand).then((rc) async {
      print("FFmpeg process exited with rc $rc");
      if (rc == 0) {
        print('Video created successfully at $videoPath');
        setState(() {
          _isVideoReady = true;
          _videoPlayerController = VideoPlayerController.file(File(videoPath));
        });

        await _videoPlayerController!.initialize();
        setState(() {});
      } else {
        print('FFmpeg command failed with rc $rc');
      }
    });
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
        child: _isVideoReady &&
                _videoPlayerController != null &&
                _videoPlayerController!.value.isInitialized
            ? Column(
                children: [
                  AspectRatio(
                    aspectRatio: _videoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController!),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
              )
            : Text('Waiting for frames...'),
      ),
    );
  }
}

//   void _displayFrames() {
//     _displayTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       if (frames.isNotEmpty) {
//         setState(() {
//           currentFrameIndex = (currentFrameIndex + 1) % frames.length;
//         });
//       } else {
//         setState(() {
//           _isBuffering = true;
//         });
//         print('Buffer underflow - waiting for more frames');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Video Stream'),
//       ),
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Container(
//               height: 400,
//               width: 300,
//               color: Colors.black,
//               child: frames.isNotEmpty
//                   ? Image.memory(
//                       frames[currentFrameIndex],
//                       fit: BoxFit.cover,
//                       gaplessPlayback: true,
//                     )
//                   : const Center(
//                       child: Text(
//                         'No video stream available',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//             ),
//             if (_isBuffering)
//               const Center(
//                 child: CircularProgressIndicator(),
//               ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _isStreaming ? _stopStreaming : _startStreaming,
//         child: Icon(_isStreaming ? Icons.stop : Icons.play_arrow),
//       ),
//     );
//   }
// }
