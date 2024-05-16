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
  List<BallScoreModel> get ballList => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
      {Object? error,
      String? currentUserId,
      List<BallScoreModel> ballList,
      bool loading});
}

/// @nodoc
class _$UserStatViewStateCopyWithImpl<$Res, $Val extends UserStatViewState>
    implements $UserStatViewStateCopyWith<$Res> {
  _$UserStatViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? currentUserId = freezed,
    Object? ballList = null,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      ballList: null == ballList
          ? _value.ballList
          : ballList // ignore: cast_nullable_to_non_nullable
              as List<BallScoreModel>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
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
      {Object? error,
      String? currentUserId,
      List<BallScoreModel> ballList,
      bool loading});
}

/// @nodoc
class __$$UserStatViewStateImplCopyWithImpl<$Res>
    extends _$UserStatViewStateCopyWithImpl<$Res, _$UserStatViewStateImpl>
    implements _$$UserStatViewStateImplCopyWith<$Res> {
  __$$UserStatViewStateImplCopyWithImpl(_$UserStatViewStateImpl _value,
      $Res Function(_$UserStatViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? currentUserId = freezed,
    Object? ballList = null,
    Object? loading = null,
  }) {
    return _then(_$UserStatViewStateImpl(
      error: freezed == error ? _value.error : error,
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      ballList: null == ballList
          ? _value._ballList
          : ballList // ignore: cast_nullable_to_non_nullable
              as List<BallScoreModel>,
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
      {this.error,
      this.currentUserId,
      final List<BallScoreModel> ballList = const [],
      this.loading = false})
      : _ballList = ballList;

  @override
  final Object? error;
  @override
  final String? currentUserId;
  final List<BallScoreModel> _ballList;
  @override
  @JsonKey()
  List<BallScoreModel> get ballList {
    if (_ballList is EqualUnmodifiableListView) return _ballList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ballList);
  }

  @override
  @JsonKey()
  final bool loading;

  @override
  String toString() {
    return 'UserStatViewState(error: $error, currentUserId: $currentUserId, ballList: $ballList, loading: $loading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId) &&
            const DeepCollectionEquality().equals(other._ballList, _ballList) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      currentUserId,
      const DeepCollectionEquality().hash(_ballList),
      loading);

  @JsonKey(ignore: true)
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
      final List<BallScoreModel> ballList,
      final bool loading}) = _$UserStatViewStateImpl;

  @override
  Object? get error;
  @override
  String? get currentUserId;
  @override
  List<BallScoreModel> get ballList;
  @override
  bool get loading;
  @override
  @JsonKey(ignore: true)
  _$$UserStatViewStateImplCopyWith<_$UserStatViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
