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

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this ApiSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ApiSession
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of ApiSession
  /// with the given fields replaced by the non-null parameter values.
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ApiSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ApiSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiSessionImplCopyWith<_$ApiSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserStat _$UserStatFromJson(Map<String, dynamic> json) {
  return _UserStat.fromJson(json);
}

/// @nodoc
mixin _$UserStat {
  int get matches => throw _privateConstructorUsedError;
  UserStatType? get type => throw _privateConstructorUsedError;
  Batting get batting => throw _privateConstructorUsedError;
  Bowling get bowling => throw _privateConstructorUsedError;
  Fielding get fielding => throw _privateConstructorUsedError;

  /// Serializes this UserStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStatCopyWith<UserStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatCopyWith<$Res> {
  factory $UserStatCopyWith(UserStat value, $Res Function(UserStat) then) =
      _$UserStatCopyWithImpl<$Res, UserStat>;
  @useResult
  $Res call(
      {int matches,
      UserStatType? type,
      Batting batting,
      Bowling bowling,
      Fielding fielding});

  $BattingCopyWith<$Res> get batting;
  $BowlingCopyWith<$Res> get bowling;
  $FieldingCopyWith<$Res> get fielding;
}

/// @nodoc
class _$UserStatCopyWithImpl<$Res, $Val extends UserStat>
    implements $UserStatCopyWith<$Res> {
  _$UserStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matches = null,
    Object? type = freezed,
    Object? batting = null,
    Object? bowling = null,
    Object? fielding = null,
  }) {
    return _then(_value.copyWith(
      matches: null == matches
          ? _value.matches
          : matches // ignore: cast_nullable_to_non_nullable
              as int,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserStatType?,
      batting: null == batting
          ? _value.batting
          : batting // ignore: cast_nullable_to_non_nullable
              as Batting,
      bowling: null == bowling
          ? _value.bowling
          : bowling // ignore: cast_nullable_to_non_nullable
              as Bowling,
      fielding: null == fielding
          ? _value.fielding
          : fielding // ignore: cast_nullable_to_non_nullable
              as Fielding,
    ) as $Val);
  }

  /// Create a copy of UserStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BattingCopyWith<$Res> get batting {
    return $BattingCopyWith<$Res>(_value.batting, (value) {
      return _then(_value.copyWith(batting: value) as $Val);
    });
  }

  /// Create a copy of UserStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BowlingCopyWith<$Res> get bowling {
    return $BowlingCopyWith<$Res>(_value.bowling, (value) {
      return _then(_value.copyWith(bowling: value) as $Val);
    });
  }

  /// Create a copy of UserStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FieldingCopyWith<$Res> get fielding {
    return $FieldingCopyWith<$Res>(_value.fielding, (value) {
      return _then(_value.copyWith(fielding: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserStatImplCopyWith<$Res>
    implements $UserStatCopyWith<$Res> {
  factory _$$UserStatImplCopyWith(
          _$UserStatImpl value, $Res Function(_$UserStatImpl) then) =
      __$$UserStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int matches,
      UserStatType? type,
      Batting batting,
      Bowling bowling,
      Fielding fielding});

  @override
  $BattingCopyWith<$Res> get batting;
  @override
  $BowlingCopyWith<$Res> get bowling;
  @override
  $FieldingCopyWith<$Res> get fielding;
}

/// @nodoc
class __$$UserStatImplCopyWithImpl<$Res>
    extends _$UserStatCopyWithImpl<$Res, _$UserStatImpl>
    implements _$$UserStatImplCopyWith<$Res> {
  __$$UserStatImplCopyWithImpl(
      _$UserStatImpl _value, $Res Function(_$UserStatImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matches = null,
    Object? type = freezed,
    Object? batting = null,
    Object? bowling = null,
    Object? fielding = null,
  }) {
    return _then(_$UserStatImpl(
      matches: null == matches
          ? _value.matches
          : matches // ignore: cast_nullable_to_non_nullable
              as int,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserStatType?,
      batting: null == batting
          ? _value.batting
          : batting // ignore: cast_nullable_to_non_nullable
              as Batting,
      bowling: null == bowling
          ? _value.bowling
          : bowling // ignore: cast_nullable_to_non_nullable
              as Bowling,
      fielding: null == fielding
          ? _value.fielding
          : fielding // ignore: cast_nullable_to_non_nullable
              as Fielding,
    ));
  }
}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true)
class _$UserStatImpl implements _UserStat {
  const _$UserStatImpl(
      {this.matches = 0,
      this.type,
      this.batting = const Batting(),
      this.bowling = const Bowling(),
      this.fielding = const Fielding()});

  factory _$UserStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStatImplFromJson(json);

  @override
  @JsonKey()
  final int matches;
  @override
  final UserStatType? type;
  @override
  @JsonKey()
  final Batting batting;
  @override
  @JsonKey()
  final Bowling bowling;
  @override
  @JsonKey()
  final Fielding fielding;

  @override
  String toString() {
    return 'UserStat(matches: $matches, type: $type, batting: $batting, bowling: $bowling, fielding: $fielding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatImpl &&
            (identical(other.matches, matches) || other.matches == matches) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.batting, batting) || other.batting == batting) &&
            (identical(other.bowling, bowling) || other.bowling == bowling) &&
            (identical(other.fielding, fielding) ||
                other.fielding == fielding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, matches, type, batting, bowling, fielding);

  /// Create a copy of UserStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatImplCopyWith<_$UserStatImpl> get copyWith =>
      __$$UserStatImplCopyWithImpl<_$UserStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserStatImplToJson(
      this,
    );
  }
}

