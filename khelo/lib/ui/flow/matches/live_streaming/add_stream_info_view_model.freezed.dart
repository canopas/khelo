// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_stream_info_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddStreamInfoViewState {
  Object? get error => throw _privateConstructorUsedError;
  Object? get actionError => throw _privateConstructorUsedError;
  LiveStreamModel? get stream => throw _privateConstructorUsedError;
  MatchModel? get match => throw _privateConstructorUsedError;
  MediumOption? get mediumOption => throw _privateConstructorUsedError;
  String? get channelId => throw _privateConstructorUsedError;
  List<YTChannel> get ytChannels => throw _privateConstructorUsedError;
  bool get showSelectResolutionSheet => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  /// Create a copy of AddStreamInfoViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddStreamInfoViewStateCopyWith<AddStreamInfoViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddStreamInfoViewStateCopyWith<$Res> {
  factory $AddStreamInfoViewStateCopyWith(AddStreamInfoViewState value,
          $Res Function(AddStreamInfoViewState) then) =
      _$AddStreamInfoViewStateCopyWithImpl<$Res, AddStreamInfoViewState>;
  @useResult
  $Res call(
      {Object? error,
      Object? actionError,
      LiveStreamModel? stream,
      MatchModel? match,
      MediumOption? mediumOption,
      String? channelId,
      List<YTChannel> ytChannels,
      bool showSelectResolutionSheet,
      bool loading});

  $LiveStreamModelCopyWith<$Res>? get stream;
  $MatchModelCopyWith<$Res>? get match;
}

