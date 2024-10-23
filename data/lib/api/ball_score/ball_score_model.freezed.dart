// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ball_score_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BallScoreModel _$BallScoreModelFromJson(Map<String, dynamic> json) {
  return _BallScoreModel.fromJson(json);
}

/// @nodoc
mixin _$BallScoreModel {
  String get id => throw _privateConstructorUsedError;
  String get inning_id => throw _privateConstructorUsedError;
  String get match_id => throw _privateConstructorUsedError;
  int get over_number => throw _privateConstructorUsedError;
  int get ball_number => throw _privateConstructorUsedError;
  String get bowler_id => throw _privateConstructorUsedError;
  String get batsman_id => throw _privateConstructorUsedError;
  String get non_striker_id => throw _privateConstructorUsedError;
  int get runs_scored => throw _privateConstructorUsedError;
  ExtrasType? get extras_type => throw _privateConstructorUsedError;
  int? get extras_awarded => throw _privateConstructorUsedError;
  WicketType? get wicket_type => throw _privateConstructorUsedError;
  FieldingPositionType? get fielding_position =>
      throw _privateConstructorUsedError;
  String? get player_out_id => throw _privateConstructorUsedError;
  String? get wicket_taker_id => throw _privateConstructorUsedError;
  bool get is_four => throw _privateConstructorUsedError;
  bool get is_six => throw _privateConstructorUsedError;
  DateTime? get time => throw _privateConstructorUsedError;
  @TimeStampJsonConverter()
  DateTime? get score_time => throw _privateConstructorUsedError;

  /// Serializes this BallScoreModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BallScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BallScoreModelCopyWith<BallScoreModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BallScoreModelCopyWith<$Res> {
  factory $BallScoreModelCopyWith(
          BallScoreModel value, $Res Function(BallScoreModel) then) =
      _$BallScoreModelCopyWithImpl<$Res, BallScoreModel>;
  @useResult
  $Res call(
      {String id,
      String inning_id,
      String match_id,
      int over_number,
      int ball_number,
      String bowler_id,
      String batsman_id,
      String non_striker_id,
      int runs_scored,
      ExtrasType? extras_type,
      int? extras_awarded,
      WicketType? wicket_type,
      FieldingPositionType? fielding_position,
      String? player_out_id,
      String? wicket_taker_id,
      bool is_four,
      bool is_six,
      DateTime? time,
      @TimeStampJsonConverter() DateTime? score_time});
}

/// @nodoc
class _$BallScoreModelCopyWithImpl<$Res, $Val extends BallScoreModel>
    implements $BallScoreModelCopyWith<$Res> {
  _$BallScoreModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BallScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? inning_id = null,
    Object? match_id = null,
    Object? over_number = null,
    Object? ball_number = null,
    Object? bowler_id = null,
    Object? batsman_id = null,
    Object? non_striker_id = null,
    Object? runs_scored = null,
    Object? extras_type = freezed,
    Object? extras_awarded = freezed,
    Object? wicket_type = freezed,
    Object? fielding_position = freezed,
    Object? player_out_id = freezed,
    Object? wicket_taker_id = freezed,
    Object? is_four = null,
    Object? is_six = null,
    Object? time = freezed,
    Object? score_time = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      inning_id: null == inning_id
          ? _value.inning_id
          : inning_id // ignore: cast_nullable_to_non_nullable
              as String,
      match_id: null == match_id
          ? _value.match_id
          : match_id // ignore: cast_nullable_to_non_nullable
              as String,
      over_number: null == over_number
          ? _value.over_number
          : over_number // ignore: cast_nullable_to_non_nullable
              as int,
      ball_number: null == ball_number
          ? _value.ball_number
          : ball_number // ignore: cast_nullable_to_non_nullable
              as int,
      bowler_id: null == bowler_id
          ? _value.bowler_id
          : bowler_id // ignore: cast_nullable_to_non_nullable
              as String,
      batsman_id: null == batsman_id
          ? _value.batsman_id
          : batsman_id // ignore: cast_nullable_to_non_nullable
              as String,
      non_striker_id: null == non_striker_id
          ? _value.non_striker_id
          : non_striker_id // ignore: cast_nullable_to_non_nullable
              as String,
      runs_scored: null == runs_scored
          ? _value.runs_scored
          : runs_scored // ignore: cast_nullable_to_non_nullable
              as int,
      extras_type: freezed == extras_type
          ? _value.extras_type
          : extras_type // ignore: cast_nullable_to_non_nullable
              as ExtrasType?,
      extras_awarded: freezed == extras_awarded
          ? _value.extras_awarded
          : extras_awarded // ignore: cast_nullable_to_non_nullable
              as int?,
      wicket_type: freezed == wicket_type
          ? _value.wicket_type
          : wicket_type // ignore: cast_nullable_to_non_nullable
              as WicketType?,
      fielding_position: freezed == fielding_position
          ? _value.fielding_position
          : fielding_position // ignore: cast_nullable_to_non_nullable
              as FieldingPositionType?,
      player_out_id: freezed == player_out_id
          ? _value.player_out_id
          : player_out_id // ignore: cast_nullable_to_non_nullable
              as String?,
      wicket_taker_id: freezed == wicket_taker_id
          ? _value.wicket_taker_id
          : wicket_taker_id // ignore: cast_nullable_to_non_nullable
              as String?,
      is_four: null == is_four
          ? _value.is_four
          : is_four // ignore: cast_nullable_to_non_nullable
              as bool,
      is_six: null == is_six
          ? _value.is_six
          : is_six // ignore: cast_nullable_to_non_nullable
              as bool,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      score_time: freezed == score_time
          ? _value.score_time
          : score_time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BallScoreModelImplCopyWith<$Res>
    implements $BallScoreModelCopyWith<$Res> {
  factory _$$BallScoreModelImplCopyWith(_$BallScoreModelImpl value,
          $Res Function(_$BallScoreModelImpl) then) =
      __$$BallScoreModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String inning_id,
      String match_id,
      int over_number,
      int ball_number,
      String bowler_id,
      String batsman_id,
      String non_striker_id,
      int runs_scored,
      ExtrasType? extras_type,
      int? extras_awarded,
      WicketType? wicket_type,
      FieldingPositionType? fielding_position,
      String? player_out_id,
      String? wicket_taker_id,
      bool is_four,
      bool is_six,
      DateTime? time,
      @TimeStampJsonConverter() DateTime? score_time});
}

