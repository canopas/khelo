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
  String get id => throw _privateConstructorUsedError;
  List<MatchTeamModel> get teams => throw _privateConstructorUsedError;
  String? get tournament_id => throw _privateConstructorUsedError;
  MatchType get match_type => throw _privateConstructorUsedError;
  int get number_of_over => throw _privateConstructorUsedError;
  int get over_per_bowler => throw _privateConstructorUsedError;
  List<String> get players => throw _privateConstructorUsedError;
  List<String> get team_ids => throw _privateConstructorUsedError;
  List<String> get team_creator_ids => throw _privateConstructorUsedError;
  List<int> get power_play_overs1 => throw _privateConstructorUsedError;
  List<int> get power_play_overs2 => throw _privateConstructorUsedError;
  List<int> get power_play_overs3 => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get ground => throw _privateConstructorUsedError;
  DateTime? get start_time => throw _privateConstructorUsedError;
  @TimeStampJsonConverter()
  DateTime? get start_at => throw _privateConstructorUsedError;
  BallType get ball_type => throw _privateConstructorUsedError;
  PitchType get pitch_type => throw _privateConstructorUsedError;
  String get created_by => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<UserModel>? get umpires => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<UserModel>? get scorers => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<UserModel>? get commentators => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  UserModel? get referee => throw _privateConstructorUsedError;
  List<String>? get umpire_ids => throw _privateConstructorUsedError;
  List<String>? get scorer_ids => throw _privateConstructorUsedError;
  List<String>? get commentator_ids => throw _privateConstructorUsedError;
  String? get referee_id => throw _privateConstructorUsedError;
  MatchStatus get match_status => throw _privateConstructorUsedError;
  TossDecision? get toss_decision => throw _privateConstructorUsedError;
  String? get toss_winner_id => throw _privateConstructorUsedError;
  String? get current_playing_team_id => throw _privateConstructorUsedError;
  RevisedTarget? get revised_target => throw _privateConstructorUsedError;
  @TimeStampJsonConverter()
  DateTime? get updated_at => throw _privateConstructorUsedError;

  /// Serializes this MatchModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {String id,
      List<MatchTeamModel> teams,
      String? tournament_id,
      MatchType match_type,
      int number_of_over,
      int over_per_bowler,
      List<String> players,
      List<String> team_ids,
      List<String> team_creator_ids,
      List<int> power_play_overs1,
      List<int> power_play_overs2,
      List<int> power_play_overs3,
      String city,
      String ground,
      DateTime? start_time,
      @TimeStampJsonConverter() DateTime? start_at,
      BallType ball_type,
      PitchType pitch_type,
      String created_by,
      @JsonKey(includeToJson: false, includeFromJson: false)
      List<UserModel>? umpires,
      @JsonKey(includeToJson: false, includeFromJson: false)
      List<UserModel>? scorers,
      @JsonKey(includeToJson: false, includeFromJson: false)
      List<UserModel>? commentators,
      @JsonKey(includeToJson: false, includeFromJson: false) UserModel? referee,
      List<String>? umpire_ids,
      List<String>? scorer_ids,
      List<String>? commentator_ids,
      String? referee_id,
      MatchStatus match_status,
      TossDecision? toss_decision,
      String? toss_winner_id,
      String? current_playing_team_id,
      RevisedTarget? revised_target,
      @TimeStampJsonConverter() DateTime? updated_at});

  $UserModelCopyWith<$Res>? get referee;
  $RevisedTargetCopyWith<$Res>? get revised_target;
}

