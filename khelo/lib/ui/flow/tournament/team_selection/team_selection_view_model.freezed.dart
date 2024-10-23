// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_selection_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TeamSelectionViewState {
  TextEditingController get searchController =>
      throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  List<TeamModel> get selectedTeams => throw _privateConstructorUsedError;
  List<TeamModel> get searchResults => throw _privateConstructorUsedError;
  List<TeamModel> get userTeams => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get showSelectionError => throw _privateConstructorUsedError;
  bool get searchInProgress => throw _privateConstructorUsedError;

  /// Create a copy of TeamSelectionViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamSelectionViewStateCopyWith<TeamSelectionViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamSelectionViewStateCopyWith<$Res> {
  factory $TeamSelectionViewStateCopyWith(TeamSelectionViewState value,
          $Res Function(TeamSelectionViewState) then) =
      _$TeamSelectionViewStateCopyWithImpl<$Res, TeamSelectionViewState>;
  @useResult
  $Res call(
      {TextEditingController searchController,
      Object? error,
      List<TeamModel> selectedTeams,
      List<TeamModel> searchResults,
      List<TeamModel> userTeams,
      bool loading,
      bool showSelectionError,
      bool searchInProgress});
}

/// @nodoc
class _$TeamSelectionViewStateCopyWithImpl<$Res,
        $Val extends TeamSelectionViewState>
    implements $TeamSelectionViewStateCopyWith<$Res> {
  _$TeamSelectionViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamSelectionViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? error = freezed,
    Object? selectedTeams = null,
    Object? searchResults = null,
    Object? userTeams = null,
    Object? loading = null,
    Object? showSelectionError = null,
    Object? searchInProgress = null,
  }) {
    return _then(_value.copyWith(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      error: freezed == error ? _value.error : error,
      selectedTeams: null == selectedTeams
          ? _value.selectedTeams
          : selectedTeams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
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
      showSelectionError: null == showSelectionError
          ? _value.showSelectionError
          : showSelectionError // ignore: cast_nullable_to_non_nullable
              as bool,
      searchInProgress: null == searchInProgress
          ? _value.searchInProgress
          : searchInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamSelectionViewStateImplCopyWith<$Res>
    implements $TeamSelectionViewStateCopyWith<$Res> {
  factory _$$TeamSelectionViewStateImplCopyWith(
          _$TeamSelectionViewStateImpl value,
          $Res Function(_$TeamSelectionViewStateImpl) then) =
      __$$TeamSelectionViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController searchController,
      Object? error,
      List<TeamModel> selectedTeams,
      List<TeamModel> searchResults,
      List<TeamModel> userTeams,
      bool loading,
      bool showSelectionError,
      bool searchInProgress});
}

/// @nodoc
class __$$TeamSelectionViewStateImplCopyWithImpl<$Res>
    extends _$TeamSelectionViewStateCopyWithImpl<$Res,
        _$TeamSelectionViewStateImpl>
    implements _$$TeamSelectionViewStateImplCopyWith<$Res> {
  __$$TeamSelectionViewStateImplCopyWithImpl(
      _$TeamSelectionViewStateImpl _value,
      $Res Function(_$TeamSelectionViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeamSelectionViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? error = freezed,
    Object? selectedTeams = null,
    Object? searchResults = null,
    Object? userTeams = null,
    Object? loading = null,
    Object? showSelectionError = null,
    Object? searchInProgress = null,
  }) {
    return _then(_$TeamSelectionViewStateImpl(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      error: freezed == error ? _value.error : error,
      selectedTeams: null == selectedTeams
          ? _value._selectedTeams
          : selectedTeams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
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
      showSelectionError: null == showSelectionError
          ? _value.showSelectionError
          : showSelectionError // ignore: cast_nullable_to_non_nullable
              as bool,
      searchInProgress: null == searchInProgress
          ? _value.searchInProgress
          : searchInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TeamSelectionViewStateImpl implements _TeamSelectionViewState {
  const _$TeamSelectionViewStateImpl(
      {required this.searchController,
      this.error,
      final List<TeamModel> selectedTeams = const [],
      final List<TeamModel> searchResults = const [],
      final List<TeamModel> userTeams = const [],
      this.loading = false,
      this.showSelectionError = false,
      this.searchInProgress = false})
      : _selectedTeams = selectedTeams,
        _searchResults = searchResults,
        _userTeams = userTeams;

  @override
  final TextEditingController searchController;
  @override
  final Object? error;
  final List<TeamModel> _selectedTeams;
  @override
  @JsonKey()
  List<TeamModel> get selectedTeams {
    if (_selectedTeams is EqualUnmodifiableListView) return _selectedTeams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedTeams);
  }

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
  final bool showSelectionError;
  @override
  @JsonKey()
  final bool searchInProgress;

  @override
  String toString() {
    return 'TeamSelectionViewState(searchController: $searchController, error: $error, selectedTeams: $selectedTeams, searchResults: $searchResults, userTeams: $userTeams, loading: $loading, showSelectionError: $showSelectionError, searchInProgress: $searchInProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamSelectionViewStateImpl &&
            (identical(other.searchController, searchController) ||
                other.searchController == searchController) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other._selectedTeams, _selectedTeams) &&
            const DeepCollectionEquality()
                .equals(other._searchResults, _searchResults) &&
            const DeepCollectionEquality()
                .equals(other._userTeams, _userTeams) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.showSelectionError, showSelectionError) ||
                other.showSelectionError == showSelectionError) &&
            (identical(other.searchInProgress, searchInProgress) ||
                other.searchInProgress == searchInProgress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      searchController,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(_selectedTeams),
      const DeepCollectionEquality().hash(_searchResults),
      const DeepCollectionEquality().hash(_userTeams),
      loading,
      showSelectionError,
      searchInProgress);

  /// Create a copy of TeamSelectionViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamSelectionViewStateImplCopyWith<_$TeamSelectionViewStateImpl>
      get copyWith => __$$TeamSelectionViewStateImplCopyWithImpl<
          _$TeamSelectionViewStateImpl>(this, _$identity);
}

abstract class _TeamSelectionViewState implements TeamSelectionViewState {
  const factory _TeamSelectionViewState(
      {required final TextEditingController searchController,
      final Object? error,
      final List<TeamModel> selectedTeams,
      final List<TeamModel> searchResults,
      final List<TeamModel> userTeams,
      final bool loading,
      final bool showSelectionError,
      final bool searchInProgress}) = _$TeamSelectionViewStateImpl;

  @override
  TextEditingController get searchController;
  @override
  Object? get error;
  @override
  List<TeamModel> get selectedTeams;
  @override
  List<TeamModel> get searchResults;
  @override
  List<TeamModel> get userTeams;
  @override
  bool get loading;
  @override
  bool get showSelectionError;
  @override
  bool get searchInProgress;

  /// Create a copy of TeamSelectionViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamSelectionViewStateImplCopyWith<_$TeamSelectionViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
