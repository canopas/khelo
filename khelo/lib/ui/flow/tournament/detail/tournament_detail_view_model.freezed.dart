// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournament_detail_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TournamentDetailState {
  TournamentModel? get tournament => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  int get selectedTab => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  Object? get actionError => throw _privateConstructorUsedError;
  String? get matchFilter => throw _privateConstructorUsedError;
  List<MatchModel> get filteredMatches => throw _privateConstructorUsedError;
  KeyStatTag get statFilter => throw _privateConstructorUsedError;
  List<PlayerKeyStat> get filteredStats => throw _privateConstructorUsedError;
  List<TeamPoint> get teamPoints => throw _privateConstructorUsedError;

  /// Create a copy of TournamentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TournamentDetailStateCopyWith<TournamentDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentDetailStateCopyWith<$Res> {
  factory $TournamentDetailStateCopyWith(TournamentDetailState value,
          $Res Function(TournamentDetailState) then) =
      _$TournamentDetailStateCopyWithImpl<$Res, TournamentDetailState>;
  @useResult
  $Res call(
      {TournamentModel? tournament,
      bool loading,
      int selectedTab,
      Object? error,
      Object? actionError,
      String? matchFilter,
      List<MatchModel> filteredMatches,
      KeyStatTag statFilter,
      List<PlayerKeyStat> filteredStats,
      List<TeamPoint> teamPoints});

  $TournamentModelCopyWith<$Res>? get tournament;
}

