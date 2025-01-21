// ignore_for_file: use_build_context_synchronously

import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';


class pickvideo extends StatefulWidget {
  @override
  _pickvideoState createState() => _pickvideoState();
}

class _pickvideoState extends State<pickvideo> {
  String? _videoPath;
  String? _supportedEncoder;

  @override
  void initState() {
    super.initState();
    requestPermissions();
    checkSupportedEncoders();
  }

  // Future<void> checkSupportedEncoders() async {
  //   // final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  //   final List<String> encoders = [
  //     'libx264',
  //     'h264',
  //     'mpeg4',
  //   ];

  //   for (var encoder in encoders) {
  //     final int result = await FFmpegKit.execute('-hide_banner -encoders');
  //     if (result == 0) {
  //       _supportedEncoder = encoder;
  //       print('Encoder $encoder is supported');
  //       break;
  //     } else {
  //       print('Encoder $encoder is not supported');
  //     }
  //   }
  // }
  Future<void> checkSupportedEncoders() async {
  final List<String> encoders = [
    'libx264',
    'h264',
    'mpeg4',
  ];

  for (var encoder in encoders) {
    final FFmpegSession session = await FFmpegKit.execute('-hide_banner -encoders');
    final returnCode = await session.getReturnCode();

    if (returnCode != null && returnCode == 0) {
      // Check if the encoder is in the output
      final String? output = await session.getOutput();
      if (output != null && output.contains(encoder)) {
        print('Encoder $encoder is supported');
        _supportedEncoder = encoder; // Save the supported encoder
        break;
      } else {
        print('Encoder $encoder is not supported');
      }
    } else {
      print('FFmpeg command failed with return code: $returnCode');
    }
  }
}

  @override
  void dispose() {
    super.dispose();
    _stopStreaming();
  }

  Future<void> _stopStreaming() async {
    // final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

    // Kill the FFmpeg process to stop streaming
    await FFmpegKit.cancel();
    print('Streaming stopped');
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

  // Future<void> startLiveStream() async {
  //   if (_videoPath == null) return;

  //   // Hardcode your RTMP URL and stream key
  //   final String rtmpUrl = 'rtmp://a.rtmp.youtube.com/live2';
  //   final String streamKey = '3e0r-ghz0-v4uc-0rm6-d17s';

  //   // Construct the full RTMP URL
  //   final String fullRtmpUrl = '$rtmpUrl/$streamKey';

  //   // Use FFmpeg to stream the video file to YouTube
  //   final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  //   final int result = await _flutterFFmpeg.execute(
  //       '-re -i $_videoPath -f lavfi -t 1 -i anullsrc=channel_layout=stereo:sample_rate=44100 -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 50 -qmin 10 -qmax 51 -c:a aac -b:a 128k -ar 44100 -flvflags no_duration_filesize   -f flv $fullRtmpUrl');

  //   if (result == 0) {
  //     print('Streaming started successfully');
  //   } else {
  //     print('Error in streaming: $result');
  //   }
  // }
  Future<void> startLiveStream() async {
  if (_videoPath == null) return;

  // Hardcode your RTMP URL and stream key
  final String rtmpUrl = 'rtmp://a.rtmp.youtube.com/live2';
  final String streamKey = '3e0r-ghz0-v4uc-0rm6-d17s';

  // Construct the full RTMP URL
  final String fullRtmpUrl = '$rtmpUrl/$streamKey';

  // FFmpeg command to stream the video file to YouTube
  final String ffmpegCommand =
      '-re -i $_videoPath -f lavfi -t 1 -i anullsrc=channel_layout=stereo:sample_rate=44100 '
      '-maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 50 -qmin 10 -qmax 51 '
      '-c:a aac -b:a 128k -ar 44100 -flvflags no_duration_filesize -f flv $fullRtmpUrl';

  print('Running FFmpeg command to start live stream: $ffmpegCommand');

  // Execute the FFmpeg command using ffmpeg_kit_flutter
  final FFmpegSession session = await FFmpegKit.execute(ffmpegCommand);

  // Get the return code from the session
  final returnCode = await session.getReturnCode();

  if (returnCode != null && returnCode == 0) {
    print('Streaming started successfully');
  } else {
    print('Error in streaming. Return code: $returnCode');
    final String? failStackTrace = await session.getFailStackTrace();
    if (failStackTrace != null) {
      print('FFmpeg failed stack trace: $failStackTrace');
    }
  }
}

  Future<void> pickVideo() async {
    // PermissionStatus status = await Permission.manageExternalStorage.request();
    // if (status.isGranted) {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);

    if (result != null) {
      setState(() {
        _videoPath = result.files.single.path;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Live Stream'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: pickVideo,
              child: const Text(
                'Pick Video',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: startLiveStream,
              child: const Text(
                'Start Live Stream',
                style: TextStyle(color: Colors.black),
              ),
            ),
            if (_videoPath != null) Text('Selected video: $_videoPath'),
          ],
        ),
      ),
    );
  }
}
