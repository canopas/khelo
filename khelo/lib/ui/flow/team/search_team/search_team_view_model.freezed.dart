// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_team_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchTeamState {
  TextEditingController get searchController =>
      throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  String? get actionError => throw _privateConstructorUsedError;
  TeamModel? get selectedTeam => throw _privateConstructorUsedError;
  List<TeamModel> get searchResults => throw _privateConstructorUsedError;
  List<TeamModel> get userTeams => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get searchInProgress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchTeamStateCopyWith<SearchTeamState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchTeamStateCopyWith<$Res> {
  factory $SearchTeamStateCopyWith(
          SearchTeamState value, $Res Function(SearchTeamState) then) =
      _$SearchTeamStateCopyWithImpl<$Res, SearchTeamState>;
  @useResult
  $Res call(
      {TextEditingController searchController,
      Object? error,
      String? actionError,
      TeamModel? selectedTeam,
      List<TeamModel> searchResults,
      List<TeamModel> userTeams,
      bool loading,
      bool searchInProgress});

  $TeamModelCopyWith<$Res>? get selectedTeam;
}

/// @nodoc
class _$SearchTeamStateCopyWithImpl<$Res, $Val extends SearchTeamState>
    implements $SearchTeamStateCopyWith<$Res> {
  _$SearchTeamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? error = freezed,
    Object? actionError = freezed,
    Object? selectedTeam = freezed,
    Object? searchResults = null,
    Object? userTeams = null,
    Object? loading = null,
    Object? searchInProgress = null,
  }) {
    return _then(_value.copyWith(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError
          ? _value.actionError
          : actionError // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedTeam: freezed == selectedTeam
          ? _value.selectedTeam
          : selectedTeam // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      searchResults: null == searchResults
          ? _value.searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
      userTeams: null == userTeams
          ? _value.userTeams
          : userTeams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
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

  @override
  @pragma('vm:prefer-inline')
  $TeamModelCopyWith<$Res>? get selectedTeam {
    if (_value.selectedTeam == null) {
      return null;
    }

    return $TeamModelCopyWith<$Res>(_value.selectedTeam!, (value) {
      return _then(_value.copyWith(selectedTeam: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SearchTeamStateImplCopyWith<$Res>
    implements $SearchTeamStateCopyWith<$Res> {
  factory _$$SearchTeamStateImplCopyWith(_$SearchTeamStateImpl value,
          $Res Function(_$SearchTeamStateImpl) then) =
      __$$SearchTeamStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController searchController,
      Object? error,
      String? actionError,
      TeamModel? selectedTeam,
      List<TeamModel> searchResults,
      List<TeamModel> userTeams,
      bool loading,
      bool searchInProgress});

  @override
  $TeamModelCopyWith<$Res>? get selectedTeam;
}

/// @nodoc
class __$$SearchTeamStateImplCopyWithImpl<$Res>
    extends _$SearchTeamStateCopyWithImpl<$Res, _$SearchTeamStateImpl>
    implements _$$SearchTeamStateImplCopyWith<$Res> {
  __$$SearchTeamStateImplCopyWithImpl(
      _$SearchTeamStateImpl _value, $Res Function(_$SearchTeamStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? error = freezed,
    Object? actionError = freezed,
    Object? selectedTeam = freezed,
    Object? searchResults = null,
    Object? userTeams = null,
    Object? loading = null,
    Object? searchInProgress = null,
  }) {
    return _then(_$SearchTeamStateImpl(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError
          ? _value.actionError
          : actionError // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedTeam: freezed == selectedTeam
          ? _value.selectedTeam
          : selectedTeam // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      searchResults: null == searchResults
          ? _value._searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
      userTeams: null == userTeams
          ? _value._userTeams
          : userTeams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
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

class _$SearchTeamStateImpl implements _SearchTeamState {
  const _$SearchTeamStateImpl(
      {required this.searchController,
      this.error,
      this.actionError,
      this.selectedTeam,
      final List<TeamModel> searchResults = const [],
      final List<TeamModel> userTeams = const [],
      this.loading = false,
      this.searchInProgress = false})
      : _searchResults = searchResults,
        _userTeams = userTeams;

  @override
  final TextEditingController searchController;
  @override
  final Object? error;
  @override
  final String? actionError;
  @override
  final TeamModel? selectedTeam;
  final List<TeamModel> _searchResults;
  @override
  @JsonKey()
  List<TeamModel> get searchResults {
    if (_searchResults is EqualUnmodifiableListView) return _searchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchResults);
  }

  final List<TeamModel> _userTeams;
  @override
  @JsonKey()
  List<TeamModel> get userTeams {
    if (_userTeams is EqualUnmodifiableListView) return _userTeams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userTeams);
  }

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool searchInProgress;

  @override
  String toString() {
    return 'SearchTeamState(searchController: $searchController, error: $error, actionError: $actionError, selectedTeam: $selectedTeam, searchResults: $searchResults, userTeams: $userTeams, loading: $loading, searchInProgress: $searchInProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchTeamStateImpl &&
            (identical(other.searchController, searchController) ||
                other.searchController == searchController) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.actionError, actionError) ||
                other.actionError == actionError) &&
            (identical(other.selectedTeam, selectedTeam) ||
                other.selectedTeam == selectedTeam) &&
            const DeepCollectionEquality()
                .equals(other._searchResults, _searchResults) &&
            const DeepCollectionEquality()
                .equals(other._userTeams, _userTeams) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.searchInProgress, searchInProgress) ||
                other.searchInProgress == searchInProgress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      searchController,
      const DeepCollectionEquality().hash(error),
      actionError,
      selectedTeam,
      const DeepCollectionEquality().hash(_searchResults),
      const DeepCollectionEquality().hash(_userTeams),
      loading,
      searchInProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchTeamStateImplCopyWith<_$SearchTeamStateImpl> get copyWith =>
      __$$SearchTeamStateImplCopyWithImpl<_$SearchTeamStateImpl>(
          this, _$identity);
}

abstract class _SearchTeamState implements SearchTeamState {
  const factory _SearchTeamState(
      {required final TextEditingController searchController,
      final Object? error,
      final String? actionError,
      final TeamModel? selectedTeam,
      final List<TeamModel> searchResults,
      final List<TeamModel> userTeams,
      final bool loading,
      final bool searchInProgress}) = _$SearchTeamStateImpl;

  @override
  TextEditingController get searchController;
  @override
  Object? get error;
  @override
  String? get actionError;
  @override
  TeamModel? get selectedTeam;
  @override
  List<TeamModel> get searchResults;
  @override
  List<TeamModel> get userTeams;
  @override
  bool get loading;
  @override
  bool get searchInProgress;
  @override
  @JsonKey(ignore: true)
  _$$SearchTeamStateImplCopyWith<_$SearchTeamStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
