// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) {
  return _TeamModel.fromJson(json);
}

/// @nodoc
mixin _$TeamModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get name_lowercase => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get profile_img_url => throw _privateConstructorUsedError;
  String? get created_by => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  @TimeStampJsonConverter()
  DateTime? get created_time => throw _privateConstructorUsedError;
  @JsonKey(name: FireStoreConst.teamPlayers)
  List<TeamPlayer> get players => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamModelCopyWith<TeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamModelCopyWith<$Res> {
  factory $TeamModelCopyWith(TeamModel value, $Res Function(TeamModel) then) =
      _$TeamModelCopyWithImpl<$Res, TeamModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String name_lowercase,
      String? city,
      String? profile_img_url,
      String? created_by,
      DateTime? created_at,
      @TimeStampJsonConverter() DateTime? created_time,
      @JsonKey(name: FireStoreConst.teamPlayers) List<TeamPlayer> players});
}

/// @nodoc
class _$TeamModelCopyWithImpl<$Res, $Val extends TeamModel>
    implements $TeamModelCopyWith<$Res> {
  _$TeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? name_lowercase = null,
    Object? city = freezed,
    Object? profile_img_url = freezed,
    Object? created_by = freezed,
    Object? created_at = freezed,
    Object? created_time = freezed,
    Object? players = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      name_lowercase: null == name_lowercase
          ? _value.name_lowercase
          : name_lowercase // ignore: cast_nullable_to_non_nullable
              as String,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      profile_img_url: freezed == profile_img_url
          ? _value.profile_img_url
          : profile_img_url // ignore: cast_nullable_to_non_nullable
              as String?,
      created_by: freezed == created_by
          ? _value.created_by
          : created_by // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      created_time: freezed == created_time
          ? _value.created_time
          : created_time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<TeamPlayer>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamModelImplCopyWith<$Res>
    implements $TeamModelCopyWith<$Res> {
  factory _$$TeamModelImplCopyWith(
          _$TeamModelImpl value, $Res Function(_$TeamModelImpl) then) =
      __$$TeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String name_lowercase,
      String? city,
      String? profile_img_url,
      String? created_by,
      DateTime? created_at,
      @TimeStampJsonConverter() DateTime? created_time,
      @JsonKey(name: FireStoreConst.teamPlayers) List<TeamPlayer> players});
}

/// @nodoc
class __$$TeamModelImplCopyWithImpl<$Res>
    extends _$TeamModelCopyWithImpl<$Res, _$TeamModelImpl>
    implements _$$TeamModelImplCopyWith<$Res> {
  __$$TeamModelImplCopyWithImpl(
      _$TeamModelImpl _value, $Res Function(_$TeamModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? name_lowercase = null,
    Object? city = freezed,
    Object? profile_img_url = freezed,
    Object? created_by = freezed,
    Object? created_at = freezed,
    Object? created_time = freezed,
    Object? players = null,
  }) {
    return _then(_$TeamModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      name_lowercase: null == name_lowercase
          ? _value.name_lowercase
          : name_lowercase // ignore: cast_nullable_to_non_nullable
              as String,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      profile_img_url: freezed == profile_img_url
          ? _value.profile_img_url
          : profile_img_url // ignore: cast_nullable_to_non_nullable
              as String?,
      created_by: freezed == created_by
          ? _value.created_by
          : created_by // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      created_time: freezed == created_time
          ? _value.created_time
          : created_time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<TeamPlayer>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TeamModelImpl implements _TeamModel {
  const _$TeamModelImpl(
      {required this.id,
      required this.name,
      required this.name_lowercase,
      this.city,
      this.profile_img_url,
      this.created_by,
      this.created_at,
      @TimeStampJsonConverter() this.created_time,
      @JsonKey(name: FireStoreConst.teamPlayers)
      final List<TeamPlayer> players = const []})
      : _players = players;

  factory _$TeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String name_lowercase;
  @override
  final String? city;
  @override
  final String? profile_img_url;
  @override
  final String? created_by;
  @override
  final DateTime? created_at;
  @override
  @TimeStampJsonConverter()
  final DateTime? created_time;
  final List<TeamPlayer> _players;
  @override
  @JsonKey(name: FireStoreConst.teamPlayers)
  List<TeamPlayer> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  String toString() {
    return 'TeamModel(id: $id, name: $name, name_lowercase: $name_lowercase, city: $city, profile_img_url: $profile_img_url, created_by: $created_by, created_at: $created_at, created_time: $created_time, players: $players)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.name_lowercase, name_lowercase) ||
                other.name_lowercase == name_lowercase) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.profile_img_url, profile_img_url) ||
                other.profile_img_url == profile_img_url) &&
            (identical(other.created_by, created_by) ||
                other.created_by == created_by) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.created_time, created_time) ||
                other.created_time == created_time) &&
            const DeepCollectionEquality().equals(other._players, _players));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      name_lowercase,
      city,
      profile_img_url,
      created_by,
      created_at,
      created_time,
      const DeepCollectionEquality().hash(_players));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamModelImplCopyWith<_$TeamModelImpl> get copyWith =>
      __$$TeamModelImplCopyWithImpl<_$TeamModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamModelImplToJson(
      this,
    );
  }
}

