// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MatchModel _$MatchModelFromJson(Map<String, dynamic> json) {
  return _MatchModel.fromJson(json);
}

/// @nodoc
mixin _$MatchModel {
  String? get id => throw _privateConstructorUsedError;
  List<MatchTeamModel> get teams => throw _privateConstructorUsedError;
  MatchType get match_type => throw _privateConstructorUsedError;
  int get number_of_over => throw _privateConstructorUsedError;
  int get over_per_bowler => throw _privateConstructorUsedError;
  List<int> get power_play_overs1 => throw _privateConstructorUsedError;
  List<int> get power_play_overs2 => throw _privateConstructorUsedError;
  List<int> get power_play_overs3 => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get ground => throw _privateConstructorUsedError;
  DateTime get start_time => throw _privateConstructorUsedError;
  BallType get ball_type => throw _privateConstructorUsedError;
  PitchType get pitch_type => throw _privateConstructorUsedError;
  List<UserModel>? get umpires => throw _privateConstructorUsedError;
  List<UserModel>? get scorers => throw _privateConstructorUsedError;
  List<UserModel>? get commentators => throw _privateConstructorUsedError;
  UserModel? get referee => throw _privateConstructorUsedError;
  MatchStatus get match_status => throw _privateConstructorUsedError;
  TossDecision? get toss_decision => throw _privateConstructorUsedError;
  String? get toss_winner_id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchModelCopyWith<MatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchModelCopyWith<$Res> {
  factory $MatchModelCopyWith(
          MatchModel value, $Res Function(MatchModel) then) =
      _$MatchModelCopyWithImpl<$Res, MatchModel>;
  @useResult
  $Res call(
      {String? id,
      List<MatchTeamModel> teams,
      MatchType match_type,
      int number_of_over,
      int over_per_bowler,
      List<int> power_play_overs1,
      List<int> power_play_overs2,
      List<int> power_play_overs3,
      String city,
      String ground,
      DateTime start_time,
      BallType ball_type,
      PitchType pitch_type,
      List<UserModel>? umpires,
      List<UserModel>? scorers,
      List<UserModel>? commentators,
      UserModel? referee,
      MatchStatus match_status,
      TossDecision? toss_decision,
      String? toss_winner_id});

  $UserModelCopyWith<$Res>? get referee;
}

/// @nodoc
class _$MatchModelCopyWithImpl<$Res, $Val extends MatchModel>
    implements $MatchModelCopyWith<$Res> {
  _$MatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teams = null,
    Object? match_type = null,
    Object? number_of_over = null,
    Object? over_per_bowler = null,
    Object? power_play_overs1 = null,
    Object? power_play_overs2 = null,
    Object? power_play_overs3 = null,
    Object? city = null,
    Object? ground = null,
    Object? start_time = null,
    Object? ball_type = null,
    Object? pitch_type = null,
    Object? umpires = freezed,
    Object? scorers = freezed,
    Object? commentators = freezed,
    Object? referee = freezed,
    Object? match_status = null,
    Object? toss_decision = freezed,
    Object? toss_winner_id = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<MatchTeamModel>,
      match_type: null == match_type
          ? _value.match_type
          : match_type // ignore: cast_nullable_to_non_nullable
              as MatchType,
      number_of_over: null == number_of_over
          ? _value.number_of_over
          : number_of_over // ignore: cast_nullable_to_non_nullable
              as int,
      over_per_bowler: null == over_per_bowler
          ? _value.over_per_bowler
          : over_per_bowler // ignore: cast_nullable_to_non_nullable
              as int,
      power_play_overs1: null == power_play_overs1
          ? _value.power_play_overs1
          : power_play_overs1 // ignore: cast_nullable_to_non_nullable
              as List<int>,
      power_play_overs2: null == power_play_overs2
          ? _value.power_play_overs2
          : power_play_overs2 // ignore: cast_nullable_to_non_nullable
              as List<int>,
      power_play_overs3: null == power_play_overs3
          ? _value.power_play_overs3
          : power_play_overs3 // ignore: cast_nullable_to_non_nullable
              as List<int>,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      ground: null == ground
          ? _value.ground
          : ground // ignore: cast_nullable_to_non_nullable
              as String,
      start_time: null == start_time
          ? _value.start_time
          : start_time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ball_type: null == ball_type
          ? _value.ball_type
          : ball_type // ignore: cast_nullable_to_non_nullable
              as BallType,
      pitch_type: null == pitch_type
          ? _value.pitch_type
          : pitch_type // ignore: cast_nullable_to_non_nullable
              as PitchType,
      umpires: freezed == umpires
          ? _value.umpires
          : umpires // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
      scorers: freezed == scorers
          ? _value.scorers
          : scorers // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
      commentators: freezed == commentators
          ? _value.commentators
          : commentators // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
      referee: freezed == referee
          ? _value.referee
          : referee // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      match_status: null == match_status
          ? _value.match_status
          : match_status // ignore: cast_nullable_to_non_nullable
              as MatchStatus,
      toss_decision: freezed == toss_decision
          ? _value.toss_decision
          : toss_decision // ignore: cast_nullable_to_non_nullable
              as TossDecision?,
      toss_winner_id: freezed == toss_winner_id
          ? _value.toss_winner_id
          : toss_winner_id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get referee {
    if (_value.referee == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.referee!, (value) {
      return _then(_value.copyWith(referee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MatchModelImplCopyWith<$Res>
    implements $MatchModelCopyWith<$Res> {
  factory _$$MatchModelImplCopyWith(
          _$MatchModelImpl value, $Res Function(_$MatchModelImpl) then) =
      __$$MatchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      List<MatchTeamModel> teams,
      MatchType match_type,
      int number_of_over,
      int over_per_bowler,
      List<int> power_play_overs1,
      List<int> power_play_overs2,
      List<int> power_play_overs3,
      String city,
      String ground,
      DateTime start_time,
      BallType ball_type,
      PitchType pitch_type,
      List<UserModel>? umpires,
      List<UserModel>? scorers,
      List<UserModel>? commentators,
      UserModel? referee,
      MatchStatus match_status,
      TossDecision? toss_decision,
      String? toss_winner_id});

  @override
  $UserModelCopyWith<$Res>? get referee;
}

/// @nodoc
class __$$MatchModelImplCopyWithImpl<$Res>
    extends _$MatchModelCopyWithImpl<$Res, _$MatchModelImpl>
    implements _$$MatchModelImplCopyWith<$Res> {
  __$$MatchModelImplCopyWithImpl(
      _$MatchModelImpl _value, $Res Function(_$MatchModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teams = null,
    Object? match_type = null,
    Object? number_of_over = null,
    Object? over_per_bowler = null,
    Object? power_play_overs1 = null,
    Object? power_play_overs2 = null,
    Object? power_play_overs3 = null,
    Object? city = null,
    Object? ground = null,
    Object? start_time = null,
    Object? ball_type = null,
    Object? pitch_type = null,
    Object? umpires = freezed,
    Object? scorers = freezed,
    Object? commentators = freezed,
    Object? referee = freezed,
    Object? match_status = null,
    Object? toss_decision = freezed,
    Object? toss_winner_id = freezed,
  }) {
    return _then(_$MatchModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      teams: null == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<MatchTeamModel>,
      match_type: null == match_type
          ? _value.match_type
          : match_type // ignore: cast_nullable_to_non_nullable
              as MatchType,
      number_of_over: null == number_of_over
          ? _value.number_of_over
          : number_of_over // ignore: cast_nullable_to_non_nullable
              as int,
      over_per_bowler: null == over_per_bowler
          ? _value.over_per_bowler
          : over_per_bowler // ignore: cast_nullable_to_non_nullable
              as int,
      power_play_overs1: null == power_play_overs1
          ? _value._power_play_overs1
          : power_play_overs1 // ignore: cast_nullable_to_non_nullable
              as List<int>,
      power_play_overs2: null == power_play_overs2
          ? _value._power_play_overs2
          : power_play_overs2 // ignore: cast_nullable_to_non_nullable
              as List<int>,
      power_play_overs3: null == power_play_overs3
          ? _value._power_play_overs3
          : power_play_overs3 // ignore: cast_nullable_to_non_nullable
              as List<int>,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      ground: null == ground
          ? _value.ground
          : ground // ignore: cast_nullable_to_non_nullable
              as String,
      start_time: null == start_time
          ? _value.start_time
          : start_time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ball_type: null == ball_type
          ? _value.ball_type
          : ball_type // ignore: cast_nullable_to_non_nullable
              as BallType,
      pitch_type: null == pitch_type
          ? _value.pitch_type
          : pitch_type // ignore: cast_nullable_to_non_nullable
              as PitchType,
      umpires: freezed == umpires
          ? _value._umpires
          : umpires // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
      scorers: freezed == scorers
          ? _value._scorers
          : scorers // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
      commentators: freezed == commentators
          ? _value._commentators
          : commentators // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
      referee: freezed == referee
          ? _value.referee
          : referee // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      match_status: null == match_status
          ? _value.match_status
          : match_status // ignore: cast_nullable_to_non_nullable
              as MatchStatus,
      toss_decision: freezed == toss_decision
          ? _value.toss_decision
          : toss_decision // ignore: cast_nullable_to_non_nullable
              as TossDecision?,
      toss_winner_id: freezed == toss_winner_id
          ? _value.toss_winner_id
          : toss_winner_id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchModelImpl implements _MatchModel {
  const _$MatchModelImpl(
      {this.id,
      required final List<MatchTeamModel> teams,
      required this.match_type,
      required this.number_of_over,
      required this.over_per_bowler,
      final List<int> power_play_overs1 = const [],
      final List<int> power_play_overs2 = const [],
      final List<int> power_play_overs3 = const [],
      required this.city,
      required this.ground,
      required this.start_time,
      required this.ball_type,
      required this.pitch_type,
      final List<UserModel>? umpires,
      final List<UserModel>? scorers,
      final List<UserModel>? commentators,
      this.referee,
      required this.match_status,
      this.toss_decision,
      this.toss_winner_id})
      : _teams = teams,
        _power_play_overs1 = power_play_overs1,
        _power_play_overs2 = power_play_overs2,
        _power_play_overs3 = power_play_overs3,
        _umpires = umpires,
        _scorers = scorers,
        _commentators = commentators;

  factory _$MatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchModelImplFromJson(json);

  @override
  final String? id;
  final List<MatchTeamModel> _teams;
  @override
  List<MatchTeamModel> get teams {
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teams);
  }

  @override
  final MatchType match_type;
  @override
  final int number_of_over;
  @override
  final int over_per_bowler;
  final List<int> _power_play_overs1;
  @override
  @JsonKey()
  List<int> get power_play_overs1 {
    if (_power_play_overs1 is EqualUnmodifiableListView)
      return _power_play_overs1;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_power_play_overs1);
  }

  final List<int> _power_play_overs2;
  @override
  @JsonKey()
  List<int> get power_play_overs2 {
    if (_power_play_overs2 is EqualUnmodifiableListView)
      return _power_play_overs2;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_power_play_overs2);
  }

  final List<int> _power_play_overs3;
  @override
  @JsonKey()
  List<int> get power_play_overs3 {
    if (_power_play_overs3 is EqualUnmodifiableListView)
      return _power_play_overs3;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_power_play_overs3);
  }

  @override
  final String city;
  @override
  final String ground;
  @override
  final DateTime start_time;
  @override
  final BallType ball_type;
  @override
  final PitchType pitch_type;
  final List<UserModel>? _umpires;
  @override
  List<UserModel>? get umpires {
    final value = _umpires;
    if (value == null) return null;
    if (_umpires is EqualUnmodifiableListView) return _umpires;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<UserModel>? _scorers;
  @override
  List<UserModel>? get scorers {
    final value = _scorers;
    if (value == null) return null;
    if (_scorers is EqualUnmodifiableListView) return _scorers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<UserModel>? _commentators;
  @override
  List<UserModel>? get commentators {
    final value = _commentators;
    if (value == null) return null;
    if (_commentators is EqualUnmodifiableListView) return _commentators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final UserModel? referee;
  @override
  final MatchStatus match_status;
  @override
  final TossDecision? toss_decision;
  @override
  final String? toss_winner_id;

  @override
  String toString() {
    return 'MatchModel(id: $id, teams: $teams, match_type: $match_type, number_of_over: $number_of_over, over_per_bowler: $over_per_bowler, power_play_overs1: $power_play_overs1, power_play_overs2: $power_play_overs2, power_play_overs3: $power_play_overs3, city: $city, ground: $ground, start_time: $start_time, ball_type: $ball_type, pitch_type: $pitch_type, umpires: $umpires, scorers: $scorers, commentators: $commentators, referee: $referee, match_status: $match_status, toss_decision: $toss_decision, toss_winner_id: $toss_winner_id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            (identical(other.match_type, match_type) ||
                other.match_type == match_type) &&
            (identical(other.number_of_over, number_of_over) ||
                other.number_of_over == number_of_over) &&
            (identical(other.over_per_bowler, over_per_bowler) ||
                other.over_per_bowler == over_per_bowler) &&
            const DeepCollectionEquality()
                .equals(other._power_play_overs1, _power_play_overs1) &&
            const DeepCollectionEquality()
                .equals(other._power_play_overs2, _power_play_overs2) &&
            const DeepCollectionEquality()
                .equals(other._power_play_overs3, _power_play_overs3) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.ground, ground) || other.ground == ground) &&
            (identical(other.start_time, start_time) ||
                other.start_time == start_time) &&
            (identical(other.ball_type, ball_type) ||
                other.ball_type == ball_type) &&
            (identical(other.pitch_type, pitch_type) ||
                other.pitch_type == pitch_type) &&
            const DeepCollectionEquality().equals(other._umpires, _umpires) &&
            const DeepCollectionEquality().equals(other._scorers, _scorers) &&
            const DeepCollectionEquality()
                .equals(other._commentators, _commentators) &&
            (identical(other.referee, referee) || other.referee == referee) &&
            (identical(other.match_status, match_status) ||
                other.match_status == match_status) &&
            (identical(other.toss_decision, toss_decision) ||
                other.toss_decision == toss_decision) &&
            (identical(other.toss_winner_id, toss_winner_id) ||
                other.toss_winner_id == toss_winner_id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        const DeepCollectionEquality().hash(_teams),
        match_type,
        number_of_over,
        over_per_bowler,
        const DeepCollectionEquality().hash(_power_play_overs1),
        const DeepCollectionEquality().hash(_power_play_overs2),
        const DeepCollectionEquality().hash(_power_play_overs3),
        city,
        ground,
        start_time,
        ball_type,
        pitch_type,
        const DeepCollectionEquality().hash(_umpires),
        const DeepCollectionEquality().hash(_scorers),
        const DeepCollectionEquality().hash(_commentators),
        referee,
        match_status,
        toss_decision,
        toss_winner_id
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchModelImplCopyWith<_$MatchModelImpl> get copyWith =>
      __$$MatchModelImplCopyWithImpl<_$MatchModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchModelImplToJson(
      this,
    );
  }
}

abstract class _MatchModel implements MatchModel {
  const factory _MatchModel(
      {final String? id,
      required final List<MatchTeamModel> teams,
      required final MatchType match_type,
      required final int number_of_over,
      required final int over_per_bowler,
      final List<int> power_play_overs1,
      final List<int> power_play_overs2,
      final List<int> power_play_overs3,
      required final String city,
      required final String ground,
      required final DateTime start_time,
      required final BallType ball_type,
      required final PitchType pitch_type,
      final List<UserModel>? umpires,
      final List<UserModel>? scorers,
      final List<UserModel>? commentators,
      final UserModel? referee,
      required final MatchStatus match_status,
      final TossDecision? toss_decision,
      final String? toss_winner_id}) = _$MatchModelImpl;

  factory _MatchModel.fromJson(Map<String, dynamic> json) =
      _$MatchModelImpl.fromJson;

  @override
  String? get id;
  @override
  List<MatchTeamModel> get teams;
  @override
  MatchType get match_type;
  @override
  int get number_of_over;
  @override
  int get over_per_bowler;
  @override
  List<int> get power_play_overs1;
  @override
  List<int> get power_play_overs2;
  @override
  List<int> get power_play_overs3;
  @override
  String get city;
  @override
  String get ground;
  @override
  DateTime get start_time;
  @override
  BallType get ball_type;
  @override
  PitchType get pitch_type;
  @override
  List<UserModel>? get umpires;
  @override
  List<UserModel>? get scorers;
  @override
  List<UserModel>? get commentators;
  @override
  UserModel? get referee;
  @override
  MatchStatus get match_status;
  @override
  TossDecision? get toss_decision;
  @override
  String? get toss_winner_id;
  @override
  @JsonKey(ignore: true)
  _$$MatchModelImplCopyWith<_$MatchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchTeamModel _$MatchTeamModelFromJson(Map<String, dynamic> json) {
  return _MatchTeamModel.fromJson(json);
}

/// @nodoc
mixin _$MatchTeamModel {
  TeamModel get team => throw _privateConstructorUsedError;
  String? get captain_id => throw _privateConstructorUsedError;
  String? get admin_id => throw _privateConstructorUsedError;
  List<MatchPlayer> get squad => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchTeamModelCopyWith<MatchTeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchTeamModelCopyWith<$Res> {
  factory $MatchTeamModelCopyWith(
          MatchTeamModel value, $Res Function(MatchTeamModel) then) =
      _$MatchTeamModelCopyWithImpl<$Res, MatchTeamModel>;
  @useResult
  $Res call(
      {TeamModel team,
      String? captain_id,
      String? admin_id,
      List<MatchPlayer> squad});

  $TeamModelCopyWith<$Res> get team;
}

/// @nodoc
class _$MatchTeamModelCopyWithImpl<$Res, $Val extends MatchTeamModel>
    implements $MatchTeamModelCopyWith<$Res> {
  _$MatchTeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team = null,
    Object? captain_id = freezed,
    Object? admin_id = freezed,
    Object? squad = null,
  }) {
    return _then(_value.copyWith(
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamModel,
      captain_id: freezed == captain_id
          ? _value.captain_id
          : captain_id // ignore: cast_nullable_to_non_nullable
              as String?,
      admin_id: freezed == admin_id
          ? _value.admin_id
          : admin_id // ignore: cast_nullable_to_non_nullable
              as String?,
      squad: null == squad
          ? _value.squad
          : squad // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TeamModelCopyWith<$Res> get team {
    return $TeamModelCopyWith<$Res>(_value.team, (value) {
      return _then(_value.copyWith(team: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MatchTeamModelImplCopyWith<$Res>
    implements $MatchTeamModelCopyWith<$Res> {
  factory _$$MatchTeamModelImplCopyWith(_$MatchTeamModelImpl value,
          $Res Function(_$MatchTeamModelImpl) then) =
      __$$MatchTeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TeamModel team,
      String? captain_id,
      String? admin_id,
      List<MatchPlayer> squad});

  @override
  $TeamModelCopyWith<$Res> get team;
}

/// @nodoc
class __$$MatchTeamModelImplCopyWithImpl<$Res>
    extends _$MatchTeamModelCopyWithImpl<$Res, _$MatchTeamModelImpl>
    implements _$$MatchTeamModelImplCopyWith<$Res> {
  __$$MatchTeamModelImplCopyWithImpl(
      _$MatchTeamModelImpl _value, $Res Function(_$MatchTeamModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team = null,
    Object? captain_id = freezed,
    Object? admin_id = freezed,
    Object? squad = null,
  }) {
    return _then(_$MatchTeamModelImpl(
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamModel,
      captain_id: freezed == captain_id
          ? _value.captain_id
          : captain_id // ignore: cast_nullable_to_non_nullable
              as String?,
      admin_id: freezed == admin_id
          ? _value.admin_id
          : admin_id // ignore: cast_nullable_to_non_nullable
              as String?,
      squad: null == squad
          ? _value._squad
          : squad // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchTeamModelImpl implements _MatchTeamModel {
  const _$MatchTeamModelImpl(
      {required this.team,
      this.captain_id,
      this.admin_id,
      final List<MatchPlayer> squad = const []})
      : _squad = squad;

  factory _$MatchTeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchTeamModelImplFromJson(json);

  @override
  final TeamModel team;
  @override
  final String? captain_id;
  @override
  final String? admin_id;
  final List<MatchPlayer> _squad;
  @override
  @JsonKey()
  List<MatchPlayer> get squad {
    if (_squad is EqualUnmodifiableListView) return _squad;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_squad);
  }

  @override
  String toString() {
    return 'MatchTeamModel(team: $team, captain_id: $captain_id, admin_id: $admin_id, squad: $squad)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchTeamModelImpl &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.captain_id, captain_id) ||
                other.captain_id == captain_id) &&
            (identical(other.admin_id, admin_id) ||
                other.admin_id == admin_id) &&
            const DeepCollectionEquality().equals(other._squad, _squad));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, team, captain_id, admin_id,
      const DeepCollectionEquality().hash(_squad));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchTeamModelImplCopyWith<_$MatchTeamModelImpl> get copyWith =>
      __$$MatchTeamModelImplCopyWithImpl<_$MatchTeamModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchTeamModelImplToJson(
      this,
    );
  }
}

abstract class _MatchTeamModel implements MatchTeamModel {
  const factory _MatchTeamModel(
      {required final TeamModel team,
      final String? captain_id,
      final String? admin_id,
      final List<MatchPlayer> squad}) = _$MatchTeamModelImpl;

  factory _MatchTeamModel.fromJson(Map<String, dynamic> json) =
      _$MatchTeamModelImpl.fromJson;

  @override
  TeamModel get team;
  @override
  String? get captain_id;
  @override
  String? get admin_id;
  @override
  List<MatchPlayer> get squad;
  @override
  @JsonKey(ignore: true)
  _$$MatchTeamModelImplCopyWith<_$MatchTeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchPlayer _$MatchPlayerFromJson(Map<String, dynamic> json) {
  return _MatchPlayer.fromJson(json);
}

/// @nodoc
mixin _$MatchPlayer {
  UserModel get player => throw _privateConstructorUsedError;
  PlayerStatus? get status => throw _privateConstructorUsedError;
  int? get index => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchPlayerCopyWith<MatchPlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchPlayerCopyWith<$Res> {
  factory $MatchPlayerCopyWith(
          MatchPlayer value, $Res Function(MatchPlayer) then) =
      _$MatchPlayerCopyWithImpl<$Res, MatchPlayer>;
  @useResult
  $Res call({UserModel player, PlayerStatus? status, int? index});

  $UserModelCopyWith<$Res> get player;
}

/// @nodoc
class _$MatchPlayerCopyWithImpl<$Res, $Val extends MatchPlayer>
    implements $MatchPlayerCopyWith<$Res> {
  _$MatchPlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? status = freezed,
    Object? index = freezed,
  }) {
    return _then(_value.copyWith(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as UserModel,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlayerStatus?,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get player {
    return $UserModelCopyWith<$Res>(_value.player, (value) {
      return _then(_value.copyWith(player: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MatchPlayerImplCopyWith<$Res>
    implements $MatchPlayerCopyWith<$Res> {
  factory _$$MatchPlayerImplCopyWith(
          _$MatchPlayerImpl value, $Res Function(_$MatchPlayerImpl) then) =
      __$$MatchPlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserModel player, PlayerStatus? status, int? index});

  @override
  $UserModelCopyWith<$Res> get player;
}

/// @nodoc
class __$$MatchPlayerImplCopyWithImpl<$Res>
    extends _$MatchPlayerCopyWithImpl<$Res, _$MatchPlayerImpl>
    implements _$$MatchPlayerImplCopyWith<$Res> {
  __$$MatchPlayerImplCopyWithImpl(
      _$MatchPlayerImpl _value, $Res Function(_$MatchPlayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? status = freezed,
    Object? index = freezed,
  }) {
    return _then(_$MatchPlayerImpl(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as UserModel,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlayerStatus?,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchPlayerImpl implements _MatchPlayer {
  const _$MatchPlayerImpl({required this.player, this.status, this.index});

  factory _$MatchPlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchPlayerImplFromJson(json);

  @override
  final UserModel player;
  @override
  final PlayerStatus? status;
  @override
  final int? index;

  @override
  String toString() {
    return 'MatchPlayer(player: $player, status: $status, index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchPlayerImpl &&
            (identical(other.player, player) || other.player == player) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, player, status, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchPlayerImplCopyWith<_$MatchPlayerImpl> get copyWith =>
      __$$MatchPlayerImplCopyWithImpl<_$MatchPlayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchPlayerImplToJson(
      this,
    );
  }
}

abstract class _MatchPlayer implements MatchPlayer {
  const factory _MatchPlayer(
      {required final UserModel player,
      final PlayerStatus? status,
      final int? index}) = _$MatchPlayerImpl;

  factory _MatchPlayer.fromJson(Map<String, dynamic> json) =
      _$MatchPlayerImpl.fromJson;

  @override
  UserModel get player;
  @override
  PlayerStatus? get status;
  @override
  int? get index;
  @override
  @JsonKey(ignore: true)
  _$$MatchPlayerImplCopyWith<_$MatchPlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddEditMatchRequest _$AddEditMatchRequestFromJson(Map<String, dynamic> json) {
  return _AddEditMatchRequest.fromJson(json);
}

/// @nodoc
mixin _$AddEditMatchRequest {
  String? get id => throw _privateConstructorUsedError;
  List<AddMatchTeamRequest> get teams => throw _privateConstructorUsedError;
  MatchType get match_type => throw _privateConstructorUsedError;
  int get number_of_over => throw _privateConstructorUsedError;
  int get over_per_bowler => throw _privateConstructorUsedError;
  List<int>? get power_play_overs1 => throw _privateConstructorUsedError;
  List<int>? get power_play_overs2 => throw _privateConstructorUsedError;
  List<int>? get power_play_overs3 => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get ground => throw _privateConstructorUsedError;
  DateTime get start_time => throw _privateConstructorUsedError;
  BallType get ball_type => throw _privateConstructorUsedError;
  PitchType get pitch_type => throw _privateConstructorUsedError;
  List<String>? get umpire_ids => throw _privateConstructorUsedError;
  List<String>? get scorer_ids => throw _privateConstructorUsedError;
  List<String>? get commentator_ids => throw _privateConstructorUsedError;
  String? get referee_id => throw _privateConstructorUsedError;
  MatchStatus get match_status => throw _privateConstructorUsedError;
  TossDecision? get toss_decision => throw _privateConstructorUsedError;
  String? get toss_winner_id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddEditMatchRequestCopyWith<AddEditMatchRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddEditMatchRequestCopyWith<$Res> {
  factory $AddEditMatchRequestCopyWith(
          AddEditMatchRequest value, $Res Function(AddEditMatchRequest) then) =
      _$AddEditMatchRequestCopyWithImpl<$Res, AddEditMatchRequest>;
  @useResult
  $Res call(
      {String? id,
      List<AddMatchTeamRequest> teams,
      MatchType match_type,
      int number_of_over,
      int over_per_bowler,
      List<int>? power_play_overs1,
      List<int>? power_play_overs2,
      List<int>? power_play_overs3,
      String city,
      String ground,
      DateTime start_time,
      BallType ball_type,
      PitchType pitch_type,
      List<String>? umpire_ids,
      List<String>? scorer_ids,
      List<String>? commentator_ids,
      String? referee_id,
      MatchStatus match_status,
      TossDecision? toss_decision,
      String? toss_winner_id});
}

/// @nodoc
class _$AddEditMatchRequestCopyWithImpl<$Res, $Val extends AddEditMatchRequest>
    implements $AddEditMatchRequestCopyWith<$Res> {
  _$AddEditMatchRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teams = null,
    Object? match_type = null,
    Object? number_of_over = null,
    Object? over_per_bowler = null,
    Object? power_play_overs1 = freezed,
    Object? power_play_overs2 = freezed,
    Object? power_play_overs3 = freezed,
    Object? city = null,
    Object? ground = null,
    Object? start_time = null,
    Object? ball_type = null,
    Object? pitch_type = null,
    Object? umpire_ids = freezed,
    Object? scorer_ids = freezed,
    Object? commentator_ids = freezed,
    Object? referee_id = freezed,
    Object? match_status = null,
    Object? toss_decision = freezed,
    Object? toss_winner_id = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<AddMatchTeamRequest>,
      match_type: null == match_type
          ? _value.match_type
          : match_type // ignore: cast_nullable_to_non_nullable
              as MatchType,
      number_of_over: null == number_of_over
          ? _value.number_of_over
          : number_of_over // ignore: cast_nullable_to_non_nullable
              as int,
      over_per_bowler: null == over_per_bowler
          ? _value.over_per_bowler
          : over_per_bowler // ignore: cast_nullable_to_non_nullable
              as int,
      power_play_overs1: freezed == power_play_overs1
          ? _value.power_play_overs1
          : power_play_overs1 // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      power_play_overs2: freezed == power_play_overs2
          ? _value.power_play_overs2
          : power_play_overs2 // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      power_play_overs3: freezed == power_play_overs3
          ? _value.power_play_overs3
          : power_play_overs3 // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      ground: null == ground
          ? _value.ground
          : ground // ignore: cast_nullable_to_non_nullable
              as String,
      start_time: null == start_time
          ? _value.start_time
          : start_time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ball_type: null == ball_type
          ? _value.ball_type
          : ball_type // ignore: cast_nullable_to_non_nullable
              as BallType,
      pitch_type: null == pitch_type
          ? _value.pitch_type
          : pitch_type // ignore: cast_nullable_to_non_nullable
              as PitchType,
      umpire_ids: freezed == umpire_ids
          ? _value.umpire_ids
          : umpire_ids // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      scorer_ids: freezed == scorer_ids
          ? _value.scorer_ids
          : scorer_ids // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      commentator_ids: freezed == commentator_ids
          ? _value.commentator_ids
          : commentator_ids // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      referee_id: freezed == referee_id
          ? _value.referee_id
          : referee_id // ignore: cast_nullable_to_non_nullable
              as String?,
      match_status: null == match_status
          ? _value.match_status
          : match_status // ignore: cast_nullable_to_non_nullable
              as MatchStatus,
      toss_decision: freezed == toss_decision
          ? _value.toss_decision
          : toss_decision // ignore: cast_nullable_to_non_nullable
              as TossDecision?,
      toss_winner_id: freezed == toss_winner_id
          ? _value.toss_winner_id
          : toss_winner_id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddEditMatchRequestImplCopyWith<$Res>
    implements $AddEditMatchRequestCopyWith<$Res> {
  factory _$$AddEditMatchRequestImplCopyWith(_$AddEditMatchRequestImpl value,
          $Res Function(_$AddEditMatchRequestImpl) then) =
      __$$AddEditMatchRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      List<AddMatchTeamRequest> teams,
      MatchType match_type,
      int number_of_over,
      int over_per_bowler,
      List<int>? power_play_overs1,
      List<int>? power_play_overs2,
      List<int>? power_play_overs3,
      String city,
      String ground,
      DateTime start_time,
      BallType ball_type,
      PitchType pitch_type,
      List<String>? umpire_ids,
      List<String>? scorer_ids,
      List<String>? commentator_ids,
      String? referee_id,
      MatchStatus match_status,
      TossDecision? toss_decision,
      String? toss_winner_id});
}

/// @nodoc
class __$$AddEditMatchRequestImplCopyWithImpl<$Res>
    extends _$AddEditMatchRequestCopyWithImpl<$Res, _$AddEditMatchRequestImpl>
    implements _$$AddEditMatchRequestImplCopyWith<$Res> {
  __$$AddEditMatchRequestImplCopyWithImpl(_$AddEditMatchRequestImpl _value,
      $Res Function(_$AddEditMatchRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teams = null,
    Object? match_type = null,
    Object? number_of_over = null,
    Object? over_per_bowler = null,
    Object? power_play_overs1 = freezed,
    Object? power_play_overs2 = freezed,
    Object? power_play_overs3 = freezed,
    Object? city = null,
    Object? ground = null,
    Object? start_time = null,
    Object? ball_type = null,
    Object? pitch_type = null,
    Object? umpire_ids = freezed,
    Object? scorer_ids = freezed,
    Object? commentator_ids = freezed,
    Object? referee_id = freezed,
    Object? match_status = null,
    Object? toss_decision = freezed,
    Object? toss_winner_id = freezed,
  }) {
    return _then(_$AddEditMatchRequestImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      teams: null == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<AddMatchTeamRequest>,
      match_type: null == match_type
          ? _value.match_type
          : match_type // ignore: cast_nullable_to_non_nullable
              as MatchType,
      number_of_over: null == number_of_over
          ? _value.number_of_over
          : number_of_over // ignore: cast_nullable_to_non_nullable
              as int,
      over_per_bowler: null == over_per_bowler
          ? _value.over_per_bowler
          : over_per_bowler // ignore: cast_nullable_to_non_nullable
              as int,
      power_play_overs1: freezed == power_play_overs1
          ? _value._power_play_overs1
          : power_play_overs1 // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      power_play_overs2: freezed == power_play_overs2
          ? _value._power_play_overs2
          : power_play_overs2 // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      power_play_overs3: freezed == power_play_overs3
          ? _value._power_play_overs3
          : power_play_overs3 // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      ground: null == ground
          ? _value.ground
          : ground // ignore: cast_nullable_to_non_nullable
              as String,
      start_time: null == start_time
          ? _value.start_time
          : start_time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ball_type: null == ball_type
          ? _value.ball_type
          : ball_type // ignore: cast_nullable_to_non_nullable
              as BallType,
      pitch_type: null == pitch_type
          ? _value.pitch_type
          : pitch_type // ignore: cast_nullable_to_non_nullable
              as PitchType,
      umpire_ids: freezed == umpire_ids
          ? _value._umpire_ids
          : umpire_ids // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      scorer_ids: freezed == scorer_ids
          ? _value._scorer_ids
          : scorer_ids // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      commentator_ids: freezed == commentator_ids
          ? _value._commentator_ids
          : commentator_ids // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      referee_id: freezed == referee_id
          ? _value.referee_id
          : referee_id // ignore: cast_nullable_to_non_nullable
              as String?,
      match_status: null == match_status
          ? _value.match_status
          : match_status // ignore: cast_nullable_to_non_nullable
              as MatchStatus,
      toss_decision: freezed == toss_decision
          ? _value.toss_decision
          : toss_decision // ignore: cast_nullable_to_non_nullable
              as TossDecision?,
      toss_winner_id: freezed == toss_winner_id
          ? _value.toss_winner_id
          : toss_winner_id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddEditMatchRequestImpl implements _AddEditMatchRequest {
  const _$AddEditMatchRequestImpl(
      {this.id,
      required final List<AddMatchTeamRequest> teams,
      required this.match_type,
      required this.number_of_over,
      required this.over_per_bowler,
      final List<int>? power_play_overs1,
      final List<int>? power_play_overs2,
      final List<int>? power_play_overs3,
      required this.city,
      required this.ground,
      required this.start_time,
      required this.ball_type,
      required this.pitch_type,
      final List<String>? umpire_ids,
      final List<String>? scorer_ids,
      final List<String>? commentator_ids,
      this.referee_id,
      required this.match_status,
      this.toss_decision,
      this.toss_winner_id})
      : _teams = teams,
        _power_play_overs1 = power_play_overs1,
        _power_play_overs2 = power_play_overs2,
        _power_play_overs3 = power_play_overs3,
        _umpire_ids = umpire_ids,
        _scorer_ids = scorer_ids,
        _commentator_ids = commentator_ids;

  factory _$AddEditMatchRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddEditMatchRequestImplFromJson(json);

  @override
  final String? id;
  final List<AddMatchTeamRequest> _teams;
  @override
  List<AddMatchTeamRequest> get teams {
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teams);
  }

  @override
  final MatchType match_type;
  @override
  final int number_of_over;
  @override
  final int over_per_bowler;
  final List<int>? _power_play_overs1;
  @override
  List<int>? get power_play_overs1 {
    final value = _power_play_overs1;
    if (value == null) return null;
    if (_power_play_overs1 is EqualUnmodifiableListView)
      return _power_play_overs1;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _power_play_overs2;
  @override
  List<int>? get power_play_overs2 {
    final value = _power_play_overs2;
    if (value == null) return null;
    if (_power_play_overs2 is EqualUnmodifiableListView)
      return _power_play_overs2;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _power_play_overs3;
  @override
  List<int>? get power_play_overs3 {
    final value = _power_play_overs3;
    if (value == null) return null;
    if (_power_play_overs3 is EqualUnmodifiableListView)
      return _power_play_overs3;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String city;
  @override
  final String ground;
  @override
  final DateTime start_time;
  @override
  final BallType ball_type;
  @override
  final PitchType pitch_type;
  final List<String>? _umpire_ids;
  @override
  List<String>? get umpire_ids {
    final value = _umpire_ids;
    if (value == null) return null;
    if (_umpire_ids is EqualUnmodifiableListView) return _umpire_ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _scorer_ids;
  @override
  List<String>? get scorer_ids {
    final value = _scorer_ids;
    if (value == null) return null;
    if (_scorer_ids is EqualUnmodifiableListView) return _scorer_ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _commentator_ids;
  @override
  List<String>? get commentator_ids {
    final value = _commentator_ids;
    if (value == null) return null;
    if (_commentator_ids is EqualUnmodifiableListView) return _commentator_ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? referee_id;
  @override
  final MatchStatus match_status;
  @override
  final TossDecision? toss_decision;
  @override
  final String? toss_winner_id;

  @override
  String toString() {
    return 'AddEditMatchRequest(id: $id, teams: $teams, match_type: $match_type, number_of_over: $number_of_over, over_per_bowler: $over_per_bowler, power_play_overs1: $power_play_overs1, power_play_overs2: $power_play_overs2, power_play_overs3: $power_play_overs3, city: $city, ground: $ground, start_time: $start_time, ball_type: $ball_type, pitch_type: $pitch_type, umpire_ids: $umpire_ids, scorer_ids: $scorer_ids, commentator_ids: $commentator_ids, referee_id: $referee_id, match_status: $match_status, toss_decision: $toss_decision, toss_winner_id: $toss_winner_id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddEditMatchRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            (identical(other.match_type, match_type) ||
                other.match_type == match_type) &&
            (identical(other.number_of_over, number_of_over) ||
                other.number_of_over == number_of_over) &&
            (identical(other.over_per_bowler, over_per_bowler) ||
                other.over_per_bowler == over_per_bowler) &&
            const DeepCollectionEquality()
                .equals(other._power_play_overs1, _power_play_overs1) &&
            const DeepCollectionEquality()
                .equals(other._power_play_overs2, _power_play_overs2) &&
            const DeepCollectionEquality()
                .equals(other._power_play_overs3, _power_play_overs3) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.ground, ground) || other.ground == ground) &&
            (identical(other.start_time, start_time) ||
                other.start_time == start_time) &&
            (identical(other.ball_type, ball_type) ||
                other.ball_type == ball_type) &&
            (identical(other.pitch_type, pitch_type) ||
                other.pitch_type == pitch_type) &&
            const DeepCollectionEquality()
                .equals(other._umpire_ids, _umpire_ids) &&
            const DeepCollectionEquality()
                .equals(other._scorer_ids, _scorer_ids) &&
            const DeepCollectionEquality()
                .equals(other._commentator_ids, _commentator_ids) &&
            (identical(other.referee_id, referee_id) ||
                other.referee_id == referee_id) &&
            (identical(other.match_status, match_status) ||
                other.match_status == match_status) &&
            (identical(other.toss_decision, toss_decision) ||
                other.toss_decision == toss_decision) &&
            (identical(other.toss_winner_id, toss_winner_id) ||
                other.toss_winner_id == toss_winner_id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        const DeepCollectionEquality().hash(_teams),
        match_type,
        number_of_over,
        over_per_bowler,
        const DeepCollectionEquality().hash(_power_play_overs1),
        const DeepCollectionEquality().hash(_power_play_overs2),
        const DeepCollectionEquality().hash(_power_play_overs3),
        city,
        ground,
        start_time,
        ball_type,
        pitch_type,
        const DeepCollectionEquality().hash(_umpire_ids),
        const DeepCollectionEquality().hash(_scorer_ids),
        const DeepCollectionEquality().hash(_commentator_ids),
        referee_id,
        match_status,
        toss_decision,
        toss_winner_id
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddEditMatchRequestImplCopyWith<_$AddEditMatchRequestImpl> get copyWith =>
      __$$AddEditMatchRequestImplCopyWithImpl<_$AddEditMatchRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddEditMatchRequestImplToJson(
      this,
    );
  }
}

abstract class _AddEditMatchRequest implements AddEditMatchRequest {
  const factory _AddEditMatchRequest(
      {final String? id,
      required final List<AddMatchTeamRequest> teams,
      required final MatchType match_type,
      required final int number_of_over,
      required final int over_per_bowler,
      final List<int>? power_play_overs1,
      final List<int>? power_play_overs2,
      final List<int>? power_play_overs3,
      required final String city,
      required final String ground,
      required final DateTime start_time,
      required final BallType ball_type,
      required final PitchType pitch_type,
      final List<String>? umpire_ids,
      final List<String>? scorer_ids,
      final List<String>? commentator_ids,
      final String? referee_id,
      required final MatchStatus match_status,
      final TossDecision? toss_decision,
      final String? toss_winner_id}) = _$AddEditMatchRequestImpl;

  factory _AddEditMatchRequest.fromJson(Map<String, dynamic> json) =
      _$AddEditMatchRequestImpl.fromJson;

  @override
  String? get id;
  @override
  List<AddMatchTeamRequest> get teams;
  @override
  MatchType get match_type;
  @override
  int get number_of_over;
  @override
  int get over_per_bowler;
  @override
  List<int>? get power_play_overs1;
  @override
  List<int>? get power_play_overs2;
  @override
  List<int>? get power_play_overs3;
  @override
  String get city;
  @override
  String get ground;
  @override
  DateTime get start_time;
  @override
  BallType get ball_type;
  @override
  PitchType get pitch_type;
  @override
  List<String>? get umpire_ids;
  @override
  List<String>? get scorer_ids;
  @override
  List<String>? get commentator_ids;
  @override
  String? get referee_id;
  @override
  MatchStatus get match_status;
  @override
  TossDecision? get toss_decision;
  @override
  String? get toss_winner_id;
  @override
  @JsonKey(ignore: true)
  _$$AddEditMatchRequestImplCopyWith<_$AddEditMatchRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddMatchTeamRequest _$AddMatchTeamRequestFromJson(Map<String, dynamic> json) {
  return _AddMatchTeamRequest.fromJson(json);
}

/// @nodoc
mixin _$AddMatchTeamRequest {
  String get team_id => throw _privateConstructorUsedError;
  String? get captain_id => throw _privateConstructorUsedError;
  String? get admin_id => throw _privateConstructorUsedError;
  List<MatchPlayerRequest> get squad => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddMatchTeamRequestCopyWith<AddMatchTeamRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddMatchTeamRequestCopyWith<$Res> {
  factory $AddMatchTeamRequestCopyWith(
          AddMatchTeamRequest value, $Res Function(AddMatchTeamRequest) then) =
      _$AddMatchTeamRequestCopyWithImpl<$Res, AddMatchTeamRequest>;
  @useResult
  $Res call(
      {String team_id,
      String? captain_id,
      String? admin_id,
      List<MatchPlayerRequest> squad});
}

/// @nodoc
class _$AddMatchTeamRequestCopyWithImpl<$Res, $Val extends AddMatchTeamRequest>
    implements $AddMatchTeamRequestCopyWith<$Res> {
  _$AddMatchTeamRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team_id = null,
    Object? captain_id = freezed,
    Object? admin_id = freezed,
    Object? squad = null,
  }) {
    return _then(_value.copyWith(
      team_id: null == team_id
          ? _value.team_id
          : team_id // ignore: cast_nullable_to_non_nullable
              as String,
      captain_id: freezed == captain_id
          ? _value.captain_id
          : captain_id // ignore: cast_nullable_to_non_nullable
              as String?,
      admin_id: freezed == admin_id
          ? _value.admin_id
          : admin_id // ignore: cast_nullable_to_non_nullable
              as String?,
      squad: null == squad
          ? _value.squad
          : squad // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayerRequest>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddMatchTeamRequestImplCopyWith<$Res>
    implements $AddMatchTeamRequestCopyWith<$Res> {
  factory _$$AddMatchTeamRequestImplCopyWith(_$AddMatchTeamRequestImpl value,
          $Res Function(_$AddMatchTeamRequestImpl) then) =
      __$$AddMatchTeamRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String team_id,
      String? captain_id,
      String? admin_id,
      List<MatchPlayerRequest> squad});
}

/// @nodoc
class __$$AddMatchTeamRequestImplCopyWithImpl<$Res>
    extends _$AddMatchTeamRequestCopyWithImpl<$Res, _$AddMatchTeamRequestImpl>
    implements _$$AddMatchTeamRequestImplCopyWith<$Res> {
  __$$AddMatchTeamRequestImplCopyWithImpl(_$AddMatchTeamRequestImpl _value,
      $Res Function(_$AddMatchTeamRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team_id = null,
    Object? captain_id = freezed,
    Object? admin_id = freezed,
    Object? squad = null,
  }) {
    return _then(_$AddMatchTeamRequestImpl(
      team_id: null == team_id
          ? _value.team_id
          : team_id // ignore: cast_nullable_to_non_nullable
              as String,
      captain_id: freezed == captain_id
          ? _value.captain_id
          : captain_id // ignore: cast_nullable_to_non_nullable
              as String?,
      admin_id: freezed == admin_id
          ? _value.admin_id
          : admin_id // ignore: cast_nullable_to_non_nullable
              as String?,
      squad: null == squad
          ? _value._squad
          : squad // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayerRequest>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddMatchTeamRequestImpl implements _AddMatchTeamRequest {
  const _$AddMatchTeamRequestImpl(
      {required this.team_id,
      this.captain_id,
      this.admin_id,
      final List<MatchPlayerRequest> squad = const []})
      : _squad = squad;

  factory _$AddMatchTeamRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddMatchTeamRequestImplFromJson(json);

  @override
  final String team_id;
  @override
  final String? captain_id;
  @override
  final String? admin_id;
  final List<MatchPlayerRequest> _squad;
  @override
  @JsonKey()
  List<MatchPlayerRequest> get squad {
    if (_squad is EqualUnmodifiableListView) return _squad;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_squad);
  }

  @override
  String toString() {
    return 'AddMatchTeamRequest(team_id: $team_id, captain_id: $captain_id, admin_id: $admin_id, squad: $squad)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddMatchTeamRequestImpl &&
            (identical(other.team_id, team_id) || other.team_id == team_id) &&
            (identical(other.captain_id, captain_id) ||
                other.captain_id == captain_id) &&
            (identical(other.admin_id, admin_id) ||
                other.admin_id == admin_id) &&
            const DeepCollectionEquality().equals(other._squad, _squad));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, team_id, captain_id, admin_id,
      const DeepCollectionEquality().hash(_squad));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddMatchTeamRequestImplCopyWith<_$AddMatchTeamRequestImpl> get copyWith =>
      __$$AddMatchTeamRequestImplCopyWithImpl<_$AddMatchTeamRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddMatchTeamRequestImplToJson(
      this,
    );
  }
}

abstract class _AddMatchTeamRequest implements AddMatchTeamRequest {
  const factory _AddMatchTeamRequest(
      {required final String team_id,
      final String? captain_id,
      final String? admin_id,
      final List<MatchPlayerRequest> squad}) = _$AddMatchTeamRequestImpl;

  factory _AddMatchTeamRequest.fromJson(Map<String, dynamic> json) =
      _$AddMatchTeamRequestImpl.fromJson;

  @override
  String get team_id;
  @override
  String? get captain_id;
  @override
  String? get admin_id;
  @override
  List<MatchPlayerRequest> get squad;
  @override
  @JsonKey(ignore: true)
  _$$AddMatchTeamRequestImplCopyWith<_$AddMatchTeamRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchPlayerRequest _$MatchPlayerRequestFromJson(Map<String, dynamic> json) {
  return _MatchPlayerRequest.fromJson(json);
}

/// @nodoc
mixin _$MatchPlayerRequest {
  String get id => throw _privateConstructorUsedError;
  PlayerStatus get status => throw _privateConstructorUsedError;
  int? get index => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchPlayerRequestCopyWith<MatchPlayerRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchPlayerRequestCopyWith<$Res> {
  factory $MatchPlayerRequestCopyWith(
          MatchPlayerRequest value, $Res Function(MatchPlayerRequest) then) =
      _$MatchPlayerRequestCopyWithImpl<$Res, MatchPlayerRequest>;
  @useResult
  $Res call({String id, PlayerStatus status, int? index});
}

/// @nodoc
class _$MatchPlayerRequestCopyWithImpl<$Res, $Val extends MatchPlayerRequest>
    implements $MatchPlayerRequestCopyWith<$Res> {
  _$MatchPlayerRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? index = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlayerStatus,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchPlayerRequestImplCopyWith<$Res>
    implements $MatchPlayerRequestCopyWith<$Res> {
  factory _$$MatchPlayerRequestImplCopyWith(_$MatchPlayerRequestImpl value,
          $Res Function(_$MatchPlayerRequestImpl) then) =
      __$$MatchPlayerRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, PlayerStatus status, int? index});
}

/// @nodoc
class __$$MatchPlayerRequestImplCopyWithImpl<$Res>
    extends _$MatchPlayerRequestCopyWithImpl<$Res, _$MatchPlayerRequestImpl>
    implements _$$MatchPlayerRequestImplCopyWith<$Res> {
  __$$MatchPlayerRequestImplCopyWithImpl(_$MatchPlayerRequestImpl _value,
      $Res Function(_$MatchPlayerRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? index = freezed,
  }) {
    return _then(_$MatchPlayerRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlayerStatus,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchPlayerRequestImpl implements _MatchPlayerRequest {
  const _$MatchPlayerRequestImpl(
      {required this.id, required this.status, this.index});

  factory _$MatchPlayerRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchPlayerRequestImplFromJson(json);

  @override
  final String id;
  @override
  final PlayerStatus status;
  @override
  final int? index;

  @override
  String toString() {
    return 'MatchPlayerRequest(id: $id, status: $status, index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchPlayerRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, status, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchPlayerRequestImplCopyWith<_$MatchPlayerRequestImpl> get copyWith =>
      __$$MatchPlayerRequestImplCopyWithImpl<_$MatchPlayerRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchPlayerRequestImplToJson(
      this,
    );
  }
}

abstract class _MatchPlayerRequest implements MatchPlayerRequest {
  const factory _MatchPlayerRequest(
      {required final String id,
      required final PlayerStatus status,
      final int? index}) = _$MatchPlayerRequestImpl;

  factory _MatchPlayerRequest.fromJson(Map<String, dynamic> json) =
      _$MatchPlayerRequestImpl.fromJson;

  @override
  String get id;
  @override
  PlayerStatus get status;
  @override
  int? get index;
  @override
  @JsonKey(ignore: true)
  _$$MatchPlayerRequestImplCopyWith<_$MatchPlayerRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
