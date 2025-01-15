// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stream_camera_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StreamCameraViewState {
  Object? get error => throw _privateConstructorUsedError;
  LiveStreamModel? get stream => throw _privateConstructorUsedError;
  RtmpConnection? get connection => throw _privateConstructorUsedError;
  RtmpStream? get rtmpStream => throw _privateConstructorUsedError;
  CameraPosition get currentPosition => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isAudioEnable => throw _privateConstructorUsedError;

  /// Create a copy of StreamCameraViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreamCameraViewStateCopyWith<StreamCameraViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamCameraViewStateCopyWith<$Res> {
  factory $StreamCameraViewStateCopyWith(StreamCameraViewState value,
          $Res Function(StreamCameraViewState) then) =
      _$StreamCameraViewStateCopyWithImpl<$Res, StreamCameraViewState>;
  @useResult
  $Res call(
      {Object? error,
      LiveStreamModel? stream,
      RtmpConnection? connection,
      RtmpStream? rtmpStream,
      CameraPosition currentPosition,
      bool isLoading,
      bool isAudioEnable});

  $LiveStreamModelCopyWith<$Res>? get stream;
}

/// @nodoc
class _$StreamCameraViewStateCopyWithImpl<$Res,
        $Val extends StreamCameraViewState>
    implements $StreamCameraViewStateCopyWith<$Res> {
  _$StreamCameraViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamCameraViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? stream = freezed,
    Object? connection = freezed,
    Object? rtmpStream = freezed,
    Object? currentPosition = null,
    Object? isLoading = null,
    Object? isAudioEnable = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      stream: freezed == stream
          ? _value.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as LiveStreamModel?,
      connection: freezed == connection
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as RtmpConnection?,
      rtmpStream: freezed == rtmpStream
          ? _value.rtmpStream
          : rtmpStream // ignore: cast_nullable_to_non_nullable
              as RtmpStream?,
      currentPosition: null == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as CameraPosition,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAudioEnable: null == isAudioEnable
          ? _value.isAudioEnable
          : isAudioEnable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of StreamCameraViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LiveStreamModelCopyWith<$Res>? get stream {
    if (_value.stream == null) {
      return null;
    }

    return $LiveStreamModelCopyWith<$Res>(_value.stream!, (value) {
      return _then(_value.copyWith(stream: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StreamCameraViewStateImplCopyWith<$Res>
    implements $StreamCameraViewStateCopyWith<$Res> {
  factory _$$StreamCameraViewStateImplCopyWith(
          _$StreamCameraViewStateImpl value,
          $Res Function(_$StreamCameraViewStateImpl) then) =
      __$$StreamCameraViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error,
      LiveStreamModel? stream,
      RtmpConnection? connection,
      RtmpStream? rtmpStream,
      CameraPosition currentPosition,
      bool isLoading,
      bool isAudioEnable});

  @override
  $LiveStreamModelCopyWith<$Res>? get stream;
}

/// @nodoc
class __$$StreamCameraViewStateImplCopyWithImpl<$Res>
    extends _$StreamCameraViewStateCopyWithImpl<$Res,
        _$StreamCameraViewStateImpl>
    implements _$$StreamCameraViewStateImplCopyWith<$Res> {
  __$$StreamCameraViewStateImplCopyWithImpl(_$StreamCameraViewStateImpl _value,
      $Res Function(_$StreamCameraViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreamCameraViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? stream = freezed,
    Object? connection = freezed,
    Object? rtmpStream = freezed,
    Object? currentPosition = null,
    Object? isLoading = null,
    Object? isAudioEnable = null,
  }) {
    return _then(_$StreamCameraViewStateImpl(
      error: freezed == error ? _value.error : error,
      stream: freezed == stream
          ? _value.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as LiveStreamModel?,
      connection: freezed == connection
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as RtmpConnection?,
      rtmpStream: freezed == rtmpStream
          ? _value.rtmpStream
          : rtmpStream // ignore: cast_nullable_to_non_nullable
              as RtmpStream?,
      currentPosition: null == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as CameraPosition,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAudioEnable: null == isAudioEnable
          ? _value.isAudioEnable
          : isAudioEnable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$StreamCameraViewStateImpl implements _StreamCameraViewState {
  const _$StreamCameraViewStateImpl(
      {this.error,
      this.stream,
      this.connection,
      this.rtmpStream,
      this.currentPosition = CameraPosition.front,
      this.isLoading = false,
      this.isAudioEnable = false});

  @override
  final Object? error;
  @override
  final LiveStreamModel? stream;
  @override
  final RtmpConnection? connection;
  @override
  final RtmpStream? rtmpStream;
  @override
  @JsonKey()
  final CameraPosition currentPosition;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isAudioEnable;

  @override
  String toString() {
    return 'StreamCameraViewState(error: $error, stream: $stream, connection: $connection, rtmpStream: $rtmpStream, currentPosition: $currentPosition, isLoading: $isLoading, isAudioEnable: $isAudioEnable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamCameraViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stream, stream) || other.stream == stream) &&
            (identical(other.connection, connection) ||
                other.connection == connection) &&
            (identical(other.rtmpStream, rtmpStream) ||
                other.rtmpStream == rtmpStream) &&
            (identical(other.currentPosition, currentPosition) ||
                other.currentPosition == currentPosition) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isAudioEnable, isAudioEnable) ||
                other.isAudioEnable == isAudioEnable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      stream,
      connection,
      rtmpStream,
      currentPosition,
      isLoading,
      isAudioEnable);

  /// Create a copy of StreamCameraViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamCameraViewStateImplCopyWith<_$StreamCameraViewStateImpl>
      get copyWith => __$$StreamCameraViewStateImplCopyWithImpl<
          _$StreamCameraViewStateImpl>(this, _$identity);
}

abstract class _StreamCameraViewState implements StreamCameraViewState {
  const factory _StreamCameraViewState(
      {final Object? error,
      final LiveStreamModel? stream,
      final RtmpConnection? connection,
      final RtmpStream? rtmpStream,
      final CameraPosition currentPosition,
      final bool isLoading,
      final bool isAudioEnable}) = _$StreamCameraViewStateImpl;

  @override
  Object? get error;
  @override
  LiveStreamModel? get stream;
  @override
  RtmpConnection? get connection;
  @override
  RtmpStream? get rtmpStream;
  @override
  CameraPosition get currentPosition;
  @override
  bool get isLoading;
  @override
  bool get isAudioEnable;

  /// Create a copy of StreamCameraViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamCameraViewStateImplCopyWith<_$StreamCameraViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
