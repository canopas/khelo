import 'package:data/api/live_stream/live_stream_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haishin_kit/stream_view_texture.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/ui/flow/matches/live_streaming/stream_camera/stream_camera_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../domain/extensions/widget_extension.dart';

class StreamCameraScreen extends ConsumerStatefulWidget {
  final LiveStreamModel stream;

  const StreamCameraScreen({super.key, required this.stream});

  @override
  ConsumerState createState() => _StreamCameraScreenState();
}

class _StreamCameraScreenState extends ConsumerState<StreamCameraScreen> {
  late StreamCameraViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(streamCameraStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.stream));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(streamCameraStateProvider);

    return AppPage(
      body: Builder(
        builder: (context) => _body(context, state),
      ),
    );
  }

  Widget _body(BuildContext context, StreamCameraViewState state) {
    if (state.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return ErrorScreen(
        onRetryTap: notifier.initPlatformState,
        error: state.error,
      );
    }

    if (state.rtmpStream != null) {
      return Stack(
        children: [
          SizedBox.expand(child: StreamViewTexture(state.rtmpStream)),
          _recordingModeButton(state),
        ],
      );
    }

    return Text(
      "Something is not well",
      style: AppTextStyle.subtitle1
          .copyWith(color: context.colorScheme.textPrimary),
    );
  }

  Widget _recordingModeButton(StreamCameraViewState state) {
    return Padding(
      padding: context.mediaQueryPadding + EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                if (state.stream?.status == LiveStreamStatus.live ||
                    state.stream?.status == LiveStreamStatus.paused)
                  _iconButton(
                    isEnable: state.stream?.status == LiveStreamStatus.paused,
                    action: LiveActions.resume,
                    disabledAction: LiveActions.pause,
                    onTap: () {
                      final status =
                          state.stream?.status == LiveStreamStatus.paused
                              ? LiveStreamStatus.live
                              : LiveStreamStatus.paused;
                      notifier.updateStreamingStatus(status);
                    },
                  ),
                _iconButton(
                  isEnable: state.isAudioEnable,
                  action: LiveActions.unmute,
                  disabledAction: LiveActions.mute,
                  onTap: notifier.toggleMuteButton,
                ),
                if (state.stream?.status != LiveStreamStatus.completed)
                  _iconButton(
                    isEnable: state.stream?.status == LiveStreamStatus.pending,
                    action: LiveActions.start,
                    disabledAction: LiveActions.end,
                    onTap: () {
                      final status =
                          state.stream?.status == LiveStreamStatus.pending
                              ? LiveStreamStatus.live
                              : LiveStreamStatus.completed;
                      notifier.updateStreamingStatus(status);
                    },
                  ),
                _iconButton(
                  action: LiveActions.switchCamera,
                  onTap: notifier.switchCamera,
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.live_tv, color: context.colorScheme.alert),
          )
        ],
      ),
    );
  }

  Widget _iconButton({
    bool isEnable = false,
    required LiveActions action,
    LiveActions? disabledAction,
    required VoidCallback onTap,
  }) {
    final title = (disabledAction != null && !isEnable)
        ? disabledAction.getString(context)
        : action.getString(context);

    final icon = (disabledAction != null && !isEnable)
        ? disabledAction.getIcon()
        : action.getIcon();

    final showEnabled = disabledAction != null && isEnable;
    return OnTapScale(
      onTap: onTap,
      enabled: true, // TODO: if state.loading is not true
      child: Material(
        type: MaterialType.transparency,
        child: Chip(
          avatar: Icon(
            icon,
            size: 18,
            color: showEnabled
                ? context.colorScheme.onPrimary
                : context.colorScheme.primary,
          ),
          label: Text(
            title,
            style: AppTextStyle.body2.copyWith(
                color: showEnabled
                    ? context.colorScheme.onPrimary
                    : context.colorScheme.primary),
          ),
          backgroundColor: showEnabled
              ? context.colorScheme.primary
              : context.colorScheme.containerLowOnSurface,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          side: const BorderSide(color: Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
