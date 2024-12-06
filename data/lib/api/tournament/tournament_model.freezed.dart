// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournament_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TournamentModel _$TournamentModelFromJson(Map<String, dynamic> json) {
  return _TournamentModel.fromJson(json);
}

/// @nodoc
mixin _$TournamentModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get profile_img_url => throw _privateConstructorUsedError;
  String? get banner_img_url => throw _privateConstructorUsedError;
  TournamentType get type => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  TournamentStatus get status => throw _privateConstructorUsedError;
  List<TournamentMember> get members => throw _privateConstructorUsedError;
  String get created_by => throw _privateConstructorUsedError;
  @TimeStampJsonConverter()
  DateTime? get created_at => throw _privateConstructorUsedError;
  @TimeStampJsonConverter()
  DateTime get start_date => throw _privateConstructorUsedError;
  @TimeStampJsonConverter()
  DateTime get end_date => throw _privateConstructorUsedError;
  List<String> get team_ids => throw _privateConstructorUsedError;
  List<String> get match_ids => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<TeamModel> get teams => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<MatchModel> get matches => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<PlayerKeyStat> get keyStats => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<TournamentTeamStat> get teamStats => throw _privateConstructorUsedError;

  /// Serializes this TournamentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TournamentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TournamentModelCopyWith<TournamentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentModelCopyWith<$Res> {
  factory $TournamentModelCopyWith(
          TournamentModel value, $Res Function(TournamentModel) then) =
      _$TournamentModelCopyWithImpl<$Res, TournamentModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? profile_img_url,
      String? banner_img_url,
      TournamentType type,
      @JsonKey(includeFromJson: false, includeToJson: false)
      TournamentStatus status,
      List<TournamentMember> members,
      String created_by,
      @TimeStampJsonConverter() DateTime? created_at,
      @TimeStampJsonConverter() DateTime start_date,
      @TimeStampJsonConverter() DateTime end_date,
      List<String> team_ids,
      List<String> match_ids,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<TeamModel> teams,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<MatchModel> matches,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<PlayerKeyStat> keyStats,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<TournamentTeamStat> teamStats});
}

/// @nodoc
class _$TournamentModelCopyWithImpl<$Res, $Val extends TournamentModel>
    implements $TournamentModelCopyWith<$Res> {
  _$TournamentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TournamentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? profile_img_url = freezed,
    Object? banner_img_url = freezed,
    Object? type = null,
    Object? status = null,
    Object? members = null,
    Object? created_by = null,
    Object? created_at = freezed,
    Object? start_date = null,
    Object? end_date = null,
    Object? team_ids = null,
    Object? match_ids = null,
    Object? teams = null,
    Object? matches = null,
    Object? keyStats = null,
    Object? teamStats = null,
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
      profile_img_url: freezed == profile_img_url
          ? _value.profile_img_url
          : profile_img_url // ignore: cast_nullable_to_non_nullable
              as String?,
      banner_img_url: freezed == banner_img_url
          ? _value.banner_img_url
          : banner_img_url // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TournamentType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TournamentStatus,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<TournamentMember>,
      created_by: null == created_by
          ? _value.created_by
          : created_by // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      start_date: null == start_date
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end_date: null == end_date
          ? _value.end_date
          : end_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      team_ids: null == team_ids
          ? _value.team_ids
          : team_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      match_ids: null == match_ids
          ? _value.match_ids
          : match_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
      matches: null == matches
          ? _value.matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
      keyStats: null == keyStats
          ? _value.keyStats
          : keyStats // ignore: cast_nullable_to_non_nullable
              as List<PlayerKeyStat>,
      teamStats: null == teamStats
          ? _value.teamStats
          : teamStats // ignore: cast_nullable_to_non_nullable
              as List<TournamentTeamStat>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TournamentModelImplCopyWith<$Res>
    implements $TournamentModelCopyWith<$Res> {
  factory _$$TournamentModelImplCopyWith(_$TournamentModelImpl value,
          $Res Function(_$TournamentModelImpl) then) =
      __$$TournamentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? profile_img_url,
      String? banner_img_url,
      TournamentType type,
      @JsonKey(includeFromJson: false, includeToJson: false)
      TournamentStatus status,
      List<TournamentMember> members,
      String created_by,
      @TimeStampJsonConverter() DateTime? created_at,
      @TimeStampJsonConverter() DateTime start_date,
      @TimeStampJsonConverter() DateTime end_date,
      List<String> team_ids,
      List<String> match_ids,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<TeamModel> teams,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<MatchModel> matches,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<PlayerKeyStat> keyStats,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<TournamentTeamStat> teamStats});
}

