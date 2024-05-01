// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_team_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddTeamState {
  TextEditingController get nameController =>
      throw _privateConstructorUsedError;
  TextEditingController get locationController =>
      throw _privateConstructorUsedError;
  Object? get actionError => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool? get isNameAvailable => throw _privateConstructorUsedError;
  TeamModel? get team => throw _privateConstructorUsedError;
  TeamModel? get editTeam => throw _privateConstructorUsedError;
  UserModel? get currentUser => throw _privateConstructorUsedError;
  bool get isImageUploading => throw _privateConstructorUsedError;
  bool get isAddMeCheckBoxEnable => throw _privateConstructorUsedError;
  bool get checkingForAvailability => throw _privateConstructorUsedError;
  bool get isAddBtnEnable => throw _privateConstructorUsedError;
  bool get isAddInProgress => throw _privateConstructorUsedError;
  bool get isPop => throw _privateConstructorUsedError;
  List<UserModel> get teamMembers => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddTeamStateCopyWith<AddTeamState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddTeamStateCopyWith<$Res> {
  factory $AddTeamStateCopyWith(
          AddTeamState value, $Res Function(AddTeamState) then) =
      _$AddTeamStateCopyWithImpl<$Res, AddTeamState>;
  @useResult
  $Res call(
      {TextEditingController nameController,
      TextEditingController locationController,
      Object? actionError,
      String? imageUrl,
      bool? isNameAvailable,
      TeamModel? team,
      TeamModel? editTeam,
      UserModel? currentUser,
      bool isImageUploading,
      bool isAddMeCheckBoxEnable,
      bool checkingForAvailability,
      bool isAddBtnEnable,
      bool isAddInProgress,
      bool isPop,
      List<UserModel> teamMembers});

  $TeamModelCopyWith<$Res>? get team;
  $TeamModelCopyWith<$Res>? get editTeam;
  $UserModelCopyWith<$Res>? get currentUser;
}

