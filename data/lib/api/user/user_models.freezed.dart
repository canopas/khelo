// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get name_lowercase => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  DateTime? get dob => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get profile_img_url => throw _privateConstructorUsedError;
  UserGender? get gender => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  DateTime? get updated_at => throw _privateConstructorUsedError;
  PlayerRole? get player_role => throw _privateConstructorUsedError;
  BattingStyle? get batting_style => throw _privateConstructorUsedError;
  BowlingStyle? get bowling_style => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get notifications => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String? name,
      String? name_lowercase,
      String? location,
      String? phone,
      DateTime? dob,
      String? email,
      String? profile_img_url,
      UserGender? gender,
      DateTime? created_at,
      DateTime? updated_at,
      PlayerRole? player_role,
      BattingStyle? batting_style,
      BowlingStyle? bowling_style,
      bool isActive,
      bool notifications});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? name_lowercase = freezed,
    Object? location = freezed,
    Object? phone = freezed,
    Object? dob = freezed,
    Object? email = freezed,
    Object? profile_img_url = freezed,
    Object? gender = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
    Object? player_role = freezed,
    Object? batting_style = freezed,
    Object? bowling_style = freezed,
    Object? isActive = null,
    Object? notifications = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      name_lowercase: freezed == name_lowercase
          ? _value.name_lowercase
          : name_lowercase // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profile_img_url: freezed == profile_img_url
          ? _value.profile_img_url
          : profile_img_url // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as UserGender?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      player_role: freezed == player_role
          ? _value.player_role
          : player_role // ignore: cast_nullable_to_non_nullable
              as PlayerRole?,
      batting_style: freezed == batting_style
          ? _value.batting_style
          : batting_style // ignore: cast_nullable_to_non_nullable
              as BattingStyle?,
      bowling_style: freezed == bowling_style
          ? _value.bowling_style
          : bowling_style // ignore: cast_nullable_to_non_nullable
              as BowlingStyle?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? name,
      String? name_lowercase,
      String? location,
      String? phone,
      DateTime? dob,
      String? email,
      String? profile_img_url,
      UserGender? gender,
      DateTime? created_at,
      DateTime? updated_at,
      PlayerRole? player_role,
      BattingStyle? batting_style,
      BowlingStyle? bowling_style,
      bool isActive,
      bool notifications});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? name_lowercase = freezed,
    Object? location = freezed,
    Object? phone = freezed,
    Object? dob = freezed,
    Object? email = freezed,
    Object? profile_img_url = freezed,
    Object? gender = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
    Object? player_role = freezed,
    Object? batting_style = freezed,
    Object? bowling_style = freezed,
    Object? isActive = null,
    Object? notifications = null,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      name_lowercase: freezed == name_lowercase
          ? _value.name_lowercase
          : name_lowercase // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profile_img_url: freezed == profile_img_url
          ? _value.profile_img_url
          : profile_img_url // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as UserGender?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      player_role: freezed == player_role
          ? _value.player_role
          : player_role // ignore: cast_nullable_to_non_nullable
              as PlayerRole?,
      batting_style: freezed == batting_style
          ? _value.batting_style
          : batting_style // ignore: cast_nullable_to_non_nullable
              as BattingStyle?,
      bowling_style: freezed == bowling_style
          ? _value.bowling_style
          : bowling_style // ignore: cast_nullable_to_non_nullable
              as BowlingStyle?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl extends _UserModel {
  const _$UserModelImpl(
      {required this.id,
      this.name,
      this.name_lowercase,
      this.location,
      this.phone,
      this.dob,
      this.email,
      this.profile_img_url,
      this.gender,
      this.created_at,
      this.updated_at,
      this.player_role,
      this.batting_style,
      this.bowling_style,
      this.isActive = true,
      this.notifications = true})
      : super._();

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final String? name_lowercase;
  @override
  final String? location;
  @override
  final String? phone;
  @override
  final DateTime? dob;
  @override
  final String? email;
  @override
  final String? profile_img_url;
  @override
  final UserGender? gender;
  @override
  final DateTime? created_at;
  @override
  final DateTime? updated_at;
  @override
  final PlayerRole? player_role;
  @override
  final BattingStyle? batting_style;
  @override
  final BowlingStyle? bowling_style;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool notifications;

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, name_lowercase: $name_lowercase, location: $location, phone: $phone, dob: $dob, email: $email, profile_img_url: $profile_img_url, gender: $gender, created_at: $created_at, updated_at: $updated_at, player_role: $player_role, batting_style: $batting_style, bowling_style: $bowling_style, isActive: $isActive, notifications: $notifications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.name_lowercase, name_lowercase) ||
                other.name_lowercase == name_lowercase) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profile_img_url, profile_img_url) ||
                other.profile_img_url == profile_img_url) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at) &&
            (identical(other.player_role, player_role) ||
                other.player_role == player_role) &&
            (identical(other.batting_style, batting_style) ||
                other.batting_style == batting_style) &&
            (identical(other.bowling_style, bowling_style) ||
                other.bowling_style == bowling_style) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.notifications, notifications) ||
                other.notifications == notifications));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      name_lowercase,
      location,
      phone,
      dob,
      email,
      profile_img_url,
      gender,
      created_at,
      updated_at,
      player_role,
      batting_style,
      bowling_style,
      isActive,
      notifications);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel(
      {required final String id,
      final String? name,
      final String? name_lowercase,
      final String? location,
      final String? phone,
      final DateTime? dob,
      final String? email,
      final String? profile_img_url,
      final UserGender? gender,
      final DateTime? created_at,
      final DateTime? updated_at,
      final PlayerRole? player_role,
      final BattingStyle? batting_style,
      final BowlingStyle? bowling_style,
      final bool isActive,
      final bool notifications}) = _$UserModelImpl;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  String? get name_lowercase;
  @override
  String? get location;
  @override
  String? get phone;
  @override
  DateTime? get dob;
  @override
  String? get email;
  @override
  String? get profile_img_url;
  @override
  UserGender? get gender;
  @override
  DateTime? get created_at;
  @override
  DateTime? get updated_at;
  @override
  PlayerRole? get player_role;
  @override
  BattingStyle? get batting_style;
  @override
  BowlingStyle? get bowling_style;
  @override
  bool get isActive;
  @override
  bool get notifications;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiSession _$ApiSessionFromJson(Map<String, dynamic> json) {
  return _ApiSession.fromJson(json);
}

