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
  String? get name_initial => throw _privateConstructorUsedError;
  String? get profile_img_url => throw _privateConstructorUsedError;
  String? get created_by => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  UserModel get created_by_user => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  @TimeStampJsonConverter()
  DateTime? get created_time => throw _privateConstructorUsedError;
  @JsonKey(name: FireStoreConst.teamPlayers)
  List<TeamPlayer> get players => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  TeamStat get stat => throw _privateConstructorUsedError;

  /// Serializes this TeamModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      String? name_initial,
      String? profile_img_url,
      String? created_by,
      @JsonKey(includeToJson: false, includeFromJson: false)
      UserModel created_by_user,
      DateTime? created_at,
      @TimeStampJsonConverter() DateTime? created_time,
      @JsonKey(name: FireStoreConst.teamPlayers) List<TeamPlayer> players,
      @JsonKey(includeToJson: false, includeFromJson: false) TeamStat stat});

  $UserModelCopyWith<$Res> get created_by_user;
  $TeamStatCopyWith<$Res> get stat;
}

/// @nodoc
class _$TeamModelCopyWithImpl<$Res, $Val extends TeamModel>
    implements $TeamModelCopyWith<$Res> {
  _$TeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? name_lowercase = null,
    Object? city = freezed,
    Object? name_initial = freezed,
    Object? profile_img_url = freezed,
    Object? created_by = freezed,
    Object? created_by_user = null,
    Object? created_at = freezed,
    Object? created_time = freezed,
    Object? players = null,
    Object? stat = null,
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
      name_initial: freezed == name_initial
          ? _value.name_initial
          : name_initial // ignore: cast_nullable_to_non_nullable
              as String?,
      profile_img_url: freezed == profile_img_url
          ? _value.profile_img_url
          : profile_img_url // ignore: cast_nullable_to_non_nullable
              as String?,
      created_by: freezed == created_by
          ? _value.created_by
          : created_by // ignore: cast_nullable_to_non_nullable
              as String?,
      created_by_user: null == created_by_user
          ? _value.created_by_user
          : created_by_user // ignore: cast_nullable_to_non_nullable
              as UserModel,
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
      stat: null == stat
          ? _value.stat
          : stat // ignore: cast_nullable_to_non_nullable
              as TeamStat,
    ) as $Val);
  }

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get created_by_user {
    return $UserModelCopyWith<$Res>(_value.created_by_user, (value) {
      return _then(_value.copyWith(created_by_user: value) as $Val);
    });
  }

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamStatCopyWith<$Res> get stat {
    return $TeamStatCopyWith<$Res>(_value.stat, (value) {
      return _then(_value.copyWith(stat: value) as $Val);
    });
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
      String? name_initial,
      String? profile_img_url,
      String? created_by,
      @JsonKey(includeToJson: false, includeFromJson: false)
      UserModel created_by_user,
      DateTime? created_at,
      @TimeStampJsonConverter() DateTime? created_time,
      @JsonKey(name: FireStoreConst.teamPlayers) List<TeamPlayer> players,
      @JsonKey(includeToJson: false, includeFromJson: false) TeamStat stat});

  @override
  $UserModelCopyWith<$Res> get created_by_user;
  @override
  $TeamStatCopyWith<$Res> get stat;
}

