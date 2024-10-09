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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddTeamState {
  TextEditingController get nameController =>
      throw _privateConstructorUsedError;
  TextEditingController get locationController =>
      throw _privateConstructorUsedError;
  TextEditingController get nameInitialsController =>
      throw _privateConstructorUsedError;
  Object? get actionError => throw _privateConstructorUsedError;
  String? get filePath => throw _privateConstructorUsedError;
  bool? get isNameAvailable => throw _privateConstructorUsedError;
  TeamModel? get team => throw _privateConstructorUsedError;
  TeamModel? get editTeam => throw _privateConstructorUsedError;
  bool get isImageUploading => throw _privateConstructorUsedError;
  bool get isAddMeCheckBoxEnable => throw _privateConstructorUsedError;
  bool get checkingForAvailability => throw _privateConstructorUsedError;
  bool get isAddBtnEnable => throw _privateConstructorUsedError;
  bool get isAddInProgress => throw _privateConstructorUsedError;
  bool get isPop => throw _privateConstructorUsedError;
  List<TeamPlayer> get teamMembers => throw _privateConstructorUsedError;

  /// Create a copy of AddTeamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      TextEditingController nameInitialsController,
      Object? actionError,
      String? filePath,
      bool? isNameAvailable,
      TeamModel? team,
      TeamModel? editTeam,
      bool isImageUploading,
      bool isAddMeCheckBoxEnable,
      bool checkingForAvailability,
      bool isAddBtnEnable,
      bool isAddInProgress,
      bool isPop,
      List<TeamPlayer> teamMembers});

  $TeamModelCopyWith<$Res>? get team;
  $TeamModelCopyWith<$Res>? get editTeam;
}

/// @nodoc
class _$AddTeamStateCopyWithImpl<$Res, $Val extends AddTeamState>
    implements $AddTeamStateCopyWith<$Res> {
  _$AddTeamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddTeamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameController = null,
    Object? locationController = null,
    Object? nameInitialsController = null,
    Object? actionError = freezed,
    Object? filePath = freezed,
    Object? isNameAvailable = freezed,
    Object? team = freezed,
    Object? editTeam = freezed,
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
      nameInitialsController: null == nameInitialsController
          ? _value.nameInitialsController
          : nameInitialsController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      actionError: freezed == actionError ? _value.actionError : actionError,
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
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
              as List<TeamPlayer>,
    ) as $Val);
  }

  /// Create a copy of AddTeamState
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of AddTeamState
  /// with the given fields replaced by the non-null parameter values.
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
      TextEditingController nameInitialsController,
      Object? actionError,
      String? filePath,
      bool? isNameAvailable,
      TeamModel? team,
      TeamModel? editTeam,
      bool isImageUploading,
      bool isAddMeCheckBoxEnable,
      bool checkingForAvailability,
      bool isAddBtnEnable,
      bool isAddInProgress,
      bool isPop,
      List<TeamPlayer> teamMembers});

  @override
  $TeamModelCopyWith<$Res>? get team;
  @override
  $TeamModelCopyWith<$Res>? get editTeam;
}

/// @nodoc
class __$$AddTeamStateImplCopyWithImpl<$Res>
    extends _$AddTeamStateCopyWithImpl<$Res, _$AddTeamStateImpl>
    implements _$$AddTeamStateImplCopyWith<$Res> {
  __$$AddTeamStateImplCopyWithImpl(
      _$AddTeamStateImpl _value, $Res Function(_$AddTeamStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddTeamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameController = null,
    Object? locationController = null,
    Object? nameInitialsController = null,
    Object? actionError = freezed,
    Object? filePath = freezed,
    Object? isNameAvailable = freezed,
    Object? team = freezed,
    Object? editTeam = freezed,
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
      nameInitialsController: null == nameInitialsController
          ? _value.nameInitialsController
          : nameInitialsController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      actionError: freezed == actionError ? _value.actionError : actionError,
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
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
              as List<TeamPlayer>,
    ));
  }
}