/// @nodoc
mixin _$ApiSession {
  String get id => throw _privateConstructorUsedError;
  String get user_id => throw _privateConstructorUsedError;
  int get device_type => throw _privateConstructorUsedError;
  String get device_id => throw _privateConstructorUsedError;
  String get device_name => throw _privateConstructorUsedError;
  String? get device_fcm_token => throw _privateConstructorUsedError;
  int get app_version => throw _privateConstructorUsedError;
  String get os_version => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  bool get is_active => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiSessionCopyWith<ApiSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiSessionCopyWith<$Res> {
  factory $ApiSessionCopyWith(
          ApiSession value, $Res Function(ApiSession) then) =
      _$ApiSessionCopyWithImpl<$Res, ApiSession>;
  @useResult
  $Res call(
      {String id,
      String user_id,
      int device_type,
      String device_id,
      String device_name,
      String? device_fcm_token,
      int app_version,
      String os_version,
      DateTime? created_at,
      bool is_active});
}

/// @nodoc
class _$ApiSessionCopyWithImpl<$Res, $Val extends ApiSession>
    implements $ApiSessionCopyWith<$Res> {
  _$ApiSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user_id = null,
    Object? device_type = null,
    Object? device_id = null,
    Object? device_name = null,
    Object? device_fcm_token = freezed,
    Object? app_version = null,
    Object? os_version = null,
    Object? created_at = freezed,
    Object? is_active = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      device_type: null == device_type
          ? _value.device_type
          : device_type // ignore: cast_nullable_to_non_nullable
              as int,
      device_id: null == device_id
          ? _value.device_id
          : device_id // ignore: cast_nullable_to_non_nullable
              as String,
      device_name: null == device_name
          ? _value.device_name
          : device_name // ignore: cast_nullable_to_non_nullable
              as String,
      device_fcm_token: freezed == device_fcm_token
          ? _value.device_fcm_token
          : device_fcm_token // ignore: cast_nullable_to_non_nullable
              as String?,
      app_version: null == app_version
          ? _value.app_version
          : app_version // ignore: cast_nullable_to_non_nullable
              as int,
      os_version: null == os_version
          ? _value.os_version
          : os_version // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      is_active: null == is_active
          ? _value.is_active
          : is_active // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiSessionImplCopyWith<$Res>
    implements $ApiSessionCopyWith<$Res> {
  factory _$$ApiSessionImplCopyWith(
          _$ApiSessionImpl value, $Res Function(_$ApiSessionImpl) then) =
      __$$ApiSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String user_id,
      int device_type,
      String device_id,
      String device_name,
      String? device_fcm_token,
      int app_version,
      String os_version,
      DateTime? created_at,
      bool is_active});
}