/// @nodoc
class __$$TournamentModelImplCopyWithImpl<$Res>
    extends _$TournamentModelCopyWithImpl<$Res, _$TournamentModelImpl>
    implements _$$TournamentModelImplCopyWith<$Res> {
  __$$TournamentModelImplCopyWithImpl(
      _$TournamentModelImpl _value, $Res Function(_$TournamentModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TournamentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? profile_img_url = freezed,
    Object? banner_img_url = freezed,
    Object? type = null,
    Object? status = null,
    Object? members = null,
    Object? created_by = null,
    Object? created_at = freezed,
    Object? start_date = null,
    Object? end_date = null,
    Object? team_ids = null,
    Object? match_ids = null,
    Object? teams = null,
    Object? matches = null,
    Object? keyStats = null,
    Object? teamStats = null,
  }) {
    return _then(_$TournamentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profile_img_url: freezed == profile_img_url
          ? _value.profile_img_url
          : profile_img_url // ignore: cast_nullable_to_non_nullable
              as String?,
      banner_img_url: freezed == banner_img_url
          ? _value.banner_img_url
          : banner_img_url // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TournamentType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TournamentStatus,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<TournamentMember>,
      created_by: null == created_by
          ? _value.created_by
          : created_by // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      start_date: null == start_date
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end_date: null == end_date
          ? _value.end_date
          : end_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      team_ids: null == team_ids
          ? _value._team_ids
          : team_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      match_ids: null == match_ids
          ? _value._match_ids
          : match_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      teams: null == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
      matches: null == matches
          ? _value._matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
      keyStats: null == keyStats
          ? _value._keyStats
          : keyStats // ignore: cast_nullable_to_non_nullable
              as List<PlayerKeyStat>,
      teamStats: null == teamStats
          ? _value._teamStats
          : teamStats // ignore: cast_nullable_to_non_nullable
              as List<TournamentTeamStat>,
    ));
  }
}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true)
class _$TournamentModelImpl implements _TournamentModel {
  const _$TournamentModelImpl(
      {required this.id,
      required this.name,
      this.profile_img_url,
      this.banner_img_url,
      required this.type,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.status = TournamentStatus.upcoming,
      final List<TournamentMember> members = const [],
      required this.created_by,
      @TimeStampJsonConverter() this.created_at,
      @TimeStampJsonConverter() required this.start_date,
      @TimeStampJsonConverter() required this.end_date,
      final List<String> team_ids = const [],
      final List<String> match_ids = const [],
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<TeamModel> teams = const [],
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<MatchModel> matches = const [],
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<PlayerKeyStat> keyStats = const [],
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<TournamentTeamStat> teamStats = const []})
      : _members = members,
        _team_ids = team_ids,
        _match_ids = match_ids,
        _teams = teams,
        _matches = matches,
        _keyStats = keyStats,
        _teamStats = teamStats;