/// @nodoc
class _$MatchModelCopyWithImpl<$Res, $Val extends MatchModel>
    implements $MatchModelCopyWith<$Res> {
  _$MatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? teams = null,
    Object? tournament_id = freezed,
    Object? match_type = null,
    Object? number_of_over = null,
    Object? over_per_bowler = null,
    Object? players = null,
    Object? team_ids = null,
    Object? team_creator_ids = null,
    Object? power_play_overs1 = null,
    Object? power_play_overs2 = null,
    Object? power_play_overs3 = null,
    Object? city = null,
    Object? ground = null,
    Object? start_time = freezed,
    Object? start_at = freezed,
    Object? ball_type = null,
    Object? pitch_type = null,
    Object? created_by = null,
    Object? umpires = freezed,
    Object? scorers = freezed,
    Object? commentators = freezed,
    Object? referee = freezed,
    Object? umpire_ids = freezed,
    Object? scorer_ids = freezed,
    Object? commentator_ids = freezed,
    Object? referee_id = freezed,
    Object? match_status = null,
    Object? toss_decision = freezed,
    Object? toss_winner_id = freezed,
    Object? current_playing_team_id = freezed,
    Object? revised_target = freezed,
    Object? updated_at = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<MatchTeamModel>,
      tournament_id: freezed == tournament_id
          ? _value.tournament_id
          : tournament_id // ignore: cast_nullable_to_non_nullable
              as String?,
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
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<String>,
      team_ids: null == team_ids
          ? _value.team_ids
          : team_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      team_creator_ids: null == team_creator_ids
          ? _value.team_creator_ids
          : team_creator_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      start_time: freezed == start_time
          ? _value.start_time
          : start_time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      start_at: freezed == start_at
          ? _value.start_at
          : start_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ball_type: null == ball_type
          ? _value.ball_type
          : ball_type // ignore: cast_nullable_to_non_nullable
              as BallType,
      pitch_type: null == pitch_type
          ? _value.pitch_type
          : pitch_type // ignore: cast_nullable_to_non_nullable
              as PitchType,
      created_by: null == created_by
          ? _value.created_by
          : created_by // ignore: cast_nullable_to_non_nullable
              as String,
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
      current_playing_team_id: freezed == current_playing_team_id
          ? _value.current_playing_team_id
          : current_playing_team_id // ignore: cast_nullable_to_non_nullable
              as String?,
      revised_target: freezed == revised_target
          ? _value.revised_target
          : revised_target // ignore: cast_nullable_to_non_nullable
              as RevisedTarget?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RevisedTargetCopyWith<$Res>? get revised_target {
    if (_value.revised_target == null) {
      return null;
    }

    return $RevisedTargetCopyWith<$Res>(_value.revised_target!, (value) {
      return _then(_value.copyWith(revised_target: value) as $Val);
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
      {String id,
      List<MatchTeamModel> teams,
      String? tournament_id,
      MatchType match_type,
      int number_of_over,
      int over_per_bowler,
      List<String> players,
      List<String> team_ids,
      List<String> team_creator_ids,
      List<int> power_play_overs1,
      List<int> power_play_overs2,
      List<int> power_play_overs3,
      String city,
      String ground,
      DateTime? start_time,
      @TimeStampJsonConverter() DateTime? start_at,
      BallType ball_type,
      PitchType pitch_type,
      String created_by,
      @JsonKey(includeToJson: false, includeFromJson: false)
      List<UserModel>? umpires,
      @JsonKey(includeToJson: false, includeFromJson: false)
      List<UserModel>? scorers,
      @JsonKey(includeToJson: false, includeFromJson: false)
      List<UserModel>? commentators,
      @JsonKey(includeToJson: false, includeFromJson: false) UserModel? referee,
      List<String>? umpire_ids,
      List<String>? scorer_ids,
      List<String>? commentator_ids,
      String? referee_id,
      MatchStatus match_status,
      TossDecision? toss_decision,
      String? toss_winner_id,
      String? current_playing_team_id,
      RevisedTarget? revised_target,
      @TimeStampJsonConverter() DateTime? updated_at});

  @override
  $UserModelCopyWith<$Res>? get referee;
  @override
  $RevisedTargetCopyWith<$Res>? get revised_target;
}

/// @nodoc
class __$$MatchModelImplCopyWithImpl<$Res>
    extends _$MatchModelCopyWithImpl<$Res, _$MatchModelImpl>
    implements _$$MatchModelImplCopyWith<$Res> {
  __$$MatchModelImplCopyWithImpl(
      _$MatchModelImpl _value, $Res Function(_$MatchModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? teams = null,
    Object? tournament_id = freezed,
    Object? match_type = null,
    Object? number_of_over = null,
    Object? over_per_bowler = null,
    Object? players = null,
    Object? team_ids = null,
    Object? team_creator_ids = null,
    Object? power_play_overs1 = null,
    Object? power_play_overs2 = null,
    Object? power_play_overs3 = null,
    Object? city = null,
    Object? ground = null,
    Object? start_time = freezed,
    Object? start_at = freezed,
    Object? ball_type = null,
    Object? pitch_type = null,
    Object? created_by = null,
    Object? umpires = freezed,
    Object? scorers = freezed,
    Object? commentators = freezed,
    Object? referee = freezed,
    Object? umpire_ids = freezed,
    Object? scorer_ids = freezed,
    Object? commentator_ids = freezed,
    Object? referee_id = freezed,
    Object? match_status = null,
    Object? toss_decision = freezed,
    Object? toss_winner_id = freezed,
    Object? current_playing_team_id = freezed,
    Object? revised_target = freezed,
    Object? updated_at = freezed,
  }) {
    return _then(_$MatchModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      teams: null == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<MatchTeamModel>,
      tournament_id: freezed == tournament_id
          ? _value.tournament_id
          : tournament_id // ignore: cast_nullable_to_non_nullable
              as String?,
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
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<String>,
      team_ids: null == team_ids
          ? _value._team_ids
          : team_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      team_creator_ids: null == team_creator_ids
          ? _value._team_creator_ids
          : team_creator_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      start_time: freezed == start_time
          ? _value.start_time
          : start_time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      start_at: freezed == start_at
          ? _value.start_at
          : start_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ball_type: null == ball_type
          ? _value.ball_type
          : ball_type // ignore: cast_nullable_to_non_nullable
              as BallType,
      pitch_type: null == pitch_type
          ? _value.pitch_type
          : pitch_type // ignore: cast_nullable_to_non_nullable
              as PitchType,
      created_by: null == created_by
          ? _value.created_by
          : created_by // ignore: cast_nullable_to_non_nullable
              as String,
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
      current_playing_team_id: freezed == current_playing_team_id
          ? _value.current_playing_team_id
          : current_playing_team_id // ignore: cast_nullable_to_non_nullable
              as String?,
      revised_target: freezed == revised_target
          ? _value.revised_target
          : revised_target // ignore: cast_nullable_to_non_nullable
              as RevisedTarget?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true)
class _$MatchModelImpl implements _MatchModel {
  const _$MatchModelImpl(
      {required this.id,
      required final List<MatchTeamModel> teams,
      this.tournament_id,
      required this.match_type,
      required this.number_of_over,
      required this.over_per_bowler,
      final List<String> players = const [],
      final List<String> team_ids = const [],
      final List<String> team_creator_ids = const [],
      final List<int> power_play_overs1 = const [],
      final List<int> power_play_overs2 = const [],
      final List<int> power_play_overs3 = const [],
      required this.city,
      required this.ground,
      this.start_time,
      @TimeStampJsonConverter() this.start_at,
      required this.ball_type,
      required this.pitch_type,
      required this.created_by,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final List<UserModel>? umpires,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final List<UserModel>? scorers,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final List<UserModel>? commentators,
      @JsonKey(includeToJson: false, includeFromJson: false) this.referee,
      final List<String>? umpire_ids,
      final List<String>? scorer_ids,
      final List<String>? commentator_ids,
      this.referee_id,
      required this.match_status,
      this.toss_decision,
      this.toss_winner_id,
      this.current_playing_team_id,
      this.revised_target,
      @TimeStampJsonConverter() this.updated_at})
      : _teams = teams,
        _players = players,
        _team_ids = team_ids,
        _team_creator_ids = team_creator_ids,
        _power_play_overs1 = power_play_overs1,
        _power_play_overs2 = power_play_overs2,
        _power_play_overs3 = power_play_overs3,
        _umpires = umpires,
        _scorers = scorers,
        _commentators = commentators,
        _umpire_ids = umpire_ids,
        _scorer_ids = scorer_ids,
        _commentator_ids = commentator_ids;

  factory _$MatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchModelImplFromJson(json);

  @override
  final String id;
  final List<MatchTeamModel> _teams;
  @override
  List<MatchTeamModel> get teams {
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teams);
  }

  @override
  final String? tournament_id;
  @override
  final MatchType match_type;
  @override
  final int number_of_over;
  @override
  final int over_per_bowler;
  final List<String> _players;
  @override
  @JsonKey()
  List<String> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  final List<String> _team_ids;
  @override
  @JsonKey()
  List<String> get team_ids {
    if (_team_ids is EqualUnmodifiableListView) return _team_ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_team_ids);
  }

  final List<String> _team_creator_ids;
  @override
  @JsonKey()
  List<String> get team_creator_ids {
    if (_team_creator_ids is EqualUnmodifiableListView)
      return _team_creator_ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_team_creator_ids);
  }

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
  final DateTime? start_time;
  @override
  @TimeStampJsonConverter()
  final DateTime? start_at;
  @override
  final BallType ball_type;
  @override
  final PitchType pitch_type;
  @override
  final String created_by;
  final List<UserModel>? _umpires;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<UserModel>? get umpires {
    final value = _umpires;
    if (value == null) return null;
    if (_umpires is EqualUnmodifiableListView) return _umpires;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<UserModel>? _scorers;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<UserModel>? get scorers {
    final value = _scorers;
    if (value == null) return null;
    if (_scorers is EqualUnmodifiableListView) return _scorers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<UserModel>? _commentators;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<UserModel>? get commentators {
    final value = _commentators;
    if (value == null) return null;
    if (_commentators is EqualUnmodifiableListView) return _commentators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final UserModel? referee;
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
  final String? current_playing_team_id;
  @override
  final RevisedTarget? revised_target;
  @override
  @TimeStampJsonConverter()
  final DateTime? updated_at;

  @override
  String toString() {
    return 'MatchModel(id: $id, teams: $teams, tournament_id: $tournament_id, match_type: $match_type, number_of_over: $number_of_over, over_per_bowler: $over_per_bowler, players: $players, team_ids: $team_ids, team_creator_ids: $team_creator_ids, power_play_overs1: $power_play_overs1, power_play_overs2: $power_play_overs2, power_play_overs3: $power_play_overs3, city: $city, ground: $ground, start_time: $start_time, start_at: $start_at, ball_type: $ball_type, pitch_type: $pitch_type, created_by: $created_by, umpires: $umpires, scorers: $scorers, commentators: $commentators, referee: $referee, umpire_ids: $umpire_ids, scorer_ids: $scorer_ids, commentator_ids: $commentator_ids, referee_id: $referee_id, match_status: $match_status, toss_decision: $toss_decision, toss_winner_id: $toss_winner_id, current_playing_team_id: $current_playing_team_id, revised_target: $revised_target, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            (identical(other.tournament_id, tournament_id) ||
                other.tournament_id == tournament_id) &&
            (identical(other.match_type, match_type) ||
                other.match_type == match_type) &&
            (identical(other.number_of_over, number_of_over) ||
                other.number_of_over == number_of_over) &&
            (identical(other.over_per_bowler, over_per_bowler) ||
                other.over_per_bowler == over_per_bowler) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality().equals(other._team_ids, _team_ids) &&
            const DeepCollectionEquality()
                .equals(other._team_creator_ids, _team_creator_ids) &&
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
            (identical(other.start_at, start_at) ||
                other.start_at == start_at) &&
            (identical(other.ball_type, ball_type) ||
                other.ball_type == ball_type) &&
            (identical(other.pitch_type, pitch_type) ||
                other.pitch_type == pitch_type) &&
            (identical(other.created_by, created_by) ||
                other.created_by == created_by) &&
            const DeepCollectionEquality().equals(other._umpires, _umpires) &&
            const DeepCollectionEquality().equals(other._scorers, _scorers) &&
            const DeepCollectionEquality()
                .equals(other._commentators, _commentators) &&
            (identical(other.referee, referee) || other.referee == referee) &&
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
                other.toss_winner_id == toss_winner_id) &&
            (identical(
                    other.current_playing_team_id, current_playing_team_id) ||
                other.current_playing_team_id == current_playing_team_id) &&
            (identical(other.revised_target, revised_target) ||
                other.revised_target == revised_target) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        const DeepCollectionEquality().hash(_teams),
        tournament_id,
        match_type,
        number_of_over,
        over_per_bowler,
        const DeepCollectionEquality().hash(_players),
        const DeepCollectionEquality().hash(_team_ids),
        const DeepCollectionEquality().hash(_team_creator_ids),
        const DeepCollectionEquality().hash(_power_play_overs1),
        const DeepCollectionEquality().hash(_power_play_overs2),
        const DeepCollectionEquality().hash(_power_play_overs3),
        city,
        ground,
        start_time,
        start_at,
        ball_type,
        pitch_type,
        created_by,
        const DeepCollectionEquality().hash(_umpires),
        const DeepCollectionEquality().hash(_scorers),
        const DeepCollectionEquality().hash(_commentators),
        referee,
        const DeepCollectionEquality().hash(_umpire_ids),
        const DeepCollectionEquality().hash(_scorer_ids),
        const DeepCollectionEquality().hash(_commentator_ids),
        referee_id,
        match_status,
        toss_decision,
        toss_winner_id,
        current_playing_team_id,
        revised_target,
        updated_at
      ]);

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {required final String id,
      required final List<MatchTeamModel> teams,
      final String? tournament_id,
      required final MatchType match_type,
      required final int number_of_over,
      required final int over_per_bowler,
      final List<String> players,
      final List<String> team_ids,
      final List<String> team_creator_ids,
      final List<int> power_play_overs1,
      final List<int> power_play_overs2,
      final List<int> power_play_overs3,
      required final String city,
      required final String ground,
      final DateTime? start_time,
      @TimeStampJsonConverter() final DateTime? start_at,
      required final BallType ball_type,
      required final PitchType pitch_type,
      required final String created_by,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final List<UserModel>? umpires,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final List<UserModel>? scorers,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final List<UserModel>? commentators,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final UserModel? referee,
      final List<String>? umpire_ids,
      final List<String>? scorer_ids,
      final List<String>? commentator_ids,
      final String? referee_id,
      required final MatchStatus match_status,
      final TossDecision? toss_decision,
      final String? toss_winner_id,
      final String? current_playing_team_id,
      final RevisedTarget? revised_target,
      @TimeStampJsonConverter() final DateTime? updated_at}) = _$MatchModelImpl;

  factory _MatchModel.fromJson(Map<String, dynamic> json) =
      _$MatchModelImpl.fromJson;

  @override
  String get id;
  @override
  List<MatchTeamModel> get teams;
  @override
  String? get tournament_id;
  @override
  MatchType get match_type;
  @override
  int get number_of_over;
  @override
  int get over_per_bowler;
  @override
  List<String> get players;
  @override
  List<String> get team_ids;
  @override
  List<String> get team_creator_ids;
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
  DateTime? get start_time;
  @override
  @TimeStampJsonConverter()
  DateTime? get start_at;
  @override
  BallType get ball_type;
  @override
  PitchType get pitch_type;
  @override
  String get created_by;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<UserModel>? get umpires;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<UserModel>? get scorers;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<UserModel>? get commentators;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  UserModel? get referee;
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
  String? get current_playing_team_id;
  @override
  RevisedTarget? get revised_target;
  @override
  @TimeStampJsonConverter()
  DateTime? get updated_at;

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchModelImplCopyWith<_$MatchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchSetting _$MatchSettingFromJson(Map<String, dynamic> json) {
  return _MatchSetting.fromJson(json);
}

/// @nodoc
mixin _$MatchSetting {
  bool get continue_with_injured_player => throw _privateConstructorUsedError;
  bool get show_wagon_wheel_for_less_run => throw _privateConstructorUsedError;
  bool get show_wagon_wheel_for_dot_ball => throw _privateConstructorUsedError;

  /// Serializes this MatchSetting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchSettingCopyWith<MatchSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchSettingCopyWith<$Res> {
  factory $MatchSettingCopyWith(
          MatchSetting value, $Res Function(MatchSetting) then) =
      _$MatchSettingCopyWithImpl<$Res, MatchSetting>;
  @useResult
  $Res call(
      {bool continue_with_injured_player,
      bool show_wagon_wheel_for_less_run,
      bool show_wagon_wheel_for_dot_ball});
}

/// @nodoc
class _$MatchSettingCopyWithImpl<$Res, $Val extends MatchSetting>
    implements $MatchSettingCopyWith<$Res> {
  _$MatchSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchSetting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? continue_with_injured_player = null,
    Object? show_wagon_wheel_for_less_run = null,
    Object? show_wagon_wheel_for_dot_ball = null,
  }) {
    return _then(_value.copyWith(
      continue_with_injured_player: null == continue_with_injured_player
          ? _value.continue_with_injured_player
          : continue_with_injured_player // ignore: cast_nullable_to_non_nullable
              as bool,
      show_wagon_wheel_for_less_run: null == show_wagon_wheel_for_less_run
          ? _value.show_wagon_wheel_for_less_run
          : show_wagon_wheel_for_less_run // ignore: cast_nullable_to_non_nullable
              as bool,
      show_wagon_wheel_for_dot_ball: null == show_wagon_wheel_for_dot_ball
          ? _value.show_wagon_wheel_for_dot_ball
          : show_wagon_wheel_for_dot_ball // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchSettingImplCopyWith<$Res>
    implements $MatchSettingCopyWith<$Res> {
  factory _$$MatchSettingImplCopyWith(
          _$MatchSettingImpl value, $Res Function(_$MatchSettingImpl) then) =
      __$$MatchSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool continue_with_injured_player,
      bool show_wagon_wheel_for_less_run,
      bool show_wagon_wheel_for_dot_ball});
}

/// @nodoc
class __$$MatchSettingImplCopyWithImpl<$Res>
    extends _$MatchSettingCopyWithImpl<$Res, _$MatchSettingImpl>
    implements _$$MatchSettingImplCopyWith<$Res> {
  __$$MatchSettingImplCopyWithImpl(
      _$MatchSettingImpl _value, $Res Function(_$MatchSettingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchSetting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? continue_with_injured_player = null,
    Object? show_wagon_wheel_for_less_run = null,
    Object? show_wagon_wheel_for_dot_ball = null,
  }) {
    return _then(_$MatchSettingImpl(
      continue_with_injured_player: null == continue_with_injured_player
          ? _value.continue_with_injured_player
          : continue_with_injured_player // ignore: cast_nullable_to_non_nullable
              as bool,
      show_wagon_wheel_for_less_run: null == show_wagon_wheel_for_less_run
          ? _value.show_wagon_wheel_for_less_run
          : show_wagon_wheel_for_less_run // ignore: cast_nullable_to_non_nullable
              as bool,
      show_wagon_wheel_for_dot_ball: null == show_wagon_wheel_for_dot_ball
          ? _value.show_wagon_wheel_for_dot_ball
          : show_wagon_wheel_for_dot_ball // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchSettingImpl implements _MatchSetting {
  const _$MatchSettingImpl(
      {this.continue_with_injured_player = true,
      this.show_wagon_wheel_for_less_run = true,
      this.show_wagon_wheel_for_dot_ball = true});

  factory _$MatchSettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchSettingImplFromJson(json);

  @override
  @JsonKey()
  final bool continue_with_injured_player;
  @override
  @JsonKey()
  final bool show_wagon_wheel_for_less_run;
  @override
  @JsonKey()
  final bool show_wagon_wheel_for_dot_ball;

  @override
  String toString() {
    return 'MatchSetting(continue_with_injured_player: $continue_with_injured_player, show_wagon_wheel_for_less_run: $show_wagon_wheel_for_less_run, show_wagon_wheel_for_dot_ball: $show_wagon_wheel_for_dot_ball)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchSettingImpl &&
            (identical(other.continue_with_injured_player,
                    continue_with_injured_player) ||
                other.continue_with_injured_player ==
                    continue_with_injured_player) &&
            (identical(other.show_wagon_wheel_for_less_run,
                    show_wagon_wheel_for_less_run) ||
                other.show_wagon_wheel_for_less_run ==
                    show_wagon_wheel_for_less_run) &&
            (identical(other.show_wagon_wheel_for_dot_ball,
                    show_wagon_wheel_for_dot_ball) ||
                other.show_wagon_wheel_for_dot_ball ==
                    show_wagon_wheel_for_dot_ball));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, continue_with_injured_player,
      show_wagon_wheel_for_less_run, show_wagon_wheel_for_dot_ball);

  /// Create a copy of MatchSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchSettingImplCopyWith<_$MatchSettingImpl> get copyWith =>
      __$$MatchSettingImplCopyWithImpl<_$MatchSettingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchSettingImplToJson(
      this,
    );
  }
}

abstract class _MatchSetting implements MatchSetting {
  const factory _MatchSetting(
      {final bool continue_with_injured_player,
      final bool show_wagon_wheel_for_less_run,
      final bool show_wagon_wheel_for_dot_ball}) = _$MatchSettingImpl;

  factory _MatchSetting.fromJson(Map<String, dynamic> json) =
      _$MatchSettingImpl.fromJson;

  @override
  bool get continue_with_injured_player;
  @override
  bool get show_wagon_wheel_for_less_run;
  @override
  bool get show_wagon_wheel_for_dot_ball;

  /// Create a copy of MatchSetting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchSettingImplCopyWith<_$MatchSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchTeamModel _$MatchTeamModelFromJson(Map<String, dynamic> json) {
  return _MatchTeamModel.fromJson(json);
}

/// @nodoc
mixin _$MatchTeamModel {
  @JsonKey(includeToJson: false, includeFromJson: false)
  TeamModel get team => throw _privateConstructorUsedError;
  String get team_id => throw _privateConstructorUsedError;
  String? get captain_id => throw _privateConstructorUsedError;
  String? get admin_id => throw _privateConstructorUsedError;
  double get over => throw _privateConstructorUsedError;
  int get run => throw _privateConstructorUsedError;
  int get wicket => throw _privateConstructorUsedError;
  List<MatchPlayer> get squad => throw _privateConstructorUsedError;

  /// Serializes this MatchTeamModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchTeamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {@JsonKey(includeToJson: false, includeFromJson: false) TeamModel team,
      String team_id,
      String? captain_id,
      String? admin_id,
      double over,
      int run,
      int wicket,
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

  /// Create a copy of MatchTeamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team = null,
    Object? team_id = null,
    Object? captain_id = freezed,
    Object? admin_id = freezed,
    Object? over = null,
    Object? run = null,
    Object? wicket = null,
    Object? squad = null,
  }) {
    return _then(_value.copyWith(
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamModel,
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
      over: null == over
          ? _value.over
          : over // ignore: cast_nullable_to_non_nullable
              as double,
      run: null == run
          ? _value.run
          : run // ignore: cast_nullable_to_non_nullable
              as int,
      wicket: null == wicket
          ? _value.wicket
          : wicket // ignore: cast_nullable_to_non_nullable
              as int,
      squad: null == squad
          ? _value.squad
          : squad // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>,
    ) as $Val);
  }

  /// Create a copy of MatchTeamModel
  /// with the given fields replaced by the non-null parameter values.
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
      {@JsonKey(includeToJson: false, includeFromJson: false) TeamModel team,
      String team_id,
      String? captain_id,
      String? admin_id,
      double over,
      int run,
      int wicket,
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

  /// Create a copy of MatchTeamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team = null,
    Object? team_id = null,
    Object? captain_id = freezed,
    Object? admin_id = freezed,
    Object? over = null,
    Object? run = null,
    Object? wicket = null,
    Object? squad = null,
  }) {
    return _then(_$MatchTeamModelImpl(
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamModel,
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
      over: null == over
          ? _value.over
          : over // ignore: cast_nullable_to_non_nullable
              as double,
      run: null == run
          ? _value.run
          : run // ignore: cast_nullable_to_non_nullable
              as int,
      wicket: null == wicket
          ? _value.wicket
          : wicket // ignore: cast_nullable_to_non_nullable
              as int,
      squad: null == squad
          ? _value._squad
          : squad // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>,
    ));
  }
}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true)
class _$MatchTeamModelImpl implements _MatchTeamModel {
  const _$MatchTeamModelImpl(
      {@JsonKey(includeToJson: false, includeFromJson: false)
      this.team = const TeamModel(name: '', name_lowercase: '', id: ''),
      required this.team_id,
      this.captain_id,
      this.admin_id,
      this.over = 0,
      this.run = 0,
      this.wicket = 0,
      final List<MatchPlayer> squad = const []})
      : _squad = squad;

