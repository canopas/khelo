import 'package:data/api/live_stream/live_stream_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stream_camera_view_model.freezed.dart';

final streamCameraStateProvider = StateNotifierProvider.autoDispose<
    StreamCameraViewNotifier, StreamCameraViewState>((ref) {
  return StreamCameraViewNotifier();
});

class StreamCameraViewNotifier extends StateNotifier<StreamCameraViewState> {
  StreamCameraViewNotifier() : super(StreamCameraViewState());

  void setData(LiveStreamModel stream) {
    state = state.copyWith(stream: stream);
  }
}

@freezed
class StreamCameraViewState with _$StreamCameraViewState {
  const factory StreamCameraViewState({
    Object? error,
    LiveStreamModel? stream,
  }) = _StreamCameraViewState;
}
