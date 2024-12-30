import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  String filePath = 'assets/videos/sampletest1.mp4';
  late VideoPlayerController _videoPlayerController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.asset(filePath);
    try {
      await _videoPlayerController.initialize();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('Error initializing video player: $e');
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: _isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: () {
                          _videoPlayerController.play();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.pause),
                        onPressed: () {
                          _videoPlayerController.pause();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.stop),
                        onPressed: () {
                          _videoPlayerController.seekTo(Duration.zero);
                          _videoPlayerController.pause();
                        },
                      ),
                    ],
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
