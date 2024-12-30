import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ioredis/ioredis.dart';

class VideoStreamPage3 extends StatefulWidget {
  const VideoStreamPage3({Key? key}) : super(key: key);

  @override
  _VideoStreamPage3State createState() => _VideoStreamPage3State();
}

class _VideoStreamPage3State extends State<VideoStreamPage3> {
  Uint8List? currentFrame;
  Uint8List? nextFrame;
  List<Uint8List> failedFrames = [];
  bool isLoading = false;
  late Redis redis;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    connectToRedis();
    startListening();
  }

  @override
  void dispose() {
    stopListening();
    super.dispose();
  }

  Future<void> connectToRedis() async {
    try {
      redis = Redis(RedisOptions(host: '3.6.250.12', port: 6380));
      print('Connected to Redis');
      setState(() {
        isConnected = true;
      });
    } catch (e) {
      print('Failed to connect to Redis: $e');
    }
  }

  void startListening() async {
    try {
      print('Subscribing to video_frames...');
      RedisSubscriber subscriber = await redis.subscribe('video_frames');
      print('Subscribed to video_frames');

      subscriber.onMessage = (String channel, String? message) async {
        if (message != null) {
          print('Received message: ${message.length}');
          try {
            Map<String, dynamic> jsonMap = jsonDecode(message);
            String frameDataJson = jsonMap['frame_data'];
            String normalizedMessage = base64.normalize(frameDataJson);
            Uint8List bytes = base64.decode(normalizedMessage);
            print('Frame received.');

            // Double buffering technique
            setState(() {
              nextFrame = bytes;
              currentFrame = nextFrame;
            });

            print('Current frame updated.');
          } catch (e) {
            print('Error decoding base64 string: $e');
            failedFrames.add(base64.decode(message!));
          }
        }
      };
    } catch (e) {
      print('Error subscribing to video_frames: $e');
    }
  }

  void stopListening() async {
    await redis.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Stream'),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 400,
              width: 300,
              color: Colors.black,
              child: currentFrame != null
                  ? Image.memory(
                      currentFrame!,
                      fit: BoxFit.cover,
                    )
                  : const Center(
                      child: Text(
                        'No frames received yet',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: stopListening,
        child: const Icon(Icons.stop),
      ),
    );
  }
}