  factory _$MatchTeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchTeamModelImplFromJson(json);

  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final TeamModel team;
  @override
  final String team_id;
  @override
  final String? captain_id;
  @override
  final String? admin_id;
  @override
  @JsonKey()
  final double over;
  @override
  @JsonKey()
  final int run;
  @override
  @JsonKey()
  final int wicket;
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
    return 'MatchTeamModel(team: $team, team_id: $team_id, captain_id: $captain_id, admin_id: $admin_id, over: $over, run: $run, wicket: $wicket, squad: $squad)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchTeamModelImpl &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.team_id, team_id) || other.team_id == team_id) &&
            (identical(other.captain_id, captain_id) ||
                other.captain_id == captain_id) &&
            (identical(other.admin_id, admin_id) ||
                other.admin_id == admin_id) &&
            (identical(other.over, over) || other.over == over) &&
            (identical(other.run, run) || other.run == run) &&
            (identical(other.wicket, wicket) || other.wicket == wicket) &&
            const DeepCollectionEquality().equals(other._squad, _squad));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, team, team_id, captain_id,
      admin_id, over, run, wicket, const DeepCollectionEquality().hash(_squad));

  /// Create a copy of MatchTeamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {@JsonKey(includeToJson: false, includeFromJson: false)
      final TeamModel team,
      required final String team_id,
      final String? captain_id,
      final String? admin_id,
      final double over,
      final int run,
      final int wicket,
      final List<MatchPlayer> squad}) = _$MatchTeamModelImpl;

  factory _MatchTeamModel.fromJson(Map<String, dynamic> json) =
      _$MatchTeamModelImpl.fromJson;

  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  TeamModel get team;
  @override
  String get team_id;
  @override
  String? get captain_id;
  @override
  String? get admin_id;
  @override
  double get over;
  @override
  int get run;
  @override
  int get wicket;
  @override
  List<MatchPlayer> get squad;

  /// Create a copy of MatchTeamModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchTeamModelImplCopyWith<_$MatchTeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchPlayer _$MatchPlayerFromJson(Map<String, dynamic> json) {
  return _MatchPlayer.fromJson(json);
}

