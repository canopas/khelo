// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_list_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TeamListViewState {
  Object? get error => throw _privateConstructorUsedError;
  DateTime? get showFilterOptionSheet => throw _privateConstructorUsedError;
  String? get currentUserId => throw _privateConstructorUsedError;
  List<TeamModel> get teams => throw _privateConstructorUsedError;
  List<TeamModel> get filteredTeams => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  TeamFilterOption get selectedFilter => throw _privateConstructorUsedError;

  /// Create a copy of TeamListViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamListViewStateCopyWith<TeamListViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamListViewStateCopyWith<$Res> {
  factory $TeamListViewStateCopyWith(
          TeamListViewState value, $Res Function(TeamListViewState) then) =
      _$TeamListViewStateCopyWithImpl<$Res, TeamListViewState>;
  @useResult
  $Res call(
      {Object? error,
      DateTime? showFilterOptionSheet,
      String? currentUserId,
      List<TeamModel> teams,
      List<TeamModel> filteredTeams,
      bool loading,
      TeamFilterOption selectedFilter});
}

/// @nodoc
class _$TeamListViewStateCopyWithImpl<$Res, $Val extends TeamListViewState>
    implements $TeamListViewStateCopyWith<$Res> {
  _$TeamListViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamListViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? showFilterOptionSheet = freezed,
    Object? currentUserId = freezed,
    Object? teams = null,
    Object? filteredTeams = null,
    Object? loading = null,
    Object? selectedFilter = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      showFilterOptionSheet: freezed == showFilterOptionSheet
          ? _value.showFilterOptionSheet
          : showFilterOptionSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
      filteredTeams: null == filteredTeams
          ? _value.filteredTeams
          : filteredTeams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedFilter: null == selectedFilter
          ? _value.selectedFilter
          : selectedFilter // ignore: cast_nullable_to_non_nullable
              as TeamFilterOption,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamListViewStateImplCopyWith<$Res>
    implements $TeamListViewStateCopyWith<$Res> {
  factory _$$TeamListViewStateImplCopyWith(_$TeamListViewStateImpl value,
          $Res Function(_$TeamListViewStateImpl) then) =
      __$$TeamListViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error,
      DateTime? showFilterOptionSheet,
      String? currentUserId,
      List<TeamModel> teams,
      List<TeamModel> filteredTeams,
      bool loading,
      TeamFilterOption selectedFilter});
}

/// @nodoc
class __$$TeamListViewStateImplCopyWithImpl<$Res>
    extends _$TeamListViewStateCopyWithImpl<$Res, _$TeamListViewStateImpl>
    implements _$$TeamListViewStateImplCopyWith<$Res> {
  __$$TeamListViewStateImplCopyWithImpl(_$TeamListViewStateImpl _value,
      $Res Function(_$TeamListViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeamListViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? showFilterOptionSheet = freezed,
    Object? currentUserId = freezed,
    Object? teams = null,
    Object? filteredTeams = null,
    Object? loading = null,
    Object? selectedFilter = null,
  }) {
    return _then(_$TeamListViewStateImpl(
      error: freezed == error ? _value.error : error,
      showFilterOptionSheet: freezed == showFilterOptionSheet
          ? _value.showFilterOptionSheet
          : showFilterOptionSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      teams: null == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
      filteredTeams: null == filteredTeams
          ? _value._filteredTeams
          : filteredTeams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedFilter: null == selectedFilter
          ? _value.selectedFilter
          : selectedFilter // ignore: cast_nullable_to_non_nullable
              as TeamFilterOption,
    ));
  }
}

/// @nodoc

class _$TeamListViewStateImpl implements _TeamListViewState {
  const _$TeamListViewStateImpl(
      {this.error,
      this.showFilterOptionSheet,
      this.currentUserId,
      final List<TeamModel> teams = const [],
      final List<TeamModel> filteredTeams = const [],
      this.loading = false,
      this.selectedFilter = TeamFilterOption.all})
      : _teams = teams,
        _filteredTeams = filteredTeams;

  @override
  final Object? error;
  @override
  final DateTime? showFilterOptionSheet;
  @override
  final String? currentUserId;
  final List<TeamModel> _teams;
  @override
  @JsonKey()
  List<TeamModel> get teams {
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teams);
  }

  final List<TeamModel> _filteredTeams;
  @override
  @JsonKey()
  List<TeamModel> get filteredTeams {
    if (_filteredTeams is EqualUnmodifiableListView) return _filteredTeams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredTeams);
  }

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final TeamFilterOption selectedFilter;

  @override
  String toString() {
    return 'TeamListViewState(error: $error, showFilterOptionSheet: $showFilterOptionSheet, currentUserId: $currentUserId, teams: $teams, filteredTeams: $filteredTeams, loading: $loading, selectedFilter: $selectedFilter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamListViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.showFilterOptionSheet, showFilterOptionSheet) ||
                other.showFilterOptionSheet == showFilterOptionSheet) &&
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            const DeepCollectionEquality()
                .equals(other._filteredTeams, _filteredTeams) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.selectedFilter, selectedFilter) ||
                other.selectedFilter == selectedFilter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      showFilterOptionSheet,
      currentUserId,
      const DeepCollectionEquality().hash(_teams),
      const DeepCollectionEquality().hash(_filteredTeams),
      loading,
      selectedFilter);

  /// Create a copy of TeamListViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamListViewStateImplCopyWith<_$TeamListViewStateImpl> get copyWith =>
      __$$TeamListViewStateImplCopyWithImpl<_$TeamListViewStateImpl>(
          this, _$identity);
}

abstract class _TeamListViewState implements TeamListViewState {
  const factory _TeamListViewState(
      {final Object? error,
      final DateTime? showFilterOptionSheet,
      final String? currentUserId,
      final List<TeamModel> teams,
      final List<TeamModel> filteredTeams,
      final bool loading,
      final TeamFilterOption selectedFilter}) = _$TeamListViewStateImpl;

  @override
  Object? get error;
  @override
  DateTime? get showFilterOptionSheet;
  @override
  String? get currentUserId;
  @override
  List<TeamModel> get teams;
  @override
  List<TeamModel> get filteredTeams;
  @override
  bool get loading;
  @override
  TeamFilterOption get selectedFilter;

  /// Create a copy of TeamListViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamListViewStateImplCopyWith<_$TeamListViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
