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
  String? get currentUserId => throw _privateConstructorUsedError;
  String? get matchFilter => throw _privateConstructorUsedError;
  List<MatchModel> get matches => throw _privateConstructorUsedError;
  List<TournamentTeamStat> get teamStats => throw _privateConstructorUsedError;
  List<PlayerKeyStat> get keyStats => throw _privateConstructorUsedError;
  List<MatchModel> get filteredMatches => throw _privateConstructorUsedError;
  KeyStatFilterTag get selectedFilterTag => throw _privateConstructorUsedError;
  List<PlayerKeyStat> get filteredStats => throw _privateConstructorUsedError;

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
      String? currentUserId,
      String? matchFilter,
      List<MatchModel> matches,
      List<TournamentTeamStat> teamStats,
      List<PlayerKeyStat> keyStats,
      List<MatchModel> filteredMatches,
      KeyStatFilterTag selectedFilterTag,
      List<PlayerKeyStat> filteredStats});

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
    Object? currentUserId = freezed,
    Object? matchFilter = freezed,
    Object? matches = null,
    Object? teamStats = null,
    Object? keyStats = null,
    Object? filteredMatches = null,
    Object? selectedFilterTag = null,
    Object? filteredStats = null,
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
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      matchFilter: freezed == matchFilter
          ? _value.matchFilter
          : matchFilter // ignore: cast_nullable_to_non_nullable
              as String?,
      matches: null == matches
          ? _value.matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
      teamStats: null == teamStats
          ? _value.teamStats
          : teamStats // ignore: cast_nullable_to_non_nullable
              as List<TournamentTeamStat>,
      keyStats: null == keyStats
          ? _value.keyStats
          : keyStats // ignore: cast_nullable_to_non_nullable
              as List<PlayerKeyStat>,
      filteredMatches: null == filteredMatches
          ? _value.filteredMatches
          : filteredMatches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
      selectedFilterTag: null == selectedFilterTag
          ? _value.selectedFilterTag
          : selectedFilterTag // ignore: cast_nullable_to_non_nullable
              as KeyStatFilterTag,
      filteredStats: null == filteredStats
          ? _value.filteredStats
          : filteredStats // ignore: cast_nullable_to_non_nullable
              as List<PlayerKeyStat>,
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
      String? currentUserId,
      String? matchFilter,
      List<MatchModel> matches,
      List<TournamentTeamStat> teamStats,
      List<PlayerKeyStat> keyStats,
      List<MatchModel> filteredMatches,
      KeyStatFilterTag selectedFilterTag,
      List<PlayerKeyStat> filteredStats});

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
    Object? currentUserId = freezed,
    Object? matchFilter = freezed,
    Object? matches = null,
    Object? teamStats = null,
    Object? keyStats = null,
    Object? filteredMatches = null,
    Object? selectedFilterTag = null,
    Object? filteredStats = null,
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
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      matchFilter: freezed == matchFilter
          ? _value.matchFilter
          : matchFilter // ignore: cast_nullable_to_non_nullable
              as String?,
      matches: null == matches
          ? _value._matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
      teamStats: null == teamStats
          ? _value._teamStats
          : teamStats // ignore: cast_nullable_to_non_nullable
              as List<TournamentTeamStat>,
      keyStats: null == keyStats
          ? _value._keyStats
          : keyStats // ignore: cast_nullable_to_non_nullable
              as List<PlayerKeyStat>,
      filteredMatches: null == filteredMatches
          ? _value._filteredMatches
          : filteredMatches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
      selectedFilterTag: null == selectedFilterTag
          ? _value.selectedFilterTag
          : selectedFilterTag // ignore: cast_nullable_to_non_nullable
              as KeyStatFilterTag,
      filteredStats: null == filteredStats
          ? _value._filteredStats
          : filteredStats // ignore: cast_nullable_to_non_nullable
              as List<PlayerKeyStat>,
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
      this.currentUserId,
      this.matchFilter = null,
      final List<MatchModel> matches = const [],
      final List<TournamentTeamStat> teamStats = const [],
      final List<PlayerKeyStat> keyStats = const [],
      final List<MatchModel> filteredMatches = const [],
      this.selectedFilterTag = KeyStatFilterTag.all,
      final List<PlayerKeyStat> filteredStats = const []})
      : _matches = matches,
        _teamStats = teamStats,
        _keyStats = keyStats,
        _filteredMatches = filteredMatches,
        _filteredStats = filteredStats;

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
  final String? currentUserId;
  @override
  @JsonKey()
  final String? matchFilter;
  final List<MatchModel> _matches;
  @override
  @JsonKey()
  List<MatchModel> get matches {
    if (_matches is EqualUnmodifiableListView) return _matches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matches);
  }

  final List<TournamentTeamStat> _teamStats;
  @override
  @JsonKey()
  List<TournamentTeamStat> get teamStats {
    if (_teamStats is EqualUnmodifiableListView) return _teamStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamStats);
  }

  final List<PlayerKeyStat> _keyStats;
  @override
  @JsonKey()
  List<PlayerKeyStat> get keyStats {
    if (_keyStats is EqualUnmodifiableListView) return _keyStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keyStats);
  }

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
  final KeyStatFilterTag selectedFilterTag;
  final List<PlayerKeyStat> _filteredStats;
  @override
  @JsonKey()
  List<PlayerKeyStat> get filteredStats {
    if (_filteredStats is EqualUnmodifiableListView) return _filteredStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredStats);
  }

  @override
  String toString() {
    return 'TournamentDetailState(tournament: $tournament, loading: $loading, selectedTab: $selectedTab, error: $error, actionError: $actionError, currentUserId: $currentUserId, matchFilter: $matchFilter, matches: $matches, teamStats: $teamStats, keyStats: $keyStats, filteredMatches: $filteredMatches, selectedFilterTag: $selectedFilterTag, filteredStats: $filteredStats)';
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
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId) &&
            (identical(other.matchFilter, matchFilter) ||
                other.matchFilter == matchFilter) &&
            const DeepCollectionEquality().equals(other._matches, _matches) &&
            const DeepCollectionEquality()
                .equals(other._teamStats, _teamStats) &&
            const DeepCollectionEquality().equals(other._keyStats, _keyStats) &&
            const DeepCollectionEquality()
                .equals(other._filteredMatches, _filteredMatches) &&
            (identical(other.selectedFilterTag, selectedFilterTag) ||
                other.selectedFilterTag == selectedFilterTag) &&
            const DeepCollectionEquality()
                .equals(other._filteredStats, _filteredStats));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      tournament,
      loading,
      selectedTab,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(actionError),
      currentUserId,
      matchFilter,
      const DeepCollectionEquality().hash(_matches),
      const DeepCollectionEquality().hash(_teamStats),
      const DeepCollectionEquality().hash(_keyStats),
      const DeepCollectionEquality().hash(_filteredMatches),
      selectedFilterTag,
      const DeepCollectionEquality().hash(_filteredStats));

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
      final String? currentUserId,
      final String? matchFilter,
      final List<MatchModel> matches,
      final List<TournamentTeamStat> teamStats,
      final List<PlayerKeyStat> keyStats,
      final List<MatchModel> filteredMatches,
      final KeyStatFilterTag selectedFilterTag,
      final List<PlayerKeyStat> filteredStats}) = _$TournamentDetailStateImpl;

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
  String? get currentUserId;
  @override
  String? get matchFilter;
  @override
  List<MatchModel> get matches;
  @override
  List<TournamentTeamStat> get teamStats;
  @override
  List<PlayerKeyStat> get keyStats;
  @override
  List<MatchModel> get filteredMatches;
  @override
  KeyStatFilterTag get selectedFilterTag;
  @override
  List<PlayerKeyStat> get filteredStats;

  /// Create a copy of TournamentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TournamentDetailStateImplCopyWith<_$TournamentDetailStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
