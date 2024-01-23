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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get dob => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get profile_img_url => throw _privateConstructorUsedError;
  UserGender? get gender => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  DateTime? get updated_at => throw _privateConstructorUsedError;
  String? get player_role => throw _privateConstructorUsedError;
  String? get batting_style => throw _privateConstructorUsedError;
  String? get bowling_style => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {int id,
      String? name,
      String? location,
      String? phone,
      String? dob,
      String? email,
      String? profile_img_url,
      UserGender? gender,
      DateTime? created_at,
      DateTime? updated_at,
      String? player_role,
      String? batting_style,
      String? bowling_style});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
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
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
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
              as String?,
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
              as String?,
      batting_style: freezed == batting_style
          ? _value.batting_style
          : batting_style // ignore: cast_nullable_to_non_nullable
              as String?,
      bowling_style: freezed == bowling_style
          ? _value.bowling_style
          : bowling_style // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? name,
      String? location,
      String? phone,
      String? dob,
      String? email,
      String? profile_img_url,
      UserGender? gender,
      DateTime? created_at,
      DateTime? updated_at,
      String? player_role,
      String? batting_style,
      String? bowling_style});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
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
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
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
              as String?,
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
              as String?,
      batting_style: freezed == batting_style
          ? _value.batting_style
          : batting_style // ignore: cast_nullable_to_non_nullable
              as String?,
      bowling_style: freezed == bowling_style
          ? _value.bowling_style
          : bowling_style // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl extends _User {
  const _$UserImpl(
      {required this.id,
      this.name,
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
      this.bowling_style})
      : super._();

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final int id;
  @override
  final String? name;
  @override
  final String? location;
  @override
  final String? phone;
  @override
  final String? dob;
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
  final String? player_role;
  @override
  final String? batting_style;
  @override
  final String? bowling_style;

  @override
  String toString() {
    return 'User(id: $id, name: $name, location: $location, phone: $phone, dob: $dob, email: $email, profile_img_url: $profile_img_url, gender: $gender, created_at: $created_at, updated_at: $updated_at, player_role: $player_role, batting_style: $batting_style, bowling_style: $bowling_style)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
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
                other.bowling_style == bowling_style));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
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
      bowling_style);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User extends User {
  const factory _User(
      {required final int id,
      final String? name,
      final String? location,
      final String? phone,
      final String? dob,
      final String? email,
      final String? profile_img_url,
      final UserGender? gender,
      final DateTime? created_at,
      final DateTime? updated_at,
      final String? player_role,
      final String? batting_style,
      final String? bowling_style}) = _$UserImpl;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  String? get location;
  @override
  String? get phone;
  @override
  String? get dob;
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
  String? get player_role;
  @override
  String? get batting_style;
  @override
  String? get bowling_style;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
