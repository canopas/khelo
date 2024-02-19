// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_user_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchUserViewState {
  TextEditingController get searchController =>
      throw _privateConstructorUsedError;
  List<UserModel> get searchedUsers => throw _privateConstructorUsedError;
  UserModel? get selectedUser => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchUserViewStateCopyWith<SearchUserViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchUserViewStateCopyWith<$Res> {
  factory $SearchUserViewStateCopyWith(
          SearchUserViewState value, $Res Function(SearchUserViewState) then) =
      _$SearchUserViewStateCopyWithImpl<$Res, SearchUserViewState>;
  @useResult
  $Res call(
      {TextEditingController searchController,
      List<UserModel> searchedUsers,
      UserModel? selectedUser,
      Object? error});

  $UserModelCopyWith<$Res>? get selectedUser;
}

/// @nodoc
class _$SearchUserViewStateCopyWithImpl<$Res, $Val extends SearchUserViewState>
    implements $SearchUserViewStateCopyWith<$Res> {
  _$SearchUserViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? searchedUsers = null,
    Object? selectedUser = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      searchedUsers: null == searchedUsers
          ? _value.searchedUsers
          : searchedUsers // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      selectedUser: freezed == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      error: freezed == error ? _value.error : error,
    ) as $Val);
  }

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
abstract class _$$SearchUserViewStateImplCopyWith<$Res>
    implements $SearchUserViewStateCopyWith<$Res> {
  factory _$$SearchUserViewStateImplCopyWith(_$SearchUserViewStateImpl value,
          $Res Function(_$SearchUserViewStateImpl) then) =
      __$$SearchUserViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController searchController,
      List<UserModel> searchedUsers,
      UserModel? selectedUser,
      Object? error});

  @override
  $UserModelCopyWith<$Res>? get selectedUser;
}

/// @nodoc
class __$$SearchUserViewStateImplCopyWithImpl<$Res>
    extends _$SearchUserViewStateCopyWithImpl<$Res, _$SearchUserViewStateImpl>
    implements _$$SearchUserViewStateImplCopyWith<$Res> {
  __$$SearchUserViewStateImplCopyWithImpl(_$SearchUserViewStateImpl _value,
      $Res Function(_$SearchUserViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? searchedUsers = null,
    Object? selectedUser = freezed,
    Object? error = freezed,
  }) {
    return _then(_$SearchUserViewStateImpl(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      searchedUsers: null == searchedUsers
          ? _value._searchedUsers
          : searchedUsers // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      selectedUser: freezed == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$SearchUserViewStateImpl implements _SearchUserViewState {
  const _$SearchUserViewStateImpl(
      {required this.searchController,
      final List<UserModel> searchedUsers = const [],
      this.selectedUser,
      this.error})
      : _searchedUsers = searchedUsers;

  @override
  final TextEditingController searchController;
  final List<UserModel> _searchedUsers;
  @override
  @JsonKey()
  List<UserModel> get searchedUsers {
    if (_searchedUsers is EqualUnmodifiableListView) return _searchedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchedUsers);
  }

  @override
  final UserModel? selectedUser;
  @override
  final Object? error;

  @override
  String toString() {
    return 'SearchUserViewState(searchController: $searchController, searchedUsers: $searchedUsers, selectedUser: $selectedUser, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchUserViewStateImpl &&
            (identical(other.searchController, searchController) ||
                other.searchController == searchController) &&
            const DeepCollectionEquality()
                .equals(other._searchedUsers, _searchedUsers) &&
            (identical(other.selectedUser, selectedUser) ||
                other.selectedUser == selectedUser) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      searchController,
      const DeepCollectionEquality().hash(_searchedUsers),
      selectedUser,
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchUserViewStateImplCopyWith<_$SearchUserViewStateImpl> get copyWith =>
      __$$SearchUserViewStateImplCopyWithImpl<_$SearchUserViewStateImpl>(
          this, _$identity);
}

abstract class _SearchUserViewState implements SearchUserViewState {
  const factory _SearchUserViewState(
      {required final TextEditingController searchController,
      final List<UserModel> searchedUsers,
      final UserModel? selectedUser,
      final Object? error}) = _$SearchUserViewStateImpl;

  @override
  TextEditingController get searchController;
  @override
  List<UserModel> get searchedUsers;
  @override
  UserModel? get selectedUser;
  @override
  Object? get error;
  @override
  @JsonKey(ignore: true)
  _$$SearchUserViewStateImplCopyWith<_$SearchUserViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
