// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_detail_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TeamDetailState {
  Object? get error => throw _privateConstructorUsedError;
  TeamModel? get team => throw _privateConstructorUsedError;
  String? get currentUserId => throw _privateConstructorUsedError;
  List<MatchModel>? get matches => throw _privateConstructorUsedError;
  int get selectedTab => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  MatchStats get matchStats => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TeamDetailStateCopyWith<TeamDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamDetailStateCopyWith<$Res> {
  factory $TeamDetailStateCopyWith(
          TeamDetailState value, $Res Function(TeamDetailState) then) =
      _$TeamDetailStateCopyWithImpl<$Res, TeamDetailState>;
  @useResult
  $Res call(
      {Object? error,
      TeamModel? team,
      String? currentUserId,
      List<MatchModel>? matches,
      int selectedTab,
      bool loading,
      MatchStats matchStats});

  $TeamModelCopyWith<$Res>? get team;
  $MatchStatsCopyWith<$Res> get matchStats;
}

/// @nodoc
class _$TeamDetailStateCopyWithImpl<$Res, $Val extends TeamDetailState>
    implements $TeamDetailStateCopyWith<$Res> {
  _$TeamDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? team = freezed,
    Object? currentUserId = freezed,
    Object? matches = freezed,
    Object? selectedTab = null,
    Object? loading = null,
    Object? matchStats = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      matches: freezed == matches
          ? _value.matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>?,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      matchStats: null == matchStats
          ? _value.matchStats
          : matchStats // ignore: cast_nullable_to_non_nullable
              as MatchStats,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TeamModelCopyWith<$Res>? get team {
    if (_value.team == null) {
      return null;
    }

    return $TeamModelCopyWith<$Res>(_value.team!, (value) {
      return _then(_value.copyWith(team: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MatchStatsCopyWith<$Res> get matchStats {
    return $MatchStatsCopyWith<$Res>(_value.matchStats, (value) {
      return _then(_value.copyWith(matchStats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TeamDetailStateImplCopyWith<$Res>
    implements $TeamDetailStateCopyWith<$Res> {
  factory _$$TeamDetailStateImplCopyWith(_$TeamDetailStateImpl value,
          $Res Function(_$TeamDetailStateImpl) then) =
      __$$TeamDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error,
      TeamModel? team,
      String? currentUserId,
      List<MatchModel>? matches,
      int selectedTab,
      bool loading,
      MatchStats matchStats});

  @override
  $TeamModelCopyWith<$Res>? get team;
  @override
  $MatchStatsCopyWith<$Res> get matchStats;
}

/// @nodoc
class __$$TeamDetailStateImplCopyWithImpl<$Res>
    extends _$TeamDetailStateCopyWithImpl<$Res, _$TeamDetailStateImpl>
    implements _$$TeamDetailStateImplCopyWith<$Res> {
  __$$TeamDetailStateImplCopyWithImpl(
      _$TeamDetailStateImpl _value, $Res Function(_$TeamDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? team = freezed,
    Object? currentUserId = freezed,
    Object? matches = freezed,
    Object? selectedTab = null,
    Object? loading = null,
    Object? matchStats = null,
  }) {
    return _then(_$TeamDetailStateImpl(
      error: freezed == error ? _value.error : error,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      matches: freezed == matches
          ? _value._matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>?,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      matchStats: null == matchStats
          ? _value.matchStats
          : matchStats // ignore: cast_nullable_to_non_nullable
              as MatchStats,
    ));
  }
}

/// @nodoc

class _$TeamDetailStateImpl implements _TeamDetailState {
  const _$TeamDetailStateImpl(
      {this.error,
      this.team,
      this.currentUserId,
      final List<MatchModel>? matches,
      this.selectedTab = 0,
      this.loading = false,
      this.matchStats = const MatchStats()})
      : _matches = matches;

  @override
  final Object? error;
  @override
  final TeamModel? team;
  @override
  final String? currentUserId;
  final List<MatchModel>? _matches;
  @override
  List<MatchModel>? get matches {
    final value = _matches;
    if (value == null) return null;
    if (_matches is EqualUnmodifiableListView) return _matches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int selectedTab;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final MatchStats matchStats;

  @override
  String toString() {
    return 'TeamDetailState(error: $error, team: $team, currentUserId: $currentUserId, matches: $matches, selectedTab: $selectedTab, loading: $loading, matchStats: $matchStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamDetailStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId) &&
            const DeepCollectionEquality().equals(other._matches, _matches) &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.matchStats, matchStats) ||
                other.matchStats == matchStats));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      team,
      currentUserId,
      const DeepCollectionEquality().hash(_matches),
      selectedTab,
      loading,
      matchStats);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamDetailStateImplCopyWith<_$TeamDetailStateImpl> get copyWith =>
      __$$TeamDetailStateImplCopyWithImpl<_$TeamDetailStateImpl>(
          this, _$identity);
}

abstract class _TeamDetailState implements TeamDetailState {
  const factory _TeamDetailState(
      {final Object? error,
      final TeamModel? team,
      final String? currentUserId,
      final List<MatchModel>? matches,
      final int selectedTab,
      final bool loading,
      final MatchStats matchStats}) = _$TeamDetailStateImpl;

  @override
  Object? get error;
  @override
  TeamModel? get team;
  @override
  String? get currentUserId;
  @override
  List<MatchModel>? get matches;
  @override
  int get selectedTab;
  @override
  bool get loading;
  @override
  MatchStats get matchStats;
  @override
  @JsonKey(ignore: true)
  _$$TeamDetailStateImplCopyWith<_$TeamDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
