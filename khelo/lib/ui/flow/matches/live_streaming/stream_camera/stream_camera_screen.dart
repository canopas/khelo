// import 'package:audio_session/audio_session.dart';
import 'package:camera/camera.dart';
import 'package:data/api/live_stream/live_stream_model.dart';

// import 'package:haishin_kit/audio_settings.dart';
// import 'package:haishin_kit/audio_source.dart';
// import 'package:haishin_kit/rtmp_connection.dart';
// import 'package:haishin_kit/rtmp_stream.dart';
// import 'package:haishin_kit/stream_view_texture.dart';
// import 'package:haishin_kit/video_settings.dart';
// import 'package:haishin_kit/video_source.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/ui/flow/matches/live_streaming/stream_camera/stream_camera_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../domain/extensions/widget_extension.dart';

// class StreamCameraScreen extends ConsumerStatefulWidget {
//   final LiveStreamModel stream;
//
//   const StreamCameraScreen({super.key, required this.stream});
//
//   @override
//   ConsumerState createState() => _StreamCameraScreenState();
// }
//
// class _StreamCameraScreenState extends ConsumerState<StreamCameraScreen> {
//   late StreamCameraViewNotifier notifier;
//   RtmpConnection? _connection;
//   RtmpStream? _stream;
//   bool _recording = false;
//   String _mode = "publish";
//   CameraPosition currentPosition = CameraPosition.back;
//
//   @override
//   void initState() {
//     super.initState();
//     notifier = ref.read(streamCameraStateProvider.notifier);
//     runPostFrame(() => notifier.setData(widget.stream));
//     initPlatformState();
//   }
//
//   Future<void> initPlatformState() async {
//     await Permission.camera.request();
//     await Permission.microphone.request();
//
//     // Set up AVAudioSession for iOS.
//     final session = await AudioSession.instance;
//     await session.configure(const AudioSessionConfiguration(
//       avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
//       avAudioSessionCategoryOptions:
//           AVAudioSessionCategoryOptions.allowBluetooth,
//     ));
//
//     RtmpConnection connection = await RtmpConnection.create();
//     connection.eventChannel.receiveBroadcastStream().listen((event) {
//       print("event: $event");
//       switch (event["data"]["code"]) {
//         case 'NetConnection.Connect.Success':
//           if (_mode == "publish") {
//             _stream?.publish("live");
//           } else {
//             _stream?.play("live");
//           }
//           setState(() {
//             _recording = true;
//           });
//           break;
//       }
//     });
//
//     RtmpStream stream = await RtmpStream.create(connection);
//     stream.audioSettings = AudioSettings(bitrate: 64 * 1000);
//     stream.videoSettings = VideoSettings(
//       width: 480,
//       height: 272,
//       bitrate: 512 * 1000,
//     );
//     stream.attachAudio(AudioSource());
//     stream.attachVideo(VideoSource(position: currentPosition));
//
//     if (!mounted) return;
//
//     setState(() {
//       _connection = connection;
//       _stream = stream;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('HaishinKit'), actions: [
//           IconButton(
//             icon: const Icon(Icons.play_arrow),
//             onPressed: () {
//               if (_mode == "publish") {
//                 _mode = "playback";
//                 _stream?.attachVideo(null);
//                 _stream?.attachAudio(null);
//               } else {
//                 _mode = "publish";
//                 _stream?.attachAudio(AudioSource());
//                 _stream?.attachVideo(VideoSource(position: currentPosition));
//               }
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.flip_camera_android),
//             onPressed: () {
//               if (currentPosition == CameraPosition.front) {
//                 currentPosition = CameraPosition.back;
//               } else {
//                 currentPosition = CameraPosition.front;
//               }
//               _stream?.attachVideo(VideoSource(position: currentPosition));
//             },
//           )
//         ]),
//         body: Center(
//           child: _stream == null ? const Text("") : StreamViewTexture(_stream),
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: _recording
//               ? const Icon(Icons.fiber_smart_record)
//               : const Icon(Icons.not_started),
//           onPressed: () {
//             if (_recording) {
//               _connection?.close();
//               setState(() {
//                 _recording = false;
//               });
//             } else {
//               _connection?.connect("rtmp://a.rtmp.youtube.com/live2/j5rz-chhh-aht8-ujdp-16pg");
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

class StreamCameraScreen2 extends ConsumerStatefulWidget {
  final LiveStreamModel stream;

  const StreamCameraScreen2({super.key, required this.stream});

  @override
  ConsumerState createState() => _StreamCameraScreen2State();
}

class _StreamCameraScreen2State extends ConsumerState<StreamCameraScreen2> {
  CameraController? cameraController;
  late StreamCameraViewNotifier notifier;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.first; // Use first camera for simplicity

    cameraController = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: true,
    );

    await cameraController?.initialize();
    setState(() {});
  }

  Future<void> startStreaming(String rtmpUrl) async {
    // Start recording video
    await cameraController?.startVideoRecording();

    // FFmpeg command will be executed after we have the file (handled on stop)
    print("Recording started. Streaming will start on stop.");
  }

  Future<String> getTempFilePath() async {
    final directory = await getTemporaryDirectory();
    return '${directory.path}/temp.mp4';
  }

  Future<void> stopStreaming(String rtmpUrl) async {
    // Stop recording and get the video file
    final XFile? videoFile = await cameraController?.stopVideoRecording();

    if (videoFile == null) {
      return;
    }
    // Get the file path
    final videoFilePath = videoFile.path;

    // FFmpeg command to stream the recorded video
    final command = '''
  ffmpeg -re -i $videoFilePath -c:v libx264 -preset ultrafast -tune zerolatency -b:v 1500k -maxrate 1500k -bufsize 1500k -pix_fmt yuv420p -f flv $rtmpUrl
  ''';

    // Execute the FFmpeg command
    await FFmpegKit.execute(command);

    print("Streaming stopped.");
  }

  Future<void> requestPermissions() async {
    await [
      Permission.camera,
      Permission.microphone,
    ].request();
  }

  bool isStreaming = false;

  @override
  void initState() {
    super.initState();
    callFunctions();
    notifier = ref.read(streamCameraStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.stream));
  }

  callFunctions() async {
    await requestPermissions();
    await initializeCamera();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  void toggleStreaming() async {
    final rtmpUrl = "rtmp://your.server.com/live/streamkey";

    if (isStreaming) {
      await stopStreaming(rtmpUrl);
    } else {
      await startStreaming(rtmpUrl);
    }

    setState(() {
      isStreaming = !isStreaming;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!(cameraController?.value.isInitialized ?? true)) {
      return Center(child: CircularProgressIndicator());
    }

    if (cameraController != null) {
      return Scaffold(
        appBar: AppBar(title: Text("RTMP Streaming")),
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: cameraController!.value.aspectRatio,
              child: CameraPreview(cameraController!),
            ),
            ElevatedButton(
              onPressed: toggleStreaming,
              child: Text(isStreaming ? "Stop Streaming" : "Start Streaming"),
            ),
          ],
        ),
      );
    }
    return Text("Something is probably wrong");
  }
}