/// @nodoc
class __$$TeamModelImplCopyWithImpl<$Res>
    extends _$TeamModelCopyWithImpl<$Res, _$TeamModelImpl>
    implements _$$TeamModelImplCopyWith<$Res> {
  __$$TeamModelImplCopyWithImpl(
      _$TeamModelImpl _value, $Res Function(_$TeamModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? name_lowercase = null,
    Object? city = freezed,
    Object? name_initial = freezed,
    Object? profile_img_url = freezed,
    Object? created_by = freezed,
    Object? created_by_user = null,
    Object? created_at = freezed,
    Object? created_time = freezed,
    Object? players = null,
    Object? stat = null,
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
      name_initial: freezed == name_initial
          ? _value.name_initial
          : name_initial // ignore: cast_nullable_to_non_nullable
              as String?,
      profile_img_url: freezed == profile_img_url
          ? _value.profile_img_url
          : profile_img_url // ignore: cast_nullable_to_non_nullable
              as String?,
      created_by: freezed == created_by
          ? _value.created_by
          : created_by // ignore: cast_nullable_to_non_nullable
              as String?,
      created_by_user: null == created_by_user
          ? _value.created_by_user
          : created_by_user // ignore: cast_nullable_to_non_nullable
              as UserModel,
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
      stat: null == stat
          ? _value.stat
          : stat // ignore: cast_nullable_to_non_nullable
              as TeamStat,
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
      this.name_initial,
      this.profile_img_url,
      this.created_by,
      @JsonKey(includeToJson: false, includeFromJson: false)
      this.created_by_user = const UserModel(id: ''),
      this.created_at,
      @TimeStampJsonConverter() this.created_time,
      @JsonKey(name: FireStoreConst.teamPlayers)
      final List<TeamPlayer> players = const [],
      @JsonKey(includeToJson: false, includeFromJson: false)
      this.stat = const TeamStat()})
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
  final String? name_initial;
  @override
  final String? profile_img_url;
  @override
  final String? created_by;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final UserModel created_by_user;
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
  @JsonKey(includeToJson: false, includeFromJson: false)
  final TeamStat stat;

  @override
  String toString() {
    return 'TeamModel(id: $id, name: $name, name_lowercase: $name_lowercase, city: $city, name_initial: $name_initial, profile_img_url: $profile_img_url, created_by: $created_by, created_by_user: $created_by_user, created_at: $created_at, created_time: $created_time, players: $players, stat: $stat)';
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
            (identical(other.name_initial, name_initial) ||
                other.name_initial == name_initial) &&
            (identical(other.profile_img_url, profile_img_url) ||
                other.profile_img_url == profile_img_url) &&
            (identical(other.created_by, created_by) ||
                other.created_by == created_by) &&
            (identical(other.created_by_user, created_by_user) ||
                other.created_by_user == created_by_user) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.created_time, created_time) ||
                other.created_time == created_time) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            (identical(other.stat, stat) || other.stat == stat));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      name_lowercase,
      city,
      name_initial,
      profile_img_url,
      created_by,
      created_by_user,
      created_at,
      created_time,
      const DeepCollectionEquality().hash(_players),
      stat);

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      final String? name_initial,
      final String? profile_img_url,
      final String? created_by,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final UserModel created_by_user,
      final DateTime? created_at,
      @TimeStampJsonConverter() final DateTime? created_time,
      @JsonKey(name: FireStoreConst.teamPlayers) final List<TeamPlayer> players,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final TeamStat stat}) = _$TeamModelImpl;

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
  String? get name_initial;
  @override
  String? get profile_img_url;
  @override
  String? get created_by;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  UserModel get created_by_user;
  @override
  DateTime? get created_at;
  @override
  @TimeStampJsonConverter()
  DateTime? get created_time;
  @override
  @JsonKey(name: FireStoreConst.teamPlayers)
  List<TeamPlayer> get players;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  TeamStat get stat;

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this TeamPlayer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamPlayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of TeamPlayer
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of TeamPlayer
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of TeamPlayer
  /// with the given fields replaced by the non-null parameter values.
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, role, user);

  /// Create a copy of TeamPlayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of TeamPlayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamPlayerImplCopyWith<_$TeamPlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamStat _$TeamStatFromJson(Map<String, dynamic> json) {
  return _TeamStat.fromJson(json);
}