/// @nodoc

class _$AddTeamStateImpl implements _AddTeamState {
  const _$AddTeamStateImpl(
      {required this.nameController,
      required this.locationController,
      required this.nameInitialsController,
      this.actionError,
      this.filePath,
      this.isNameAvailable,
      this.team,
      this.editTeam,
      this.isImageUploading = false,
      this.isAddMeCheckBoxEnable = true,
      this.checkingForAvailability = false,
      this.isAddBtnEnable = false,
      this.isAddInProgress = false,
      this.isPop = false,
      final List<TeamPlayer> teamMembers = const []})
      : _teamMembers = teamMembers;

  @override
  final TextEditingController nameController;
  @override
  final TextEditingController locationController;
  @override
  final TextEditingController nameInitialsController;
  @override
  final Object? actionError;
  @override
  final String? filePath;
  @override
  final bool? isNameAvailable;
  @override
  final TeamModel? team;
  @override
  final TeamModel? editTeam;
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
  final List<TeamPlayer> _teamMembers;
  @override
  @JsonKey()
  List<TeamPlayer> get teamMembers {
    if (_teamMembers is EqualUnmodifiableListView) return _teamMembers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamMembers);
  }

  @override
  String toString() {
    return 'AddTeamState(nameController: $nameController, locationController: $locationController, nameInitialsController: $nameInitialsController, actionError: $actionError, filePath: $filePath, isNameAvailable: $isNameAvailable, team: $team, editTeam: $editTeam, isImageUploading: $isImageUploading, isAddMeCheckBoxEnable: $isAddMeCheckBoxEnable, checkingForAvailability: $checkingForAvailability, isAddBtnEnable: $isAddBtnEnable, isAddInProgress: $isAddInProgress, isPop: $isPop, teamMembers: $teamMembers)';
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
            (identical(other.nameInitialsController, nameInitialsController) ||
                other.nameInitialsController == nameInitialsController) &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.isNameAvailable, isNameAvailable) ||
                other.isNameAvailable == isNameAvailable) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.editTeam, editTeam) ||
                other.editTeam == editTeam) &&
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
      nameInitialsController,
      const DeepCollectionEquality().hash(actionError),
      filePath,
      isNameAvailable,
      team,
      editTeam,
      isImageUploading,
      isAddMeCheckBoxEnable,
      checkingForAvailability,
      isAddBtnEnable,
      isAddInProgress,
      isPop,
      const DeepCollectionEquality().hash(_teamMembers));

  /// Create a copy of AddTeamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTeamStateImplCopyWith<_$AddTeamStateImpl> get copyWith =>
      __$$AddTeamStateImplCopyWithImpl<_$AddTeamStateImpl>(this, _$identity);
}

abstract class _AddTeamState implements AddTeamState {
  const factory _AddTeamState(
      {required final TextEditingController nameController,
      required final TextEditingController locationController,
      required final TextEditingController nameInitialsController,
      final Object? actionError,
      final String? filePath,
      final bool? isNameAvailable,
      final TeamModel? team,
      final TeamModel? editTeam,
      final bool isImageUploading,
      final bool isAddMeCheckBoxEnable,
      final bool checkingForAvailability,
      final bool isAddBtnEnable,
      final bool isAddInProgress,
      final bool isPop,
      final List<TeamPlayer> teamMembers}) = _$AddTeamStateImpl;

  @override
  TextEditingController get nameController;
  @override
  TextEditingController get locationController;
  @override
  TextEditingController get nameInitialsController;
  @override
  Object? get actionError;
  @override
  String? get filePath;
  @override
  bool? get isNameAvailable;
  @override
  TeamModel? get team;
  @override
  TeamModel? get editTeam;
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
  List<TeamPlayer> get teamMembers;

  /// Create a copy of AddTeamState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTeamStateImplCopyWith<_$AddTeamStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