  factory _$TournamentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? profile_img_url;
  @override
  final String? banner_img_url;
  @override
  final TournamentType type;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TournamentStatus status;
  final List<TournamentMember> _members;
  @override
  @JsonKey()
  List<TournamentMember> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final String created_by;
  @override
  @TimeStampJsonConverter()
  final DateTime? created_at;
  @override
  @TimeStampJsonConverter()
  final DateTime start_date;
  @override
  @TimeStampJsonConverter()
  final DateTime end_date;
  final List<String> _team_ids;
  @override
  @JsonKey()
  List<String> get team_ids {
    if (_team_ids is EqualUnmodifiableListView) return _team_ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_team_ids);
  }

  final List<String> _match_ids;
  @override
  @JsonKey()
  List<String> get match_ids {
    if (_match_ids is EqualUnmodifiableListView) return _match_ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_match_ids);
  }

  final List<TeamModel> _teams;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<TeamModel> get teams {
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teams);
  }

  final List<MatchModel> _matches;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<MatchModel> get matches {
    if (_matches is EqualUnmodifiableListView) return _matches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matches);
  }

  final List<PlayerKeyStat> _keyStats;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<PlayerKeyStat> get keyStats {
    if (_keyStats is EqualUnmodifiableListView) return _keyStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keyStats);
  }

  final List<TournamentTeamStat> _teamStats;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<TournamentTeamStat> get teamStats {
    if (_teamStats is EqualUnmodifiableListView) return _teamStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamStats);
  }

  @override
  String toString() {
    return 'TournamentModel(id: $id, name: $name, profile_img_url: $profile_img_url, banner_img_url: $banner_img_url, type: $type, status: $status, members: $members, created_by: $created_by, created_at: $created_at, start_date: $start_date, end_date: $end_date, team_ids: $team_ids, match_ids: $match_ids, teams: $teams, matches: $matches, keyStats: $keyStats, teamStats: $teamStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profile_img_url, profile_img_url) ||
                other.profile_img_url == profile_img_url) &&
            (identical(other.banner_img_url, banner_img_url) ||
                other.banner_img_url == banner_img_url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.created_by, created_by) ||
                other.created_by == created_by) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.start_date, start_date) ||
                other.start_date == start_date) &&
            (identical(other.end_date, end_date) ||
                other.end_date == end_date) &&
            const DeepCollectionEquality().equals(other._team_ids, _team_ids) &&
            const DeepCollectionEquality()
                .equals(other._match_ids, _match_ids) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            const DeepCollectionEquality().equals(other._matches, _matches) &&
            const DeepCollectionEquality().equals(other._keyStats, _keyStats) &&
            const DeepCollectionEquality()
                .equals(other._teamStats, _teamStats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      profile_img_url,
      banner_img_url,
      type,
      status,
      const DeepCollectionEquality().hash(_members),
      created_by,
      created_at,
      start_date,
      end_date,
      const DeepCollectionEquality().hash(_team_ids),
      const DeepCollectionEquality().hash(_match_ids),
      const DeepCollectionEquality().hash(_teams),
      const DeepCollectionEquality().hash(_matches),
      const DeepCollectionEquality().hash(_keyStats),
      const DeepCollectionEquality().hash(_teamStats));

  /// Create a copy of TournamentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentModelImplCopyWith<_$TournamentModelImpl> get copyWith =>
      __$$TournamentModelImplCopyWithImpl<_$TournamentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TournamentModelImplToJson(
      this,
    );
  }
}

abstract class _TournamentModel implements TournamentModel {
  const factory _TournamentModel(
      {required final String id,
      required final String name,
      final String? profile_img_url,
      final String? banner_img_url,
      required final TournamentType type,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final TournamentStatus status,
      final List<TournamentMember> members,
      required final String created_by,
      @TimeStampJsonConverter() final DateTime? created_at,
      @TimeStampJsonConverter() required final DateTime start_date,
      @TimeStampJsonConverter() required final DateTime end_date,
      final List<String> team_ids,
      final List<String> match_ids,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<TeamModel> teams,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<MatchModel> matches,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<PlayerKeyStat> keyStats,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<TournamentTeamStat> teamStats}) = _$TournamentModelImpl;

