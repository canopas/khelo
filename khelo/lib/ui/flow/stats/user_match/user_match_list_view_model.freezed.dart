// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_match_list_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserMatchListState {
  Object? get error => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  List<MatchModel> get matches => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserMatchListStateCopyWith<UserMatchListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserMatchListStateCopyWith<$Res> {
  factory $UserMatchListStateCopyWith(
          UserMatchListState value, $Res Function(UserMatchListState) then) =
      _$UserMatchListStateCopyWithImpl<$Res, UserMatchListState>;
  @useResult
  $Res call({Object? error, bool loading, List<MatchModel> matches});
}

/// @nodoc
class _$UserMatchListStateCopyWithImpl<$Res, $Val extends UserMatchListState>
    implements $UserMatchListStateCopyWith<$Res> {
  _$UserMatchListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? loading = null,
    Object? matches = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      matches: null == matches
          ? _value.matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserMatchListStateImplCopyWith<$Res>
    implements $UserMatchListStateCopyWith<$Res> {
  factory _$$UserMatchListStateImplCopyWith(_$UserMatchListStateImpl value,
          $Res Function(_$UserMatchListStateImpl) then) =
      __$$UserMatchListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Object? error, bool loading, List<MatchModel> matches});
}

/// @nodoc
class __$$UserMatchListStateImplCopyWithImpl<$Res>
    extends _$UserMatchListStateCopyWithImpl<$Res, _$UserMatchListStateImpl>
    implements _$$UserMatchListStateImplCopyWith<$Res> {
  __$$UserMatchListStateImplCopyWithImpl(_$UserMatchListStateImpl _value,
      $Res Function(_$UserMatchListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? loading = null,
    Object? matches = null,
  }) {
    return _then(_$UserMatchListStateImpl(
      error: freezed == error ? _value.error : error,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      matches: null == matches
          ? _value._matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
    ));
  }
}

/// @nodoc

class _$UserMatchListStateImpl implements _UserMatchListState {
  const _$UserMatchListStateImpl(
      {this.error,
      this.loading = false,
      final List<MatchModel> matches = const []})
      : _matches = matches;

  @override
  final Object? error;
  @override
  @JsonKey()
  final bool loading;
  final List<MatchModel> _matches;
  @override
  @JsonKey()
  List<MatchModel> get matches {
    if (_matches is EqualUnmodifiableListView) return _matches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matches);
  }

  @override
  String toString() {
    return 'UserMatchListState(error: $error, loading: $loading, matches: $matches)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserMatchListStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality().equals(other._matches, _matches));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      loading,
      const DeepCollectionEquality().hash(_matches));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserMatchListStateImplCopyWith<_$UserMatchListStateImpl> get copyWith =>
      __$$UserMatchListStateImplCopyWithImpl<_$UserMatchListStateImpl>(
          this, _$identity);
}

abstract class _UserMatchListState implements UserMatchListState {
  const factory _UserMatchListState(
      {final Object? error,
      final bool loading,
      final List<MatchModel> matches}) = _$UserMatchListStateImpl;

  @override
  Object? get error;
  @override
  bool get loading;
  @override
  List<MatchModel> get matches;
  @override
  @JsonKey(ignore: true)
  _$$UserMatchListStateImplCopyWith<_$UserMatchListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