abstract class _UserStat implements UserStat {
  const factory _UserStat(
      {final int matches,
      final UserStatType? type,
      final Batting batting,
      final Bowling bowling,
      final Fielding fielding}) = _$UserStatImpl;

  factory _UserStat.fromJson(Map<String, dynamic> json) =
      _$UserStatImpl.fromJson;

  @override
  int get matches;
  @override
  UserStatType? get type;
  @override
  Batting get batting;
  @override
  Bowling get bowling;
  @override
  Fielding get fielding;

  /// Create a copy of UserStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatImplCopyWith<_$UserStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Batting _$BattingFromJson(Map<String, dynamic> json) {
  return _Batting.fromJson(json);
}

/// @nodoc
mixin _$Batting {
  int get innings => throw _privateConstructorUsedError;
  int get run_scored => throw _privateConstructorUsedError;
  double get average => throw _privateConstructorUsedError;
  double get strike_rate => throw _privateConstructorUsedError;
  int get ball_faced => throw _privateConstructorUsedError;
  int get fours => throw _privateConstructorUsedError;
  int get sixes => throw _privateConstructorUsedError;
  int get fifties => throw _privateConstructorUsedError;
  int get hundreds => throw _privateConstructorUsedError;
  int get ducks => throw _privateConstructorUsedError;
  int get dismissal => throw _privateConstructorUsedError;

  /// Serializes this Batting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Batting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BattingCopyWith<Batting> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattingCopyWith<$Res> {
  factory $BattingCopyWith(Batting value, $Res Function(Batting) then) =
      _$BattingCopyWithImpl<$Res, Batting>;
  @useResult
  $Res call(
      {int innings,
      int run_scored,
      double average,
      double strike_rate,
      int ball_faced,
      int fours,
      int sixes,
      int fifties,
      int hundreds,
      int ducks,
      int dismissal});
}