/// @nodoc
class _$AddStreamInfoViewStateCopyWithImpl<$Res,
        $Val extends AddStreamInfoViewState>
    implements $AddStreamInfoViewStateCopyWith<$Res> {
  _$AddStreamInfoViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddStreamInfoViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? actionError = freezed,
    Object? stream = freezed,
    Object? match = freezed,
    Object? mediumOption = freezed,
    Object? channelId = freezed,
    Object? ytChannels = null,
    Object? showSelectResolutionSheet = null,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
      stream: freezed == stream
          ? _value.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as LiveStreamModel?,
      match: freezed == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as MatchModel?,
      mediumOption: freezed == mediumOption
          ? _value.mediumOption
          : mediumOption // ignore: cast_nullable_to_non_nullable
              as MediumOption?,
      channelId: freezed == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String?,
      ytChannels: null == ytChannels
          ? _value.ytChannels
          : ytChannels // ignore: cast_nullable_to_non_nullable
              as List<YTChannel>,
      showSelectResolutionSheet: null == showSelectResolutionSheet
          ? _value.showSelectResolutionSheet
          : showSelectResolutionSheet // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of AddStreamInfoViewState
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

  /// Create a copy of AddStreamInfoViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchModelCopyWith<$Res>? get match {
    if (_value.match == null) {
      return null;
    }

    return $MatchModelCopyWith<$Res>(_value.match!, (value) {
      return _then(_value.copyWith(match: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddStreamInfoViewStateImplCopyWith<$Res>
    implements $AddStreamInfoViewStateCopyWith<$Res> {
  factory _$$AddStreamInfoViewStateImplCopyWith(
          _$AddStreamInfoViewStateImpl value,
          $Res Function(_$AddStreamInfoViewStateImpl) then) =
      __$$AddStreamInfoViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error,
      Object? actionError,
      LiveStreamModel? stream,
      MatchModel? match,
      MediumOption? mediumOption,
      String? channelId,
      List<YTChannel> ytChannels,
      bool showSelectResolutionSheet,
      bool loading});

  @override
  $LiveStreamModelCopyWith<$Res>? get stream;
  @override
  $MatchModelCopyWith<$Res>? get match;
}

/// @nodoc
class __$$AddStreamInfoViewStateImplCopyWithImpl<$Res>
    extends _$AddStreamInfoViewStateCopyWithImpl<$Res,
        _$AddStreamInfoViewStateImpl>
    implements _$$AddStreamInfoViewStateImplCopyWith<$Res> {
  __$$AddStreamInfoViewStateImplCopyWithImpl(
      _$AddStreamInfoViewStateImpl _value,
      $Res Function(_$AddStreamInfoViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddStreamInfoViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? actionError = freezed,
    Object? stream = freezed,
    Object? match = freezed,
    Object? mediumOption = freezed,
    Object? channelId = freezed,
    Object? ytChannels = null,
    Object? showSelectResolutionSheet = null,
    Object? loading = null,
  }) {
    return _then(_$AddStreamInfoViewStateImpl(
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
      stream: freezed == stream
          ? _value.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as LiveStreamModel?,
      match: freezed == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as MatchModel?,
      mediumOption: freezed == mediumOption
          ? _value.mediumOption
          : mediumOption // ignore: cast_nullable_to_non_nullable
              as MediumOption?,
      channelId: freezed == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String?,
      ytChannels: null == ytChannels
          ? _value._ytChannels
          : ytChannels // ignore: cast_nullable_to_non_nullable
              as List<YTChannel>,
      showSelectResolutionSheet: null == showSelectResolutionSheet
          ? _value.showSelectResolutionSheet
          : showSelectResolutionSheet // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AddStreamInfoViewStateImpl implements _AddStreamInfoViewState {
  const _$AddStreamInfoViewStateImpl(
      {this.error,
      this.actionError,
      this.stream,
      this.match,
      this.mediumOption,
      this.channelId,
      final List<YTChannel> ytChannels = const [],
      this.showSelectResolutionSheet = false,
      this.loading = false})
      : _ytChannels = ytChannels;

  @override
  final Object? error;
  @override
  final Object? actionError;
  @override
  final LiveStreamModel? stream;
  @override
  final MatchModel? match;
  @override
  final MediumOption? mediumOption;
  @override
  final String? channelId;
  final List<YTChannel> _ytChannels;
  @override
  @JsonKey()
  List<YTChannel> get ytChannels {
    if (_ytChannels is EqualUnmodifiableListView) return _ytChannels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ytChannels);
  }

  @override
  @JsonKey()
  final bool showSelectResolutionSheet;
  @override
  @JsonKey()
  final bool loading;

  @override
  String toString() {
    return 'AddStreamInfoViewState(error: $error, actionError: $actionError, stream: $stream, match: $match, mediumOption: $mediumOption, channelId: $channelId, ytChannels: $ytChannels, showSelectResolutionSheet: $showSelectResolutionSheet, loading: $loading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddStreamInfoViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError) &&
            (identical(other.stream, stream) || other.stream == stream) &&
            (identical(other.match, match) || other.match == match) &&
            (identical(other.mediumOption, mediumOption) ||
                other.mediumOption == mediumOption) &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            const DeepCollectionEquality()
                .equals(other._ytChannels, _ytChannels) &&
            (identical(other.showSelectResolutionSheet,
                    showSelectResolutionSheet) ||
                other.showSelectResolutionSheet == showSelectResolutionSheet) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(actionError),
      stream,
      match,
      mediumOption,
      channelId,
      const DeepCollectionEquality().hash(_ytChannels),
      showSelectResolutionSheet,
      loading);

  /// Create a copy of AddStreamInfoViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddStreamInfoViewStateImplCopyWith<_$AddStreamInfoViewStateImpl>
      get copyWith => __$$AddStreamInfoViewStateImplCopyWithImpl<
          _$AddStreamInfoViewStateImpl>(this, _$identity);
}

abstract class _AddStreamInfoViewState implements AddStreamInfoViewState {
  const factory _AddStreamInfoViewState(
      {final Object? error,
      final Object? actionError,
      final LiveStreamModel? stream,
      final MatchModel? match,
      final MediumOption? mediumOption,
      final String? channelId,
      final List<YTChannel> ytChannels,
      final bool showSelectResolutionSheet,
      final bool loading}) = _$AddStreamInfoViewStateImpl;

  @override
  Object? get error;
  @override
  Object? get actionError;
  @override
  LiveStreamModel? get stream;
  @override
  MatchModel? get match;
  @override
  MediumOption? get mediumOption;
  @override
  String? get channelId;
  @override
  List<YTChannel> get ytChannels;
  @override
  bool get showSelectResolutionSheet;
  @override
  bool get loading;

  /// Create a copy of AddStreamInfoViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddStreamInfoViewStateImplCopyWith<_$AddStreamInfoViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