/// @nodoc
class _$AddTeamStateCopyWithImpl<$Res, $Val extends AddTeamState>
    implements $AddTeamStateCopyWith<$Res> {
  _$AddTeamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameController = null,
    Object? locationController = null,
    Object? actionError = freezed,
    Object? imageUrl = freezed,
    Object? isNameAvailable = freezed,
    Object? team = freezed,
    Object? editTeam = freezed,
    Object? currentUser = freezed,
    Object? isImageUploading = null,
    Object? isAddMeCheckBoxEnable = null,
    Object? checkingForAvailability = null,
    Object? isAddBtnEnable = null,
    Object? isAddInProgress = null,
    Object? isPop = null,
    Object? teamMembers = null,
  }) {
    return _then(_value.copyWith(
      nameController: null == nameController
          ? _value.nameController
          : nameController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      locationController: null == locationController
          ? _value.locationController
          : locationController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      actionError: freezed == actionError ? _value.actionError : actionError,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isNameAvailable: freezed == isNameAvailable
          ? _value.isNameAvailable
          : isNameAvailable // ignore: cast_nullable_to_non_nullable
              as bool?,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      editTeam: freezed == editTeam
          ? _value.editTeam
          : editTeam // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      isImageUploading: null == isImageUploading
          ? _value.isImageUploading
          : isImageUploading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAddMeCheckBoxEnable: null == isAddMeCheckBoxEnable
          ? _value.isAddMeCheckBoxEnable
          : isAddMeCheckBoxEnable // ignore: cast_nullable_to_non_nullable
              as bool,
      checkingForAvailability: null == checkingForAvailability
          ? _value.checkingForAvailability
          : checkingForAvailability // ignore: cast_nullable_to_non_nullable
              as bool,
      isAddBtnEnable: null == isAddBtnEnable
          ? _value.isAddBtnEnable
          : isAddBtnEnable // ignore: cast_nullable_to_non_nullable
              as bool,
      isAddInProgress: null == isAddInProgress
          ? _value.isAddInProgress
          : isAddInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      isPop: null == isPop
          ? _value.isPop
          : isPop // ignore: cast_nullable_to_non_nullable
              as bool,
      teamMembers: null == teamMembers
          ? _value.teamMembers
          : teamMembers // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TeamModelCopyWith<$Res>? get team {
    if (_value.team == null) {
      return null;
    }

    return $TeamModelCopyWith<$Res>(_value.team!, (value) {
      return _then(_value.copyWith(team: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TeamModelCopyWith<$Res>? get editTeam {
    if (_value.editTeam == null) {
      return null;
    }

    return $TeamModelCopyWith<$Res>(_value.editTeam!, (value) {
      return _then(_value.copyWith(editTeam: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get currentUser {
    if (_value.currentUser == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.currentUser!, (value) {
      return _then(_value.copyWith(currentUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddTeamStateImplCopyWith<$Res>
    implements $AddTeamStateCopyWith<$Res> {
  factory _$$AddTeamStateImplCopyWith(
          _$AddTeamStateImpl value, $Res Function(_$AddTeamStateImpl) then) =
      __$$AddTeamStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController nameController,
      TextEditingController locationController,
      Object? actionError,
      String? imageUrl,
      bool? isNameAvailable,
      TeamModel? team,
      TeamModel? editTeam,
      UserModel? currentUser,
      bool isImageUploading,
      bool isAddMeCheckBoxEnable,
      bool checkingForAvailability,
      bool isAddBtnEnable,
      bool isAddInProgress,
      bool isPop,
      List<UserModel> teamMembers});

  @override
  $TeamModelCopyWith<$Res>? get team;
  @override
  $TeamModelCopyWith<$Res>? get editTeam;
  @override
  $UserModelCopyWith<$Res>? get currentUser;
}

/// @nodoc
class __$$AddTeamStateImplCopyWithImpl<$Res>
    extends _$AddTeamStateCopyWithImpl<$Res, _$AddTeamStateImpl>
    implements _$$AddTeamStateImplCopyWith<$Res> {
  __$$AddTeamStateImplCopyWithImpl(
      _$AddTeamStateImpl _value, $Res Function(_$AddTeamStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameController = null,
    Object? locationController = null,
    Object? actionError = freezed,
    Object? imageUrl = freezed,
    Object? isNameAvailable = freezed,
    Object? team = freezed,
    Object? editTeam = freezed,
    Object? currentUser = freezed,
    Object? isImageUploading = null,
    Object? isAddMeCheckBoxEnable = null,
    Object? checkingForAvailability = null,
    Object? isAddBtnEnable = null,
    Object? isAddInProgress = null,
    Object? isPop = null,
    Object? teamMembers = null,
  }) {
    return _then(_$AddTeamStateImpl(
      nameController: null == nameController
          ? _value.nameController
          : nameController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      locationController: null == locationController
          ? _value.locationController
          : locationController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      actionError: freezed == actionError ? _value.actionError : actionError,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isNameAvailable: freezed == isNameAvailable
          ? _value.isNameAvailable
          : isNameAvailable // ignore: cast_nullable_to_non_nullable
              as bool?,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      editTeam: freezed == editTeam
          ? _value.editTeam
          : editTeam // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      isImageUploading: null == isImageUploading
          ? _value.isImageUploading
          : isImageUploading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAddMeCheckBoxEnable: null == isAddMeCheckBoxEnable
          ? _value.isAddMeCheckBoxEnable
          : isAddMeCheckBoxEnable // ignore: cast_nullable_to_non_nullable
              as bool,
      checkingForAvailability: null == checkingForAvailability
          ? _value.checkingForAvailability
          : checkingForAvailability // ignore: cast_nullable_to_non_nullable
              as bool,
      isAddBtnEnable: null == isAddBtnEnable
          ? _value.isAddBtnEnable
          : isAddBtnEnable // ignore: cast_nullable_to_non_nullable
              as bool,
      isAddInProgress: null == isAddInProgress
          ? _value.isAddInProgress
          : isAddInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      isPop: null == isPop
          ? _value.isPop
          : isPop // ignore: cast_nullable_to_non_nullable
              as bool,
      teamMembers: null == teamMembers
          ? _value._teamMembers
          : teamMembers // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ));
  }
}

/// @nodoc

class _$AddTeamStateImpl implements _AddTeamState {
  const _$AddTeamStateImpl(
      {required this.nameController,
      required this.locationController,
      this.actionError,
      this.imageUrl,
      this.isNameAvailable,
      this.team,
      this.editTeam,
      this.currentUser,
      this.isImageUploading = false,
      this.isAddMeCheckBoxEnable = true,
      this.checkingForAvailability = false,
      this.isAddBtnEnable = false,
      this.isAddInProgress = false,
      this.isPop = false,
      final List<UserModel> teamMembers = const []})
      : _teamMembers = teamMembers;

  @override
  final TextEditingController nameController;
  @override
  final TextEditingController locationController;
  @override
  final Object? actionError;
  @override
  final String? imageUrl;
  @override
  final bool? isNameAvailable;
  @override
  final TeamModel? team;
  @override
  final TeamModel? editTeam;
  @override
  final UserModel? currentUser;
  @override
  @JsonKey()
  final bool isImageUploading;
  @override
  @JsonKey()
  final bool isAddMeCheckBoxEnable;
  @override
  @JsonKey()
  final bool checkingForAvailability;
  @override
  @JsonKey()
  final bool isAddBtnEnable;
  @override
  @JsonKey()
  final bool isAddInProgress;
  @override
  @JsonKey()
  final bool isPop;
  final List<UserModel> _teamMembers;
  @override
  @JsonKey()
  List<UserModel> get teamMembers {
    if (_teamMembers is EqualUnmodifiableListView) return _teamMembers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamMembers);
  }

  @override
  String toString() {
    return 'AddTeamState(nameController: $nameController, locationController: $locationController, actionError: $actionError, imageUrl: $imageUrl, isNameAvailable: $isNameAvailable, team: $team, editTeam: $editTeam, currentUser: $currentUser, isImageUploading: $isImageUploading, isAddMeCheckBoxEnable: $isAddMeCheckBoxEnable, checkingForAvailability: $checkingForAvailability, isAddBtnEnable: $isAddBtnEnable, isAddInProgress: $isAddInProgress, isPop: $isPop, teamMembers: $teamMembers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTeamStateImpl &&
            (identical(other.nameController, nameController) ||
                other.nameController == nameController) &&
            (identical(other.locationController, locationController) ||
                other.locationController == locationController) &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isNameAvailable, isNameAvailable) ||
                other.isNameAvailable == isNameAvailable) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.editTeam, editTeam) ||
                other.editTeam == editTeam) &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser) &&
            (identical(other.isImageUploading, isImageUploading) ||
                other.isImageUploading == isImageUploading) &&
            (identical(other.isAddMeCheckBoxEnable, isAddMeCheckBoxEnable) ||
                other.isAddMeCheckBoxEnable == isAddMeCheckBoxEnable) &&
            (identical(
                    other.checkingForAvailability, checkingForAvailability) ||
                other.checkingForAvailability == checkingForAvailability) &&
            (identical(other.isAddBtnEnable, isAddBtnEnable) ||
                other.isAddBtnEnable == isAddBtnEnable) &&
            (identical(other.isAddInProgress, isAddInProgress) ||
                other.isAddInProgress == isAddInProgress) &&
            (identical(other.isPop, isPop) || other.isPop == isPop) &&
            const DeepCollectionEquality()
                .equals(other._teamMembers, _teamMembers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      nameController,
      locationController,
      const DeepCollectionEquality().hash(actionError),
      imageUrl,
      isNameAvailable,
      team,
      editTeam,
      currentUser,
      isImageUploading,
      isAddMeCheckBoxEnable,
      checkingForAvailability,
      isAddBtnEnable,
      isAddInProgress,
      isPop,
      const DeepCollectionEquality().hash(_teamMembers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTeamStateImplCopyWith<_$AddTeamStateImpl> get copyWith =>
      __$$AddTeamStateImplCopyWithImpl<_$AddTeamStateImpl>(this, _$identity);
}

abstract class _AddTeamState implements AddTeamState {
  const factory _AddTeamState(
      {required final TextEditingController nameController,
      required final TextEditingController locationController,
      final Object? actionError,
      final String? imageUrl,
      final bool? isNameAvailable,
      final TeamModel? team,
      final TeamModel? editTeam,
      final UserModel? currentUser,
      final bool isImageUploading,
      final bool isAddMeCheckBoxEnable,
      final bool checkingForAvailability,
      final bool isAddBtnEnable,
      final bool isAddInProgress,
      final bool isPop,
      final List<UserModel> teamMembers}) = _$AddTeamStateImpl;

  @override
  TextEditingController get nameController;
  @override
  TextEditingController get locationController;
  @override
  Object? get actionError;
  @override
  String? get imageUrl;
  @override
  bool? get isNameAvailable;
  @override
  TeamModel? get team;
  @override
  TeamModel? get editTeam;
  @override
  UserModel? get currentUser;
  @override
  bool get isImageUploading;
  @override
  bool get isAddMeCheckBoxEnable;
  @override
  bool get checkingForAvailability;
  @override
  bool get isAddBtnEnable;
  @override
  bool get isAddInProgress;
  @override
  bool get isPop;
  @override
  List<UserModel> get teamMembers;
  @override
  @JsonKey(ignore: true)
  _$$AddTeamStateImplCopyWith<_$AddTeamStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