  factory _TournamentModel.fromJson(Map<String, dynamic> json) =
      _$TournamentModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get profile_img_url;
  @override
  String? get banner_img_url;
  @override
  TournamentType get type;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  TournamentStatus get status;
  @override
  List<TournamentMember> get members;
  @override
  String get created_by;
  @override
  @TimeStampJsonConverter()
  DateTime? get created_at;
  @override
  @TimeStampJsonConverter()
  DateTime get start_date;
  @override
  @TimeStampJsonConverter()
  DateTime get end_date;
  @override
  List<String> get team_ids;
  @override
  List<String> get match_ids;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<TeamModel> get teams;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<MatchModel> get matches;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<PlayerKeyStat> get keyStats;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<TournamentTeamStat> get teamStats;

  /// Create a copy of TournamentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TournamentModelImplCopyWith<_$TournamentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TournamentMember _$TournamentMemberFromJson(Map<String, dynamic> json) {
  return _TournamentMember.fromJson(json);
}

/// @nodoc
mixin _$TournamentMember {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  UserModel get user => throw _privateConstructorUsedError;
  TournamentMemberRole get role => throw _privateConstructorUsedError;

  /// Serializes this TournamentMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TournamentMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TournamentMemberCopyWith<TournamentMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentMemberCopyWith<$Res> {
  factory $TournamentMemberCopyWith(
          TournamentMember value, $Res Function(TournamentMember) then) =
      _$TournamentMemberCopyWithImpl<$Res, TournamentMember>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(includeToJson: false, includeFromJson: false) UserModel user,
      TournamentMemberRole role});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$TournamentMemberCopyWithImpl<$Res, $Val extends TournamentMember>
    implements $TournamentMemberCopyWith<$Res> {
  _$TournamentMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TournamentMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user = null,
    Object? role = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as TournamentMemberRole,
    ) as $Val);
  }

  /// Create a copy of TournamentMember
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
abstract class _$$TournamentMemberImplCopyWith<$Res>
    implements $TournamentMemberCopyWith<$Res> {
  factory _$$TournamentMemberImplCopyWith(_$TournamentMemberImpl value,
          $Res Function(_$TournamentMemberImpl) then) =
      __$$TournamentMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(includeToJson: false, includeFromJson: false) UserModel user,
      TournamentMemberRole role});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$TournamentMemberImplCopyWithImpl<$Res>
    extends _$TournamentMemberCopyWithImpl<$Res, _$TournamentMemberImpl>
    implements _$$TournamentMemberImplCopyWith<$Res> {
  __$$TournamentMemberImplCopyWithImpl(_$TournamentMemberImpl _value,
      $Res Function(_$TournamentMemberImpl) _then)
      : super(_value, _then);

  /// Create a copy of TournamentMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user = null,
    Object? role = null,
  }) {
    return _then(_$TournamentMemberImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as TournamentMemberRole,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TournamentMemberImpl implements _TournamentMember {
  const _$TournamentMemberImpl(
      {required this.id,
      @JsonKey(includeToJson: false, includeFromJson: false)
      this.user = const UserModel(id: ''),
      this.role = TournamentMemberRole.admin});

  factory _$TournamentMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentMemberImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final UserModel user;
  @override
  @JsonKey()
  final TournamentMemberRole role;

  @override
  String toString() {
    return 'TournamentMember(id: $id, user: $user, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, user, role);

  /// Create a copy of TournamentMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentMemberImplCopyWith<_$TournamentMemberImpl> get copyWith =>
      __$$TournamentMemberImplCopyWithImpl<_$TournamentMemberImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TournamentMemberImplToJson(
      this,
    );
  }
}

abstract class _TournamentMember implements TournamentMember {
  const factory _TournamentMember(
      {required final String id,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final UserModel user,
      final TournamentMemberRole role}) = _$TournamentMemberImpl;

  factory _TournamentMember.fromJson(Map<String, dynamic> json) =
      _$TournamentMemberImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  UserModel get user;
  @override
  TournamentMemberRole get role;

  /// Create a copy of TournamentMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TournamentMemberImplCopyWith<_$TournamentMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerKeyStat _$PlayerKeyStatFromJson(Map<String, dynamic> json) {
  return _PlayerKeyStat.fromJson(json);
}

/// @nodoc
mixin _$PlayerKeyStat {
  String get player_id => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  UserModel get player => throw _privateConstructorUsedError;
  UserStat get stats => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  KeyStatTag? get tag => throw _privateConstructorUsedError;
  int? get value => throw _privateConstructorUsedError;

  /// Serializes this PlayerKeyStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerKeyStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerKeyStatCopyWith<PlayerKeyStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerKeyStatCopyWith<$Res> {
  factory $PlayerKeyStatCopyWith(
          PlayerKeyStat value, $Res Function(PlayerKeyStat) then) =
      _$PlayerKeyStatCopyWithImpl<$Res, PlayerKeyStat>;
  @useResult
  $Res call(
      {String player_id,
      String teamName,
      @JsonKey(includeToJson: false, includeFromJson: false) UserModel player,
      UserStat stats,
      @JsonKey(includeToJson: false, includeFromJson: false) KeyStatTag? tag,
      int? value});

  $UserModelCopyWith<$Res> get player;
  $UserStatCopyWith<$Res> get stats;
}

/// @nodoc
class _$PlayerKeyStatCopyWithImpl<$Res, $Val extends PlayerKeyStat>
    implements $PlayerKeyStatCopyWith<$Res> {
  _$PlayerKeyStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerKeyStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player_id = null,
    Object? teamName = null,
    Object? player = null,
    Object? stats = null,
    Object? tag = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      player_id: null == player_id
          ? _value.player_id
          : player_id // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as UserModel,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as UserStat,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as KeyStatTag?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  /// Create a copy of PlayerKeyStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get player {
    return $UserModelCopyWith<$Res>(_value.player, (value) {
      return _then(_value.copyWith(player: value) as $Val);
    });
  }

  /// Create a copy of PlayerKeyStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserStatCopyWith<$Res> get stats {
    return $UserStatCopyWith<$Res>(_value.stats, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayerKeyStatImplCopyWith<$Res>
    implements $PlayerKeyStatCopyWith<$Res> {
  factory _$$PlayerKeyStatImplCopyWith(
          _$PlayerKeyStatImpl value, $Res Function(_$PlayerKeyStatImpl) then) =
      __$$PlayerKeyStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String player_id,
      String teamName,
      @JsonKey(includeToJson: false, includeFromJson: false) UserModel player,
      UserStat stats,
      @JsonKey(includeToJson: false, includeFromJson: false) KeyStatTag? tag,
      int? value});

  @override
  $UserModelCopyWith<$Res> get player;
  @override
  $UserStatCopyWith<$Res> get stats;
}

/// @nodoc
class __$$PlayerKeyStatImplCopyWithImpl<$Res>
    extends _$PlayerKeyStatCopyWithImpl<$Res, _$PlayerKeyStatImpl>
    implements _$$PlayerKeyStatImplCopyWith<$Res> {
  __$$PlayerKeyStatImplCopyWithImpl(
      _$PlayerKeyStatImpl _value, $Res Function(_$PlayerKeyStatImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlayerKeyStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player_id = null,
    Object? teamName = null,
    Object? player = null,
    Object? stats = null,
    Object? tag = freezed,
    Object? value = freezed,
  }) {
    return _then(_$PlayerKeyStatImpl(
      player_id: null == player_id
          ? _value.player_id
          : player_id // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as UserModel,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as UserStat,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as KeyStatTag?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PlayerKeyStatImpl implements _PlayerKeyStat {
  const _$PlayerKeyStatImpl(
      {required this.player_id,
      required this.teamName,
      @JsonKey(includeToJson: false, includeFromJson: false)
      this.player = const UserModel(id: ''),
      this.stats = const UserStat(),
      @JsonKey(includeToJson: false, includeFromJson: false) this.tag,
      this.value});

  factory _$PlayerKeyStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerKeyStatImplFromJson(json);

  @override
  final String player_id;
  @override
  final String teamName;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final UserModel player;
  @override
  @JsonKey()
  final UserStat stats;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final KeyStatTag? tag;
  @override
  final int? value;

  @override
  String toString() {
    return 'PlayerKeyStat(player_id: $player_id, teamName: $teamName, player: $player, stats: $stats, tag: $tag, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerKeyStatImpl &&
            (identical(other.player_id, player_id) ||
                other.player_id == player_id) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.player, player) || other.player == player) &&
            (identical(other.stats, stats) || other.stats == stats) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, player_id, teamName, player, stats, tag, value);

  /// Create a copy of PlayerKeyStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerKeyStatImplCopyWith<_$PlayerKeyStatImpl> get copyWith =>
      __$$PlayerKeyStatImplCopyWithImpl<_$PlayerKeyStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerKeyStatImplToJson(
      this,
    );
  }
}

abstract class _PlayerKeyStat implements PlayerKeyStat {
  const factory _PlayerKeyStat(
      {required final String player_id,
      required final String teamName,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final UserModel player,
      final UserStat stats,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final KeyStatTag? tag,
      final int? value}) = _$PlayerKeyStatImpl;

  factory _PlayerKeyStat.fromJson(Map<String, dynamic> json) =
      _$PlayerKeyStatImpl.fromJson;

  @override
  String get player_id;
  @override
  String get teamName;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  UserModel get player;
  @override
  UserStat get stats;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  KeyStatTag? get tag;
  @override
  int? get value;

  /// Create a copy of PlayerKeyStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerKeyStatImplCopyWith<_$PlayerKeyStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TournamentTeamStat _$TournamentTeamStatFromJson(Map<String, dynamic> json) {
  return _TournamentTeamStat.fromJson(json);
}

/// @nodoc
mixin _$TournamentTeamStat {
  String get team_id => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  TeamModel? get team => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  int get wins => throw _privateConstructorUsedError;
  int get losses => throw _privateConstructorUsedError;
  double get nrr => throw _privateConstructorUsedError;
  int get played_matches => throw _privateConstructorUsedError;

  /// Serializes this TournamentTeamStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TournamentTeamStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TournamentTeamStatCopyWith<TournamentTeamStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentTeamStatCopyWith<$Res> {
  factory $TournamentTeamStatCopyWith(
          TournamentTeamStat value, $Res Function(TournamentTeamStat) then) =
      _$TournamentTeamStatCopyWithImpl<$Res, TournamentTeamStat>;
  @useResult
  $Res call(
      {String team_id,
      @JsonKey(includeToJson: false, includeFromJson: false) TeamModel? team,
      int points,
      int wins,
      int losses,
      double nrr,
      int played_matches});

  $TeamModelCopyWith<$Res>? get team;
}

/// @nodoc
class _$TournamentTeamStatCopyWithImpl<$Res, $Val extends TournamentTeamStat>
    implements $TournamentTeamStatCopyWith<$Res> {
  _$TournamentTeamStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TournamentTeamStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team_id = null,
    Object? team = freezed,
    Object? points = null,
    Object? wins = null,
    Object? losses = null,
    Object? nrr = null,
    Object? played_matches = null,
  }) {
    return _then(_value.copyWith(
      team_id: null == team_id
          ? _value.team_id
          : team_id // ignore: cast_nullable_to_non_nullable
              as String,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      nrr: null == nrr
          ? _value.nrr
          : nrr // ignore: cast_nullable_to_non_nullable
              as double,
      played_matches: null == played_matches
          ? _value.played_matches
          : played_matches // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of TournamentTeamStat
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
}

/// @nodoc
abstract class _$$TournamentTeamStatImplCopyWith<$Res>
    implements $TournamentTeamStatCopyWith<$Res> {
  factory _$$TournamentTeamStatImplCopyWith(_$TournamentTeamStatImpl value,
          $Res Function(_$TournamentTeamStatImpl) then) =
      __$$TournamentTeamStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String team_id,
      @JsonKey(includeToJson: false, includeFromJson: false) TeamModel? team,
      int points,
      int wins,
      int losses,
      double nrr,
      int played_matches});

  @override
  $TeamModelCopyWith<$Res>? get team;
}

