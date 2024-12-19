// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchHomeViewState {
  TextEditingController get searchController =>
      throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  List<MatchModel> get matches => throw _privateConstructorUsedError;
  List<TeamModel> get teams => throw _privateConstructorUsedError;
  List<TournamentModel> get tournaments => throw _privateConstructorUsedError;
  List<UserModel> get users => throw _privateConstructorUsedError;
  int get selectedTab => throw _privateConstructorUsedError;

  /// Create a copy of SearchHomeViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchHomeViewStateCopyWith<SearchHomeViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchHomeViewStateCopyWith<$Res> {
  factory $SearchHomeViewStateCopyWith(
          SearchHomeViewState value, $Res Function(SearchHomeViewState) then) =
      _$SearchHomeViewStateCopyWithImpl<$Res, SearchHomeViewState>;
  @useResult
  $Res call(
      {TextEditingController searchController,
      Object? error,
      bool loading,
      List<MatchModel> matches,
      List<TeamModel> teams,
      List<TournamentModel> tournaments,
      List<UserModel> users,
      int selectedTab});
}

/// @nodoc
class _$SearchHomeViewStateCopyWithImpl<$Res, $Val extends SearchHomeViewState>
    implements $SearchHomeViewStateCopyWith<$Res> {
  _$SearchHomeViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchHomeViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? error = freezed,
    Object? loading = null,
    Object? matches = null,
    Object? teams = null,
    Object? tournaments = null,
    Object? users = null,
    Object? selectedTab = null,
  }) {
    return _then(_value.copyWith(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      error: freezed == error ? _value.error : error,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      matches: null == matches
          ? _value.matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
      tournaments: null == tournaments
          ? _value.tournaments
          : tournaments // ignore: cast_nullable_to_non_nullable
              as List<TournamentModel>,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchHomeViewStateImplCopyWith<$Res>
    implements $SearchHomeViewStateCopyWith<$Res> {
  factory _$$SearchHomeViewStateImplCopyWith(_$SearchHomeViewStateImpl value,
          $Res Function(_$SearchHomeViewStateImpl) then) =
      __$$SearchHomeViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController searchController,
      Object? error,
      bool loading,
      List<MatchModel> matches,
      List<TeamModel> teams,
      List<TournamentModel> tournaments,
      List<UserModel> users,
      int selectedTab});
}

/// @nodoc
class __$$SearchHomeViewStateImplCopyWithImpl<$Res>
    extends _$SearchHomeViewStateCopyWithImpl<$Res, _$SearchHomeViewStateImpl>
    implements _$$SearchHomeViewStateImplCopyWith<$Res> {
  __$$SearchHomeViewStateImplCopyWithImpl(_$SearchHomeViewStateImpl _value,
      $Res Function(_$SearchHomeViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchHomeViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? error = freezed,
    Object? loading = null,
    Object? matches = null,
    Object? teams = null,
    Object? tournaments = null,
    Object? users = null,
    Object? selectedTab = null,
  }) {
    return _then(_$SearchHomeViewStateImpl(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      error: freezed == error ? _value.error : error,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      matches: null == matches
          ? _value._matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
      teams: null == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
      tournaments: null == tournaments
          ? _value._tournaments
          : tournaments // ignore: cast_nullable_to_non_nullable
              as List<TournamentModel>,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SearchHomeViewStateImpl implements _SearchHomeViewState {
  const _$SearchHomeViewStateImpl(
      {required this.searchController,
      this.error,
      this.loading = false,
      final List<MatchModel> matches = const [],
      final List<TeamModel> teams = const [],
      final List<TournamentModel> tournaments = const [],
      final List<UserModel> users = const [],
      this.selectedTab = 0})
      : _matches = matches,
        _teams = teams,
        _tournaments = tournaments,
        _users = users;

  @override
  final TextEditingController searchController;
  @override
  final Object? error;
  @override
  @JsonKey()
  final bool loading;
  final List<MatchModel> _matches;
  @override
  @JsonKey()
  List<MatchModel> get matches {
    if (_matches is EqualUnmodifiableListView) return _matches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matches);
  }

  final List<TeamModel> _teams;
  @override
  @JsonKey()
  List<TeamModel> get teams {
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teams);
  }

  final List<TournamentModel> _tournaments;
  @override
  @JsonKey()
  List<TournamentModel> get tournaments {
    if (_tournaments is EqualUnmodifiableListView) return _tournaments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tournaments);
  }

  final List<UserModel> _users;
  @override
  @JsonKey()
  List<UserModel> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  @JsonKey()
  final int selectedTab;

  @override
  String toString() {
    return 'SearchHomeViewState(searchController: $searchController, error: $error, loading: $loading, matches: $matches, teams: $teams, tournaments: $tournaments, users: $users, selectedTab: $selectedTab)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchHomeViewStateImpl &&
            (identical(other.searchController, searchController) ||
                other.searchController == searchController) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality().equals(other._matches, _matches) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            const DeepCollectionEquality()
                .equals(other._tournaments, _tournaments) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      searchController,
      const DeepCollectionEquality().hash(error),
      loading,
      const DeepCollectionEquality().hash(_matches),
      const DeepCollectionEquality().hash(_teams),
      const DeepCollectionEquality().hash(_tournaments),
      const DeepCollectionEquality().hash(_users),
      selectedTab);

  /// Create a copy of SearchHomeViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchHomeViewStateImplCopyWith<_$SearchHomeViewStateImpl> get copyWith =>
      __$$SearchHomeViewStateImplCopyWithImpl<_$SearchHomeViewStateImpl>(
          this, _$identity);
}

abstract class _SearchHomeViewState implements SearchHomeViewState {
  const factory _SearchHomeViewState(
      {required final TextEditingController searchController,
      final Object? error,
      final bool loading,
      final List<MatchModel> matches,
      final List<TeamModel> teams,
      final List<TournamentModel> tournaments,
      final List<UserModel> users,
      final int selectedTab}) = _$SearchHomeViewStateImpl;

  @override
  TextEditingController get searchController;
  @override
  Object? get error;
  @override
  bool get loading;
  @override
  List<MatchModel> get matches;
  @override
  List<TeamModel> get teams;
  @override
  List<TournamentModel> get tournaments;
  @override
  List<UserModel> get users;
  @override
  int get selectedTab;

  /// Create a copy of SearchHomeViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchHomeViewStateImplCopyWith<_$SearchHomeViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
