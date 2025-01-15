import 'package:audio_session/audio_session.dart';
import 'package:data/api/live_stream/live_stream_model.dart';
import 'package:data/service/live_stream/live_stream_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:haishin_kit/audio_settings.dart';
import 'package:haishin_kit/audio_source.dart';
import 'package:haishin_kit/rtmp_connection.dart';
import 'package:haishin_kit/rtmp_stream.dart';
import 'package:haishin_kit/video_settings.dart';
import 'package:haishin_kit/video_source.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:permission_handler/permission_handler.dart';

part 'stream_camera_view_model.freezed.dart';

final streamCameraStateProvider = StateNotifierProvider.autoDispose<
    StreamCameraViewNotifier, StreamCameraViewState>((ref) {
  return StreamCameraViewNotifier(
    ref.read(liveStreamServiceProvider),
  );
});

class StreamCameraViewNotifier extends StateNotifier<StreamCameraViewState> {
  final LiveStreamService _liveStreamService;

  StreamCameraViewNotifier(this._liveStreamService)
      : super(StreamCameraViewState());

  void setData(LiveStreamModel stream) {
    state = state.copyWith(stream: stream);
    initPlatformState();
  }

  Future<void> updateStreamingStatus(LiveStreamStatus status) async {
    if (state.stream == null) {
      return;
    }
    try {
      await _liveStreamService.updateStreamingStatus(state.stream!.id, status);

      switch (status) {
        case LiveStreamStatus.live:
          state.connection?.connect("${state.stream!.server_url}/");
          await state.rtmpStream?.setHasVideo(true);
        case LiveStreamStatus.paused:
          await state.rtmpStream?.setHasVideo(false);
        case LiveStreamStatus.completed:
          await state.rtmpStream?.setHasVideo(false);
          await state.rtmpStream?.close();
          state.connection?.close();
        default:
          break;
      }

      state = state.copyWith(stream: state.stream?.copyWith(status: status));
    } catch (e) {
      debugPrint(
          "StreamCameraViewNotifier: error while updating streaming status -> $e");
    }
  }

  Future<void> requestPermissions() async {
    final permissions = [Permission.camera, Permission.microphone];

    for (var permission in permissions) {
      if (!await permission.status.isGranted) {
        await permission.request();
      }
    }
  }

  Future<void> initPlatformState() async {
    await requestPermissions();

    state = state.copyWith(isLoading: true);
    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
        avAudioSessionCategoryOptions:
            AVAudioSessionCategoryOptions.allowBluetooth,
      ));

      RtmpConnection connection = await RtmpConnection.create();
      connection.eventChannel.receiveBroadcastStream().listen((event) {
        switch (event["data"]["code"]) {
          case 'NetConnection.Connect.Success':
            if (state.stream?.status == LiveStreamStatus.live) {
              state.rtmpStream?.publish(state.stream!.stream_name);
            }
            break;
          case 'NetConnection.Connect.Closed':
            break;
        }
      });

      RtmpStream stream = await RtmpStream.create(connection);
      stream.audioSettings = AudioSettings(bitrate: 64 * 1000);
      stream.videoSettings = VideoSettings(
        width: Resolution.hd.width,
        height: Resolution.hd.height,
        bitrate: Bitrate.medium.value * 1000,
        // frameInterval: 2,
        // profileLevel: ProfileLevel.h264High31,
      );
      await stream.attachAudio(AudioSource());
      await stream.attachVideo(VideoSource(position: state.currentPosition));
      await stream.setHasAudio(state.isAudioEnable);
      await stream.setHasVideo(state.stream?.status == LiveStreamStatus.live);

      state = state.copyWith(
        connection: connection,
        rtmpStream: stream,
        isLoading: false,
      );
    } catch (e) {
      debugPrint(
          "StreamCameraViewNotifier: error while init platform state -> $e");
      state = state.copyWith(error: e, isLoading: false);
    }
  }

  void switchCamera() {
    state = state.copyWith(
        currentPosition: state.currentPosition == CameraPosition.front
            ? CameraPosition.back
            : CameraPosition.front);

    state.rtmpStream?.attachVideo(VideoSource(position: state.currentPosition));
  }

  Future<void> toggleMuteButton() async {
    final hasAudio = state.isAudioEnable;
    state.rtmpStream?.setHasAudio(!hasAudio);
    state = state.copyWith(isAudioEnable: !hasAudio);
  }

  @override
  void dispose() {
    state.connection?.dispose();
    state.rtmpStream?.dispose();
    super.dispose();
  }
}

@freezed
class StreamCameraViewState with _$StreamCameraViewState {
  const factory StreamCameraViewState({
    Object? error,
    LiveStreamModel? stream,
    RtmpConnection? connection,
    RtmpStream? rtmpStream,
    @Default(CameraPosition.front) CameraPosition currentPosition,
    @Default(false) bool isLoading,
    @Default(false) bool isAudioEnable,
  }) = _StreamCameraViewState;
}

enum LiveActions {
  pause,
  resume,
  start,
  end,
  mute,
  unmute,
  switchCamera;

  String getString(BuildContext context) {
    switch (this) {
      case LiveActions.pause:
        return context.l10n.stream_camera_pause_title;
      case LiveActions.resume:
        return context.l10n.stream_camera_resume_title;
      case LiveActions.end:
        return context.l10n.stream_camera_end_title;
      case LiveActions.mute:
        return context.l10n.stream_camera_mute_title;
      case LiveActions.unmute:
        return context.l10n.stream_camera_unmute_title;
      case LiveActions.switchCamera:
        return context.l10n.stream_camera_switch_camera_title;
      case LiveActions.start:
        return context.l10n.stream_camera_start_title;
    }
  }

  IconData getIcon() {
    switch (this) {
      case LiveActions.pause:
        return CupertinoIcons.pause_fill;
      case LiveActions.resume:
        return CupertinoIcons.play_circle_fill;
      case LiveActions.end:
        return CupertinoIcons.stop_fill;
      case LiveActions.mute:
        return CupertinoIcons.mic_slash_fill;
      case LiveActions.unmute:
        return CupertinoIcons.mic_fill;
      case LiveActions.switchCamera:
        return CupertinoIcons.switch_camera_solid;
      case LiveActions.start:
        return CupertinoIcons.play_fill;
    }
  }
}

enum Resolution {
  vga(640, 480),
  qhd(960, 540),
  hd(1280, 720), // 720p
  fhd(1920, 1080), // 1080p
  uhd4k(3840, 2160); // 4k

  final int width;
  final int height;

  const Resolution(this.width, this.height);
}

extension ResolutionAspectRatio on Resolution {
  double get aspectRatio => width / height;
}

enum Bitrate {
  low(64),
  medium(128),
  high(256),
  ultra(512);

  final int value;

  const Bitrate(this.value);
}