/// @nodoc
class __$$TournamentTeamStatImplCopyWithImpl<$Res>
    extends _$TournamentTeamStatCopyWithImpl<$Res, _$TournamentTeamStatImpl>
    implements _$$TournamentTeamStatImplCopyWith<$Res> {
  __$$TournamentTeamStatImplCopyWithImpl(_$TournamentTeamStatImpl _value,
      $Res Function(_$TournamentTeamStatImpl) _then)
      : super(_value, _then);

  /// Create a copy of TournamentTeamStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team_id = null,
    Object? team = freezed,
    Object? points = null,
    Object? wins = null,
    Object? losses = null,
    Object? nrr = null,
    Object? played_matches = null,
  }) {
    return _then(_$TournamentTeamStatImpl(
      team_id: null == team_id
          ? _value.team_id
          : team_id // ignore: cast_nullable_to_non_nullable
              as String,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      nrr: null == nrr
          ? _value.nrr
          : nrr // ignore: cast_nullable_to_non_nullable
              as double,
      played_matches: null == played_matches
          ? _value.played_matches
          : played_matches // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true)
class _$TournamentTeamStatImpl implements _TournamentTeamStat {
  const _$TournamentTeamStatImpl(
      {required this.team_id,
      @JsonKey(includeToJson: false, includeFromJson: false) this.team,
      this.points = 0,
      this.wins = 0,
      this.losses = 0,
      this.nrr = 0.0,
      this.played_matches = 0});

  factory _$TournamentTeamStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentTeamStatImplFromJson(json);

  @override
  final String team_id;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final TeamModel? team;
  @override
  @JsonKey()
  final int points;
  @override
  @JsonKey()
  final int wins;
  @override
  @JsonKey()
  final int losses;
  @override
  @JsonKey()
  final double nrr;
  @override
  @JsonKey()
  final int played_matches;

  @override
  String toString() {
    return 'TournamentTeamStat(team_id: $team_id, team: $team, points: $points, wins: $wins, losses: $losses, nrr: $nrr, played_matches: $played_matches)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentTeamStatImpl &&
            (identical(other.team_id, team_id) || other.team_id == team_id) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.wins, wins) || other.wins == wins) &&
            (identical(other.losses, losses) || other.losses == losses) &&
            (identical(other.nrr, nrr) || other.nrr == nrr) &&
            (identical(other.played_matches, played_matches) ||
                other.played_matches == played_matches));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, team_id, team, points, wins, losses, nrr, played_matches);

  /// Create a copy of TournamentTeamStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentTeamStatImplCopyWith<_$TournamentTeamStatImpl> get copyWith =>
      __$$TournamentTeamStatImplCopyWithImpl<_$TournamentTeamStatImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TournamentTeamStatImplToJson(
      this,
    );
  }
}

abstract class _TournamentTeamStat implements TournamentTeamStat {
  const factory _TournamentTeamStat(
      {required final String team_id,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final TeamModel? team,
      final int points,
      final int wins,
      final int losses,
      final double nrr,
      final int played_matches}) = _$TournamentTeamStatImpl;

  factory _TournamentTeamStat.fromJson(Map<String, dynamic> json) =
      _$TournamentTeamStatImpl.fromJson;

  @override
  String get team_id;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  TeamModel? get team;
  @override
  int get points;
  @override
  int get wins;
  @override
  int get losses;
  @override
  double get nrr;
  @override
  int get played_matches;

  /// Create a copy of TournamentTeamStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TournamentTeamStatImplCopyWith<_$TournamentTeamStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
