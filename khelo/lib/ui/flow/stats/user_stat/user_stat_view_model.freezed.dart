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
  int get selectedTab => throw _privateConstructorUsedError;
  List<UserStat>? get userStats => throw _privateConstructorUsedError;
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
      {Object? error,
      int selectedTab,
      List<UserStat>? userStats,
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

  /// Create a copy of UserStatViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? selectedTab = null,
    Object? userStats = freezed,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
      userStats: freezed == userStats
          ? _value.userStats
          : userStats // ignore: cast_nullable_to_non_nullable
              as List<UserStat>?,
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
      int selectedTab,
      List<UserStat>? userStats,
      bool loading});
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
    Object? selectedTab = null,
    Object? userStats = freezed,
    Object? loading = null,
  }) {
    return _then(_$UserStatViewStateImpl(
      error: freezed == error ? _value.error : error,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
      userStats: freezed == userStats
          ? _value._userStats
          : userStats // ignore: cast_nullable_to_non_nullable
              as List<UserStat>?,
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
      this.selectedTab = 0,
      final List<UserStat>? userStats = null,
      this.loading = false})
      : _userStats = userStats;

  @override
  final Object? error;
  @override
  @JsonKey()
  final int selectedTab;
  final List<UserStat>? _userStats;
  @override
  @JsonKey()
  List<UserStat>? get userStats {
    final value = _userStats;
    if (value == null) return null;
    if (_userStats is EqualUnmodifiableListView) return _userStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool loading;

  @override
  String toString() {
    return 'UserStatViewState(error: $error, selectedTab: $selectedTab, userStats: $userStats, loading: $loading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab) &&
            const DeepCollectionEquality()
                .equals(other._userStats, _userStats) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      selectedTab,
      const DeepCollectionEquality().hash(_userStats),
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
      final int selectedTab,
      final List<UserStat>? userStats,
      final bool loading}) = _$UserStatViewStateImpl;

  @override
  Object? get error;
  @override
  int get selectedTab;
  @override
  List<UserStat>? get userStats;
  @override
  bool get loading;

  /// Create a copy of UserStatViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatViewStateImplCopyWith<_$UserStatViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