/// @nodoc
class _$TournamentDetailStateCopyWithImpl<$Res,
        $Val extends TournamentDetailState>
    implements $TournamentDetailStateCopyWith<$Res> {
  _$TournamentDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TournamentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournament = freezed,
    Object? loading = null,
    Object? selectedTab = null,
    Object? error = freezed,
    Object? actionError = freezed,
    Object? matchFilter = freezed,
    Object? filteredMatches = null,
    Object? statFilter = null,
    Object? filteredStats = null,
    Object? teamPoints = null,
  }) {
    return _then(_value.copyWith(
      tournament: freezed == tournament
          ? _value.tournament
          : tournament // ignore: cast_nullable_to_non_nullable
              as TournamentModel?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
      matchFilter: freezed == matchFilter
          ? _value.matchFilter
          : matchFilter // ignore: cast_nullable_to_non_nullable
              as String?,
      filteredMatches: null == filteredMatches
          ? _value.filteredMatches
          : filteredMatches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
      statFilter: null == statFilter
          ? _value.statFilter
          : statFilter // ignore: cast_nullable_to_non_nullable
              as KeyStatTag,
      filteredStats: null == filteredStats
          ? _value.filteredStats
          : filteredStats // ignore: cast_nullable_to_non_nullable
              as List<PlayerKeyStat>,
      teamPoints: null == teamPoints
          ? _value.teamPoints
          : teamPoints // ignore: cast_nullable_to_non_nullable
              as List<TeamPoint>,
    ) as $Val);
  }

  /// Create a copy of TournamentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TournamentModelCopyWith<$Res>? get tournament {
    if (_value.tournament == null) {
      return null;
    }

    return $TournamentModelCopyWith<$Res>(_value.tournament!, (value) {
      return _then(_value.copyWith(tournament: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TournamentDetailStateImplCopyWith<$Res>
    implements $TournamentDetailStateCopyWith<$Res> {
  factory _$$TournamentDetailStateImplCopyWith(
          _$TournamentDetailStateImpl value,
          $Res Function(_$TournamentDetailStateImpl) then) =
      __$$TournamentDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TournamentModel? tournament,
      bool loading,
      int selectedTab,
      Object? error,
      Object? actionError,
      String? matchFilter,
      List<MatchModel> filteredMatches,
      KeyStatTag statFilter,
      List<PlayerKeyStat> filteredStats,
      List<TeamPoint> teamPoints});

  @override
  $TournamentModelCopyWith<$Res>? get tournament;
}

/// @nodoc
class __$$TournamentDetailStateImplCopyWithImpl<$Res>
    extends _$TournamentDetailStateCopyWithImpl<$Res,
        _$TournamentDetailStateImpl>
    implements _$$TournamentDetailStateImplCopyWith<$Res> {
  __$$TournamentDetailStateImplCopyWithImpl(_$TournamentDetailStateImpl _value,
      $Res Function(_$TournamentDetailStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TournamentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournament = freezed,
    Object? loading = null,
    Object? selectedTab = null,
    Object? error = freezed,
    Object? actionError = freezed,
    Object? matchFilter = freezed,
    Object? filteredMatches = null,
    Object? statFilter = null,
    Object? filteredStats = null,
    Object? teamPoints = null,
  }) {
    return _then(_$TournamentDetailStateImpl(
      tournament: freezed == tournament
          ? _value.tournament
          : tournament // ignore: cast_nullable_to_non_nullable
              as TournamentModel?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
      matchFilter: freezed == matchFilter
          ? _value.matchFilter
          : matchFilter // ignore: cast_nullable_to_non_nullable
              as String?,
      filteredMatches: null == filteredMatches
          ? _value._filteredMatches
          : filteredMatches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
      statFilter: null == statFilter
          ? _value.statFilter
          : statFilter // ignore: cast_nullable_to_non_nullable
              as KeyStatTag,
      filteredStats: null == filteredStats
          ? _value._filteredStats
          : filteredStats // ignore: cast_nullable_to_non_nullable
              as List<PlayerKeyStat>,
      teamPoints: null == teamPoints
          ? _value._teamPoints
          : teamPoints // ignore: cast_nullable_to_non_nullable
              as List<TeamPoint>,
    ));
  }
}

/// @nodoc

class _$TournamentDetailStateImpl implements _TournamentDetailState {
  const _$TournamentDetailStateImpl(
      {this.tournament = null,
      this.loading = false,
      this.selectedTab = 0,
      this.error,
      this.actionError,
      this.matchFilter = null,
      final List<MatchModel> filteredMatches = const [],
      this.statFilter = KeyStatTag.mostRuns,
      final List<PlayerKeyStat> filteredStats = const [],
      final List<TeamPoint> teamPoints = const []})
      : _filteredMatches = filteredMatches,
        _filteredStats = filteredStats,
        _teamPoints = teamPoints;

  @override
  @JsonKey()
  final TournamentModel? tournament;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final int selectedTab;
  @override
  final Object? error;
  @override
  final Object? actionError;
  @override
  @JsonKey()
  final String? matchFilter;
  final List<MatchModel> _filteredMatches;
  @override
  @JsonKey()
  List<MatchModel> get filteredMatches {
    if (_filteredMatches is EqualUnmodifiableListView) return _filteredMatches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredMatches);
  }

  @override
  @JsonKey()
  final KeyStatTag statFilter;
  final List<PlayerKeyStat> _filteredStats;
  @override
  @JsonKey()
  List<PlayerKeyStat> get filteredStats {
    if (_filteredStats is EqualUnmodifiableListView) return _filteredStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredStats);
  }

  final List<TeamPoint> _teamPoints;
  @override
  @JsonKey()
  List<TeamPoint> get teamPoints {
    if (_teamPoints is EqualUnmodifiableListView) return _teamPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamPoints);
  }

  @override
  String toString() {
    return 'TournamentDetailState(tournament: $tournament, loading: $loading, selectedTab: $selectedTab, error: $error, actionError: $actionError, matchFilter: $matchFilter, filteredMatches: $filteredMatches, statFilter: $statFilter, filteredStats: $filteredStats, teamPoints: $teamPoints)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentDetailStateImpl &&
            (identical(other.tournament, tournament) ||
                other.tournament == tournament) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError) &&
            (identical(other.matchFilter, matchFilter) ||
                other.matchFilter == matchFilter) &&
            const DeepCollectionEquality()
                .equals(other._filteredMatches, _filteredMatches) &&
            (identical(other.statFilter, statFilter) ||
                other.statFilter == statFilter) &&
            const DeepCollectionEquality()
                .equals(other._filteredStats, _filteredStats) &&
            const DeepCollectionEquality()
                .equals(other._teamPoints, _teamPoints));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      tournament,
      loading,
      selectedTab,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(actionError),
      matchFilter,
      const DeepCollectionEquality().hash(_filteredMatches),
      statFilter,
      const DeepCollectionEquality().hash(_filteredStats),
      const DeepCollectionEquality().hash(_teamPoints));

  /// Create a copy of TournamentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentDetailStateImplCopyWith<_$TournamentDetailStateImpl>
      get copyWith => __$$TournamentDetailStateImplCopyWithImpl<
          _$TournamentDetailStateImpl>(this, _$identity);
}

abstract class _TournamentDetailState implements TournamentDetailState {
  const factory _TournamentDetailState(
      {final TournamentModel? tournament,
      final bool loading,
      final int selectedTab,
      final Object? error,
      final Object? actionError,
      final String? matchFilter,
      final List<MatchModel> filteredMatches,
      final KeyStatTag statFilter,
      final List<PlayerKeyStat> filteredStats,
      final List<TeamPoint> teamPoints}) = _$TournamentDetailStateImpl;

  @override
  TournamentModel? get tournament;
  @override
  bool get loading;
  @override
  int get selectedTab;
  @override
  Object? get error;
  @override
  Object? get actionError;
  @override
  String? get matchFilter;
  @override
  List<MatchModel> get filteredMatches;
  @override
  KeyStatTag get statFilter;
  @override
  List<PlayerKeyStat> get filteredStats;
  @override
  List<TeamPoint> get teamPoints;

  /// Create a copy of TournamentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TournamentDetailStateImplCopyWith<_$TournamentDetailStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
