// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_substitute_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddSubstituteViewState {
  TextEditingController get searchController =>
      throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  UserModel? get selectedUser => throw _privateConstructorUsedError;
  List<UserModel> get searchedUsers => throw _privateConstructorUsedError;
  List<UserModel> get nonPlayingPlayers => throw _privateConstructorUsedError;
  List<String> get playingSquadIds => throw _privateConstructorUsedError;

  /// Create a copy of AddSubstituteViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddSubstituteViewStateCopyWith<AddSubstituteViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddSubstituteViewStateCopyWith<$Res> {
  factory $AddSubstituteViewStateCopyWith(AddSubstituteViewState value,
          $Res Function(AddSubstituteViewState) then) =
      _$AddSubstituteViewStateCopyWithImpl<$Res, AddSubstituteViewState>;
  @useResult
  $Res call(
      {TextEditingController searchController,
      Object? error,
      UserModel? selectedUser,
      List<UserModel> searchedUsers,
      List<UserModel> nonPlayingPlayers,
      List<String> playingSquadIds});

  $UserModelCopyWith<$Res>? get selectedUser;
}

/// @nodoc
class _$AddSubstituteViewStateCopyWithImpl<$Res,
        $Val extends AddSubstituteViewState>
    implements $AddSubstituteViewStateCopyWith<$Res> {
  _$AddSubstituteViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddSubstituteViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? error = freezed,
    Object? selectedUser = freezed,
    Object? searchedUsers = null,
    Object? nonPlayingPlayers = null,
    Object? playingSquadIds = null,
  }) {
    return _then(_value.copyWith(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      error: freezed == error ? _value.error : error,
      selectedUser: freezed == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      searchedUsers: null == searchedUsers
          ? _value.searchedUsers
          : searchedUsers // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      nonPlayingPlayers: null == nonPlayingPlayers
          ? _value.nonPlayingPlayers
          : nonPlayingPlayers // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      playingSquadIds: null == playingSquadIds
          ? _value.playingSquadIds
          : playingSquadIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  /// Create a copy of AddSubstituteViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get selectedUser {
    if (_value.selectedUser == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.selectedUser!, (value) {
      return _then(_value.copyWith(selectedUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddSubstituteViewStateImplCopyWith<$Res>
    implements $AddSubstituteViewStateCopyWith<$Res> {
  factory _$$AddSubstituteViewStateImplCopyWith(
          _$AddSubstituteViewStateImpl value,
          $Res Function(_$AddSubstituteViewStateImpl) then) =
      __$$AddSubstituteViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController searchController,
      Object? error,
      UserModel? selectedUser,
      List<UserModel> searchedUsers,
      List<UserModel> nonPlayingPlayers,
      List<String> playingSquadIds});

  @override
  $UserModelCopyWith<$Res>? get selectedUser;
}

/// @nodoc
class __$$AddSubstituteViewStateImplCopyWithImpl<$Res>
    extends _$AddSubstituteViewStateCopyWithImpl<$Res,
        _$AddSubstituteViewStateImpl>
    implements _$$AddSubstituteViewStateImplCopyWith<$Res> {
  __$$AddSubstituteViewStateImplCopyWithImpl(
      _$AddSubstituteViewStateImpl _value,
      $Res Function(_$AddSubstituteViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddSubstituteViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? error = freezed,
    Object? selectedUser = freezed,
    Object? searchedUsers = null,
    Object? nonPlayingPlayers = null,
    Object? playingSquadIds = null,
  }) {
    return _then(_$AddSubstituteViewStateImpl(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      error: freezed == error ? _value.error : error,
      selectedUser: freezed == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      searchedUsers: null == searchedUsers
          ? _value._searchedUsers
          : searchedUsers // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      nonPlayingPlayers: null == nonPlayingPlayers
          ? _value._nonPlayingPlayers
          : nonPlayingPlayers // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      playingSquadIds: null == playingSquadIds
          ? _value._playingSquadIds
          : playingSquadIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$AddSubstituteViewStateImpl implements _AddSubstituteViewState {
  const _$AddSubstituteViewStateImpl(
      {required this.searchController,
      this.error,
      this.selectedUser,
      final List<UserModel> searchedUsers = const [],
      final List<UserModel> nonPlayingPlayers = const [],
      final List<String> playingSquadIds = const []})
      : _searchedUsers = searchedUsers,
        _nonPlayingPlayers = nonPlayingPlayers,
        _playingSquadIds = playingSquadIds;

  @override
  final TextEditingController searchController;
  @override
  final Object? error;
  @override
  final UserModel? selectedUser;
  final List<UserModel> _searchedUsers;
  @override
  @JsonKey()
  List<UserModel> get searchedUsers {
    if (_searchedUsers is EqualUnmodifiableListView) return _searchedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchedUsers);
  }

  final List<UserModel> _nonPlayingPlayers;
  @override
  @JsonKey()
  List<UserModel> get nonPlayingPlayers {
    if (_nonPlayingPlayers is EqualUnmodifiableListView)
      return _nonPlayingPlayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nonPlayingPlayers);
  }

  final List<String> _playingSquadIds;
  @override
  @JsonKey()
  List<String> get playingSquadIds {
    if (_playingSquadIds is EqualUnmodifiableListView) return _playingSquadIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playingSquadIds);
  }

  @override
  String toString() {
    return 'AddSubstituteViewState(searchController: $searchController, error: $error, selectedUser: $selectedUser, searchedUsers: $searchedUsers, nonPlayingPlayers: $nonPlayingPlayers, playingSquadIds: $playingSquadIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddSubstituteViewStateImpl &&
            (identical(other.searchController, searchController) ||
                other.searchController == searchController) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.selectedUser, selectedUser) ||
                other.selectedUser == selectedUser) &&
            const DeepCollectionEquality()
                .equals(other._searchedUsers, _searchedUsers) &&
            const DeepCollectionEquality()
                .equals(other._nonPlayingPlayers, _nonPlayingPlayers) &&
            const DeepCollectionEquality()
                .equals(other._playingSquadIds, _playingSquadIds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      searchController,
      const DeepCollectionEquality().hash(error),
      selectedUser,
      const DeepCollectionEquality().hash(_searchedUsers),
      const DeepCollectionEquality().hash(_nonPlayingPlayers),
      const DeepCollectionEquality().hash(_playingSquadIds));

  /// Create a copy of AddSubstituteViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddSubstituteViewStateImplCopyWith<_$AddSubstituteViewStateImpl>
      get copyWith => __$$AddSubstituteViewStateImplCopyWithImpl<
          _$AddSubstituteViewStateImpl>(this, _$identity);
}

abstract class _AddSubstituteViewState implements AddSubstituteViewState {
  const factory _AddSubstituteViewState(
      {required final TextEditingController searchController,
      final Object? error,
      final UserModel? selectedUser,
      final List<UserModel> searchedUsers,
      final List<UserModel> nonPlayingPlayers,
      final List<String> playingSquadIds}) = _$AddSubstituteViewStateImpl;

  @override
  TextEditingController get searchController;
  @override
  Object? get error;
  @override
  UserModel? get selectedUser;
  @override
  List<UserModel> get searchedUsers;
  @override
  List<UserModel> get nonPlayingPlayers;
  @override
  List<String> get playingSquadIds;

  /// Create a copy of AddSubstituteViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddSubstituteViewStateImplCopyWith<_$AddSubstituteViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