/// @nodoc
mixin _$MatchPlayer {
  @JsonKey(includeToJson: false, includeFromJson: false)
  UserModel get player => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  List<PlayerPerformance> get performance => throw _privateConstructorUsedError;
  PlayerStatus get status => throw _privateConstructorUsedError;

  /// Serializes this MatchPlayer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchPlayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchPlayerCopyWith<MatchPlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchPlayerCopyWith<$Res> {
  factory $MatchPlayerCopyWith(
          MatchPlayer value, $Res Function(MatchPlayer) then) =
      _$MatchPlayerCopyWithImpl<$Res, MatchPlayer>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false, includeFromJson: false) UserModel player,
      String id,
      List<PlayerPerformance> performance,
      PlayerStatus status});

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

  /// Create a copy of MatchPlayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? id = null,
    Object? performance = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as UserModel,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      performance: null == performance
          ? _value.performance
          : performance // ignore: cast_nullable_to_non_nullable
              as List<PlayerPerformance>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlayerStatus,
    ) as $Val);
  }

  /// Create a copy of MatchPlayer
  /// with the given fields replaced by the non-null parameter values.
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
  $Res call(
      {@JsonKey(includeToJson: false, includeFromJson: false) UserModel player,
      String id,
      List<PlayerPerformance> performance,
      PlayerStatus status});

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

  /// Create a copy of MatchPlayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? id = null,
    Object? performance = null,
    Object? status = null,
  }) {
    return _then(_$MatchPlayerImpl(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as UserModel,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      performance: null == performance
          ? _value._performance
          : performance // ignore: cast_nullable_to_non_nullable
              as List<PlayerPerformance>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlayerStatus,
    ));
  }
}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true)
class _$MatchPlayerImpl implements _MatchPlayer {
  const _$MatchPlayerImpl(
      {@JsonKey(includeToJson: false, includeFromJson: false)
      this.player = const UserModel(id: ''),
      required this.id,
      final List<PlayerPerformance> performance = const [],
      this.status = PlayerStatus.played})
      : _performance = performance;