abstract class _TeamModel implements TeamModel {
  const factory _TeamModel(
      {required final String id,
      required final String name,
      required final String name_lowercase,
      final String? city,
      final String? profile_img_url,
      final String? created_by,
      final DateTime? created_at,
      @TimeStampJsonConverter() final DateTime? created_time,
      @JsonKey(name: FireStoreConst.teamPlayers)
      final List<TeamPlayer> players}) = _$TeamModelImpl;

  factory _TeamModel.fromJson(Map<String, dynamic> json) =
      _$TeamModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get name_lowercase;
  @override
  String? get city;
  @override
  String? get profile_img_url;
  @override
  String? get created_by;
  @override
  DateTime? get created_at;
  @override
  @TimeStampJsonConverter()
  DateTime? get created_time;
  @override
  @JsonKey(name: FireStoreConst.teamPlayers)
  List<TeamPlayer> get players;
  @override
  @JsonKey(ignore: true)
  _$$TeamModelImplCopyWith<_$TeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamPlayer _$TeamPlayerFromJson(Map<String, dynamic> json) {
  return _TeamPlayer.fromJson(json);
}

/// @nodoc
mixin _$TeamPlayer {
  String get id => throw _privateConstructorUsedError;
  TeamPlayerRole get role => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  UserModel get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamPlayerCopyWith<TeamPlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamPlayerCopyWith<$Res> {
  factory $TeamPlayerCopyWith(
          TeamPlayer value, $Res Function(TeamPlayer) then) =
      _$TeamPlayerCopyWithImpl<$Res, TeamPlayer>;
  @useResult
  $Res call(
      {String id,
      TeamPlayerRole role,
      @JsonKey(includeToJson: false, includeFromJson: false) UserModel user});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$TeamPlayerCopyWithImpl<$Res, $Val extends TeamPlayer>
    implements $TeamPlayerCopyWith<$Res> {
  _$TeamPlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as TeamPlayerRole,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TeamPlayerImplCopyWith<$Res>
    implements $TeamPlayerCopyWith<$Res> {
  factory _$$TeamPlayerImplCopyWith(
          _$TeamPlayerImpl value, $Res Function(_$TeamPlayerImpl) then) =
      __$$TeamPlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      TeamPlayerRole role,
      @JsonKey(includeToJson: false, includeFromJson: false) UserModel user});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$TeamPlayerImplCopyWithImpl<$Res>
    extends _$TeamPlayerCopyWithImpl<$Res, _$TeamPlayerImpl>
    implements _$$TeamPlayerImplCopyWith<$Res> {
  __$$TeamPlayerImplCopyWithImpl(
      _$TeamPlayerImpl _value, $Res Function(_$TeamPlayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? user = null,
  }) {
    return _then(_$TeamPlayerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as TeamPlayerRole,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TeamPlayerImpl implements _TeamPlayer {
  const _$TeamPlayerImpl(
      {required this.id,
      this.role = TeamPlayerRole.player,
      @JsonKey(includeToJson: false, includeFromJson: false)
      this.user = const UserModel(id: '')});

  factory _$TeamPlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamPlayerImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final TeamPlayerRole role;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final UserModel user;

  @override
  String toString() {
    return 'TeamPlayer(id: $id, role: $role, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamPlayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, role, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamPlayerImplCopyWith<_$TeamPlayerImpl> get copyWith =>
      __$$TeamPlayerImplCopyWithImpl<_$TeamPlayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamPlayerImplToJson(
      this,
    );
  }
}

abstract class _TeamPlayer implements TeamPlayer {
  const factory _TeamPlayer(
      {required final String id,
      final TeamPlayerRole role,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final UserModel user}) = _$TeamPlayerImpl;

  factory _TeamPlayer.fromJson(Map<String, dynamic> json) =
      _$TeamPlayerImpl.fromJson;

  @override
  String get id;
  @override
  TeamPlayerRole get role;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  UserModel get user;
  @override
  @JsonKey(ignore: true)
  _$$TeamPlayerImplCopyWith<_$TeamPlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