/// @nodoc
class __$$BallScoreModelImplCopyWithImpl<$Res>
    extends _$BallScoreModelCopyWithImpl<$Res, _$BallScoreModelImpl>
    implements _$$BallScoreModelImplCopyWith<$Res> {
  __$$BallScoreModelImplCopyWithImpl(
      _$BallScoreModelImpl _value, $Res Function(_$BallScoreModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BallScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? inning_id = null,
    Object? match_id = null,
    Object? over_number = null,
    Object? ball_number = null,
    Object? bowler_id = null,
    Object? batsman_id = null,
    Object? non_striker_id = null,
    Object? runs_scored = null,
    Object? extras_type = freezed,
    Object? extras_awarded = freezed,
    Object? wicket_type = freezed,
    Object? fielding_position = freezed,
    Object? player_out_id = freezed,
    Object? wicket_taker_id = freezed,
    Object? is_four = null,
    Object? is_six = null,
    Object? time = freezed,
    Object? score_time = freezed,
  }) {
    return _then(_$BallScoreModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      inning_id: null == inning_id
          ? _value.inning_id
          : inning_id // ignore: cast_nullable_to_non_nullable
              as String,
      match_id: null == match_id
          ? _value.match_id
          : match_id // ignore: cast_nullable_to_non_nullable
              as String,
      over_number: null == over_number
          ? _value.over_number
          : over_number // ignore: cast_nullable_to_non_nullable
              as int,
      ball_number: null == ball_number
          ? _value.ball_number
          : ball_number // ignore: cast_nullable_to_non_nullable
              as int,
      bowler_id: null == bowler_id
          ? _value.bowler_id
          : bowler_id // ignore: cast_nullable_to_non_nullable
              as String,
      batsman_id: null == batsman_id
          ? _value.batsman_id
          : batsman_id // ignore: cast_nullable_to_non_nullable
              as String,
      non_striker_id: null == non_striker_id
          ? _value.non_striker_id
          : non_striker_id // ignore: cast_nullable_to_non_nullable
              as String,
      runs_scored: null == runs_scored
          ? _value.runs_scored
          : runs_scored // ignore: cast_nullable_to_non_nullable
              as int,
      extras_type: freezed == extras_type
          ? _value.extras_type
          : extras_type // ignore: cast_nullable_to_non_nullable
              as ExtrasType?,
      extras_awarded: freezed == extras_awarded
          ? _value.extras_awarded
          : extras_awarded // ignore: cast_nullable_to_non_nullable
              as int?,
      wicket_type: freezed == wicket_type
          ? _value.wicket_type
          : wicket_type // ignore: cast_nullable_to_non_nullable
              as WicketType?,
      fielding_position: freezed == fielding_position
          ? _value.fielding_position
          : fielding_position // ignore: cast_nullable_to_non_nullable
              as FieldingPositionType?,
      player_out_id: freezed == player_out_id
          ? _value.player_out_id
          : player_out_id // ignore: cast_nullable_to_non_nullable
              as String?,
      wicket_taker_id: freezed == wicket_taker_id
          ? _value.wicket_taker_id
          : wicket_taker_id // ignore: cast_nullable_to_non_nullable
              as String?,
      is_four: null == is_four
          ? _value.is_four
          : is_four // ignore: cast_nullable_to_non_nullable
              as bool,
      is_six: null == is_six
          ? _value.is_six
          : is_six // ignore: cast_nullable_to_non_nullable
              as bool,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      score_time: freezed == score_time
          ? _value.score_time
          : score_time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BallScoreModelImpl implements _BallScoreModel {
  const _$BallScoreModelImpl(
      {required this.id,
      required this.inning_id,
      required this.match_id,
      required this.over_number,
      required this.ball_number,
      required this.bowler_id,
      required this.batsman_id,
      required this.non_striker_id,
      required this.runs_scored,
      this.extras_type,
      this.extras_awarded,
      this.wicket_type,
      this.fielding_position,
      this.player_out_id,
      this.wicket_taker_id,
      required this.is_four,
      required this.is_six,
      this.time,
      @TimeStampJsonConverter() this.score_time});

  factory _$BallScoreModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BallScoreModelImplFromJson(json);

  @override
  final String id;
  @override
  final String inning_id;
  @override
  final String match_id;
  @override
  final int over_number;
  @override
  final int ball_number;
  @override
  final String bowler_id;
  @override
  final String batsman_id;
  @override
  final String non_striker_id;
  @override
  final int runs_scored;
  @override
  final ExtrasType? extras_type;
  @override
  final int? extras_awarded;
  @override
  final WicketType? wicket_type;
  @override
  final FieldingPositionType? fielding_position;
  @override
  final String? player_out_id;
  @override
  final String? wicket_taker_id;
  @override
  final bool is_four;
  @override
  final bool is_six;
  @override
  final DateTime? time;
  @override
  @TimeStampJsonConverter()
  final DateTime? score_time;

  @override
  String toString() {
    return 'BallScoreModel(id: $id, inning_id: $inning_id, match_id: $match_id, over_number: $over_number, ball_number: $ball_number, bowler_id: $bowler_id, batsman_id: $batsman_id, non_striker_id: $non_striker_id, runs_scored: $runs_scored, extras_type: $extras_type, extras_awarded: $extras_awarded, wicket_type: $wicket_type, fielding_position: $fielding_position, player_out_id: $player_out_id, wicket_taker_id: $wicket_taker_id, is_four: $is_four, is_six: $is_six, time: $time, score_time: $score_time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BallScoreModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.inning_id, inning_id) ||
                other.inning_id == inning_id) &&
            (identical(other.match_id, match_id) ||
                other.match_id == match_id) &&
            (identical(other.over_number, over_number) ||
                other.over_number == over_number) &&
            (identical(other.ball_number, ball_number) ||
                other.ball_number == ball_number) &&
            (identical(other.bowler_id, bowler_id) ||
                other.bowler_id == bowler_id) &&
            (identical(other.batsman_id, batsman_id) ||
                other.batsman_id == batsman_id) &&
            (identical(other.non_striker_id, non_striker_id) ||
                other.non_striker_id == non_striker_id) &&
            (identical(other.runs_scored, runs_scored) ||
                other.runs_scored == runs_scored) &&
            (identical(other.extras_type, extras_type) ||
                other.extras_type == extras_type) &&
            (identical(other.extras_awarded, extras_awarded) ||
                other.extras_awarded == extras_awarded) &&
            (identical(other.wicket_type, wicket_type) ||
                other.wicket_type == wicket_type) &&
            (identical(other.fielding_position, fielding_position) ||
                other.fielding_position == fielding_position) &&
            (identical(other.player_out_id, player_out_id) ||
                other.player_out_id == player_out_id) &&
            (identical(other.wicket_taker_id, wicket_taker_id) ||
                other.wicket_taker_id == wicket_taker_id) &&
            (identical(other.is_four, is_four) || other.is_four == is_four) &&
            (identical(other.is_six, is_six) || other.is_six == is_six) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.score_time, score_time) ||
                other.score_time == score_time));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        inning_id,
        match_id,
        over_number,
        ball_number,
        bowler_id,
        batsman_id,
        non_striker_id,
        runs_scored,
        extras_type,
        extras_awarded,
        wicket_type,
        fielding_position,
        player_out_id,
        wicket_taker_id,
        is_four,
        is_six,
        time,
        score_time
      ]);

  /// Create a copy of BallScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BallScoreModelImplCopyWith<_$BallScoreModelImpl> get copyWith =>
      __$$BallScoreModelImplCopyWithImpl<_$BallScoreModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BallScoreModelImplToJson(
      this,
    );
  }
}

abstract class _BallScoreModel implements BallScoreModel {
  const factory _BallScoreModel(
          {required final String id,
          required final String inning_id,
          required final String match_id,
          required final int over_number,
          required final int ball_number,
          required final String bowler_id,
          required final String batsman_id,
          required final String non_striker_id,
          required final int runs_scored,
          final ExtrasType? extras_type,
          final int? extras_awarded,
          final WicketType? wicket_type,
          final FieldingPositionType? fielding_position,
          final String? player_out_id,
          final String? wicket_taker_id,
          required final bool is_four,
          required final bool is_six,
          final DateTime? time,
          @TimeStampJsonConverter() final DateTime? score_time}) =
      _$BallScoreModelImpl;

  factory _BallScoreModel.fromJson(Map<String, dynamic> json) =
      _$BallScoreModelImpl.fromJson;

  @override
  String get id;
  @override
  String get inning_id;
  @override
  String get match_id;
  @override
  int get over_number;
  @override
  int get ball_number;
  @override
  String get bowler_id;
  @override
  String get batsman_id;
  @override
  String get non_striker_id;
  @override
  int get runs_scored;
  @override
  ExtrasType? get extras_type;
  @override
  int? get extras_awarded;
  @override
  WicketType? get wicket_type;
  @override
  FieldingPositionType? get fielding_position;
  @override
  String? get player_out_id;
  @override
  String? get wicket_taker_id;
  @override
  bool get is_four;
  @override
  bool get is_six;
  @override
  DateTime? get time;
  @override
  @TimeStampJsonConverter()
  DateTime? get score_time;

  /// Create a copy of BallScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BallScoreModelImplCopyWith<_$BallScoreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserStat _$UserStatFromJson(Map<String, dynamic> json) {
  return _UserStat.fromJson(json);
}