  factory _$MatchPlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchPlayerImplFromJson(json);

  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final UserModel player;
  @override
  final String id;
  final List<PlayerPerformance> _performance;
  @override
  @JsonKey()
  List<PlayerPerformance> get performance {
    if (_performance is EqualUnmodifiableListView) return _performance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_performance);
  }

  @override
  @JsonKey()
  final PlayerStatus status;

  @override
  String toString() {
    return 'MatchPlayer(player: $player, id: $id, performance: $performance, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchPlayerImpl &&
            (identical(other.player, player) || other.player == player) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._performance, _performance) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, player, id,
      const DeepCollectionEquality().hash(_performance), status);

  /// Create a copy of MatchPlayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {@JsonKey(includeToJson: false, includeFromJson: false)
      final UserModel player,
      required final String id,
      final List<PlayerPerformance> performance,
      final PlayerStatus status}) = _$MatchPlayerImpl;

  factory _MatchPlayer.fromJson(Map<String, dynamic> json) =
      _$MatchPlayerImpl.fromJson;

  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  UserModel get player;
  @override
  String get id;
  @override
  List<PlayerPerformance> get performance;
  @override
  PlayerStatus get status;

  /// Create a copy of MatchPlayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchPlayerImplCopyWith<_$MatchPlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerPerformance _$PlayerPerformanceFromJson(Map<String, dynamic> json) {
  return _PlayerPerformance.fromJson(json);
}

