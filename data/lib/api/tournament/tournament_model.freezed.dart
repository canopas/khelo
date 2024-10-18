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
  List<TournamentMember> get members => throw _privateConstructorUsedError;
  String get created_by => throw _privateConstructorUsedError;
  @TimeStampJsonConverter()
  DateTime? get created_at => throw _privateConstructorUsedError;
  @TimeStampJsonConverter()
  DateTime get start_date => throw _privateConstructorUsedError;
  @TimeStampJsonConverter()
  DateTime? get end_date => throw _privateConstructorUsedError;
  List<String> get team_ids => throw _privateConstructorUsedError;
  List<String> get match_ids => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<TeamModel> get teams => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<MatchModel> get matches => throw _privateConstructorUsedError;

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
      List<TournamentMember> members,
      String created_by,
      @TimeStampJsonConverter() DateTime? created_at,
      @TimeStampJsonConverter() DateTime start_date,
      @TimeStampJsonConverter() DateTime? end_date,
      List<String> team_ids,
      List<String> match_ids,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<TeamModel> teams,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<MatchModel> matches});
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
    Object? members = null,
    Object? created_by = null,
    Object? created_at = freezed,
    Object? start_date = null,
    Object? end_date = freezed,
    Object? team_ids = null,
    Object? match_ids = null,
    Object? teams = null,
    Object? matches = null,
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
      end_date: freezed == end_date
          ? _value.end_date
          : end_date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      List<TournamentMember> members,
      String created_by,
      @TimeStampJsonConverter() DateTime? created_at,
      @TimeStampJsonConverter() DateTime start_date,
      @TimeStampJsonConverter() DateTime? end_date,
      List<String> team_ids,
      List<String> match_ids,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<TeamModel> teams,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<MatchModel> matches});
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
    Object? members = null,
    Object? created_by = null,
    Object? created_at = freezed,
    Object? start_date = null,
    Object? end_date = freezed,
    Object? team_ids = null,
    Object? match_ids = null,
    Object? teams = null,
    Object? matches = null,
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
      end_date: freezed == end_date
          ? _value.end_date
          : end_date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      final List<TournamentMember> members = const [],
      required this.created_by,
      @TimeStampJsonConverter() this.created_at,
      @TimeStampJsonConverter() required this.start_date,
      @TimeStampJsonConverter() this.end_date,
      final List<String> team_ids = const [],
      final List<String> match_ids = const [],
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<TeamModel> teams = const [],
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<MatchModel> matches = const []})
      : _members = members,
        _team_ids = team_ids,
        _match_ids = match_ids,
        _teams = teams,
        _matches = matches;

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
  final DateTime? end_date;
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

  @override
  String toString() {
    return 'TournamentModel(id: $id, name: $name, profile_img_url: $profile_img_url, banner_img_url: $banner_img_url, type: $type, members: $members, created_by: $created_by, created_at: $created_at, start_date: $start_date, end_date: $end_date, team_ids: $team_ids, match_ids: $match_ids, teams: $teams, matches: $matches)';
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
            const DeepCollectionEquality().equals(other._matches, _matches));
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
      const DeepCollectionEquality().hash(_members),
      created_by,
      created_at,
      start_date,
      end_date,
      const DeepCollectionEquality().hash(_team_ids),
      const DeepCollectionEquality().hash(_match_ids),
      const DeepCollectionEquality().hash(_teams),
      const DeepCollectionEquality().hash(_matches));

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
      final List<TournamentMember> members,
      required final String created_by,
      @TimeStampJsonConverter() final DateTime? created_at,
      @TimeStampJsonConverter() required final DateTime start_date,
      @TimeStampJsonConverter() final DateTime? end_date,
      final List<String> team_ids,
      final List<String> match_ids,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<TeamModel> teams,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<MatchModel> matches}) = _$TournamentModelImpl;

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
  DateTime? get end_date;
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