/// @nodoc
mixin _$UserStat {
  BattingStat? get battingStat => throw _privateConstructorUsedError;
  BowlingStat? get bowlingStat => throw _privateConstructorUsedError;
  FieldingStat? get fieldingStat => throw _privateConstructorUsedError;

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
      {BattingStat? battingStat,
      BowlingStat? bowlingStat,
      FieldingStat? fieldingStat});

  $BattingStatCopyWith<$Res>? get battingStat;
  $BowlingStatCopyWith<$Res>? get bowlingStat;
  $FieldingStatCopyWith<$Res>? get fieldingStat;
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
    Object? battingStat = freezed,
    Object? bowlingStat = freezed,
    Object? fieldingStat = freezed,
  }) {
    return _then(_value.copyWith(
      battingStat: freezed == battingStat
          ? _value.battingStat
          : battingStat // ignore: cast_nullable_to_non_nullable
              as BattingStat?,
      bowlingStat: freezed == bowlingStat
          ? _value.bowlingStat
          : bowlingStat // ignore: cast_nullable_to_non_nullable
              as BowlingStat?,
      fieldingStat: freezed == fieldingStat
          ? _value.fieldingStat
          : fieldingStat // ignore: cast_nullable_to_non_nullable
              as FieldingStat?,
    ) as $Val);
  }

  /// Create a copy of UserStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BattingStatCopyWith<$Res>? get battingStat {
    if (_value.battingStat == null) {
      return null;
    }

    return $BattingStatCopyWith<$Res>(_value.battingStat!, (value) {
      return _then(_value.copyWith(battingStat: value) as $Val);
    });
  }

  /// Create a copy of UserStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BowlingStatCopyWith<$Res>? get bowlingStat {
    if (_value.bowlingStat == null) {
      return null;
    }

    return $BowlingStatCopyWith<$Res>(_value.bowlingStat!, (value) {
      return _then(_value.copyWith(bowlingStat: value) as $Val);
    });
  }

  /// Create a copy of UserStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FieldingStatCopyWith<$Res>? get fieldingStat {
    if (_value.fieldingStat == null) {
      return null;
    }

    return $FieldingStatCopyWith<$Res>(_value.fieldingStat!, (value) {
      return _then(_value.copyWith(fieldingStat: value) as $Val);
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
      {BattingStat? battingStat,
      BowlingStat? bowlingStat,
      FieldingStat? fieldingStat});

  @override
  $BattingStatCopyWith<$Res>? get battingStat;
  @override
  $BowlingStatCopyWith<$Res>? get bowlingStat;
  @override
  $FieldingStatCopyWith<$Res>? get fieldingStat;
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
    Object? battingStat = freezed,
    Object? bowlingStat = freezed,
    Object? fieldingStat = freezed,
  }) {
    return _then(_$UserStatImpl(
      battingStat: freezed == battingStat
          ? _value.battingStat
          : battingStat // ignore: cast_nullable_to_non_nullable
              as BattingStat?,
      bowlingStat: freezed == bowlingStat
          ? _value.bowlingStat
          : bowlingStat // ignore: cast_nullable_to_non_nullable
              as BowlingStat?,
      fieldingStat: freezed == fieldingStat
          ? _value.fieldingStat
          : fieldingStat // ignore: cast_nullable_to_non_nullable
              as FieldingStat?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserStatImpl implements _UserStat {
  const _$UserStatImpl({this.battingStat, this.bowlingStat, this.fieldingStat});

  factory _$UserStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStatImplFromJson(json);

  @override
  final BattingStat? battingStat;
  @override
  final BowlingStat? bowlingStat;
  @override
  final FieldingStat? fieldingStat;

  @override
  String toString() {
    return 'UserStat(battingStat: $battingStat, bowlingStat: $bowlingStat, fieldingStat: $fieldingStat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatImpl &&
            (identical(other.battingStat, battingStat) ||
                other.battingStat == battingStat) &&
            (identical(other.bowlingStat, bowlingStat) ||
                other.bowlingStat == bowlingStat) &&
            (identical(other.fieldingStat, fieldingStat) ||
                other.fieldingStat == fieldingStat));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, battingStat, bowlingStat, fieldingStat);

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
      {final BattingStat? battingStat,
      final BowlingStat? bowlingStat,
      final FieldingStat? fieldingStat}) = _$UserStatImpl;

  factory _UserStat.fromJson(Map<String, dynamic> json) =
      _$UserStatImpl.fromJson;

  @override
  BattingStat? get battingStat;
  @override
  BowlingStat? get bowlingStat;
  @override
  FieldingStat? get fieldingStat;

  /// Create a copy of UserStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatImplCopyWith<_$UserStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BattingStat _$BattingStatFromJson(Map<String, dynamic> json) {
  return _BattingStat.fromJson(json);
}

/// @nodoc
mixin _$BattingStat {
  int get innings => throw _privateConstructorUsedError;
  int get runScored => throw _privateConstructorUsedError;
  double get average => throw _privateConstructorUsedError;
  double get strikeRate => throw _privateConstructorUsedError;
  int get ballFaced => throw _privateConstructorUsedError;
  int get fours => throw _privateConstructorUsedError;
  int get sixes => throw _privateConstructorUsedError;
  int get fifties => throw _privateConstructorUsedError;
  int get hundreds => throw _privateConstructorUsedError;
  int get ducks => throw _privateConstructorUsedError;

  /// Serializes this BattingStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BattingStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BattingStatCopyWith<BattingStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattingStatCopyWith<$Res> {
  factory $BattingStatCopyWith(
          BattingStat value, $Res Function(BattingStat) then) =
      _$BattingStatCopyWithImpl<$Res, BattingStat>;
  @useResult
  $Res call(
      {int innings,
      int runScored,
      double average,
      double strikeRate,
      int ballFaced,
      int fours,
      int sixes,
      int fifties,
      int hundreds,
      int ducks});
}

/// @nodoc
class _$BattingStatCopyWithImpl<$Res, $Val extends BattingStat>
    implements $BattingStatCopyWith<$Res> {
  _$BattingStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BattingStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? innings = null,
    Object? runScored = null,
    Object? average = null,
    Object? strikeRate = null,
    Object? ballFaced = null,
    Object? fours = null,
    Object? sixes = null,
    Object? fifties = null,
    Object? hundreds = null,
    Object? ducks = null,
  }) {
    return _then(_value.copyWith(
      innings: null == innings
          ? _value.innings
          : innings // ignore: cast_nullable_to_non_nullable
              as int,
      runScored: null == runScored
          ? _value.runScored
          : runScored // ignore: cast_nullable_to_non_nullable
              as int,
      average: null == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      strikeRate: null == strikeRate
          ? _value.strikeRate
          : strikeRate // ignore: cast_nullable_to_non_nullable
              as double,
      ballFaced: null == ballFaced
          ? _value.ballFaced
          : ballFaced // ignore: cast_nullable_to_non_nullable
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BattingStatImplCopyWith<$Res>
    implements $BattingStatCopyWith<$Res> {
  factory _$$BattingStatImplCopyWith(
          _$BattingStatImpl value, $Res Function(_$BattingStatImpl) then) =
      __$$BattingStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int innings,
      int runScored,
      double average,
      double strikeRate,
      int ballFaced,
      int fours,
      int sixes,
      int fifties,
      int hundreds,
      int ducks});
}

/// @nodoc
class __$$BattingStatImplCopyWithImpl<$Res>
    extends _$BattingStatCopyWithImpl<$Res, _$BattingStatImpl>
    implements _$$BattingStatImplCopyWith<$Res> {
  __$$BattingStatImplCopyWithImpl(
      _$BattingStatImpl _value, $Res Function(_$BattingStatImpl) _then)
      : super(_value, _then);

  /// Create a copy of BattingStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? innings = null,
    Object? runScored = null,
    Object? average = null,
    Object? strikeRate = null,
    Object? ballFaced = null,
    Object? fours = null,
    Object? sixes = null,
    Object? fifties = null,
    Object? hundreds = null,
    Object? ducks = null,
  }) {
    return _then(_$BattingStatImpl(
      innings: null == innings
          ? _value.innings
          : innings // ignore: cast_nullable_to_non_nullable
              as int,
      runScored: null == runScored
          ? _value.runScored
          : runScored // ignore: cast_nullable_to_non_nullable
              as int,
      average: null == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      strikeRate: null == strikeRate
          ? _value.strikeRate
          : strikeRate // ignore: cast_nullable_to_non_nullable
              as double,
      ballFaced: null == ballFaced
          ? _value.ballFaced
          : ballFaced // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattingStatImpl implements _BattingStat {
  const _$BattingStatImpl(
      {this.innings = 0,
      this.runScored = 0,
      this.average = 0.0,
      this.strikeRate = 0.0,
      this.ballFaced = 0,
      this.fours = 0,
      this.sixes = 0,
      this.fifties = 0,
      this.hundreds = 0,
      this.ducks = 0});

  factory _$BattingStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattingStatImplFromJson(json);

  @override
  @JsonKey()
  final int innings;
  @override
  @JsonKey()
  final int runScored;
  @override
  @JsonKey()
  final double average;
  @override
  @JsonKey()
  final double strikeRate;
  @override
  @JsonKey()
  final int ballFaced;
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
  String toString() {
    return 'BattingStat(innings: $innings, runScored: $runScored, average: $average, strikeRate: $strikeRate, ballFaced: $ballFaced, fours: $fours, sixes: $sixes, fifties: $fifties, hundreds: $hundreds, ducks: $ducks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattingStatImpl &&
            (identical(other.innings, innings) || other.innings == innings) &&
            (identical(other.runScored, runScored) ||
                other.runScored == runScored) &&
            (identical(other.average, average) || other.average == average) &&
            (identical(other.strikeRate, strikeRate) ||
                other.strikeRate == strikeRate) &&
            (identical(other.ballFaced, ballFaced) ||
                other.ballFaced == ballFaced) &&
            (identical(other.fours, fours) || other.fours == fours) &&
            (identical(other.sixes, sixes) || other.sixes == sixes) &&
            (identical(other.fifties, fifties) || other.fifties == fifties) &&
            (identical(other.hundreds, hundreds) ||
                other.hundreds == hundreds) &&
            (identical(other.ducks, ducks) || other.ducks == ducks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, innings, runScored, average,
      strikeRate, ballFaced, fours, sixes, fifties, hundreds, ducks);

  /// Create a copy of BattingStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BattingStatImplCopyWith<_$BattingStatImpl> get copyWith =>
      __$$BattingStatImplCopyWithImpl<_$BattingStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattingStatImplToJson(
      this,
    );
  }
}

abstract class _BattingStat implements BattingStat {
  const factory _BattingStat(
      {final int innings,
      final int runScored,
      final double average,
      final double strikeRate,
      final int ballFaced,
      final int fours,
      final int sixes,
      final int fifties,
      final int hundreds,
      final int ducks}) = _$BattingStatImpl;

  factory _BattingStat.fromJson(Map<String, dynamic> json) =
      _$BattingStatImpl.fromJson;

  @override
  int get innings;
  @override
  int get runScored;
  @override
  double get average;
  @override
  double get strikeRate;
  @override
  int get ballFaced;
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

  /// Create a copy of BattingStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BattingStatImplCopyWith<_$BattingStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BowlingStat _$BowlingStatFromJson(Map<String, dynamic> json) {
  return _BowlingStat.fromJson(json);
}

/// @nodoc
mixin _$BowlingStat {
  int get innings => throw _privateConstructorUsedError;
  int get wicketTaken => throw _privateConstructorUsedError;
  int get balls => throw _privateConstructorUsedError;
  int get runsConceded => throw _privateConstructorUsedError;
  int get maiden => throw _privateConstructorUsedError;
  int get noBalls => throw _privateConstructorUsedError;
  int get wideBalls => throw _privateConstructorUsedError;
  double get average => throw _privateConstructorUsedError;
  double get strikeRate => throw _privateConstructorUsedError;
  double get economyRate => throw _privateConstructorUsedError;

  /// Serializes this BowlingStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BowlingStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BowlingStatCopyWith<BowlingStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BowlingStatCopyWith<$Res> {
  factory $BowlingStatCopyWith(
          BowlingStat value, $Res Function(BowlingStat) then) =
      _$BowlingStatCopyWithImpl<$Res, BowlingStat>;
  @useResult
  $Res call(
      {int innings,
      int wicketTaken,
      int balls,
      int runsConceded,
      int maiden,
      int noBalls,
      int wideBalls,
      double average,
      double strikeRate,
      double economyRate});
}

/// @nodoc
class _$BowlingStatCopyWithImpl<$Res, $Val extends BowlingStat>
    implements $BowlingStatCopyWith<$Res> {
  _$BowlingStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BowlingStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? innings = null,
    Object? wicketTaken = null,
    Object? balls = null,
    Object? runsConceded = null,
    Object? maiden = null,
    Object? noBalls = null,
    Object? wideBalls = null,
    Object? average = null,
    Object? strikeRate = null,
    Object? economyRate = null,
  }) {
    return _then(_value.copyWith(
      innings: null == innings
          ? _value.innings
          : innings // ignore: cast_nullable_to_non_nullable
              as int,
      wicketTaken: null == wicketTaken
          ? _value.wicketTaken
          : wicketTaken // ignore: cast_nullable_to_non_nullable
              as int,
      balls: null == balls
          ? _value.balls
          : balls // ignore: cast_nullable_to_non_nullable
              as int,
      runsConceded: null == runsConceded
          ? _value.runsConceded
          : runsConceded // ignore: cast_nullable_to_non_nullable
              as int,
      maiden: null == maiden
          ? _value.maiden
          : maiden // ignore: cast_nullable_to_non_nullable
              as int,
      noBalls: null == noBalls
          ? _value.noBalls
          : noBalls // ignore: cast_nullable_to_non_nullable
              as int,
      wideBalls: null == wideBalls
          ? _value.wideBalls
          : wideBalls // ignore: cast_nullable_to_non_nullable
              as int,
      average: null == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      strikeRate: null == strikeRate
          ? _value.strikeRate
          : strikeRate // ignore: cast_nullable_to_non_nullable
              as double,
      economyRate: null == economyRate
          ? _value.economyRate
          : economyRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BowlingStatImplCopyWith<$Res>
    implements $BowlingStatCopyWith<$Res> {
  factory _$$BowlingStatImplCopyWith(
          _$BowlingStatImpl value, $Res Function(_$BowlingStatImpl) then) =
      __$$BowlingStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int innings,
      int wicketTaken,
      int balls,
      int runsConceded,
      int maiden,
      int noBalls,
      int wideBalls,
      double average,
      double strikeRate,
      double economyRate});
}

/// @nodoc
class __$$BowlingStatImplCopyWithImpl<$Res>
    extends _$BowlingStatCopyWithImpl<$Res, _$BowlingStatImpl>
    implements _$$BowlingStatImplCopyWith<$Res> {
  __$$BowlingStatImplCopyWithImpl(
      _$BowlingStatImpl _value, $Res Function(_$BowlingStatImpl) _then)
      : super(_value, _then);

  /// Create a copy of BowlingStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? innings = null,
    Object? wicketTaken = null,
    Object? balls = null,
    Object? runsConceded = null,
    Object? maiden = null,
    Object? noBalls = null,
    Object? wideBalls = null,
    Object? average = null,
    Object? strikeRate = null,
    Object? economyRate = null,
  }) {
    return _then(_$BowlingStatImpl(
      innings: null == innings
          ? _value.innings
          : innings // ignore: cast_nullable_to_non_nullable
              as int,
      wicketTaken: null == wicketTaken
          ? _value.wicketTaken
          : wicketTaken // ignore: cast_nullable_to_non_nullable
              as int,
      balls: null == balls
          ? _value.balls
          : balls // ignore: cast_nullable_to_non_nullable
              as int,
      runsConceded: null == runsConceded
          ? _value.runsConceded
          : runsConceded // ignore: cast_nullable_to_non_nullable
              as int,
      maiden: null == maiden
          ? _value.maiden
          : maiden // ignore: cast_nullable_to_non_nullable
              as int,
      noBalls: null == noBalls
          ? _value.noBalls
          : noBalls // ignore: cast_nullable_to_non_nullable
              as int,
      wideBalls: null == wideBalls
          ? _value.wideBalls
          : wideBalls // ignore: cast_nullable_to_non_nullable
              as int,
      average: null == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      strikeRate: null == strikeRate
          ? _value.strikeRate
          : strikeRate // ignore: cast_nullable_to_non_nullable
              as double,
      economyRate: null == economyRate
          ? _value.economyRate
          : economyRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BowlingStatImpl implements _BowlingStat {
  const _$BowlingStatImpl(
      {this.innings = 0,
      this.wicketTaken = 0,
      this.balls = 0,
      this.runsConceded = 0,
      this.maiden = 0,
      this.noBalls = 0,
      this.wideBalls = 0,
      this.average = 0.0,
      this.strikeRate = 0.0,
      this.economyRate = 0.0});

  factory _$BowlingStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$BowlingStatImplFromJson(json);

  @override
  @JsonKey()
  final int innings;
  @override
  @JsonKey()
  final int wicketTaken;
  @override
  @JsonKey()
  final int balls;
  @override
  @JsonKey()
  final int runsConceded;
  @override
  @JsonKey()
  final int maiden;
  @override
  @JsonKey()
  final int noBalls;
  @override
  @JsonKey()
  final int wideBalls;
  @override
  @JsonKey()
  final double average;
  @override
  @JsonKey()
  final double strikeRate;
  @override
  @JsonKey()
  final double economyRate;

  @override
  String toString() {
    return 'BowlingStat(innings: $innings, wicketTaken: $wicketTaken, balls: $balls, runsConceded: $runsConceded, maiden: $maiden, noBalls: $noBalls, wideBalls: $wideBalls, average: $average, strikeRate: $strikeRate, economyRate: $economyRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BowlingStatImpl &&
            (identical(other.innings, innings) || other.innings == innings) &&
            (identical(other.wicketTaken, wicketTaken) ||
                other.wicketTaken == wicketTaken) &&
            (identical(other.balls, balls) || other.balls == balls) &&
            (identical(other.runsConceded, runsConceded) ||
                other.runsConceded == runsConceded) &&
            (identical(other.maiden, maiden) || other.maiden == maiden) &&
            (identical(other.noBalls, noBalls) || other.noBalls == noBalls) &&
            (identical(other.wideBalls, wideBalls) ||
                other.wideBalls == wideBalls) &&
            (identical(other.average, average) || other.average == average) &&
            (identical(other.strikeRate, strikeRate) ||
                other.strikeRate == strikeRate) &&
            (identical(other.economyRate, economyRate) ||
                other.economyRate == economyRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      innings,
      wicketTaken,
      balls,
      runsConceded,
      maiden,
      noBalls,
      wideBalls,
      average,
      strikeRate,
      economyRate);

  /// Create a copy of BowlingStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BowlingStatImplCopyWith<_$BowlingStatImpl> get copyWith =>
      __$$BowlingStatImplCopyWithImpl<_$BowlingStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BowlingStatImplToJson(
      this,
    );
  }
}

abstract class _BowlingStat implements BowlingStat {
  const factory _BowlingStat(
      {final int innings,
      final int wicketTaken,
      final int balls,
      final int runsConceded,
      final int maiden,
      final int noBalls,
      final int wideBalls,
      final double average,
      final double strikeRate,
      final double economyRate}) = _$BowlingStatImpl;

  factory _BowlingStat.fromJson(Map<String, dynamic> json) =
      _$BowlingStatImpl.fromJson;

  @override
  int get innings;
  @override
  int get wicketTaken;
  @override
  int get balls;
  @override
  int get runsConceded;
  @override
  int get maiden;
  @override
  int get noBalls;
  @override
  int get wideBalls;
  @override
  double get average;
  @override
  double get strikeRate;
  @override
  double get economyRate;

  /// Create a copy of BowlingStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BowlingStatImplCopyWith<_$BowlingStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FieldingStat _$FieldingStatFromJson(Map<String, dynamic> json) {
  return _FieldingStat.fromJson(json);
}

/// @nodoc
mixin _$FieldingStat {
  int get catches => throw _privateConstructorUsedError;
  int get runOut => throw _privateConstructorUsedError;
  int get stumping => throw _privateConstructorUsedError;

  /// Serializes this FieldingStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FieldingStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FieldingStatCopyWith<FieldingStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldingStatCopyWith<$Res> {
  factory $FieldingStatCopyWith(
          FieldingStat value, $Res Function(FieldingStat) then) =
      _$FieldingStatCopyWithImpl<$Res, FieldingStat>;
  @useResult
  $Res call({int catches, int runOut, int stumping});
}

/// @nodoc
class _$FieldingStatCopyWithImpl<$Res, $Val extends FieldingStat>
    implements $FieldingStatCopyWith<$Res> {
  _$FieldingStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FieldingStat
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
abstract class _$$FieldingStatImplCopyWith<$Res>
    implements $FieldingStatCopyWith<$Res> {
  factory _$$FieldingStatImplCopyWith(
          _$FieldingStatImpl value, $Res Function(_$FieldingStatImpl) then) =
      __$$FieldingStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int catches, int runOut, int stumping});
}

/// @nodoc
class __$$FieldingStatImplCopyWithImpl<$Res>
    extends _$FieldingStatCopyWithImpl<$Res, _$FieldingStatImpl>
    implements _$$FieldingStatImplCopyWith<$Res> {
  __$$FieldingStatImplCopyWithImpl(
      _$FieldingStatImpl _value, $Res Function(_$FieldingStatImpl) _then)
      : super(_value, _then);

  /// Create a copy of FieldingStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? catches = null,
    Object? runOut = null,
    Object? stumping = null,
  }) {
    return _then(_$FieldingStatImpl(
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
class _$FieldingStatImpl implements _FieldingStat {
  const _$FieldingStatImpl(
      {this.catches = 0, this.runOut = 0, this.stumping = 0});

  factory _$FieldingStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldingStatImplFromJson(json);

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
    return 'FieldingStat(catches: $catches, runOut: $runOut, stumping: $stumping)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldingStatImpl &&
            (identical(other.catches, catches) || other.catches == catches) &&
            (identical(other.runOut, runOut) || other.runOut == runOut) &&
            (identical(other.stumping, stumping) ||
                other.stumping == stumping));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, catches, runOut, stumping);

  /// Create a copy of FieldingStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldingStatImplCopyWith<_$FieldingStatImpl> get copyWith =>
      __$$FieldingStatImplCopyWithImpl<_$FieldingStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldingStatImplToJson(
      this,
    );
  }
}

abstract class _FieldingStat implements FieldingStat {
  const factory _FieldingStat(
      {final int catches,
      final int runOut,
      final int stumping}) = _$FieldingStatImpl;

  factory _FieldingStat.fromJson(Map<String, dynamic> json) =
      _$FieldingStatImpl.fromJson;

  @override
  int get catches;
  @override
  int get runOut;
  @override
  int get stumping;

  /// Create a copy of FieldingStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FieldingStatImplCopyWith<_$FieldingStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OverStatModel _$OverStatModelFromJson(Map<String, dynamic> json) {
  return _OverStatModel.fromJson(json);
}

/// @nodoc
mixin _$OverStatModel {
  int get run => throw _privateConstructorUsedError;
  int get wicket => throw _privateConstructorUsedError;
  int get extra => throw _privateConstructorUsedError;

  /// Serializes this OverStatModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OverStatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OverStatModelCopyWith<OverStatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverStatModelCopyWith<$Res> {
  factory $OverStatModelCopyWith(
          OverStatModel value, $Res Function(OverStatModel) then) =
      _$OverStatModelCopyWithImpl<$Res, OverStatModel>;
  @useResult
  $Res call({int run, int wicket, int extra});
}

/// @nodoc
class _$OverStatModelCopyWithImpl<$Res, $Val extends OverStatModel>
    implements $OverStatModelCopyWith<$Res> {
  _$OverStatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OverStatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? run = null,
    Object? wicket = null,
    Object? extra = null,
  }) {
    return _then(_value.copyWith(
      run: null == run
          ? _value.run
          : run // ignore: cast_nullable_to_non_nullable
              as int,
      wicket: null == wicket
          ? _value.wicket
          : wicket // ignore: cast_nullable_to_non_nullable
              as int,
      extra: null == extra
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OverStatModelImplCopyWith<$Res>
    implements $OverStatModelCopyWith<$Res> {
  factory _$$OverStatModelImplCopyWith(
          _$OverStatModelImpl value, $Res Function(_$OverStatModelImpl) then) =
      __$$OverStatModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int run, int wicket, int extra});
}

/// @nodoc
class __$$OverStatModelImplCopyWithImpl<$Res>
    extends _$OverStatModelCopyWithImpl<$Res, _$OverStatModelImpl>
    implements _$$OverStatModelImplCopyWith<$Res> {
  __$$OverStatModelImplCopyWithImpl(
      _$OverStatModelImpl _value, $Res Function(_$OverStatModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of OverStatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? run = null,
    Object? wicket = null,
    Object? extra = null,
  }) {
    return _then(_$OverStatModelImpl(
      run: null == run
          ? _value.run
          : run // ignore: cast_nullable_to_non_nullable
              as int,
      wicket: null == wicket
          ? _value.wicket
          : wicket // ignore: cast_nullable_to_non_nullable
              as int,
      extra: null == extra
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OverStatModelImpl implements _OverStatModel {
  const _$OverStatModelImpl({this.run = 0, this.wicket = 0, this.extra = 0});

  factory _$OverStatModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverStatModelImplFromJson(json);

  @override
  @JsonKey()
  final int run;
  @override
  @JsonKey()
  final int wicket;
  @override
  @JsonKey()
  final int extra;

  @override
  String toString() {
    return 'OverStatModel(run: $run, wicket: $wicket, extra: $extra)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverStatModelImpl &&
            (identical(other.run, run) || other.run == run) &&
            (identical(other.wicket, wicket) || other.wicket == wicket) &&
            (identical(other.extra, extra) || other.extra == extra));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, run, wicket, extra);

  /// Create a copy of OverStatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OverStatModelImplCopyWith<_$OverStatModelImpl> get copyWith =>
      __$$OverStatModelImplCopyWithImpl<_$OverStatModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OverStatModelImplToJson(
      this,
    );
  }
}

abstract class _OverStatModel implements OverStatModel {
  const factory _OverStatModel(
      {final int run, final int wicket, final int extra}) = _$OverStatModelImpl;

  factory _OverStatModel.fromJson(Map<String, dynamic> json) =
      _$OverStatModelImpl.fromJson;

  @override
  int get run;
  @override
  int get wicket;
  @override
  int get extra;

  /// Create a copy of OverStatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OverStatModelImplCopyWith<_$OverStatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamRunStat _$TeamRunStatFromJson(Map<String, dynamic> json) {
  return _TeamRunStat.fromJson(json);
}

/// @nodoc
mixin _$TeamRunStat {
  String get teamName => throw _privateConstructorUsedError;
  int get run => throw _privateConstructorUsedError;
  int get wicket => throw _privateConstructorUsedError;
  double get over => throw _privateConstructorUsedError;

  /// Serializes this TeamRunStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamRunStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamRunStatCopyWith<TeamRunStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamRunStatCopyWith<$Res> {
  factory $TeamRunStatCopyWith(
          TeamRunStat value, $Res Function(TeamRunStat) then) =
      _$TeamRunStatCopyWithImpl<$Res, TeamRunStat>;
  @useResult
  $Res call({String teamName, int run, int wicket, double over});
}

/// @nodoc
class _$TeamRunStatCopyWithImpl<$Res, $Val extends TeamRunStat>
    implements $TeamRunStatCopyWith<$Res> {
  _$TeamRunStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamRunStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamName = null,
    Object? run = null,
    Object? wicket = null,
    Object? over = null,
  }) {
    return _then(_value.copyWith(
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      run: null == run
          ? _value.run
          : run // ignore: cast_nullable_to_non_nullable
              as int,
      wicket: null == wicket
          ? _value.wicket
          : wicket // ignore: cast_nullable_to_non_nullable
              as int,
      over: null == over
          ? _value.over
          : over // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamRunStatImplCopyWith<$Res>
    implements $TeamRunStatCopyWith<$Res> {
  factory _$$TeamRunStatImplCopyWith(
          _$TeamRunStatImpl value, $Res Function(_$TeamRunStatImpl) then) =
      __$$TeamRunStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String teamName, int run, int wicket, double over});
}

/// @nodoc
class __$$TeamRunStatImplCopyWithImpl<$Res>
    extends _$TeamRunStatCopyWithImpl<$Res, _$TeamRunStatImpl>
    implements _$$TeamRunStatImplCopyWith<$Res> {
  __$$TeamRunStatImplCopyWithImpl(
      _$TeamRunStatImpl _value, $Res Function(_$TeamRunStatImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeamRunStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamName = null,
    Object? run = null,
    Object? wicket = null,
    Object? over = null,
  }) {
    return _then(_$TeamRunStatImpl(
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      run: null == run
          ? _value.run
          : run // ignore: cast_nullable_to_non_nullable
              as int,
      wicket: null == wicket
          ? _value.wicket
          : wicket // ignore: cast_nullable_to_non_nullable
              as int,
      over: null == over
          ? _value.over
          : over // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamRunStatImpl implements _TeamRunStat {
  const _$TeamRunStatImpl(
      {this.teamName = "", this.run = 0, this.wicket = 0, this.over = 0});

  factory _$TeamRunStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamRunStatImplFromJson(json);

  @override
  @JsonKey()
  final String teamName;
  @override
  @JsonKey()
  final int run;
  @override
  @JsonKey()
  final int wicket;
  @override
  @JsonKey()
  final double over;

  @override
  String toString() {
    return 'TeamRunStat(teamName: $teamName, run: $run, wicket: $wicket, over: $over)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamRunStatImpl &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.run, run) || other.run == run) &&
            (identical(other.wicket, wicket) || other.wicket == wicket) &&
            (identical(other.over, over) || other.over == over));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, teamName, run, wicket, over);

  /// Create a copy of TeamRunStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamRunStatImplCopyWith<_$TeamRunStatImpl> get copyWith =>
      __$$TeamRunStatImplCopyWithImpl<_$TeamRunStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamRunStatImplToJson(
      this,
    );
  }
}

abstract class _TeamRunStat implements TeamRunStat {
  const factory _TeamRunStat(
      {final String teamName,
      final int run,
      final int wicket,
      final double over}) = _$TeamRunStatImpl;

  factory _TeamRunStat.fromJson(Map<String, dynamic> json) =
      _$TeamRunStatImpl.fromJson;

  @override
  String get teamName;
  @override
  int get run;
  @override
  int get wicket;
  @override
  double get over;

  /// Create a copy of TeamRunStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamRunStatImplCopyWith<_$TeamRunStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OverSummary {
  String get inning_id => throw _privateConstructorUsedError;
  String get team_id => throw _privateConstructorUsedError;
  List<BallScoreModel> get balls => throw _privateConstructorUsedError;
  BowlerSummary get bowler => throw _privateConstructorUsedError;
  BatsmanSummary get striker => throw _privateConstructorUsedError;
  BatsmanSummary get nonStriker => throw _privateConstructorUsedError;
  List<BatsmanSummary> get outPlayers => throw _privateConstructorUsedError;
  int get overNumber => throw _privateConstructorUsedError;
  ExtraSummary get extrasSummary => throw _privateConstructorUsedError;
  int get totalRuns => throw _privateConstructorUsedError;
  int get totalWickets => throw _privateConstructorUsedError;

  /// Create a copy of OverSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OverSummaryCopyWith<OverSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverSummaryCopyWith<$Res> {
  factory $OverSummaryCopyWith(
          OverSummary value, $Res Function(OverSummary) then) =
      _$OverSummaryCopyWithImpl<$Res, OverSummary>;
  @useResult
  $Res call(
      {String inning_id,
      String team_id,
      List<BallScoreModel> balls,
      BowlerSummary bowler,
      BatsmanSummary striker,
      BatsmanSummary nonStriker,
      List<BatsmanSummary> outPlayers,
      int overNumber,
      ExtraSummary extrasSummary,
      int totalRuns,
      int totalWickets});

  $BowlerSummaryCopyWith<$Res> get bowler;
  $BatsmanSummaryCopyWith<$Res> get striker;
  $BatsmanSummaryCopyWith<$Res> get nonStriker;
  $ExtraSummaryCopyWith<$Res> get extrasSummary;
}

/// @nodoc
class _$OverSummaryCopyWithImpl<$Res, $Val extends OverSummary>
    implements $OverSummaryCopyWith<$Res> {
  _$OverSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OverSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inning_id = null,
    Object? team_id = null,
    Object? balls = null,
    Object? bowler = null,
    Object? striker = null,
    Object? nonStriker = null,
    Object? outPlayers = null,
    Object? overNumber = null,
    Object? extrasSummary = null,
    Object? totalRuns = null,
    Object? totalWickets = null,
  }) {
    return _then(_value.copyWith(
      inning_id: null == inning_id
          ? _value.inning_id
          : inning_id // ignore: cast_nullable_to_non_nullable
              as String,
      team_id: null == team_id
          ? _value.team_id
          : team_id // ignore: cast_nullable_to_non_nullable
              as String,
      balls: null == balls
          ? _value.balls
          : balls // ignore: cast_nullable_to_non_nullable
              as List<BallScoreModel>,
      bowler: null == bowler
          ? _value.bowler
          : bowler // ignore: cast_nullable_to_non_nullable
              as BowlerSummary,
      striker: null == striker
          ? _value.striker
          : striker // ignore: cast_nullable_to_non_nullable
              as BatsmanSummary,
      nonStriker: null == nonStriker
          ? _value.nonStriker
          : nonStriker // ignore: cast_nullable_to_non_nullable
              as BatsmanSummary,
      outPlayers: null == outPlayers
          ? _value.outPlayers
          : outPlayers // ignore: cast_nullable_to_non_nullable
              as List<BatsmanSummary>,
      overNumber: null == overNumber
          ? _value.overNumber
          : overNumber // ignore: cast_nullable_to_non_nullable
              as int,
      extrasSummary: null == extrasSummary
          ? _value.extrasSummary
          : extrasSummary // ignore: cast_nullable_to_non_nullable
              as ExtraSummary,
      totalRuns: null == totalRuns
          ? _value.totalRuns
          : totalRuns // ignore: cast_nullable_to_non_nullable
              as int,
      totalWickets: null == totalWickets
          ? _value.totalWickets
          : totalWickets // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of OverSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BowlerSummaryCopyWith<$Res> get bowler {
    return $BowlerSummaryCopyWith<$Res>(_value.bowler, (value) {
      return _then(_value.copyWith(bowler: value) as $Val);
    });
  }

  /// Create a copy of OverSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BatsmanSummaryCopyWith<$Res> get striker {
    return $BatsmanSummaryCopyWith<$Res>(_value.striker, (value) {
      return _then(_value.copyWith(striker: value) as $Val);
    });
  }

  /// Create a copy of OverSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BatsmanSummaryCopyWith<$Res> get nonStriker {
    return $BatsmanSummaryCopyWith<$Res>(_value.nonStriker, (value) {
      return _then(_value.copyWith(nonStriker: value) as $Val);
    });
  }

  /// Create a copy of OverSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExtraSummaryCopyWith<$Res> get extrasSummary {
    return $ExtraSummaryCopyWith<$Res>(_value.extrasSummary, (value) {
      return _then(_value.copyWith(extrasSummary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OverSummaryImplCopyWith<$Res>
    implements $OverSummaryCopyWith<$Res> {
  factory _$$OverSummaryImplCopyWith(
          _$OverSummaryImpl value, $Res Function(_$OverSummaryImpl) then) =
      __$$OverSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String inning_id,
      String team_id,
      List<BallScoreModel> balls,
      BowlerSummary bowler,
      BatsmanSummary striker,
      BatsmanSummary nonStriker,
      List<BatsmanSummary> outPlayers,
      int overNumber,
      ExtraSummary extrasSummary,
      int totalRuns,
      int totalWickets});

  @override
  $BowlerSummaryCopyWith<$Res> get bowler;
  @override
  $BatsmanSummaryCopyWith<$Res> get striker;
  @override
  $BatsmanSummaryCopyWith<$Res> get nonStriker;
  @override
  $ExtraSummaryCopyWith<$Res> get extrasSummary;
}

/// @nodoc
class __$$OverSummaryImplCopyWithImpl<$Res>
    extends _$OverSummaryCopyWithImpl<$Res, _$OverSummaryImpl>
    implements _$$OverSummaryImplCopyWith<$Res> {
  __$$OverSummaryImplCopyWithImpl(
      _$OverSummaryImpl _value, $Res Function(_$OverSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of OverSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inning_id = null,
    Object? team_id = null,
    Object? balls = null,
    Object? bowler = null,
    Object? striker = null,
    Object? nonStriker = null,
    Object? outPlayers = null,
    Object? overNumber = null,
    Object? extrasSummary = null,
    Object? totalRuns = null,
    Object? totalWickets = null,
  }) {
    return _then(_$OverSummaryImpl(
      inning_id: null == inning_id
          ? _value.inning_id
          : inning_id // ignore: cast_nullable_to_non_nullable
              as String,
      team_id: null == team_id
          ? _value.team_id
          : team_id // ignore: cast_nullable_to_non_nullable
              as String,
      balls: null == balls
          ? _value._balls
          : balls // ignore: cast_nullable_to_non_nullable
              as List<BallScoreModel>,
      bowler: null == bowler
          ? _value.bowler
          : bowler // ignore: cast_nullable_to_non_nullable
              as BowlerSummary,
      striker: null == striker
          ? _value.striker
          : striker // ignore: cast_nullable_to_non_nullable
              as BatsmanSummary,
      nonStriker: null == nonStriker
          ? _value.nonStriker
          : nonStriker // ignore: cast_nullable_to_non_nullable
              as BatsmanSummary,
      outPlayers: null == outPlayers
          ? _value._outPlayers
          : outPlayers // ignore: cast_nullable_to_non_nullable
              as List<BatsmanSummary>,
      overNumber: null == overNumber
          ? _value.overNumber
          : overNumber // ignore: cast_nullable_to_non_nullable
              as int,
      extrasSummary: null == extrasSummary
          ? _value.extrasSummary
          : extrasSummary // ignore: cast_nullable_to_non_nullable
              as ExtraSummary,
      totalRuns: null == totalRuns
          ? _value.totalRuns
          : totalRuns // ignore: cast_nullable_to_non_nullable
              as int,
      totalWickets: null == totalWickets
          ? _value.totalWickets
          : totalWickets // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$OverSummaryImpl implements _OverSummary {
  const _$OverSummaryImpl(
      {this.inning_id = '',
      this.team_id = '',
      final List<BallScoreModel> balls = const [],
      this.bowler = const BowlerSummary(),
      this.striker = const BatsmanSummary(),
      this.nonStriker = const BatsmanSummary(),
      final List<BatsmanSummary> outPlayers = const [],
      this.overNumber = 0,
      this.extrasSummary = const ExtraSummary(),
      this.totalRuns = 0,
      this.totalWickets = 0})
      : _balls = balls,
        _outPlayers = outPlayers;

  @override
  @JsonKey()
  final String inning_id;
  @override
  @JsonKey()
  final String team_id;
  final List<BallScoreModel> _balls;
  @override
  @JsonKey()
  List<BallScoreModel> get balls {
    if (_balls is EqualUnmodifiableListView) return _balls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_balls);
  }

  @override
  @JsonKey()
  final BowlerSummary bowler;
  @override
  @JsonKey()
  final BatsmanSummary striker;
  @override
  @JsonKey()
  final BatsmanSummary nonStriker;
  final List<BatsmanSummary> _outPlayers;
  @override
  @JsonKey()
  List<BatsmanSummary> get outPlayers {
    if (_outPlayers is EqualUnmodifiableListView) return _outPlayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outPlayers);
  }

  @override
  @JsonKey()
  final int overNumber;
  @override
  @JsonKey()
  final ExtraSummary extrasSummary;
  @override
  @JsonKey()
  final int totalRuns;
  @override
  @JsonKey()
  final int totalWickets;

  @override
  String toString() {
    return 'OverSummary(inning_id: $inning_id, team_id: $team_id, balls: $balls, bowler: $bowler, striker: $striker, nonStriker: $nonStriker, outPlayers: $outPlayers, overNumber: $overNumber, extrasSummary: $extrasSummary, totalRuns: $totalRuns, totalWickets: $totalWickets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverSummaryImpl &&
            (identical(other.inning_id, inning_id) ||
                other.inning_id == inning_id) &&
            (identical(other.team_id, team_id) || other.team_id == team_id) &&
            const DeepCollectionEquality().equals(other._balls, _balls) &&
            (identical(other.bowler, bowler) || other.bowler == bowler) &&
            (identical(other.striker, striker) || other.striker == striker) &&
            (identical(other.nonStriker, nonStriker) ||
                other.nonStriker == nonStriker) &&
            const DeepCollectionEquality()
                .equals(other._outPlayers, _outPlayers) &&
            (identical(other.overNumber, overNumber) ||
                other.overNumber == overNumber) &&
            (identical(other.extrasSummary, extrasSummary) ||
                other.extrasSummary == extrasSummary) &&
            (identical(other.totalRuns, totalRuns) ||
                other.totalRuns == totalRuns) &&
            (identical(other.totalWickets, totalWickets) ||
                other.totalWickets == totalWickets));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      inning_id,
      team_id,
      const DeepCollectionEquality().hash(_balls),
      bowler,
      striker,
      nonStriker,
      const DeepCollectionEquality().hash(_outPlayers),
      overNumber,
      extrasSummary,
      totalRuns,
      totalWickets);

  /// Create a copy of OverSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OverSummaryImplCopyWith<_$OverSummaryImpl> get copyWith =>
      __$$OverSummaryImplCopyWithImpl<_$OverSummaryImpl>(this, _$identity);
}

abstract class _OverSummary implements OverSummary {
  const factory _OverSummary(
      {final String inning_id,
      final String team_id,
      final List<BallScoreModel> balls,
      final BowlerSummary bowler,
      final BatsmanSummary striker,
      final BatsmanSummary nonStriker,
      final List<BatsmanSummary> outPlayers,
      final int overNumber,
      final ExtraSummary extrasSummary,
      final int totalRuns,
      final int totalWickets}) = _$OverSummaryImpl;

  @override
  String get inning_id;
  @override
  String get team_id;
  @override
  List<BallScoreModel> get balls;
  @override
  BowlerSummary get bowler;
  @override
  BatsmanSummary get striker;
  @override
  BatsmanSummary get nonStriker;
  @override
  List<BatsmanSummary> get outPlayers;
  @override
  int get overNumber;
  @override
  ExtraSummary get extrasSummary;
  @override
  int get totalRuns;
  @override
  int get totalWickets;

  /// Create a copy of OverSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OverSummaryImplCopyWith<_$OverSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BatsmanSummary {
  UserModel get player => throw _privateConstructorUsedError;
  Player? get ballBy => throw _privateConstructorUsedError;
  Player? get catchBy => throw _privateConstructorUsedError;
  WicketType? get wicketType => throw _privateConstructorUsedError;
  double? get outAtOver => throw _privateConstructorUsedError;
  int get runs => throw _privateConstructorUsedError;
  int get ballFaced => throw _privateConstructorUsedError;
  int get sixes => throw _privateConstructorUsedError;
  int get fours => throw _privateConstructorUsedError;

  /// Create a copy of BatsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BatsmanSummaryCopyWith<BatsmanSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BatsmanSummaryCopyWith<$Res> {
  factory $BatsmanSummaryCopyWith(
          BatsmanSummary value, $Res Function(BatsmanSummary) then) =
      _$BatsmanSummaryCopyWithImpl<$Res, BatsmanSummary>;
  @useResult
  $Res call(
      {UserModel player,
      Player? ballBy,
      Player? catchBy,
      WicketType? wicketType,
      double? outAtOver,
      int runs,
      int ballFaced,
      int sixes,
      int fours});

  $UserModelCopyWith<$Res> get player;
  $PlayerCopyWith<$Res>? get ballBy;
  $PlayerCopyWith<$Res>? get catchBy;
}

/// @nodoc
class _$BatsmanSummaryCopyWithImpl<$Res, $Val extends BatsmanSummary>
    implements $BatsmanSummaryCopyWith<$Res> {
  _$BatsmanSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BatsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? ballBy = freezed,
    Object? catchBy = freezed,
    Object? wicketType = freezed,
    Object? outAtOver = freezed,
    Object? runs = null,
    Object? ballFaced = null,
    Object? sixes = null,
    Object? fours = null,
  }) {
    return _then(_value.copyWith(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as UserModel,
      ballBy: freezed == ballBy
          ? _value.ballBy
          : ballBy // ignore: cast_nullable_to_non_nullable
              as Player?,
      catchBy: freezed == catchBy
          ? _value.catchBy
          : catchBy // ignore: cast_nullable_to_non_nullable
              as Player?,
      wicketType: freezed == wicketType
          ? _value.wicketType
          : wicketType // ignore: cast_nullable_to_non_nullable
              as WicketType?,
      outAtOver: freezed == outAtOver
          ? _value.outAtOver
          : outAtOver // ignore: cast_nullable_to_non_nullable
              as double?,
      runs: null == runs
          ? _value.runs
          : runs // ignore: cast_nullable_to_non_nullable
              as int,
      ballFaced: null == ballFaced
          ? _value.ballFaced
          : ballFaced // ignore: cast_nullable_to_non_nullable
              as int,
      sixes: null == sixes
          ? _value.sixes
          : sixes // ignore: cast_nullable_to_non_nullable
              as int,
      fours: null == fours
          ? _value.fours
          : fours // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of BatsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get player {
    return $UserModelCopyWith<$Res>(_value.player, (value) {
      return _then(_value.copyWith(player: value) as $Val);
    });
  }

  /// Create a copy of BatsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res>? get ballBy {
    if (_value.ballBy == null) {
      return null;
    }

    return $PlayerCopyWith<$Res>(_value.ballBy!, (value) {
      return _then(_value.copyWith(ballBy: value) as $Val);
    });
  }

  /// Create a copy of BatsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res>? get catchBy {
    if (_value.catchBy == null) {
      return null;
    }

    return $PlayerCopyWith<$Res>(_value.catchBy!, (value) {
      return _then(_value.copyWith(catchBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BatsmanSummaryImplCopyWith<$Res>
    implements $BatsmanSummaryCopyWith<$Res> {
  factory _$$BatsmanSummaryImplCopyWith(_$BatsmanSummaryImpl value,
          $Res Function(_$BatsmanSummaryImpl) then) =
      __$$BatsmanSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserModel player,
      Player? ballBy,
      Player? catchBy,
      WicketType? wicketType,
      double? outAtOver,
      int runs,
      int ballFaced,
      int sixes,
      int fours});

  @override
  $UserModelCopyWith<$Res> get player;
  @override
  $PlayerCopyWith<$Res>? get ballBy;
  @override
  $PlayerCopyWith<$Res>? get catchBy;
}

/// @nodoc
class __$$BatsmanSummaryImplCopyWithImpl<$Res>
    extends _$BatsmanSummaryCopyWithImpl<$Res, _$BatsmanSummaryImpl>
    implements _$$BatsmanSummaryImplCopyWith<$Res> {
  __$$BatsmanSummaryImplCopyWithImpl(
      _$BatsmanSummaryImpl _value, $Res Function(_$BatsmanSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of BatsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? ballBy = freezed,
    Object? catchBy = freezed,
    Object? wicketType = freezed,
    Object? outAtOver = freezed,
    Object? runs = null,
    Object? ballFaced = null,
    Object? sixes = null,
    Object? fours = null,
  }) {
    return _then(_$BatsmanSummaryImpl(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as UserModel,
      ballBy: freezed == ballBy
          ? _value.ballBy
          : ballBy // ignore: cast_nullable_to_non_nullable
              as Player?,
      catchBy: freezed == catchBy
          ? _value.catchBy
          : catchBy // ignore: cast_nullable_to_non_nullable
              as Player?,
      wicketType: freezed == wicketType
          ? _value.wicketType
          : wicketType // ignore: cast_nullable_to_non_nullable
              as WicketType?,
      outAtOver: freezed == outAtOver
          ? _value.outAtOver
          : outAtOver // ignore: cast_nullable_to_non_nullable
              as double?,
      runs: null == runs
          ? _value.runs
          : runs // ignore: cast_nullable_to_non_nullable
              as int,
      ballFaced: null == ballFaced
          ? _value.ballFaced
          : ballFaced // ignore: cast_nullable_to_non_nullable
              as int,
      sixes: null == sixes
          ? _value.sixes
          : sixes // ignore: cast_nullable_to_non_nullable
              as int,
      fours: null == fours
          ? _value.fours
          : fours // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BatsmanSummaryImpl implements _BatsmanSummary {
  const _$BatsmanSummaryImpl(
      {this.player = const UserModel(id: ''),
      this.ballBy,
      this.catchBy,
      this.wicketType,
      this.outAtOver,
      this.runs = 0,
      this.ballFaced = 0,
      this.sixes = 0,
      this.fours = 0});

  @override
  @JsonKey()
  final UserModel player;
  @override
  final Player? ballBy;
  @override
  final Player? catchBy;
  @override
  final WicketType? wicketType;
  @override
  final double? outAtOver;
  @override
  @JsonKey()
  final int runs;
  @override
  @JsonKey()
  final int ballFaced;
  @override
  @JsonKey()
  final int sixes;
  @override
  @JsonKey()
  final int fours;

  @override
  String toString() {
    return 'BatsmanSummary(player: $player, ballBy: $ballBy, catchBy: $catchBy, wicketType: $wicketType, outAtOver: $outAtOver, runs: $runs, ballFaced: $ballFaced, sixes: $sixes, fours: $fours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BatsmanSummaryImpl &&
            (identical(other.player, player) || other.player == player) &&
            (identical(other.ballBy, ballBy) || other.ballBy == ballBy) &&
            (identical(other.catchBy, catchBy) || other.catchBy == catchBy) &&
            (identical(other.wicketType, wicketType) ||
                other.wicketType == wicketType) &&
            (identical(other.outAtOver, outAtOver) ||
                other.outAtOver == outAtOver) &&
            (identical(other.runs, runs) || other.runs == runs) &&
            (identical(other.ballFaced, ballFaced) ||
                other.ballFaced == ballFaced) &&
            (identical(other.sixes, sixes) || other.sixes == sixes) &&
            (identical(other.fours, fours) || other.fours == fours));
  }

  @override
  int get hashCode => Object.hash(runtimeType, player, ballBy, catchBy,
      wicketType, outAtOver, runs, ballFaced, sixes, fours);

  /// Create a copy of BatsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BatsmanSummaryImplCopyWith<_$BatsmanSummaryImpl> get copyWith =>
      __$$BatsmanSummaryImplCopyWithImpl<_$BatsmanSummaryImpl>(
          this, _$identity);
}

abstract class _BatsmanSummary implements BatsmanSummary {
  const factory _BatsmanSummary(
      {final UserModel player,
      final Player? ballBy,
      final Player? catchBy,
      final WicketType? wicketType,
      final double? outAtOver,
      final int runs,
      final int ballFaced,
      final int sixes,
      final int fours}) = _$BatsmanSummaryImpl;

  @override
  UserModel get player;
  @override
  Player? get ballBy;
  @override
  Player? get catchBy;
  @override
  WicketType? get wicketType;
  @override
  double? get outAtOver;
  @override
  int get runs;
  @override
  int get ballFaced;
  @override
  int get sixes;
  @override
  int get fours;

  /// Create a copy of BatsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BatsmanSummaryImplCopyWith<_$BatsmanSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BowlerSummary {
  UserModel get player => throw _privateConstructorUsedError;
  int get runsConceded => throw _privateConstructorUsedError;
  int get maiden => throw _privateConstructorUsedError;
  double get overDelivered => throw _privateConstructorUsedError;
  int get wicket => throw _privateConstructorUsedError;
  int get noBalls => throw _privateConstructorUsedError;
  int get wideBalls => throw _privateConstructorUsedError;

  /// Create a copy of BowlerSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BowlerSummaryCopyWith<BowlerSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BowlerSummaryCopyWith<$Res> {
  factory $BowlerSummaryCopyWith(
          BowlerSummary value, $Res Function(BowlerSummary) then) =
      _$BowlerSummaryCopyWithImpl<$Res, BowlerSummary>;
  @useResult
  $Res call(
      {UserModel player,
      int runsConceded,
      int maiden,
      double overDelivered,
      int wicket,
      int noBalls,
      int wideBalls});

  $UserModelCopyWith<$Res> get player;
}

/// @nodoc
class _$BowlerSummaryCopyWithImpl<$Res, $Val extends BowlerSummary>
    implements $BowlerSummaryCopyWith<$Res> {
  _$BowlerSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BowlerSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? runsConceded = null,
    Object? maiden = null,
    Object? overDelivered = null,
    Object? wicket = null,
    Object? noBalls = null,
    Object? wideBalls = null,
  }) {
    return _then(_value.copyWith(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as UserModel,
      runsConceded: null == runsConceded
          ? _value.runsConceded
          : runsConceded // ignore: cast_nullable_to_non_nullable
              as int,
      maiden: null == maiden
          ? _value.maiden
          : maiden // ignore: cast_nullable_to_non_nullable
              as int,
      overDelivered: null == overDelivered
          ? _value.overDelivered
          : overDelivered // ignore: cast_nullable_to_non_nullable
              as double,
      wicket: null == wicket
          ? _value.wicket
          : wicket // ignore: cast_nullable_to_non_nullable
              as int,
      noBalls: null == noBalls
          ? _value.noBalls
          : noBalls // ignore: cast_nullable_to_non_nullable
              as int,
      wideBalls: null == wideBalls
          ? _value.wideBalls
          : wideBalls // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of BowlerSummary
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
abstract class _$$BowlerSummaryImplCopyWith<$Res>
    implements $BowlerSummaryCopyWith<$Res> {
  factory _$$BowlerSummaryImplCopyWith(
          _$BowlerSummaryImpl value, $Res Function(_$BowlerSummaryImpl) then) =
      __$$BowlerSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserModel player,
      int runsConceded,
      int maiden,
      double overDelivered,
      int wicket,
      int noBalls,
      int wideBalls});

  @override
  $UserModelCopyWith<$Res> get player;
}

/// @nodoc
class __$$BowlerSummaryImplCopyWithImpl<$Res>
    extends _$BowlerSummaryCopyWithImpl<$Res, _$BowlerSummaryImpl>
    implements _$$BowlerSummaryImplCopyWith<$Res> {
  __$$BowlerSummaryImplCopyWithImpl(
      _$BowlerSummaryImpl _value, $Res Function(_$BowlerSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of BowlerSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? runsConceded = null,
    Object? maiden = null,
    Object? overDelivered = null,
    Object? wicket = null,
    Object? noBalls = null,
    Object? wideBalls = null,
  }) {
    return _then(_$BowlerSummaryImpl(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as UserModel,
      runsConceded: null == runsConceded
          ? _value.runsConceded
          : runsConceded // ignore: cast_nullable_to_non_nullable
              as int,
      maiden: null == maiden
          ? _value.maiden
          : maiden // ignore: cast_nullable_to_non_nullable
              as int,
      overDelivered: null == overDelivered
          ? _value.overDelivered
          : overDelivered // ignore: cast_nullable_to_non_nullable
              as double,
      wicket: null == wicket
          ? _value.wicket
          : wicket // ignore: cast_nullable_to_non_nullable
              as int,
      noBalls: null == noBalls
          ? _value.noBalls
          : noBalls // ignore: cast_nullable_to_non_nullable
              as int,
      wideBalls: null == wideBalls
          ? _value.wideBalls
          : wideBalls // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BowlerSummaryImpl implements _BowlerSummary {
  const _$BowlerSummaryImpl(
      {this.player = const UserModel(id: ''),
      this.runsConceded = 0,
      this.maiden = 0,
      this.overDelivered = 0,
      this.wicket = 0,
      this.noBalls = 0,
      this.wideBalls = 0});

  @override
  @JsonKey()
  final UserModel player;
  @override
  @JsonKey()
  final int runsConceded;
  @override
  @JsonKey()
  final int maiden;
  @override
  @JsonKey()
  final double overDelivered;
  @override
  @JsonKey()
  final int wicket;
  @override
  @JsonKey()
  final int noBalls;
  @override
  @JsonKey()
  final int wideBalls;

  @override
  String toString() {
    return 'BowlerSummary(player: $player, runsConceded: $runsConceded, maiden: $maiden, overDelivered: $overDelivered, wicket: $wicket, noBalls: $noBalls, wideBalls: $wideBalls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BowlerSummaryImpl &&
            (identical(other.player, player) || other.player == player) &&
            (identical(other.runsConceded, runsConceded) ||
                other.runsConceded == runsConceded) &&
            (identical(other.maiden, maiden) || other.maiden == maiden) &&
            (identical(other.overDelivered, overDelivered) ||
                other.overDelivered == overDelivered) &&
            (identical(other.wicket, wicket) || other.wicket == wicket) &&
            (identical(other.noBalls, noBalls) || other.noBalls == noBalls) &&
            (identical(other.wideBalls, wideBalls) ||
                other.wideBalls == wideBalls));
  }

  @override
  int get hashCode => Object.hash(runtimeType, player, runsConceded, maiden,
      overDelivered, wicket, noBalls, wideBalls);

  /// Create a copy of BowlerSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BowlerSummaryImplCopyWith<_$BowlerSummaryImpl> get copyWith =>
      __$$BowlerSummaryImplCopyWithImpl<_$BowlerSummaryImpl>(this, _$identity);
}

abstract class _BowlerSummary implements BowlerSummary {
  const factory _BowlerSummary(
      {final UserModel player,
      final int runsConceded,
      final int maiden,
      final double overDelivered,
      final int wicket,
      final int noBalls,
      final int wideBalls}) = _$BowlerSummaryImpl;

  @override
  UserModel get player;
  @override
  int get runsConceded;
  @override
  int get maiden;
  @override
  double get overDelivered;
  @override
  int get wicket;
  @override
  int get noBalls;
  @override
  int get wideBalls;

  /// Create a copy of BowlerSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BowlerSummaryImplCopyWith<_$BowlerSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Player {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerCopyWith<Player> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res, Player>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res, $Val extends Player>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerImplCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$$PlayerImplCopyWith(
          _$PlayerImpl value, $Res Function(_$PlayerImpl) then) =
      __$$PlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$PlayerImplCopyWithImpl<$Res>
    extends _$PlayerCopyWithImpl<$Res, _$PlayerImpl>
    implements _$$PlayerImplCopyWith<$Res> {
  __$$PlayerImplCopyWithImpl(
      _$PlayerImpl _value, $Res Function(_$PlayerImpl) _then)
      : super(_value, _then);

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$PlayerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PlayerImpl implements _Player {
  const _$PlayerImpl({this.id = "", this.name = ""});

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;

  @override
  String toString() {
    return 'Player(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      __$$PlayerImplCopyWithImpl<_$PlayerImpl>(this, _$identity);
}

abstract class _Player implements Player {
  const factory _Player({final String id, final String name}) = _$PlayerImpl;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExtraSummary {
  int get bye => throw _privateConstructorUsedError;
  int get legBye => throw _privateConstructorUsedError;
  int get noBall => throw _privateConstructorUsedError;
  int get wideBall => throw _privateConstructorUsedError;
  int get penalty => throw _privateConstructorUsedError;

  /// Create a copy of ExtraSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExtraSummaryCopyWith<ExtraSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtraSummaryCopyWith<$Res> {
  factory $ExtraSummaryCopyWith(
          ExtraSummary value, $Res Function(ExtraSummary) then) =
      _$ExtraSummaryCopyWithImpl<$Res, ExtraSummary>;
  @useResult
  $Res call({int bye, int legBye, int noBall, int wideBall, int penalty});
}

/// @nodoc
class _$ExtraSummaryCopyWithImpl<$Res, $Val extends ExtraSummary>
    implements $ExtraSummaryCopyWith<$Res> {
  _$ExtraSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExtraSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bye = null,
    Object? legBye = null,
    Object? noBall = null,
    Object? wideBall = null,
    Object? penalty = null,
  }) {
    return _then(_value.copyWith(
      bye: null == bye
          ? _value.bye
          : bye // ignore: cast_nullable_to_non_nullable
              as int,
      legBye: null == legBye
          ? _value.legBye
          : legBye // ignore: cast_nullable_to_non_nullable
              as int,
      noBall: null == noBall
          ? _value.noBall
          : noBall // ignore: cast_nullable_to_non_nullable
              as int,
      wideBall: null == wideBall
          ? _value.wideBall
          : wideBall // ignore: cast_nullable_to_non_nullable
              as int,
      penalty: null == penalty
          ? _value.penalty
          : penalty // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExtraSummaryImplCopyWith<$Res>
    implements $ExtraSummaryCopyWith<$Res> {
  factory _$$ExtraSummaryImplCopyWith(
          _$ExtraSummaryImpl value, $Res Function(_$ExtraSummaryImpl) then) =
      __$$ExtraSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int bye, int legBye, int noBall, int wideBall, int penalty});
}

/// @nodoc
class __$$ExtraSummaryImplCopyWithImpl<$Res>
    extends _$ExtraSummaryCopyWithImpl<$Res, _$ExtraSummaryImpl>
    implements _$$ExtraSummaryImplCopyWith<$Res> {
  __$$ExtraSummaryImplCopyWithImpl(
      _$ExtraSummaryImpl _value, $Res Function(_$ExtraSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExtraSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bye = null,
    Object? legBye = null,
    Object? noBall = null,
    Object? wideBall = null,
    Object? penalty = null,
  }) {
    return _then(_$ExtraSummaryImpl(
      bye: null == bye
          ? _value.bye
          : bye // ignore: cast_nullable_to_non_nullable
              as int,
      legBye: null == legBye
          ? _value.legBye
          : legBye // ignore: cast_nullable_to_non_nullable
              as int,
      noBall: null == noBall
          ? _value.noBall
          : noBall // ignore: cast_nullable_to_non_nullable
              as int,
      wideBall: null == wideBall
          ? _value.wideBall
          : wideBall // ignore: cast_nullable_to_non_nullable
              as int,
      penalty: null == penalty
          ? _value.penalty
          : penalty // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ExtraSummaryImpl implements _ExtraSummary {
  const _$ExtraSummaryImpl(
      {this.bye = 0,
      this.legBye = 0,
      this.noBall = 0,
      this.wideBall = 0,
      this.penalty = 0});

  @override
  @JsonKey()
  final int bye;
  @override
  @JsonKey()
  final int legBye;
  @override
  @JsonKey()
  final int noBall;
  @override
  @JsonKey()
  final int wideBall;
  @override
  @JsonKey()
  final int penalty;

  @override
  String toString() {
    return 'ExtraSummary(bye: $bye, legBye: $legBye, noBall: $noBall, wideBall: $wideBall, penalty: $penalty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtraSummaryImpl &&
            (identical(other.bye, bye) || other.bye == bye) &&
            (identical(other.legBye, legBye) || other.legBye == legBye) &&
            (identical(other.noBall, noBall) || other.noBall == noBall) &&
            (identical(other.wideBall, wideBall) ||
                other.wideBall == wideBall) &&
            (identical(other.penalty, penalty) || other.penalty == penalty));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, bye, legBye, noBall, wideBall, penalty);

  /// Create a copy of ExtraSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtraSummaryImplCopyWith<_$ExtraSummaryImpl> get copyWith =>
      __$$ExtraSummaryImplCopyWithImpl<_$ExtraSummaryImpl>(this, _$identity);
}

abstract class _ExtraSummary implements ExtraSummary {
  const factory _ExtraSummary(
      {final int bye,
      final int legBye,
      final int noBall,
      final int wideBall,
      final int penalty}) = _$ExtraSummaryImpl;

  @override
  int get bye;
  @override
  int get legBye;
  @override
  int get noBall;
  @override
  int get wideBall;
  @override
  int get penalty;

  /// Create a copy of ExtraSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExtraSummaryImplCopyWith<_$ExtraSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
