// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_selection_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MatchSelectionState {
  TextEditingController get searchController =>
      throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  Object? get actionError => throw _privateConstructorUsedError;
  TournamentModel? get tournament => throw _privateConstructorUsedError;
  Map<MatchGroup, Map<int, List<MatchModel>>> get searchResults =>
      throw _privateConstructorUsedError;
  Map<MatchGroup, Map<int, List<MatchModel>>> get matches =>
      throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get searchInProgress => throw _privateConstructorUsedError;

  /// Create a copy of MatchSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchSelectionStateCopyWith<MatchSelectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchSelectionStateCopyWith<$Res> {
  factory $MatchSelectionStateCopyWith(
          MatchSelectionState value, $Res Function(MatchSelectionState) then) =
      _$MatchSelectionStateCopyWithImpl<$Res, MatchSelectionState>;
  @useResult
  $Res call(
      {TextEditingController searchController,
      Object? error,
      Object? actionError,
      TournamentModel? tournament,
      Map<MatchGroup, Map<int, List<MatchModel>>> searchResults,
      Map<MatchGroup, Map<int, List<MatchModel>>> matches,
      bool loading,
      bool searchInProgress});

  $TournamentModelCopyWith<$Res>? get tournament;
}

/// @nodoc
class _$MatchSelectionStateCopyWithImpl<$Res, $Val extends MatchSelectionState>
    implements $MatchSelectionStateCopyWith<$Res> {
  _$MatchSelectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? error = freezed,
    Object? actionError = freezed,
    Object? tournament = freezed,
    Object? searchResults = null,
    Object? matches = null,
    Object? loading = null,
    Object? searchInProgress = null,
  }) {
    return _then(_value.copyWith(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
      tournament: freezed == tournament
          ? _value.tournament
          : tournament // ignore: cast_nullable_to_non_nullable
              as TournamentModel?,
      searchResults: null == searchResults
          ? _value.searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as Map<MatchGroup, Map<int, List<MatchModel>>>,
      matches: null == matches
          ? _value.matches
          : matches // ignore: cast_nullable_to_non_nullable
              as Map<MatchGroup, Map<int, List<MatchModel>>>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      searchInProgress: null == searchInProgress
          ? _value.searchInProgress
          : searchInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of MatchSelectionState
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
abstract class _$$MatchSelectionStateImplCopyWith<$Res>
    implements $MatchSelectionStateCopyWith<$Res> {
  factory _$$MatchSelectionStateImplCopyWith(_$MatchSelectionStateImpl value,
          $Res Function(_$MatchSelectionStateImpl) then) =
      __$$MatchSelectionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController searchController,
      Object? error,
      Object? actionError,
      TournamentModel? tournament,
      Map<MatchGroup, Map<int, List<MatchModel>>> searchResults,
      Map<MatchGroup, Map<int, List<MatchModel>>> matches,
      bool loading,
      bool searchInProgress});

  @override
  $TournamentModelCopyWith<$Res>? get tournament;
}

/// @nodoc
class __$$MatchSelectionStateImplCopyWithImpl<$Res>
    extends _$MatchSelectionStateCopyWithImpl<$Res, _$MatchSelectionStateImpl>
    implements _$$MatchSelectionStateImplCopyWith<$Res> {
  __$$MatchSelectionStateImplCopyWithImpl(_$MatchSelectionStateImpl _value,
      $Res Function(_$MatchSelectionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? error = freezed,
    Object? actionError = freezed,
    Object? tournament = freezed,
    Object? searchResults = null,
    Object? matches = null,
    Object? loading = null,
    Object? searchInProgress = null,
  }) {
    return _then(_$MatchSelectionStateImpl(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
      tournament: freezed == tournament
          ? _value.tournament
          : tournament // ignore: cast_nullable_to_non_nullable
              as TournamentModel?,
      searchResults: null == searchResults
          ? _value._searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as Map<MatchGroup, Map<int, List<MatchModel>>>,
      matches: null == matches
          ? _value._matches
          : matches // ignore: cast_nullable_to_non_nullable
              as Map<MatchGroup, Map<int, List<MatchModel>>>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      searchInProgress: null == searchInProgress
          ? _value.searchInProgress
          : searchInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MatchSelectionStateImpl implements _MatchSelectionState {
  const _$MatchSelectionStateImpl(
      {required this.searchController,
      this.error,
      this.actionError,
      this.tournament,
      final Map<MatchGroup, Map<int, List<MatchModel>>> searchResults =
          const {},
      final Map<MatchGroup, Map<int, List<MatchModel>>> matches = const {},
      this.loading = false,
      this.searchInProgress = false})
      : _searchResults = searchResults,
        _matches = matches;

  @override
  final TextEditingController searchController;
  @override
  final Object? error;
  @override
  final Object? actionError;
  @override
  final TournamentModel? tournament;
  final Map<MatchGroup, Map<int, List<MatchModel>>> _searchResults;
  @override
  @JsonKey()
  Map<MatchGroup, Map<int, List<MatchModel>>> get searchResults {
    if (_searchResults is EqualUnmodifiableMapView) return _searchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_searchResults);
  }

  final Map<MatchGroup, Map<int, List<MatchModel>>> _matches;
  @override
  @JsonKey()
  Map<MatchGroup, Map<int, List<MatchModel>>> get matches {
    if (_matches is EqualUnmodifiableMapView) return _matches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_matches);
  }

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool searchInProgress;

  @override
  String toString() {
    return 'MatchSelectionState(searchController: $searchController, error: $error, actionError: $actionError, tournament: $tournament, searchResults: $searchResults, matches: $matches, loading: $loading, searchInProgress: $searchInProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchSelectionStateImpl &&
            (identical(other.searchController, searchController) ||
                other.searchController == searchController) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError) &&
            (identical(other.tournament, tournament) ||
                other.tournament == tournament) &&
            const DeepCollectionEquality()
                .equals(other._searchResults, _searchResults) &&
            const DeepCollectionEquality().equals(other._matches, _matches) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.searchInProgress, searchInProgress) ||
                other.searchInProgress == searchInProgress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      searchController,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(actionError),
      tournament,
      const DeepCollectionEquality().hash(_searchResults),
      const DeepCollectionEquality().hash(_matches),
      loading,
      searchInProgress);

  /// Create a copy of MatchSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchSelectionStateImplCopyWith<_$MatchSelectionStateImpl> get copyWith =>
      __$$MatchSelectionStateImplCopyWithImpl<_$MatchSelectionStateImpl>(
          this, _$identity);
}

abstract class _MatchSelectionState implements MatchSelectionState {
  const factory _MatchSelectionState(
      {required final TextEditingController searchController,
      final Object? error,
      final Object? actionError,
      final TournamentModel? tournament,
      final Map<MatchGroup, Map<int, List<MatchModel>>> searchResults,
      final Map<MatchGroup, Map<int, List<MatchModel>>> matches,
      final bool loading,
      final bool searchInProgress}) = _$MatchSelectionStateImpl;

  @override
  TextEditingController get searchController;
  @override
  Object? get error;
  @override
  Object? get actionError;
  @override
  TournamentModel? get tournament;
  @override
  Map<MatchGroup, Map<int, List<MatchModel>>> get searchResults;
  @override
  Map<MatchGroup, Map<int, List<MatchModel>>> get matches;
  @override
  bool get loading;
  @override
  bool get searchInProgress;

  /// Create a copy of MatchSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchSelectionStateImplCopyWith<_$MatchSelectionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