/// @nodoc
class __$$ApiSessionImplCopyWithImpl<$Res>
    extends _$ApiSessionCopyWithImpl<$Res, _$ApiSessionImpl>
    implements _$$ApiSessionImplCopyWith<$Res> {
  __$$ApiSessionImplCopyWithImpl(
      _$ApiSessionImpl _value, $Res Function(_$ApiSessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user_id = null,
    Object? device_type = null,
    Object? device_id = null,
    Object? device_name = null,
    Object? device_fcm_token = freezed,
    Object? app_version = null,
    Object? os_version = null,
    Object? created_at = freezed,
    Object? is_active = null,
  }) {
    return _then(_$ApiSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      device_type: null == device_type
          ? _value.device_type
          : device_type // ignore: cast_nullable_to_non_nullable
              as int,
      device_id: null == device_id
          ? _value.device_id
          : device_id // ignore: cast_nullable_to_non_nullable
              as String,
      device_name: null == device_name
          ? _value.device_name
          : device_name // ignore: cast_nullable_to_non_nullable
              as String,
      device_fcm_token: freezed == device_fcm_token
          ? _value.device_fcm_token
          : device_fcm_token // ignore: cast_nullable_to_non_nullable
              as String?,
      app_version: null == app_version
          ? _value.app_version
          : app_version // ignore: cast_nullable_to_non_nullable
              as int,
      os_version: null == os_version
          ? _value.os_version
          : os_version // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      is_active: null == is_active
          ? _value.is_active
          : is_active // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiSessionImpl extends _ApiSession {
  const _$ApiSessionImpl(
      {required this.id,
      required this.user_id,
      required this.device_type,
      required this.device_id,
      required this.device_name,
      this.device_fcm_token,
      required this.app_version,
      required this.os_version,
      this.created_at,
      this.is_active = true})
      : super._();

  factory _$ApiSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String user_id;
  @override
  final int device_type;
  @override
  final String device_id;
  @override
  final String device_name;
  @override
  final String? device_fcm_token;
  @override
  final int app_version;
  @override
  final String os_version;
  @override
  final DateTime? created_at;
  @override
  @JsonKey()
  final bool is_active;

  @override
  String toString() {
    return 'ApiSession(id: $id, user_id: $user_id, device_type: $device_type, device_id: $device_id, device_name: $device_name, device_fcm_token: $device_fcm_token, app_version: $app_version, os_version: $os_version, created_at: $created_at, is_active: $is_active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.device_type, device_type) ||
                other.device_type == device_type) &&
            (identical(other.device_id, device_id) ||
                other.device_id == device_id) &&
            (identical(other.device_name, device_name) ||
                other.device_name == device_name) &&
            (identical(other.device_fcm_token, device_fcm_token) ||
                other.device_fcm_token == device_fcm_token) &&
            (identical(other.app_version, app_version) ||
                other.app_version == app_version) &&
            (identical(other.os_version, os_version) ||
                other.os_version == os_version) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.is_active, is_active) ||
                other.is_active == is_active));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      user_id,
      device_type,
      device_id,
      device_name,
      device_fcm_token,
      app_version,
      os_version,
      created_at,
      is_active);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiSessionImplCopyWith<_$ApiSessionImpl> get copyWith =>
      __$$ApiSessionImplCopyWithImpl<_$ApiSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiSessionImplToJson(
      this,
    );
  }
}

abstract class _ApiSession extends ApiSession {
  const factory _ApiSession(
      {required final String id,
      required final String user_id,
      required final int device_type,
      required final String device_id,
      required final String device_name,
      final String? device_fcm_token,
      required final int app_version,
      required final String os_version,
      final DateTime? created_at,
      final bool is_active}) = _$ApiSessionImpl;
  const _ApiSession._() : super._();

  factory _ApiSession.fromJson(Map<String, dynamic> json) =
      _$ApiSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get user_id;
  @override
  int get device_type;
  @override
  String get device_id;
  @override
  String get device_name;
  @override
  String? get device_fcm_token;
  @override
  int get app_version;
  @override
  String get os_version;
  @override
  DateTime? get created_at;
  @override
  bool get is_active;
  @override
  @JsonKey(ignore: true)
  _$$ApiSessionImplCopyWith<_$ApiSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