/// @nodoc
class _$BattingCopyWithImpl<$Res, $Val extends Batting>
    implements $BattingCopyWith<$Res> {
  _$BattingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Batting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? innings = null,
    Object? run_scored = null,
    Object? average = null,
    Object? strike_rate = null,
    Object? ball_faced = null,
    Object? fours = null,
    Object? sixes = null,
    Object? fifties = null,
    Object? hundreds = null,
    Object? ducks = null,
    Object? dismissal = null,
  }) {
    return _then(_value.copyWith(
      innings: null == innings
          ? _value.innings
          : innings // ignore: cast_nullable_to_non_nullable
              as int,
      run_scored: null == run_scored
          ? _value.run_scored
          : run_scored // ignore: cast_nullable_to_non_nullable
              as int,
      average: null == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      strike_rate: null == strike_rate
          ? _value.strike_rate
          : strike_rate // ignore: cast_nullable_to_non_nullable
              as double,
      ball_faced: null == ball_faced
          ? _value.ball_faced
          : ball_faced // ignore: cast_nullable_to_non_nullable
              as int,
      fours: null == fours
          ? _value.fours
          : fours // ignore: cast_nullable_to_non_nullable
              as int,
      sixes: null == sixes
          ? _value.sixes
          : sixes // ignore: cast_nullable_to_non_nullable
              as int,
      fifties: null == fifties
          ? _value.fifties
          : fifties // ignore: cast_nullable_to_non_nullable
              as int,
      hundreds: null == hundreds
          ? _value.hundreds
          : hundreds // ignore: cast_nullable_to_non_nullable
              as int,
      ducks: null == ducks
          ? _value.ducks
          : ducks // ignore: cast_nullable_to_non_nullable
              as int,
      dismissal: null == dismissal
          ? _value.dismissal
          : dismissal // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BattingImplCopyWith<$Res> implements $BattingCopyWith<$Res> {
  factory _$$BattingImplCopyWith(
          _$BattingImpl value, $Res Function(_$BattingImpl) then) =
      __$$BattingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int innings,
      int run_scored,
      double average,
      double strike_rate,
      int ball_faced,
      int fours,
      int sixes,
      int fifties,
      int hundreds,
      int ducks,
      int dismissal});
}