/// @nodoc
mixin _$TeamStat {
  int get played => throw _privateConstructorUsedError;
  TeamMatchStatus get status => throw _privateConstructorUsedError;
  int get runs => throw _privateConstructorUsedError;
  int get wickets => throw _privateConstructorUsedError;
  double get batting_average => throw _privateConstructorUsedError;
  double get bowling_average => throw _privateConstructorUsedError;
  int get highest_runs => throw _privateConstructorUsedError;
  int get lowest_runs => throw _privateConstructorUsedError;
  double get run_rate => throw _privateConstructorUsedError;

  /// Serializes this TeamStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamStatCopyWith<TeamStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamStatCopyWith<$Res> {
  factory $TeamStatCopyWith(TeamStat value, $Res Function(TeamStat) then) =
      _$TeamStatCopyWithImpl<$Res, TeamStat>;
  @useResult
  $Res call(
      {int played,
      TeamMatchStatus status,
      int runs,
      int wickets,
      double batting_average,
      double bowling_average,
      int highest_runs,
      int lowest_runs,
      double run_rate});

  $TeamMatchStatusCopyWith<$Res> get status;
}

/// @nodoc
class _$TeamStatCopyWithImpl<$Res, $Val extends TeamStat>
    implements $TeamStatCopyWith<$Res> {
  _$TeamStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? played = null,
    Object? status = null,
    Object? runs = null,
    Object? wickets = null,
    Object? batting_average = null,
    Object? bowling_average = null,
    Object? highest_runs = null,
    Object? lowest_runs = null,
    Object? run_rate = null,
  }) {
    return _then(_value.copyWith(
      played: null == played
          ? _value.played
          : played // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TeamMatchStatus,
      runs: null == runs
          ? _value.runs
          : runs // ignore: cast_nullable_to_non_nullable
              as int,
      wickets: null == wickets
          ? _value.wickets
          : wickets // ignore: cast_nullable_to_non_nullable
              as int,
      batting_average: null == batting_average
          ? _value.batting_average
          : batting_average // ignore: cast_nullable_to_non_nullable
              as double,
      bowling_average: null == bowling_average
          ? _value.bowling_average
          : bowling_average // ignore: cast_nullable_to_non_nullable
              as double,
      highest_runs: null == highest_runs
          ? _value.highest_runs
          : highest_runs // ignore: cast_nullable_to_non_nullable
              as int,
      lowest_runs: null == lowest_runs
          ? _value.lowest_runs
          : lowest_runs // ignore: cast_nullable_to_non_nullable
              as int,
      run_rate: null == run_rate
          ? _value.run_rate
          : run_rate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  /// Create a copy of TeamStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamMatchStatusCopyWith<$Res> get status {
    return $TeamMatchStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TeamStatImplCopyWith<$Res>
    implements $TeamStatCopyWith<$Res> {
  factory _$$TeamStatImplCopyWith(
          _$TeamStatImpl value, $Res Function(_$TeamStatImpl) then) =
      __$$TeamStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int played,
      TeamMatchStatus status,
      int runs,
      int wickets,
      double batting_average,
      double bowling_average,
      int highest_runs,
      int lowest_runs,
      double run_rate});

  @override
  $TeamMatchStatusCopyWith<$Res> get status;
}

/// @nodoc
class __$$TeamStatImplCopyWithImpl<$Res>
    extends _$TeamStatCopyWithImpl<$Res, _$TeamStatImpl>
    implements _$$TeamStatImplCopyWith<$Res> {
  __$$TeamStatImplCopyWithImpl(
      _$TeamStatImpl _value, $Res Function(_$TeamStatImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeamStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? played = null,
    Object? status = null,
    Object? runs = null,
    Object? wickets = null,
    Object? batting_average = null,
    Object? bowling_average = null,
    Object? highest_runs = null,
    Object? lowest_runs = null,
    Object? run_rate = null,
  }) {
    return _then(_$TeamStatImpl(
      played: null == played
          ? _value.played
          : played // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TeamMatchStatus,
      runs: null == runs
          ? _value.runs
          : runs // ignore: cast_nullable_to_non_nullable
              as int,
      wickets: null == wickets
          ? _value.wickets
          : wickets // ignore: cast_nullable_to_non_nullable
              as int,
      batting_average: null == batting_average
          ? _value.batting_average
          : batting_average // ignore: cast_nullable_to_non_nullable
              as double,
      bowling_average: null == bowling_average
          ? _value.bowling_average
          : bowling_average // ignore: cast_nullable_to_non_nullable
              as double,
      highest_runs: null == highest_runs
          ? _value.highest_runs
          : highest_runs // ignore: cast_nullable_to_non_nullable
              as int,
      lowest_runs: null == lowest_runs
          ? _value.lowest_runs
          : lowest_runs // ignore: cast_nullable_to_non_nullable
              as int,
      run_rate: null == run_rate
          ? _value.run_rate
          : run_rate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true)
class _$TeamStatImpl implements _TeamStat {
  const _$TeamStatImpl(
      {this.played = 0,
      this.status = const TeamMatchStatus(),
      this.runs = 0,
      this.wickets = 0,
      this.batting_average = 0.0,
      this.bowling_average = 0.0,
      this.highest_runs = 0,
      this.lowest_runs = 0,
      this.run_rate = 0.0});

  factory _$TeamStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamStatImplFromJson(json);

  @override
  @JsonKey()
  final int played;
  @override
  @JsonKey()
  final TeamMatchStatus status;
  @override
  @JsonKey()
  final int runs;
  @override
  @JsonKey()
  final int wickets;
  @override
  @JsonKey()
  final double batting_average;
  @override
  @JsonKey()
  final double bowling_average;
  @override
  @JsonKey()
  final int highest_runs;
  @override
  @JsonKey()
  final int lowest_runs;
  @override
  @JsonKey()
  final double run_rate;

  @override
  String toString() {
    return 'TeamStat(played: $played, status: $status, runs: $runs, wickets: $wickets, batting_average: $batting_average, bowling_average: $bowling_average, highest_runs: $highest_runs, lowest_runs: $lowest_runs, run_rate: $run_rate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamStatImpl &&
            (identical(other.played, played) || other.played == played) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.runs, runs) || other.runs == runs) &&
            (identical(other.wickets, wickets) || other.wickets == wickets) &&
            (identical(other.batting_average, batting_average) ||
                other.batting_average == batting_average) &&
            (identical(other.bowling_average, bowling_average) ||
                other.bowling_average == bowling_average) &&
            (identical(other.highest_runs, highest_runs) ||
                other.highest_runs == highest_runs) &&
            (identical(other.lowest_runs, lowest_runs) ||
                other.lowest_runs == lowest_runs) &&
            (identical(other.run_rate, run_rate) ||
                other.run_rate == run_rate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, played, status, runs, wickets,
      batting_average, bowling_average, highest_runs, lowest_runs, run_rate);

  /// Create a copy of TeamStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamStatImplCopyWith<_$TeamStatImpl> get copyWith =>
      __$$TeamStatImplCopyWithImpl<_$TeamStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamStatImplToJson(
      this,
    );
  }
}

abstract class _TeamStat implements TeamStat {
  const factory _TeamStat(
      {final int played,
      final TeamMatchStatus status,
      final int runs,
      final int wickets,
      final double batting_average,
      final double bowling_average,
      final int highest_runs,
      final int lowest_runs,
      final double run_rate}) = _$TeamStatImpl;

  factory _TeamStat.fromJson(Map<String, dynamic> json) =
      _$TeamStatImpl.fromJson;

  @override
  int get played;
  @override
  TeamMatchStatus get status;
  @override
  int get runs;
  @override
  int get wickets;
  @override
  double get batting_average;
  @override
  double get bowling_average;
  @override
  int get highest_runs;
  @override
  int get lowest_runs;
  @override
  double get run_rate;

  /// Create a copy of TeamStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamStatImplCopyWith<_$TeamStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamMatchStatus _$TeamMatchStatusFromJson(Map<String, dynamic> json) {
  return _TeamMatchStatus.fromJson(json);
}

/// @nodoc
mixin _$TeamMatchStatus {
  int get win => throw _privateConstructorUsedError;
  int get tie => throw _privateConstructorUsedError;
  int get lost => throw _privateConstructorUsedError;

  /// Serializes this TeamMatchStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamMatchStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamMatchStatusCopyWith<TeamMatchStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamMatchStatusCopyWith<$Res> {
  factory $TeamMatchStatusCopyWith(
          TeamMatchStatus value, $Res Function(TeamMatchStatus) then) =
      _$TeamMatchStatusCopyWithImpl<$Res, TeamMatchStatus>;
  @useResult
  $Res call({int win, int tie, int lost});
}

/// @nodoc
class _$TeamMatchStatusCopyWithImpl<$Res, $Val extends TeamMatchStatus>
    implements $TeamMatchStatusCopyWith<$Res> {
  _$TeamMatchStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamMatchStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? win = null,
    Object? tie = null,
    Object? lost = null,
  }) {
    return _then(_value.copyWith(
      win: null == win
          ? _value.win
          : win // ignore: cast_nullable_to_non_nullable
              as int,
      tie: null == tie
          ? _value.tie
          : tie // ignore: cast_nullable_to_non_nullable
              as int,
      lost: null == lost
          ? _value.lost
          : lost // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamMatchStatusImplCopyWith<$Res>
    implements $TeamMatchStatusCopyWith<$Res> {
  factory _$$TeamMatchStatusImplCopyWith(_$TeamMatchStatusImpl value,
          $Res Function(_$TeamMatchStatusImpl) then) =
      __$$TeamMatchStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int win, int tie, int lost});
}

/// @nodoc
class __$$TeamMatchStatusImplCopyWithImpl<$Res>
    extends _$TeamMatchStatusCopyWithImpl<$Res, _$TeamMatchStatusImpl>
    implements _$$TeamMatchStatusImplCopyWith<$Res> {
  __$$TeamMatchStatusImplCopyWithImpl(
      _$TeamMatchStatusImpl _value, $Res Function(_$TeamMatchStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeamMatchStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? win = null,
    Object? tie = null,
    Object? lost = null,
  }) {
    return _then(_$TeamMatchStatusImpl(
      win: null == win
          ? _value.win
          : win // ignore: cast_nullable_to_non_nullable
              as int,
      tie: null == tie
          ? _value.tie
          : tie // ignore: cast_nullable_to_non_nullable
              as int,
      lost: null == lost
          ? _value.lost
          : lost // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamMatchStatusImpl implements _TeamMatchStatus {
  const _$TeamMatchStatusImpl({this.win = 0, this.tie = 0, this.lost = 0});

  factory _$TeamMatchStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamMatchStatusImplFromJson(json);

  @override
  @JsonKey()
  final int win;
  @override
  @JsonKey()
  final int tie;
  @override
  @JsonKey()
  final int lost;

  @override
  String toString() {
    return 'TeamMatchStatus(win: $win, tie: $tie, lost: $lost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMatchStatusImpl &&
            (identical(other.win, win) || other.win == win) &&
            (identical(other.tie, tie) || other.tie == tie) &&
            (identical(other.lost, lost) || other.lost == lost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, win, tie, lost);

  /// Create a copy of TeamMatchStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamMatchStatusImplCopyWith<_$TeamMatchStatusImpl> get copyWith =>
      __$$TeamMatchStatusImplCopyWithImpl<_$TeamMatchStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamMatchStatusImplToJson(
      this,
    );
  }
}

abstract class _TeamMatchStatus implements TeamMatchStatus {
  const factory _TeamMatchStatus(
      {final int win, final int tie, final int lost}) = _$TeamMatchStatusImpl;

  factory _TeamMatchStatus.fromJson(Map<String, dynamic> json) =
      _$TeamMatchStatusImpl.fromJson;

  @override
  int get win;
  @override
  int get tie;
  @override
  int get lost;

  /// Create a copy of TeamMatchStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamMatchStatusImplCopyWith<_$TeamMatchStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
