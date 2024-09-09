// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_stat_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserStatViewState {
  Object? get error => throw _privateConstructorUsedError;
  String? get currentUserId => throw _privateConstructorUsedError;
  UserStat? get userStat => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  /// Create a copy of UserStatViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStatViewStateCopyWith<UserStatViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatViewStateCopyWith<$Res> {
  factory $UserStatViewStateCopyWith(
          UserStatViewState value, $Res Function(UserStatViewState) then) =
      _$UserStatViewStateCopyWithImpl<$Res, UserStatViewState>;
  @useResult
  $Res call(
      {Object? error, String? currentUserId, UserStat? userStat, bool loading});

  $UserStatCopyWith<$Res>? get userStat;
}

/// @nodoc
class _$UserStatViewStateCopyWithImpl<$Res, $Val extends UserStatViewState>
    implements $UserStatViewStateCopyWith<$Res> {
  _$UserStatViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStatViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? currentUserId = freezed,
    Object? userStat = freezed,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      userStat: freezed == userStat
          ? _value.userStat
          : userStat // ignore: cast_nullable_to_non_nullable
              as UserStat?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of UserStatViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserStatCopyWith<$Res>? get userStat {
    if (_value.userStat == null) {
      return null;
    }

    return $UserStatCopyWith<$Res>(_value.userStat!, (value) {
      return _then(_value.copyWith(userStat: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserStatViewStateImplCopyWith<$Res>
    implements $UserStatViewStateCopyWith<$Res> {
  factory _$$UserStatViewStateImplCopyWith(_$UserStatViewStateImpl value,
          $Res Function(_$UserStatViewStateImpl) then) =
      __$$UserStatViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error, String? currentUserId, UserStat? userStat, bool loading});

  @override
  $UserStatCopyWith<$Res>? get userStat;
}

/// @nodoc
class __$$UserStatViewStateImplCopyWithImpl<$Res>
    extends _$UserStatViewStateCopyWithImpl<$Res, _$UserStatViewStateImpl>
    implements _$$UserStatViewStateImplCopyWith<$Res> {
  __$$UserStatViewStateImplCopyWithImpl(_$UserStatViewStateImpl _value,
      $Res Function(_$UserStatViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserStatViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? currentUserId = freezed,
    Object? userStat = freezed,
    Object? loading = null,
  }) {
    return _then(_$UserStatViewStateImpl(
      error: freezed == error ? _value.error : error,
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      userStat: freezed == userStat
          ? _value.userStat
          : userStat // ignore: cast_nullable_to_non_nullable
              as UserStat?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UserStatViewStateImpl implements _UserStatViewState {
  const _$UserStatViewStateImpl(
      {this.error, this.currentUserId, this.userStat, this.loading = false});

  @override
  final Object? error;
  @override
  final String? currentUserId;
  @override
  final UserStat? userStat;
  @override
  @JsonKey()
  final bool loading;

  @override
  String toString() {
    return 'UserStatViewState(error: $error, currentUserId: $currentUserId, userStat: $userStat, loading: $loading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId) &&
            (identical(other.userStat, userStat) ||
                other.userStat == userStat) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      currentUserId,
      userStat,
      loading);

  /// Create a copy of UserStatViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatViewStateImplCopyWith<_$UserStatViewStateImpl> get copyWith =>
      __$$UserStatViewStateImplCopyWithImpl<_$UserStatViewStateImpl>(
          this, _$identity);
}

abstract class _UserStatViewState implements UserStatViewState {
  const factory _UserStatViewState(
      {final Object? error,
      final String? currentUserId,
      final UserStat? userStat,
      final bool loading}) = _$UserStatViewStateImpl;

  @override
  Object? get error;
  @override
  String? get currentUserId;
  @override
  UserStat? get userStat;
  @override
  bool get loading;

  /// Create a copy of UserStatViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatViewStateImplCopyWith<_$UserStatViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