/// @nodoc
class __$$BattingImplCopyWithImpl<$Res>
    extends _$BattingCopyWithImpl<$Res, _$BattingImpl>
    implements _$$BattingImplCopyWith<$Res> {
  __$$BattingImplCopyWithImpl(
      _$BattingImpl _value, $Res Function(_$BattingImpl) _then)
      : super(_value, _then);

  /// Create a copy of Batting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? innings = null,
    Object? run_scored = null,
    Object? average = null,
    Object? strike_rate = null,
    Object? ball_faced = null,
    Object? fours = null,
    Object? sixes = null,
    Object? fifties = null,
    Object? hundreds = null,
    Object? ducks = null,
    Object? dismissal = null,
  }) {
    return _then(_$BattingImpl(
      innings: null == innings
          ? _value.innings
          : innings // ignore: cast_nullable_to_non_nullable
              as int,
      run_scored: null == run_scored
          ? _value.run_scored
          : run_scored // ignore: cast_nullable_to_non_nullable
              as int,
      average: null == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      strike_rate: null == strike_rate
          ? _value.strike_rate
          : strike_rate // ignore: cast_nullable_to_non_nullable
              as double,
      ball_faced: null == ball_faced
          ? _value.ball_faced
          : ball_faced // ignore: cast_nullable_to_non_nullable
              as int,
      fours: null == fours
          ? _value.fours
          : fours // ignore: cast_nullable_to_non_nullable
              as int,
      sixes: null == sixes
          ? _value.sixes
          : sixes // ignore: cast_nullable_to_non_nullable
              as int,
      fifties: null == fifties
          ? _value.fifties
          : fifties // ignore: cast_nullable_to_non_nullable
              as int,
      hundreds: null == hundreds
          ? _value.hundreds
          : hundreds // ignore: cast_nullable_to_non_nullable
              as int,
      ducks: null == ducks
          ? _value.ducks
          : ducks // ignore: cast_nullable_to_non_nullable
              as int,
      dismissal: null == dismissal
          ? _value.dismissal
          : dismissal // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattingImpl implements _Batting {
  const _$BattingImpl(
      {this.innings = 0,
      this.run_scored = 0,
      this.average = 0.0,
      this.strike_rate = 0.0,
      this.ball_faced = 0,
      this.fours = 0,
      this.sixes = 0,
      this.fifties = 0,
      this.hundreds = 0,
      this.ducks = 0,
      this.dismissal = 0});

  factory _$BattingImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattingImplFromJson(json);

  @override
  @JsonKey()
  final int innings;
  @override
  @JsonKey()
  final int run_scored;
  @override
  @JsonKey()
  final double average;
  @override
  @JsonKey()
  final double strike_rate;
  @override
  @JsonKey()
  final int ball_faced;
  @override
  @JsonKey()
  final int fours;
  @override
  @JsonKey()
  final int sixes;
  @override
  @JsonKey()
  final int fifties;
  @override
  @JsonKey()
  final int hundreds;
  @override
  @JsonKey()
  final int ducks;
  @override
  @JsonKey()
  final int dismissal;

  @override
  String toString() {
    return 'Batting(innings: $innings, run_scored: $run_scored, average: $average, strike_rate: $strike_rate, ball_faced: $ball_faced, fours: $fours, sixes: $sixes, fifties: $fifties, hundreds: $hundreds, ducks: $ducks, dismissal: $dismissal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattingImpl &&
            (identical(other.innings, innings) || other.innings == innings) &&
            (identical(other.run_scored, run_scored) ||
                other.run_scored == run_scored) &&
            (identical(other.average, average) || other.average == average) &&
            (identical(other.strike_rate, strike_rate) ||
                other.strike_rate == strike_rate) &&
            (identical(other.ball_faced, ball_faced) ||
                other.ball_faced == ball_faced) &&
            (identical(other.fours, fours) || other.fours == fours) &&
            (identical(other.sixes, sixes) || other.sixes == sixes) &&
            (identical(other.fifties, fifties) || other.fifties == fifties) &&
            (identical(other.hundreds, hundreds) ||
                other.hundreds == hundreds) &&
            (identical(other.ducks, ducks) || other.ducks == ducks) &&
            (identical(other.dismissal, dismissal) ||
                other.dismissal == dismissal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      innings,
      run_scored,
      average,
      strike_rate,
      ball_faced,
      fours,
      sixes,
      fifties,
      hundreds,
      ducks,
      dismissal);

  /// Create a copy of Batting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BattingImplCopyWith<_$BattingImpl> get copyWith =>
      __$$BattingImplCopyWithImpl<_$BattingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattingImplToJson(
      this,
    );
  }
}

abstract class _Batting implements Batting {
  const factory _Batting(
      {final int innings,
      final int run_scored,
      final double average,
      final double strike_rate,
      final int ball_faced,
      final int fours,
      final int sixes,
      final int fifties,
      final int hundreds,
      final int ducks,
      final int dismissal}) = _$BattingImpl;

  factory _Batting.fromJson(Map<String, dynamic> json) = _$BattingImpl.fromJson;

  @override
  int get innings;
  @override
  int get run_scored;
  @override
  double get average;
  @override
  double get strike_rate;
  @override
  int get ball_faced;
  @override
  int get fours;
  @override
  int get sixes;
  @override
  int get fifties;
  @override
  int get hundreds;
  @override
  int get ducks;
  @override
  int get dismissal;

  /// Create a copy of Batting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BattingImplCopyWith<_$BattingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Bowling _$BowlingFromJson(Map<String, dynamic> json) {
  return _Bowling.fromJson(json);
}

/// @nodoc
mixin _$Bowling {
  int get innings => throw _privateConstructorUsedError;
  int get wicket_taken => throw _privateConstructorUsedError;
  int get balls => throw _privateConstructorUsedError;
  int get runs_conceded => throw _privateConstructorUsedError;
  int get maiden => throw _privateConstructorUsedError;
  int get no_balls => throw _privateConstructorUsedError;
  int get wide_balls => throw _privateConstructorUsedError;
  double get average => throw _privateConstructorUsedError;
  double get strike_rate => throw _privateConstructorUsedError;
  double get economy_rate => throw _privateConstructorUsedError;

  /// Serializes this Bowling to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bowling
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BowlingCopyWith<Bowling> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BowlingCopyWith<$Res> {
  factory $BowlingCopyWith(Bowling value, $Res Function(Bowling) then) =
      _$BowlingCopyWithImpl<$Res, Bowling>;
  @useResult
  $Res call(
      {int innings,
      int wicket_taken,
      int balls,
      int runs_conceded,
      int maiden,
      int no_balls,
      int wide_balls,
      double average,
      double strike_rate,
      double economy_rate});
}

/// @nodoc
class _$BowlingCopyWithImpl<$Res, $Val extends Bowling>
    implements $BowlingCopyWith<$Res> {
  _$BowlingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bowling
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? innings = null,
    Object? wicket_taken = null,
    Object? balls = null,
    Object? runs_conceded = null,
    Object? maiden = null,
    Object? no_balls = null,
    Object? wide_balls = null,
    Object? average = null,
    Object? strike_rate = null,
    Object? economy_rate = null,
  }) {
    return _then(_value.copyWith(
      innings: null == innings
          ? _value.innings
          : innings // ignore: cast_nullable_to_non_nullable
              as int,
      wicket_taken: null == wicket_taken
          ? _value.wicket_taken
          : wicket_taken // ignore: cast_nullable_to_non_nullable
              as int,
      balls: null == balls
          ? _value.balls
          : balls // ignore: cast_nullable_to_non_nullable
              as int,
      runs_conceded: null == runs_conceded
          ? _value.runs_conceded
          : runs_conceded // ignore: cast_nullable_to_non_nullable
              as int,
      maiden: null == maiden
          ? _value.maiden
          : maiden // ignore: cast_nullable_to_non_nullable
              as int,
      no_balls: null == no_balls
          ? _value.no_balls
          : no_balls // ignore: cast_nullable_to_non_nullable
              as int,
      wide_balls: null == wide_balls
          ? _value.wide_balls
          : wide_balls // ignore: cast_nullable_to_non_nullable
              as int,
      average: null == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      strike_rate: null == strike_rate
          ? _value.strike_rate
          : strike_rate // ignore: cast_nullable_to_non_nullable
              as double,
      economy_rate: null == economy_rate
          ? _value.economy_rate
          : economy_rate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BowlingImplCopyWith<$Res> implements $BowlingCopyWith<$Res> {
  factory _$$BowlingImplCopyWith(
          _$BowlingImpl value, $Res Function(_$BowlingImpl) then) =
      __$$BowlingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int innings,
      int wicket_taken,
      int balls,
      int runs_conceded,
      int maiden,
      int no_balls,
      int wide_balls,
      double average,
      double strike_rate,
      double economy_rate});
}

/// @nodoc
class __$$BowlingImplCopyWithImpl<$Res>
    extends _$BowlingCopyWithImpl<$Res, _$BowlingImpl>
    implements _$$BowlingImplCopyWith<$Res> {
  __$$BowlingImplCopyWithImpl(
      _$BowlingImpl _value, $Res Function(_$BowlingImpl) _then)
      : super(_value, _then);

  /// Create a copy of Bowling
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? innings = null,
    Object? wicket_taken = null,
    Object? balls = null,
    Object? runs_conceded = null,
    Object? maiden = null,
    Object? no_balls = null,
    Object? wide_balls = null,
    Object? average = null,
    Object? strike_rate = null,
    Object? economy_rate = null,
  }) {
    return _then(_$BowlingImpl(
      innings: null == innings
          ? _value.innings
          : innings // ignore: cast_nullable_to_non_nullable
              as int,
      wicket_taken: null == wicket_taken
          ? _value.wicket_taken
          : wicket_taken // ignore: cast_nullable_to_non_nullable
              as int,
      balls: null == balls
          ? _value.balls
          : balls // ignore: cast_nullable_to_non_nullable
              as int,
      runs_conceded: null == runs_conceded
          ? _value.runs_conceded
          : runs_conceded // ignore: cast_nullable_to_non_nullable
              as int,
      maiden: null == maiden
          ? _value.maiden
          : maiden // ignore: cast_nullable_to_non_nullable
              as int,
      no_balls: null == no_balls
          ? _value.no_balls
          : no_balls // ignore: cast_nullable_to_non_nullable
              as int,
      wide_balls: null == wide_balls
          ? _value.wide_balls
          : wide_balls // ignore: cast_nullable_to_non_nullable
              as int,
      average: null == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      strike_rate: null == strike_rate
          ? _value.strike_rate
          : strike_rate // ignore: cast_nullable_to_non_nullable
              as double,
      economy_rate: null == economy_rate
          ? _value.economy_rate
          : economy_rate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BowlingImpl implements _Bowling {
  const _$BowlingImpl(
      {this.innings = 0,
      this.wicket_taken = 0,
      this.balls = 0,
      this.runs_conceded = 0,
      this.maiden = 0,
      this.no_balls = 0,
      this.wide_balls = 0,
      this.average = 0.0,
      this.strike_rate = 0.0,
      this.economy_rate = 0.0});

  factory _$BowlingImpl.fromJson(Map<String, dynamic> json) =>
      _$$BowlingImplFromJson(json);

  @override
  @JsonKey()
  final int innings;
  @override
  @JsonKey()
  final int wicket_taken;
  @override
  @JsonKey()
  final int balls;
  @override
  @JsonKey()
  final int runs_conceded;
  @override
  @JsonKey()
  final int maiden;
  @override
  @JsonKey()
  final int no_balls;
  @override
  @JsonKey()
  final int wide_balls;
  @override
  @JsonKey()
  final double average;
  @override
  @JsonKey()
  final double strike_rate;
  @override
  @JsonKey()
  final double economy_rate;

  @override
  String toString() {
    return 'Bowling(innings: $innings, wicket_taken: $wicket_taken, balls: $balls, runs_conceded: $runs_conceded, maiden: $maiden, no_balls: $no_balls, wide_balls: $wide_balls, average: $average, strike_rate: $strike_rate, economy_rate: $economy_rate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BowlingImpl &&
            (identical(other.innings, innings) || other.innings == innings) &&
            (identical(other.wicket_taken, wicket_taken) ||
                other.wicket_taken == wicket_taken) &&
            (identical(other.balls, balls) || other.balls == balls) &&
            (identical(other.runs_conceded, runs_conceded) ||
                other.runs_conceded == runs_conceded) &&
            (identical(other.maiden, maiden) || other.maiden == maiden) &&
            (identical(other.no_balls, no_balls) ||
                other.no_balls == no_balls) &&
            (identical(other.wide_balls, wide_balls) ||
                other.wide_balls == wide_balls) &&
            (identical(other.average, average) || other.average == average) &&
            (identical(other.strike_rate, strike_rate) ||
                other.strike_rate == strike_rate) &&
            (identical(other.economy_rate, economy_rate) ||
                other.economy_rate == economy_rate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      innings,
      wicket_taken,
      balls,
      runs_conceded,
      maiden,
      no_balls,
      wide_balls,
      average,
      strike_rate,
      economy_rate);

  /// Create a copy of Bowling
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BowlingImplCopyWith<_$BowlingImpl> get copyWith =>
      __$$BowlingImplCopyWithImpl<_$BowlingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BowlingImplToJson(
      this,
    );
  }
}

abstract class _Bowling implements Bowling {
  const factory _Bowling(
      {final int innings,
      final int wicket_taken,
      final int balls,
      final int runs_conceded,
      final int maiden,
      final int no_balls,
      final int wide_balls,
      final double average,
      final double strike_rate,
      final double economy_rate}) = _$BowlingImpl;

  factory _Bowling.fromJson(Map<String, dynamic> json) = _$BowlingImpl.fromJson;

  @override
  int get innings;
  @override
  int get wicket_taken;
  @override
  int get balls;
  @override
  int get runs_conceded;
  @override
  int get maiden;
  @override
  int get no_balls;
  @override
  int get wide_balls;
  @override
  double get average;
  @override
  double get strike_rate;
  @override
  double get economy_rate;

  /// Create a copy of Bowling
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BowlingImplCopyWith<_$BowlingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Fielding _$FieldingFromJson(Map<String, dynamic> json) {
  return _Fielding.fromJson(json);
}

/// @nodoc
mixin _$Fielding {
  int get catches => throw _privateConstructorUsedError;
  int get runOut => throw _privateConstructorUsedError;
  int get stumping => throw _privateConstructorUsedError;

  /// Serializes this Fielding to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Fielding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FieldingCopyWith<Fielding> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldingCopyWith<$Res> {
  factory $FieldingCopyWith(Fielding value, $Res Function(Fielding) then) =
      _$FieldingCopyWithImpl<$Res, Fielding>;
  @useResult
  $Res call({int catches, int runOut, int stumping});
}

/// @nodoc
class _$FieldingCopyWithImpl<$Res, $Val extends Fielding>
    implements $FieldingCopyWith<$Res> {
  _$FieldingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Fielding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? catches = null,
    Object? runOut = null,
    Object? stumping = null,
  }) {
    return _then(_value.copyWith(
      catches: null == catches
          ? _value.catches
          : catches // ignore: cast_nullable_to_non_nullable
              as int,
      runOut: null == runOut
          ? _value.runOut
          : runOut // ignore: cast_nullable_to_non_nullable
              as int,
      stumping: null == stumping
          ? _value.stumping
          : stumping // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FieldingImplCopyWith<$Res>
    implements $FieldingCopyWith<$Res> {
  factory _$$FieldingImplCopyWith(
          _$FieldingImpl value, $Res Function(_$FieldingImpl) then) =
      __$$FieldingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int catches, int runOut, int stumping});
}

/// @nodoc
class __$$FieldingImplCopyWithImpl<$Res>
    extends _$FieldingCopyWithImpl<$Res, _$FieldingImpl>
    implements _$$FieldingImplCopyWith<$Res> {
  __$$FieldingImplCopyWithImpl(
      _$FieldingImpl _value, $Res Function(_$FieldingImpl) _then)
      : super(_value, _then);

  /// Create a copy of Fielding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? catches = null,
    Object? runOut = null,
    Object? stumping = null,
  }) {
    return _then(_$FieldingImpl(
      catches: null == catches
          ? _value.catches
          : catches // ignore: cast_nullable_to_non_nullable
              as int,
      runOut: null == runOut
          ? _value.runOut
          : runOut // ignore: cast_nullable_to_non_nullable
              as int,
      stumping: null == stumping
          ? _value.stumping
          : stumping // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FieldingImpl implements _Fielding {
  const _$FieldingImpl({this.catches = 0, this.runOut = 0, this.stumping = 0});

  factory _$FieldingImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldingImplFromJson(json);

  @override
  @JsonKey()
  final int catches;
  @override
  @JsonKey()
  final int runOut;
  @override
  @JsonKey()
  final int stumping;

  @override
  String toString() {
    return 'Fielding(catches: $catches, runOut: $runOut, stumping: $stumping)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldingImpl &&
            (identical(other.catches, catches) || other.catches == catches) &&
            (identical(other.runOut, runOut) || other.runOut == runOut) &&
            (identical(other.stumping, stumping) ||
                other.stumping == stumping));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, catches, runOut, stumping);

  /// Create a copy of Fielding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldingImplCopyWith<_$FieldingImpl> get copyWith =>
      __$$FieldingImplCopyWithImpl<_$FieldingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldingImplToJson(
      this,
    );
  }
}

abstract class _Fielding implements Fielding {
  const factory _Fielding(
      {final int catches,
      final int runOut,
      final int stumping}) = _$FieldingImpl;

  factory _Fielding.fromJson(Map<String, dynamic> json) =
      _$FieldingImpl.fromJson;

  @override
  int get catches;
  @override
  int get runOut;
  @override
  int get stumping;

  /// Create a copy of Fielding
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FieldingImplCopyWith<_$FieldingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
