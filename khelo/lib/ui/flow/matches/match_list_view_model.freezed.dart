// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_list_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MatchListViewState {
  Object? get error => throw _privateConstructorUsedError;
  String? get currentUserId => throw _privateConstructorUsedError;
  List<MatchModel> get matches => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  /// Create a copy of MatchListViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchListViewStateCopyWith<MatchListViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchListViewStateCopyWith<$Res> {
  factory $MatchListViewStateCopyWith(
          MatchListViewState value, $Res Function(MatchListViewState) then) =
      _$MatchListViewStateCopyWithImpl<$Res, MatchListViewState>;
  @useResult
  $Res call(
      {Object? error,
      String? currentUserId,
      List<MatchModel> matches,
      bool loading});
}

/// @nodoc
class _$MatchListViewStateCopyWithImpl<$Res, $Val extends MatchListViewState>
    implements $MatchListViewStateCopyWith<$Res> {
  _$MatchListViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchListViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? currentUserId = freezed,
    Object? matches = null,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      matches: null == matches
          ? _value.matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchListViewStateImplCopyWith<$Res>
    implements $MatchListViewStateCopyWith<$Res> {
  factory _$$MatchListViewStateImplCopyWith(_$MatchListViewStateImpl value,
          $Res Function(_$MatchListViewStateImpl) then) =
      __$$MatchListViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error,
      String? currentUserId,
      List<MatchModel> matches,
      bool loading});
}

/// @nodoc
class __$$MatchListViewStateImplCopyWithImpl<$Res>
    extends _$MatchListViewStateCopyWithImpl<$Res, _$MatchListViewStateImpl>
    implements _$$MatchListViewStateImplCopyWith<$Res> {
  __$$MatchListViewStateImplCopyWithImpl(_$MatchListViewStateImpl _value,
      $Res Function(_$MatchListViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchListViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? currentUserId = freezed,
    Object? matches = null,
    Object? loading = null,
  }) {
    return _then(_$MatchListViewStateImpl(
      error: freezed == error ? _value.error : error,
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      matches: null == matches
          ? _value._matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MatchListViewStateImpl implements _MatchListViewState {
  const _$MatchListViewStateImpl(
      {this.error,
      this.currentUserId,
      final List<MatchModel> matches = const [],
      this.loading = false})
      : _matches = matches;

  @override
  final Object? error;
  @override
  final String? currentUserId;
  final List<MatchModel> _matches;
  @override
  @JsonKey()
  List<MatchModel> get matches {
    if (_matches is EqualUnmodifiableListView) return _matches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matches);
  }

  @override
  @JsonKey()
  final bool loading;

  @override
  String toString() {
    return 'MatchListViewState(error: $error, currentUserId: $currentUserId, matches: $matches, loading: $loading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchListViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId) &&
            const DeepCollectionEquality().equals(other._matches, _matches) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      currentUserId,
      const DeepCollectionEquality().hash(_matches),
      loading);

  /// Create a copy of MatchListViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchListViewStateImplCopyWith<_$MatchListViewStateImpl> get copyWith =>
      __$$MatchListViewStateImplCopyWithImpl<_$MatchListViewStateImpl>(
          this, _$identity);
}

abstract class _MatchListViewState implements MatchListViewState {
  const factory _MatchListViewState(
      {final Object? error,
      final String? currentUserId,
      final List<MatchModel> matches,
      final bool loading}) = _$MatchListViewStateImpl;

  @override
  Object? get error;
  @override
  String? get currentUserId;
  @override
  List<MatchModel> get matches;
  @override
  bool get loading;

  /// Create a copy of MatchListViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchListViewStateImplCopyWith<_$MatchListViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