/// @nodoc
mixin _$PlayerPerformance {
  String get inning_id => throw _privateConstructorUsedError;
  PlayerStatus? get status => throw _privateConstructorUsedError;
  int? get index => throw _privateConstructorUsedError;

  /// Serializes this PlayerPerformance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerPerformance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerPerformanceCopyWith<PlayerPerformance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerPerformanceCopyWith<$Res> {
  factory $PlayerPerformanceCopyWith(
          PlayerPerformance value, $Res Function(PlayerPerformance) then) =
      _$PlayerPerformanceCopyWithImpl<$Res, PlayerPerformance>;
  @useResult
  $Res call({String inning_id, PlayerStatus? status, int? index});
}

/// @nodoc
class _$PlayerPerformanceCopyWithImpl<$Res, $Val extends PlayerPerformance>
    implements $PlayerPerformanceCopyWith<$Res> {
  _$PlayerPerformanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerPerformance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inning_id = null,
    Object? status = freezed,
    Object? index = freezed,
  }) {
    return _then(_value.copyWith(
      inning_id: null == inning_id
          ? _value.inning_id
          : inning_id // ignore: cast_nullable_to_non_nullable
              as String,
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
}

/// @nodoc
abstract class _$$PlayerPerformanceImplCopyWith<$Res>
    implements $PlayerPerformanceCopyWith<$Res> {
  factory _$$PlayerPerformanceImplCopyWith(_$PlayerPerformanceImpl value,
          $Res Function(_$PlayerPerformanceImpl) then) =
      __$$PlayerPerformanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String inning_id, PlayerStatus? status, int? index});
}

