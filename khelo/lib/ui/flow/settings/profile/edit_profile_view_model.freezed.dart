// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EditProfileState {
  DateTime get dob => throw _privateConstructorUsedError;
  TextEditingController get nameController =>
      throw _privateConstructorUsedError;
  TextEditingController get emailController =>
      throw _privateConstructorUsedError;
  TextEditingController get locationController =>
      throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  UserGender? get gender => throw _privateConstructorUsedError;
  BattingStyle? get battingStyle => throw _privateConstructorUsedError;
  BowlingStyle? get bowlingStyle => throw _privateConstructorUsedError;
  PlayerRole? get playerRole => throw _privateConstructorUsedError;
  bool get isButtonEnable => throw _privateConstructorUsedError;
  bool get isSaved => throw _privateConstructorUsedError;
  bool get isSaveInProgress => throw _privateConstructorUsedError;
  UserModel? get currentUser => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditProfileStateCopyWith<EditProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditProfileStateCopyWith<$Res> {
  factory $EditProfileStateCopyWith(
          EditProfileState value, $Res Function(EditProfileState) then) =
      _$EditProfileStateCopyWithImpl<$Res, EditProfileState>;
  @useResult
  $Res call(
      {DateTime dob,
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController locationController,
      String? imageUrl,
      UserGender? gender,
      BattingStyle? battingStyle,
      BowlingStyle? bowlingStyle,
      PlayerRole? playerRole,
      bool isButtonEnable,
      bool isSaved,
      bool isSaveInProgress,
      UserModel? currentUser});

  $UserModelCopyWith<$Res>? get currentUser;
}

/// @nodoc
class _$EditProfileStateCopyWithImpl<$Res, $Val extends EditProfileState>
    implements $EditProfileStateCopyWith<$Res> {
  _$EditProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dob = null,
    Object? nameController = null,
    Object? emailController = null,
    Object? locationController = null,
    Object? imageUrl = freezed,
    Object? gender = freezed,
    Object? battingStyle = freezed,
    Object? bowlingStyle = freezed,
    Object? playerRole = freezed,
    Object? isButtonEnable = null,
    Object? isSaved = null,
    Object? isSaveInProgress = null,
    Object? currentUser = freezed,
  }) {
    return _then(_value.copyWith(
      dob: null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime,
      nameController: null == nameController
          ? _value.nameController
          : nameController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      emailController: null == emailController
          ? _value.emailController
          : emailController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      locationController: null == locationController
          ? _value.locationController
          : locationController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as UserGender?,
      battingStyle: freezed == battingStyle
          ? _value.battingStyle
          : battingStyle // ignore: cast_nullable_to_non_nullable
              as BattingStyle?,
      bowlingStyle: freezed == bowlingStyle
          ? _value.bowlingStyle
          : bowlingStyle // ignore: cast_nullable_to_non_nullable
              as BowlingStyle?,
      playerRole: freezed == playerRole
          ? _value.playerRole
          : playerRole // ignore: cast_nullable_to_non_nullable
              as PlayerRole?,
      isButtonEnable: null == isButtonEnable
          ? _value.isButtonEnable
          : isButtonEnable // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaveInProgress: null == isSaveInProgress
          ? _value.isSaveInProgress
          : isSaveInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ) as $Val);
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
abstract class _$$EditProfileStateImplCopyWith<$Res>
    implements $EditProfileStateCopyWith<$Res> {
  factory _$$EditProfileStateImplCopyWith(_$EditProfileStateImpl value,
          $Res Function(_$EditProfileStateImpl) then) =
      __$$EditProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime dob,
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController locationController,
      String? imageUrl,
      UserGender? gender,
      BattingStyle? battingStyle,
      BowlingStyle? bowlingStyle,
      PlayerRole? playerRole,
      bool isButtonEnable,
      bool isSaved,
      bool isSaveInProgress,
      UserModel? currentUser});

  @override
  $UserModelCopyWith<$Res>? get currentUser;
}

