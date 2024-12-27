// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_stream_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LiveStreamModel _$LiveStreamModelFromJson(Map<String, dynamic> json) {
  return _LiveStreamModel.fromJson(json);
}

/// @nodoc
mixin _$LiveStreamModel {
  String get id => throw _privateConstructorUsedError;
  String get match_id => throw _privateConstructorUsedError;
  String get rtmp_url => throw _privateConstructorUsedError;
  String get stream_id => throw _privateConstructorUsedError;
  String get broadcast_id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @TimeStampJsonConverter()
  DateTime? get start_time => throw _privateConstructorUsedError;
  LiveStreamStatus get status => throw _privateConstructorUsedError;

  /// Serializes this LiveStreamModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LiveStreamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LiveStreamModelCopyWith<LiveStreamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveStreamModelCopyWith<$Res> {
  factory $LiveStreamModelCopyWith(
          LiveStreamModel value, $Res Function(LiveStreamModel) then) =
      _$LiveStreamModelCopyWithImpl<$Res, LiveStreamModel>;
  @useResult
  $Res call(
      {String id,
      String match_id,
      String rtmp_url,
      String stream_id,
      String broadcast_id,
      String title,
      @TimeStampJsonConverter() DateTime? start_time,
      LiveStreamStatus status});
}

/// @nodoc
class _$LiveStreamModelCopyWithImpl<$Res, $Val extends LiveStreamModel>
    implements $LiveStreamModelCopyWith<$Res> {
  _$LiveStreamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LiveStreamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? match_id = null,
    Object? rtmp_url = null,
    Object? stream_id = null,
    Object? broadcast_id = null,
    Object? title = null,
    Object? start_time = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      match_id: null == match_id
          ? _value.match_id
          : match_id // ignore: cast_nullable_to_non_nullable
              as String,
      rtmp_url: null == rtmp_url
          ? _value.rtmp_url
          : rtmp_url // ignore: cast_nullable_to_non_nullable
              as String,
      stream_id: null == stream_id
          ? _value.stream_id
          : stream_id // ignore: cast_nullable_to_non_nullable
              as String,
      broadcast_id: null == broadcast_id
          ? _value.broadcast_id
          : broadcast_id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      start_time: freezed == start_time
          ? _value.start_time
          : start_time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LiveStreamStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LiveStreamModelImplCopyWith<$Res>
    implements $LiveStreamModelCopyWith<$Res> {
  factory _$$LiveStreamModelImplCopyWith(_$LiveStreamModelImpl value,
          $Res Function(_$LiveStreamModelImpl) then) =
      __$$LiveStreamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String match_id,
      String rtmp_url,
      String stream_id,
      String broadcast_id,
      String title,
      @TimeStampJsonConverter() DateTime? start_time,
      LiveStreamStatus status});
}

/// @nodoc
class __$$LiveStreamModelImplCopyWithImpl<$Res>
    extends _$LiveStreamModelCopyWithImpl<$Res, _$LiveStreamModelImpl>
    implements _$$LiveStreamModelImplCopyWith<$Res> {
  __$$LiveStreamModelImplCopyWithImpl(
      _$LiveStreamModelImpl _value, $Res Function(_$LiveStreamModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LiveStreamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? match_id = null,
    Object? rtmp_url = null,
    Object? stream_id = null,
    Object? broadcast_id = null,
    Object? title = null,
    Object? start_time = freezed,
    Object? status = null,
  }) {
    return _then(_$LiveStreamModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      match_id: null == match_id
          ? _value.match_id
          : match_id // ignore: cast_nullable_to_non_nullable
              as String,
      rtmp_url: null == rtmp_url
          ? _value.rtmp_url
          : rtmp_url // ignore: cast_nullable_to_non_nullable
              as String,
      stream_id: null == stream_id
          ? _value.stream_id
          : stream_id // ignore: cast_nullable_to_non_nullable
              as String,
      broadcast_id: null == broadcast_id
          ? _value.broadcast_id
          : broadcast_id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      start_time: freezed == start_time
          ? _value.start_time
          : start_time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LiveStreamStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LiveStreamModelImpl implements _LiveStreamModel {
  const _$LiveStreamModelImpl(
      {required this.id,
      required this.match_id,
      required this.rtmp_url,
      required this.stream_id,
      required this.broadcast_id,
      required this.title,
      @TimeStampJsonConverter() this.start_time,
      this.status = LiveStreamStatus.pending});

  factory _$LiveStreamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiveStreamModelImplFromJson(json);

  @override
  final String id;
  @override
  final String match_id;
  @override
  final String rtmp_url;
  @override
  final String stream_id;
  @override
  final String broadcast_id;
  @override
  final String title;
  @override
  @TimeStampJsonConverter()
  final DateTime? start_time;
  @override
  @JsonKey()
  final LiveStreamStatus status;

  @override
  String toString() {
    return 'LiveStreamModel(id: $id, match_id: $match_id, rtmp_url: $rtmp_url, stream_id: $stream_id, broadcast_id: $broadcast_id, title: $title, start_time: $start_time, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveStreamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.match_id, match_id) ||
                other.match_id == match_id) &&
            (identical(other.rtmp_url, rtmp_url) ||
                other.rtmp_url == rtmp_url) &&
            (identical(other.stream_id, stream_id) ||
                other.stream_id == stream_id) &&
            (identical(other.broadcast_id, broadcast_id) ||
                other.broadcast_id == broadcast_id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.start_time, start_time) ||
                other.start_time == start_time) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, match_id, rtmp_url,
      stream_id, broadcast_id, title, start_time, status);

  /// Create a copy of LiveStreamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveStreamModelImplCopyWith<_$LiveStreamModelImpl> get copyWith =>
      __$$LiveStreamModelImplCopyWithImpl<_$LiveStreamModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiveStreamModelImplToJson(
      this,
    );
  }
}

abstract class _LiveStreamModel implements LiveStreamModel {
  const factory _LiveStreamModel(
      {required final String id,
      required final String match_id,
      required final String rtmp_url,
      required final String stream_id,
      required final String broadcast_id,
      required final String title,
      @TimeStampJsonConverter() final DateTime? start_time,
      final LiveStreamStatus status}) = _$LiveStreamModelImpl;

  factory _LiveStreamModel.fromJson(Map<String, dynamic> json) =
      _$LiveStreamModelImpl.fromJson;

  @override
  String get id;
  @override
  String get match_id;
  @override
  String get rtmp_url;
  @override
  String get stream_id;
  @override
  String get broadcast_id;
  @override
  String get title;
  @override
  @TimeStampJsonConverter()
  DateTime? get start_time;
  @override
  LiveStreamStatus get status;

  /// Create a copy of LiveStreamModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LiveStreamModelImplCopyWith<_$LiveStreamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
