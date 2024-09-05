// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_detail_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserDetailViewState {
  Object? get error => throw _privateConstructorUsedError;
  UserModel? get user => throw _privateConstructorUsedError;
  int get selectedTab => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  List<TeamModel> get teams => throw _privateConstructorUsedError;
  int get testMatchesCount => throw _privateConstructorUsedError;
  int get otherMatchesCount => throw _privateConstructorUsedError;
  UserStat get testStats => throw _privateConstructorUsedError;
  UserStat get otherStats => throw _privateConstructorUsedError;

  /// Create a copy of UserDetailViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserDetailViewStateCopyWith<UserDetailViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDetailViewStateCopyWith<$Res> {
  factory $UserDetailViewStateCopyWith(
          UserDetailViewState value, $Res Function(UserDetailViewState) then) =
      _$UserDetailViewStateCopyWithImpl<$Res, UserDetailViewState>;
  @useResult
  $Res call(
      {Object? error,
      UserModel? user,
      int selectedTab,
      bool loading,
      List<TeamModel> teams,
      int testMatchesCount,
      int otherMatchesCount,
      UserStat testStats,
      UserStat otherStats});

  $UserModelCopyWith<$Res>? get user;
  $UserStatCopyWith<$Res> get testStats;
  $UserStatCopyWith<$Res> get otherStats;
}

