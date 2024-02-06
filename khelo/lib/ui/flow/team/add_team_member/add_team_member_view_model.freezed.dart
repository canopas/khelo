// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_team_member_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddTeamMemberState {
  TextEditingController get searchController =>
      throw _privateConstructorUsedError;
  TextEditingController get verifyNumberController =>
      throw _privateConstructorUsedError;
  List<UserModel> get searchedUsers => throw _privateConstructorUsedError;
  List<UserModel> get selectedUsers => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  bool get isAdded => throw _privateConstructorUsedError;
  bool get isAddInProgress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddTeamMemberStateCopyWith<AddTeamMemberState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddTeamMemberStateCopyWith<$Res> {
  factory $AddTeamMemberStateCopyWith(
          AddTeamMemberState value, $Res Function(AddTeamMemberState) then) =
      _$AddTeamMemberStateCopyWithImpl<$Res, AddTeamMemberState>;
  @useResult
  $Res call(
      {TextEditingController searchController,
      TextEditingController verifyNumberController,
      List<UserModel> searchedUsers,
      List<UserModel> selectedUsers,
      Object? error,
      bool isAdded,
      bool isAddInProgress});
}

/// @nodoc
class _$AddTeamMemberStateCopyWithImpl<$Res, $Val extends AddTeamMemberState>
    implements $AddTeamMemberStateCopyWith<$Res> {
  _$AddTeamMemberStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? verifyNumberController = null,
    Object? searchedUsers = null,
    Object? selectedUsers = null,
    Object? error = freezed,
    Object? isAdded = null,
    Object? isAddInProgress = null,
  }) {
    return _then(_value.copyWith(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      verifyNumberController: null == verifyNumberController
          ? _value.verifyNumberController
          : verifyNumberController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      searchedUsers: null == searchedUsers
          ? _value.searchedUsers
          : searchedUsers // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      selectedUsers: null == selectedUsers
          ? _value.selectedUsers
          : selectedUsers // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      error: freezed == error ? _value.error : error,
      isAdded: null == isAdded
          ? _value.isAdded
          : isAdded // ignore: cast_nullable_to_non_nullable
              as bool,
      isAddInProgress: null == isAddInProgress
          ? _value.isAddInProgress
          : isAddInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddTeamMemberStateImplCopyWith<$Res>
    implements $AddTeamMemberStateCopyWith<$Res> {
  factory _$$AddTeamMemberStateImplCopyWith(_$AddTeamMemberStateImpl value,
          $Res Function(_$AddTeamMemberStateImpl) then) =
      __$$AddTeamMemberStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController searchController,
      TextEditingController verifyNumberController,
      List<UserModel> searchedUsers,
      List<UserModel> selectedUsers,
      Object? error,
      bool isAdded,
      bool isAddInProgress});
}

/// @nodoc
class __$$AddTeamMemberStateImplCopyWithImpl<$Res>
    extends _$AddTeamMemberStateCopyWithImpl<$Res, _$AddTeamMemberStateImpl>
    implements _$$AddTeamMemberStateImplCopyWith<$Res> {
  __$$AddTeamMemberStateImplCopyWithImpl(_$AddTeamMemberStateImpl _value,
      $Res Function(_$AddTeamMemberStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? verifyNumberController = null,
    Object? searchedUsers = null,
    Object? selectedUsers = null,
    Object? error = freezed,
    Object? isAdded = null,
    Object? isAddInProgress = null,
  }) {
    return _then(_$AddTeamMemberStateImpl(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      verifyNumberController: null == verifyNumberController
          ? _value.verifyNumberController
          : verifyNumberController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      searchedUsers: null == searchedUsers
          ? _value._searchedUsers
          : searchedUsers // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      selectedUsers: null == selectedUsers
          ? _value._selectedUsers
          : selectedUsers // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      error: freezed == error ? _value.error : error,
      isAdded: null == isAdded
          ? _value.isAdded
          : isAdded // ignore: cast_nullable_to_non_nullable
              as bool,
      isAddInProgress: null == isAddInProgress
          ? _value.isAddInProgress
          : isAddInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AddTeamMemberStateImpl implements _AddTeamMemberState {
  const _$AddTeamMemberStateImpl(
      {required this.searchController,
      required this.verifyNumberController,
      final List<UserModel> searchedUsers = const [],
      final List<UserModel> selectedUsers = const [],
      this.error,
      this.isAdded = false,
      this.isAddInProgress = false})
      : _searchedUsers = searchedUsers,
        _selectedUsers = selectedUsers;

  @override
  final TextEditingController searchController;
  @override
  final TextEditingController verifyNumberController;
  final List<UserModel> _searchedUsers;
  @override
  @JsonKey()
  List<UserModel> get searchedUsers {
    if (_searchedUsers is EqualUnmodifiableListView) return _searchedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchedUsers);
  }

  final List<UserModel> _selectedUsers;
  @override
  @JsonKey()
  List<UserModel> get selectedUsers {
    if (_selectedUsers is EqualUnmodifiableListView) return _selectedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedUsers);
  }

  @override
  final Object? error;
  @override
  @JsonKey()
  final bool isAdded;
  @override
  @JsonKey()
  final bool isAddInProgress;

  @override
  String toString() {
    return 'AddTeamMemberState(searchController: $searchController, verifyNumberController: $verifyNumberController, searchedUsers: $searchedUsers, selectedUsers: $selectedUsers, error: $error, isAdded: $isAdded, isAddInProgress: $isAddInProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTeamMemberStateImpl &&
            (identical(other.searchController, searchController) ||
                other.searchController == searchController) &&
            (identical(other.verifyNumberController, verifyNumberController) ||
                other.verifyNumberController == verifyNumberController) &&
            const DeepCollectionEquality()
                .equals(other._searchedUsers, _searchedUsers) &&
            const DeepCollectionEquality()
                .equals(other._selectedUsers, _selectedUsers) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.isAdded, isAdded) || other.isAdded == isAdded) &&
            (identical(other.isAddInProgress, isAddInProgress) ||
                other.isAddInProgress == isAddInProgress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      searchController,
      verifyNumberController,
      const DeepCollectionEquality().hash(_searchedUsers),
      const DeepCollectionEquality().hash(_selectedUsers),
      const DeepCollectionEquality().hash(error),
      isAdded,
      isAddInProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTeamMemberStateImplCopyWith<_$AddTeamMemberStateImpl> get copyWith =>
      __$$AddTeamMemberStateImplCopyWithImpl<_$AddTeamMemberStateImpl>(
          this, _$identity);
}

abstract class _AddTeamMemberState implements AddTeamMemberState {
  const factory _AddTeamMemberState(
      {required final TextEditingController searchController,
      required final TextEditingController verifyNumberController,
      final List<UserModel> searchedUsers,
      final List<UserModel> selectedUsers,
      final Object? error,
      final bool isAdded,
      final bool isAddInProgress}) = _$AddTeamMemberStateImpl;

  @override
  TextEditingController get searchController;
  @override
  TextEditingController get verifyNumberController;
  @override
  List<UserModel> get searchedUsers;
  @override
  List<UserModel> get selectedUsers;
  @override
  Object? get error;
  @override
  bool get isAdded;
  @override
  bool get isAddInProgress;
  @override
  @JsonKey(ignore: true)
  _$$AddTeamMemberStateImplCopyWith<_$AddTeamMemberStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