/// @nodoc
class __$$EditProfileStateImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$EditProfileStateImpl>
    implements _$$EditProfileStateImplCopyWith<$Res> {
  __$$EditProfileStateImplCopyWithImpl(_$EditProfileStateImpl _value,
      $Res Function(_$EditProfileStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dob = null,
    Object? nameController = null,
    Object? emailController = null,
    Object? locationController = null,
    Object? imageUrl = freezed,
    Object? gender = freezed,
    Object? battingStyle = freezed,
    Object? bowlingStyle = freezed,
    Object? playerRole = freezed,
    Object? isButtonEnable = null,
    Object? isSaved = null,
    Object? isSaveInProgress = null,
    Object? currentUser = freezed,
  }) {
    return _then(_$EditProfileStateImpl(
      dob: null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime,
      nameController: null == nameController
          ? _value.nameController
          : nameController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      emailController: null == emailController
          ? _value.emailController
          : emailController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      locationController: null == locationController
          ? _value.locationController
          : locationController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as UserGender?,
      battingStyle: freezed == battingStyle
          ? _value.battingStyle
          : battingStyle // ignore: cast_nullable_to_non_nullable
              as BattingStyle?,
      bowlingStyle: freezed == bowlingStyle
          ? _value.bowlingStyle
          : bowlingStyle // ignore: cast_nullable_to_non_nullable
              as BowlingStyle?,
      playerRole: freezed == playerRole
          ? _value.playerRole
          : playerRole // ignore: cast_nullable_to_non_nullable
              as PlayerRole?,
      isButtonEnable: null == isButtonEnable
          ? _value.isButtonEnable
          : isButtonEnable // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaveInProgress: null == isSaveInProgress
          ? _value.isSaveInProgress
          : isSaveInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }
}

/// @nodoc

class _$EditProfileStateImpl implements _EditProfileState {
  const _$EditProfileStateImpl(
      {required this.dob,
      required this.nameController,
      required this.emailController,
      required this.locationController,
      this.imageUrl = null,
      this.gender = null,
      this.battingStyle = null,
      this.bowlingStyle = null,
      this.playerRole = null,
      this.isButtonEnable = false,
      this.isSaved = false,
      this.isSaveInProgress = false,
      this.currentUser});

  @override
  final DateTime dob;
  @override
  final TextEditingController nameController;
  @override
  final TextEditingController emailController;
  @override
  final TextEditingController locationController;
  @override
  @JsonKey()
  final String? imageUrl;
  @override
  @JsonKey()
  final UserGender? gender;
  @override
  @JsonKey()
  final BattingStyle? battingStyle;
  @override
  @JsonKey()
  final BowlingStyle? bowlingStyle;
  @override
  @JsonKey()
  final PlayerRole? playerRole;
  @override
  @JsonKey()
  final bool isButtonEnable;
  @override
  @JsonKey()
  final bool isSaved;
  @override
  @JsonKey()
  final bool isSaveInProgress;
  @override
  final UserModel? currentUser;

  @override
  String toString() {
    return 'EditProfileState(dob: $dob, nameController: $nameController, emailController: $emailController, locationController: $locationController, imageUrl: $imageUrl, gender: $gender, battingStyle: $battingStyle, bowlingStyle: $bowlingStyle, playerRole: $playerRole, isButtonEnable: $isButtonEnable, isSaved: $isSaved, isSaveInProgress: $isSaveInProgress, currentUser: $currentUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditProfileStateImpl &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.nameController, nameController) ||
                other.nameController == nameController) &&
            (identical(other.emailController, emailController) ||
                other.emailController == emailController) &&
            (identical(other.locationController, locationController) ||
                other.locationController == locationController) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.battingStyle, battingStyle) ||
                other.battingStyle == battingStyle) &&
            (identical(other.bowlingStyle, bowlingStyle) ||
                other.bowlingStyle == bowlingStyle) &&
            (identical(other.playerRole, playerRole) ||
                other.playerRole == playerRole) &&
            (identical(other.isButtonEnable, isButtonEnable) ||
                other.isButtonEnable == isButtonEnable) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved) &&
            (identical(other.isSaveInProgress, isSaveInProgress) ||
                other.isSaveInProgress == isSaveInProgress) &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      dob,
      nameController,
      emailController,
      locationController,
      imageUrl,
      gender,
      battingStyle,
      bowlingStyle,
      playerRole,
      isButtonEnable,
      isSaved,
      isSaveInProgress,
      currentUser);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditProfileStateImplCopyWith<_$EditProfileStateImpl> get copyWith =>
      __$$EditProfileStateImplCopyWithImpl<_$EditProfileStateImpl>(
          this, _$identity);
}

abstract class _EditProfileState implements EditProfileState {
  const factory _EditProfileState(
      {required final DateTime dob,
      required final TextEditingController nameController,
      required final TextEditingController emailController,
      required final TextEditingController locationController,
      final String? imageUrl,
      final UserGender? gender,
      final BattingStyle? battingStyle,
      final BowlingStyle? bowlingStyle,
      final PlayerRole? playerRole,
      final bool isButtonEnable,
      final bool isSaved,
      final bool isSaveInProgress,
      final UserModel? currentUser}) = _$EditProfileStateImpl;

  @override
  DateTime get dob;
  @override
  TextEditingController get nameController;
  @override
  TextEditingController get emailController;
  @override
  TextEditingController get locationController;
  @override
  String? get imageUrl;
  @override
  UserGender? get gender;
  @override
  BattingStyle? get battingStyle;
  @override
  BowlingStyle? get bowlingStyle;
  @override
  PlayerRole? get playerRole;
  @override
  bool get isButtonEnable;
  @override
  bool get isSaved;
  @override
  bool get isSaveInProgress;
  @override
  UserModel? get currentUser;
  @override
  @JsonKey(ignore: true)
  _$$EditProfileStateImplCopyWith<_$EditProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