/// @nodoc
class __$$PlayerPerformanceImplCopyWithImpl<$Res>
    extends _$PlayerPerformanceCopyWithImpl<$Res, _$PlayerPerformanceImpl>
    implements _$$PlayerPerformanceImplCopyWith<$Res> {
  __$$PlayerPerformanceImplCopyWithImpl(_$PlayerPerformanceImpl _value,
      $Res Function(_$PlayerPerformanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlayerPerformance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inning_id = null,
    Object? status = freezed,
    Object? index = freezed,
  }) {
    return _then(_$PlayerPerformanceImpl(
      inning_id: null == inning_id
          ? _value.inning_id
          : inning_id // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$PlayerPerformanceImpl implements _PlayerPerformance {
  const _$PlayerPerformanceImpl(
      {required this.inning_id, this.status, this.index});

  factory _$PlayerPerformanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerPerformanceImplFromJson(json);

  @override
  final String inning_id;
  @override
  final PlayerStatus? status;
  @override
  final int? index;

  @override
  String toString() {
    return 'PlayerPerformance(inning_id: $inning_id, status: $status, index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerPerformanceImpl &&
            (identical(other.inning_id, inning_id) ||
                other.inning_id == inning_id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, inning_id, status, index);

  /// Create a copy of PlayerPerformance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerPerformanceImplCopyWith<_$PlayerPerformanceImpl> get copyWith =>
      __$$PlayerPerformanceImplCopyWithImpl<_$PlayerPerformanceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerPerformanceImplToJson(
      this,
    );
  }
}

abstract class _PlayerPerformance implements PlayerPerformance {
  const factory _PlayerPerformance(
      {required final String inning_id,
      final PlayerStatus? status,
      final int? index}) = _$PlayerPerformanceImpl;

  factory _PlayerPerformance.fromJson(Map<String, dynamic> json) =
      _$PlayerPerformanceImpl.fromJson;

  @override
  String get inning_id;
  @override
  PlayerStatus? get status;
  @override
  int? get index;

  /// Create a copy of PlayerPerformance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerPerformanceImplCopyWith<_$PlayerPerformanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RevisedTarget _$RevisedTargetFromJson(Map<String, dynamic> json) {
  return _RevisedTarget.fromJson(json);
}

/// @nodoc
mixin _$RevisedTarget {
  int get runs => throw _privateConstructorUsedError;
  double get overs => throw _privateConstructorUsedError;
  DateTime? get time => throw _privateConstructorUsedError;
  @TimeStampJsonConverter()
  DateTime? get revised_time => throw _privateConstructorUsedError;

  /// Serializes this RevisedTarget to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RevisedTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RevisedTargetCopyWith<RevisedTarget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevisedTargetCopyWith<$Res> {
  factory $RevisedTargetCopyWith(
          RevisedTarget value, $Res Function(RevisedTarget) then) =
      _$RevisedTargetCopyWithImpl<$Res, RevisedTarget>;
  @useResult
  $Res call(
      {int runs,
      double overs,
      DateTime? time,
      @TimeStampJsonConverter() DateTime? revised_time});
}

/// @nodoc
class _$RevisedTargetCopyWithImpl<$Res, $Val extends RevisedTarget>
    implements $RevisedTargetCopyWith<$Res> {
  _$RevisedTargetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RevisedTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? runs = null,
    Object? overs = null,
    Object? time = freezed,
    Object? revised_time = freezed,
  }) {
    return _then(_value.copyWith(
      runs: null == runs
          ? _value.runs
          : runs // ignore: cast_nullable_to_non_nullable
              as int,
      overs: null == overs
          ? _value.overs
          : overs // ignore: cast_nullable_to_non_nullable
              as double,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      revised_time: freezed == revised_time
          ? _value.revised_time
          : revised_time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RevisedTargetImplCopyWith<$Res>
    implements $RevisedTargetCopyWith<$Res> {
  factory _$$RevisedTargetImplCopyWith(
          _$RevisedTargetImpl value, $Res Function(_$RevisedTargetImpl) then) =
      __$$RevisedTargetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int runs,
      double overs,
      DateTime? time,
      @TimeStampJsonConverter() DateTime? revised_time});
}

/// @nodoc
class __$$RevisedTargetImplCopyWithImpl<$Res>
    extends _$RevisedTargetCopyWithImpl<$Res, _$RevisedTargetImpl>
    implements _$$RevisedTargetImplCopyWith<$Res> {
  __$$RevisedTargetImplCopyWithImpl(
      _$RevisedTargetImpl _value, $Res Function(_$RevisedTargetImpl) _then)
      : super(_value, _then);

  /// Create a copy of RevisedTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? runs = null,
    Object? overs = null,
    Object? time = freezed,
    Object? revised_time = freezed,
  }) {
    return _then(_$RevisedTargetImpl(
      runs: null == runs
          ? _value.runs
          : runs // ignore: cast_nullable_to_non_nullable
              as int,
      overs: null == overs
          ? _value.overs
          : overs // ignore: cast_nullable_to_non_nullable
              as double,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      revised_time: freezed == revised_time
          ? _value.revised_time
          : revised_time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RevisedTargetImpl implements _RevisedTarget {
  const _$RevisedTargetImpl(
      {this.runs = 0,
      this.overs = 0,
      this.time,
      @TimeStampJsonConverter() this.revised_time});

  factory _$RevisedTargetImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevisedTargetImplFromJson(json);

  @override
  @JsonKey()
  final int runs;
  @override
  @JsonKey()
  final double overs;
  @override
  final DateTime? time;
  @override
  @TimeStampJsonConverter()
  final DateTime? revised_time;

  @override
  String toString() {
    return 'RevisedTarget(runs: $runs, overs: $overs, time: $time, revised_time: $revised_time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevisedTargetImpl &&
            (identical(other.runs, runs) || other.runs == runs) &&
            (identical(other.overs, overs) || other.overs == overs) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.revised_time, revised_time) ||
                other.revised_time == revised_time));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, runs, overs, time, revised_time);

  /// Create a copy of RevisedTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RevisedTargetImplCopyWith<_$RevisedTargetImpl> get copyWith =>
      __$$RevisedTargetImplCopyWithImpl<_$RevisedTargetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RevisedTargetImplToJson(
      this,
    );
  }
}

abstract class _RevisedTarget implements RevisedTarget {
  const factory _RevisedTarget(
          {final int runs,
          final double overs,
          final DateTime? time,
          @TimeStampJsonConverter() final DateTime? revised_time}) =
      _$RevisedTargetImpl;

  factory _RevisedTarget.fromJson(Map<String, dynamic> json) =
      _$RevisedTargetImpl.fromJson;

  @override
  int get runs;
  @override
  double get overs;
  @override
  DateTime? get time;
  @override
  @TimeStampJsonConverter()
  DateTime? get revised_time;

  /// Create a copy of RevisedTarget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RevisedTargetImplCopyWith<_$RevisedTargetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TeamMatchStatus {
  int get win => throw _privateConstructorUsedError;
  int get tie => throw _privateConstructorUsedError;
  int get lost => throw _privateConstructorUsedError;

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

class _$TeamMatchStatusImpl implements _TeamMatchStatus {
  const _$TeamMatchStatusImpl({this.win = 0, this.tie = 0, this.lost = 0});

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
}

abstract class _TeamMatchStatus implements TeamMatchStatus {
  const factory _TeamMatchStatus(
      {final int win, final int tie, final int lost}) = _$TeamMatchStatusImpl;

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
