import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ioredis/ioredis.dart';

class VideoStreamPage2 extends StatefulWidget {
  const VideoStreamPage2({Key? key}) : super(key: key);

  @override
  _VideoStreamPage2State createState() => _VideoStreamPage2State();
}

class _VideoStreamPage2State extends State<VideoStreamPage2> {
  List<Uint8List> frames = [];
  int maxFramesToBuffer = 50; // Adjust the number of frames to buffer
  int currentFrameIndex = 0;
  Timer? _timer;
  bool _isStreaming = false;
  String incompleteBase64 = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // Close the connection and stop the timer when the widget is disposed
    stopListening();
    _timer?.cancel();
  }

  void _startStreaming() {
    startListening();
    setState(() {
      _isStreaming = true;
      _startFramePlayback();
    });
  }

  void _stopStreaming() {
    stopListening();
    _timer?.cancel();
    setState(() {
      _isStreaming = false;
    });
  }

  void _startFramePlayback() {
    const frameDuration = Duration(milliseconds: 100); // Adjust the frame rate
    _timer = Timer.periodic(frameDuration, (timer) {
      setState(() {
        if (frames.isNotEmpty) {
          currentFrameIndex = (currentFrameIndex + 1) % frames.length;
        }
      });
    });
  }

  void startListening() async {
    try {
      Redis subClient = Redis(RedisOptions(host: '3.6.250.12', port: 6380));
      RedisSubscriber subscriber = await subClient.subscribe('video_frames');
      print('Subscribed to video_frames channel');

      // Listen for messages
      subscriber.onMessage = (String channel, String? message) {
        if (message != null) {
          Map<String, dynamic> jsonMap = jsonDecode(message);
          String frameDataJson = jsonMap['frame_data'];
          String normalizedMessage =
              base64.normalize(frameDataJson); // Normalize the base64 string
          Uint8List bytes = base64
              .decode(normalizedMessage); // Decode the normalized base64 string

          print('Received message with length: ${message.length}');
          // incompleteBase64 += message;

          // Check if the length of the accumulated base64 string is a multiple of 4
          // if (incompleteBase64.length % 4 == 0) {
          try {
            // Uint8List bytes = base64.decode(incompleteBase64);
            // incompleteBase64 =
            //     ''; // Clear the buffer after successful decoding

            // Check if the bytes can be decoded as an image
            if (_isValidImage(bytes)) {
              // Buffer frames
              if (frames.length < maxFramesToBuffer) {
                frames.add(bytes);
              } else {
                // Remove the oldest frame
                frames.removeAt(0);
                frames.add(bytes);
              }
              // Update the UI
              setState(() {});
            } else {
              print('Invalid image data received.');
            }
          } catch (e) {
            print('Error decoding base64 string: $e');
            incompleteBase64 = ''; // Clear the buffer on error
          }
          // }
        }
      };
    } catch (e) {
      print('Error: $e');
    }
  }

  bool _isValidBase64(String base64String) {
    // Regular expression to validate base64 string
    String base64Pattern = r'^(?:[A-Za-z0-9+\/]{4})*'
        r'(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=)?$';
    RegExp regExp = RegExp(base64Pattern);
    bool isValid = regExp.hasMatch(base64String);
    if (isValid) {
      // Additional check for length being a multiple of 4
      isValid = base64String.length % 4 == 0;
    }
    return isValid;
  }

  bool _isValidImage(Uint8List bytes) {
    try {
      // Try to decode the bytes as an image
      Image.memory(bytes);
      return true;
    } catch (e) {
      print('Error validating image bytes: $e');
      return false;
    }
  }

  void stopListening() async {
    Redis subClient = Redis(RedisOptions(host: '3.6.250.12', port: 6380));
    // Close the connection when done
    await subClient.disconnect();
    print('Disconnected from Redis');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Stream'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 400,
              width: 300,
              color: Colors.black,
              child: frames.isNotEmpty
                  ? Image.memory(
                      frames[currentFrameIndex],
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                    )
                  : const Center(
                      child: Text(
                        'No video stream available',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ),
            if (_isStreaming)
              const Positioned(
                bottom: 20,
                right: 20,
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isStreaming ? _stopStreaming : _startStreaming,
        child: Icon(_isStreaming ? Icons.stop : Icons.play_arrow),
      ),
    );
  }
}