/// @nodoc
class _$UserDetailViewStateCopyWithImpl<$Res, $Val extends UserDetailViewState>
    implements $UserDetailViewStateCopyWith<$Res> {
  _$UserDetailViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserDetailViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? user = freezed,
    Object? selectedTab = null,
    Object? loading = null,
    Object? teams = null,
    Object? testMatchesCount = null,
    Object? otherMatchesCount = null,
    Object? testStats = null,
    Object? otherStats = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
      testMatchesCount: null == testMatchesCount
          ? _value.testMatchesCount
          : testMatchesCount // ignore: cast_nullable_to_non_nullable
              as int,
      otherMatchesCount: null == otherMatchesCount
          ? _value.otherMatchesCount
          : otherMatchesCount // ignore: cast_nullable_to_non_nullable
              as int,
      testStats: null == testStats
          ? _value.testStats
          : testStats // ignore: cast_nullable_to_non_nullable
              as UserStat,
      otherStats: null == otherStats
          ? _value.otherStats
          : otherStats // ignore: cast_nullable_to_non_nullable
              as UserStat,
    ) as $Val);
  }

  /// Create a copy of UserDetailViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of UserDetailViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserStatCopyWith<$Res> get testStats {
    return $UserStatCopyWith<$Res>(_value.testStats, (value) {
      return _then(_value.copyWith(testStats: value) as $Val);
    });
  }

  /// Create a copy of UserDetailViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserStatCopyWith<$Res> get otherStats {
    return $UserStatCopyWith<$Res>(_value.otherStats, (value) {
      return _then(_value.copyWith(otherStats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserDetailViewStateImplCopyWith<$Res>
    implements $UserDetailViewStateCopyWith<$Res> {
  factory _$$UserDetailViewStateImplCopyWith(_$UserDetailViewStateImpl value,
          $Res Function(_$UserDetailViewStateImpl) then) =
      __$$UserDetailViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error,
      UserModel? user,
      int selectedTab,
      bool loading,
      List<TeamModel> teams,
      int testMatchesCount,
      int otherMatchesCount,
      UserStat testStats,
      UserStat otherStats});

  @override
  $UserModelCopyWith<$Res>? get user;
  @override
  $UserStatCopyWith<$Res> get testStats;
  @override
  $UserStatCopyWith<$Res> get otherStats;
}

/// @nodoc
class __$$UserDetailViewStateImplCopyWithImpl<$Res>
    extends _$UserDetailViewStateCopyWithImpl<$Res, _$UserDetailViewStateImpl>
    implements _$$UserDetailViewStateImplCopyWith<$Res> {
  __$$UserDetailViewStateImplCopyWithImpl(_$UserDetailViewStateImpl _value,
      $Res Function(_$UserDetailViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserDetailViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? user = freezed,
    Object? selectedTab = null,
    Object? loading = null,
    Object? teams = null,
    Object? testMatchesCount = null,
    Object? otherMatchesCount = null,
    Object? testStats = null,
    Object? otherStats = null,
  }) {
    return _then(_$UserDetailViewStateImpl(
      error: freezed == error ? _value.error : error,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      teams: null == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
      testMatchesCount: null == testMatchesCount
          ? _value.testMatchesCount
          : testMatchesCount // ignore: cast_nullable_to_non_nullable
              as int,
      otherMatchesCount: null == otherMatchesCount
          ? _value.otherMatchesCount
          : otherMatchesCount // ignore: cast_nullable_to_non_nullable
              as int,
      testStats: null == testStats
          ? _value.testStats
          : testStats // ignore: cast_nullable_to_non_nullable
              as UserStat,
      otherStats: null == otherStats
          ? _value.otherStats
          : otherStats // ignore: cast_nullable_to_non_nullable
              as UserStat,
    ));
  }
}

/// @nodoc

class _$UserDetailViewStateImpl implements _UserDetailViewState {
  const _$UserDetailViewStateImpl(
      {this.error,
      this.user,
      this.selectedTab = 0,
      this.loading = false,
      final List<TeamModel> teams = const [],
      this.testMatchesCount = 0,
      this.otherMatchesCount = 0,
      this.testStats = const UserStat(),
      this.otherStats = const UserStat()})
      : _teams = teams;

  @override
  final Object? error;
  @override
  final UserModel? user;
  @override
  @JsonKey()
  final int selectedTab;
  @override
  @JsonKey()
  final bool loading;
  final List<TeamModel> _teams;
  @override
  @JsonKey()
  List<TeamModel> get teams {
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teams);
  }

  @override
  @JsonKey()
  final int testMatchesCount;
  @override
  @JsonKey()
  final int otherMatchesCount;
  @override
  @JsonKey()
  final UserStat testStats;
  @override
  @JsonKey()
  final UserStat otherStats;

  @override
  String toString() {
    return 'UserDetailViewState(error: $error, user: $user, selectedTab: $selectedTab, loading: $loading, teams: $teams, testMatchesCount: $testMatchesCount, otherMatchesCount: $otherMatchesCount, testStats: $testStats, otherStats: $otherStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDetailViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            (identical(other.testMatchesCount, testMatchesCount) ||
                other.testMatchesCount == testMatchesCount) &&
            (identical(other.otherMatchesCount, otherMatchesCount) ||
                other.otherMatchesCount == otherMatchesCount) &&
            (identical(other.testStats, testStats) ||
                other.testStats == testStats) &&
            (identical(other.otherStats, otherStats) ||
                other.otherStats == otherStats));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      user,
      selectedTab,
      loading,
      const DeepCollectionEquality().hash(_teams),
      testMatchesCount,
      otherMatchesCount,
      testStats,
      otherStats);

  /// Create a copy of UserDetailViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDetailViewStateImplCopyWith<_$UserDetailViewStateImpl> get copyWith =>
      __$$UserDetailViewStateImplCopyWithImpl<_$UserDetailViewStateImpl>(
          this, _$identity);
}

abstract class _UserDetailViewState implements UserDetailViewState {
  const factory _UserDetailViewState(
      {final Object? error,
      final UserModel? user,
      final int selectedTab,
      final bool loading,
      final List<TeamModel> teams,
      final int testMatchesCount,
      final int otherMatchesCount,
      final UserStat testStats,
      final UserStat otherStats}) = _$UserDetailViewStateImpl;

  @override
  Object? get error;
  @override
  UserModel? get user;
  @override
  int get selectedTab;
  @override
  bool get loading;
  @override
  List<TeamModel> get teams;
  @override
  int get testMatchesCount;
  @override
  int get otherMatchesCount;
  @override
  UserStat get testStats;
  @override
  UserStat get otherStats;

  /// Create a copy of UserDetailViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserDetailViewStateImplCopyWith<_$UserDetailViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
