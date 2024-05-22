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
  String? get id => throw _privateConstructorUsedError;
  String get inning_id => throw _privateConstructorUsedError;
  int get over_number => throw _privateConstructorUsedError;
  int get ball_number => throw _privateConstructorUsedError;
  String get bowler_id => throw _privateConstructorUsedError;
  String get batsman_id => throw _privateConstructorUsedError;
  String get non_striker_id => throw _privateConstructorUsedError;
  int get runs_scored => throw _privateConstructorUsedError;
  ExtrasType? get extras_type => throw _privateConstructorUsedError;
  int? get extras_awarded => throw _privateConstructorUsedError;
  WicketType? get wicket_type => throw _privateConstructorUsedError;
  String? get player_out_id => throw _privateConstructorUsedError;
  String? get wicket_taker_id => throw _privateConstructorUsedError;
  bool get is_four => throw _privateConstructorUsedError;
  bool get is_six => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      {String? id,
      String inning_id,
      int over_number,
      int ball_number,
      String bowler_id,
      String batsman_id,
      String non_striker_id,
      int runs_scored,
      ExtrasType? extras_type,
      int? extras_awarded,
      WicketType? wicket_type,
      String? player_out_id,
      String? wicket_taker_id,
      bool is_four,
      bool is_six,
      DateTime time});
}

/// @nodoc
class _$BallScoreModelCopyWithImpl<$Res, $Val extends BallScoreModel>
    implements $BallScoreModelCopyWith<$Res> {
  _$BallScoreModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? inning_id = null,
    Object? over_number = null,
    Object? ball_number = null,
    Object? bowler_id = null,
    Object? batsman_id = null,
    Object? non_striker_id = null,
    Object? runs_scored = null,
    Object? extras_type = freezed,
    Object? extras_awarded = freezed,
    Object? wicket_type = freezed,
    Object? player_out_id = freezed,
    Object? wicket_taker_id = freezed,
    Object? is_four = null,
    Object? is_six = null,
    Object? time = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      inning_id: null == inning_id
          ? _value.inning_id
          : inning_id // ignore: cast_nullable_to_non_nullable
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
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      {String? id,
      String inning_id,
      int over_number,
      int ball_number,
      String bowler_id,
      String batsman_id,
      String non_striker_id,
      int runs_scored,
      ExtrasType? extras_type,
      int? extras_awarded,
      WicketType? wicket_type,
      String? player_out_id,
      String? wicket_taker_id,
      bool is_four,
      bool is_six,
      DateTime time});
}

/// @nodoc
class __$$BallScoreModelImplCopyWithImpl<$Res>
    extends _$BallScoreModelCopyWithImpl<$Res, _$BallScoreModelImpl>
    implements _$$BallScoreModelImplCopyWith<$Res> {
  __$$BallScoreModelImplCopyWithImpl(
      _$BallScoreModelImpl _value, $Res Function(_$BallScoreModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? inning_id = null,
    Object? over_number = null,
    Object? ball_number = null,
    Object? bowler_id = null,
    Object? batsman_id = null,
    Object? non_striker_id = null,
    Object? runs_scored = null,
    Object? extras_type = freezed,
    Object? extras_awarded = freezed,
    Object? wicket_type = freezed,
    Object? player_out_id = freezed,
    Object? wicket_taker_id = freezed,
    Object? is_four = null,
    Object? is_six = null,
    Object? time = null,
  }) {
    return _then(_$BallScoreModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      inning_id: null == inning_id
          ? _value.inning_id
          : inning_id // ignore: cast_nullable_to_non_nullable
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
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BallScoreModelImpl implements _BallScoreModel {
  const _$BallScoreModelImpl(
      {this.id,
      required this.inning_id,
      required this.over_number,
      required this.ball_number,
      required this.bowler_id,
      required this.batsman_id,
      required this.non_striker_id,
      required this.runs_scored,
      this.extras_type,
      this.extras_awarded,
      this.wicket_type,
      this.player_out_id,
      this.wicket_taker_id,
      required this.is_four,
      required this.is_six,
      required this.time});

  factory _$BallScoreModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BallScoreModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String inning_id;
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
  final String? player_out_id;
  @override
  final String? wicket_taker_id;
  @override
  final bool is_four;
  @override
  final bool is_six;
  @override
  final DateTime time;

  @override
  String toString() {
    return 'BallScoreModel(id: $id, inning_id: $inning_id, over_number: $over_number, ball_number: $ball_number, bowler_id: $bowler_id, batsman_id: $batsman_id, non_striker_id: $non_striker_id, runs_scored: $runs_scored, extras_type: $extras_type, extras_awarded: $extras_awarded, wicket_type: $wicket_type, player_out_id: $player_out_id, wicket_taker_id: $wicket_taker_id, is_four: $is_four, is_six: $is_six, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BallScoreModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.inning_id, inning_id) ||
                other.inning_id == inning_id) &&
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
            (identical(other.player_out_id, player_out_id) ||
                other.player_out_id == player_out_id) &&
            (identical(other.wicket_taker_id, wicket_taker_id) ||
                other.wicket_taker_id == wicket_taker_id) &&
            (identical(other.is_four, is_four) || other.is_four == is_four) &&
            (identical(other.is_six, is_six) || other.is_six == is_six) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      inning_id,
      over_number,
      ball_number,
      bowler_id,
      batsman_id,
      non_striker_id,
      runs_scored,
      extras_type,
      extras_awarded,
      wicket_type,
      player_out_id,
      wicket_taker_id,
      is_four,
      is_six,
      time);

  @JsonKey(ignore: true)
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
      {final String? id,
      required final String inning_id,
      required final int over_number,
      required final int ball_number,
      required final String bowler_id,
      required final String batsman_id,
      required final String non_striker_id,
      required final int runs_scored,
      final ExtrasType? extras_type,
      final int? extras_awarded,
      final WicketType? wicket_type,
      final String? player_out_id,
      final String? wicket_taker_id,
      required final bool is_four,
      required final bool is_six,
      required final DateTime time}) = _$BallScoreModelImpl;

  factory _BallScoreModel.fromJson(Map<String, dynamic> json) =
      _$BallScoreModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get inning_id;
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
  String? get player_out_id;
  @override
  String? get wicket_taker_id;
  @override
  bool get is_four;
  @override
  bool get is_six;
  @override
  DateTime get time;
  @override
  @JsonKey(ignore: true)
  _$$BallScoreModelImplCopyWith<_$BallScoreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserStat {
  int get run_scored => throw _privateConstructorUsedError;
  double get batting_average => throw _privateConstructorUsedError;
  double get batting_strike_rate => throw _privateConstructorUsedError;
  int get ball_faced => throw _privateConstructorUsedError;
  int get wicket_taken => throw _privateConstructorUsedError;
  double get bowling_average => throw _privateConstructorUsedError;
  double get bowling_strike_rate => throw _privateConstructorUsedError;
  double get economy_rate => throw _privateConstructorUsedError;
  int get catches => throw _privateConstructorUsedError;
  int get run_out => throw _privateConstructorUsedError;
  int get stumping => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserStatCopyWith<UserStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatCopyWith<$Res> {
  factory $UserStatCopyWith(UserStat value, $Res Function(UserStat) then) =
      _$UserStatCopyWithImpl<$Res, UserStat>;
  @useResult
  $Res call(
      {int run_scored,
      double batting_average,
      double batting_strike_rate,
      int ball_faced,
      int wicket_taken,
      double bowling_average,
      double bowling_strike_rate,
      double economy_rate,
      int catches,
      int run_out,
      int stumping});
}

/// @nodoc
class _$UserStatCopyWithImpl<$Res, $Val extends UserStat>
    implements $UserStatCopyWith<$Res> {
  _$UserStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? run_scored = null,
    Object? batting_average = null,
    Object? batting_strike_rate = null,
    Object? ball_faced = null,
    Object? wicket_taken = null,
    Object? bowling_average = null,
    Object? bowling_strike_rate = null,
    Object? economy_rate = null,
    Object? catches = null,
    Object? run_out = null,
    Object? stumping = null,
  }) {
    return _then(_value.copyWith(
      run_scored: null == run_scored
          ? _value.run_scored
          : run_scored // ignore: cast_nullable_to_non_nullable
              as int,
      batting_average: null == batting_average
          ? _value.batting_average
          : batting_average // ignore: cast_nullable_to_non_nullable
              as double,
      batting_strike_rate: null == batting_strike_rate
          ? _value.batting_strike_rate
          : batting_strike_rate // ignore: cast_nullable_to_non_nullable
              as double,
      ball_faced: null == ball_faced
          ? _value.ball_faced
          : ball_faced // ignore: cast_nullable_to_non_nullable
              as int,
      wicket_taken: null == wicket_taken
          ? _value.wicket_taken
          : wicket_taken // ignore: cast_nullable_to_non_nullable
              as int,
      bowling_average: null == bowling_average
          ? _value.bowling_average
          : bowling_average // ignore: cast_nullable_to_non_nullable
              as double,
      bowling_strike_rate: null == bowling_strike_rate
          ? _value.bowling_strike_rate
          : bowling_strike_rate // ignore: cast_nullable_to_non_nullable
              as double,
      economy_rate: null == economy_rate
          ? _value.economy_rate
          : economy_rate // ignore: cast_nullable_to_non_nullable
              as double,
      catches: null == catches
          ? _value.catches
          : catches // ignore: cast_nullable_to_non_nullable
              as int,
      run_out: null == run_out
          ? _value.run_out
          : run_out // ignore: cast_nullable_to_non_nullable
              as int,
      stumping: null == stumping
          ? _value.stumping
          : stumping // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
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
      {int run_scored,
      double batting_average,
      double batting_strike_rate,
      int ball_faced,
      int wicket_taken,
      double bowling_average,
      double bowling_strike_rate,
      double economy_rate,
      int catches,
      int run_out,
      int stumping});
}

/// @nodoc
class __$$UserStatImplCopyWithImpl<$Res>
    extends _$UserStatCopyWithImpl<$Res, _$UserStatImpl>
    implements _$$UserStatImplCopyWith<$Res> {
  __$$UserStatImplCopyWithImpl(
      _$UserStatImpl _value, $Res Function(_$UserStatImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? run_scored = null,
    Object? batting_average = null,
    Object? batting_strike_rate = null,
    Object? ball_faced = null,
    Object? wicket_taken = null,
    Object? bowling_average = null,
    Object? bowling_strike_rate = null,
    Object? economy_rate = null,
    Object? catches = null,
    Object? run_out = null,
    Object? stumping = null,
  }) {
    return _then(_$UserStatImpl(
      run_scored: null == run_scored
          ? _value.run_scored
          : run_scored // ignore: cast_nullable_to_non_nullable
              as int,
      batting_average: null == batting_average
          ? _value.batting_average
          : batting_average // ignore: cast_nullable_to_non_nullable
              as double,
      batting_strike_rate: null == batting_strike_rate
          ? _value.batting_strike_rate
          : batting_strike_rate // ignore: cast_nullable_to_non_nullable
              as double,
      ball_faced: null == ball_faced
          ? _value.ball_faced
          : ball_faced // ignore: cast_nullable_to_non_nullable
              as int,
      wicket_taken: null == wicket_taken
          ? _value.wicket_taken
          : wicket_taken // ignore: cast_nullable_to_non_nullable
              as int,
      bowling_average: null == bowling_average
          ? _value.bowling_average
          : bowling_average // ignore: cast_nullable_to_non_nullable
              as double,
      bowling_strike_rate: null == bowling_strike_rate
          ? _value.bowling_strike_rate
          : bowling_strike_rate // ignore: cast_nullable_to_non_nullable
              as double,
      economy_rate: null == economy_rate
          ? _value.economy_rate
          : economy_rate // ignore: cast_nullable_to_non_nullable
              as double,
      catches: null == catches
          ? _value.catches
          : catches // ignore: cast_nullable_to_non_nullable
              as int,
      run_out: null == run_out
          ? _value.run_out
          : run_out // ignore: cast_nullable_to_non_nullable
              as int,
      stumping: null == stumping
          ? _value.stumping
          : stumping // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$UserStatImpl implements _UserStat {
  const _$UserStatImpl(
      {this.run_scored = 0,
      this.batting_average = 0.0,
      this.batting_strike_rate = 0.0,
      this.ball_faced = 0,
      this.wicket_taken = 0,
      this.bowling_average = 0.0,
      this.bowling_strike_rate = 0.0,
      this.economy_rate = 0.0,
      this.catches = 0,
      this.run_out = 0,
      this.stumping = 0});

  @override
  @JsonKey()
  final int run_scored;
  @override
  @JsonKey()
  final double batting_average;
  @override
  @JsonKey()
  final double batting_strike_rate;
  @override
  @JsonKey()
  final int ball_faced;
  @override
  @JsonKey()
  final int wicket_taken;
  @override
  @JsonKey()
  final double bowling_average;
  @override
  @JsonKey()
  final double bowling_strike_rate;
  @override
  @JsonKey()
  final double economy_rate;
  @override
  @JsonKey()
  final int catches;
  @override
  @JsonKey()
  final int run_out;
  @override
  @JsonKey()
  final int stumping;

  @override
  String toString() {
    return 'UserStat(run_scored: $run_scored, batting_average: $batting_average, batting_strike_rate: $batting_strike_rate, ball_faced: $ball_faced, wicket_taken: $wicket_taken, bowling_average: $bowling_average, bowling_strike_rate: $bowling_strike_rate, economy_rate: $economy_rate, catches: $catches, run_out: $run_out, stumping: $stumping)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatImpl &&
            (identical(other.run_scored, run_scored) ||
                other.run_scored == run_scored) &&
            (identical(other.batting_average, batting_average) ||
                other.batting_average == batting_average) &&
            (identical(other.batting_strike_rate, batting_strike_rate) ||
                other.batting_strike_rate == batting_strike_rate) &&
            (identical(other.ball_faced, ball_faced) ||
                other.ball_faced == ball_faced) &&
            (identical(other.wicket_taken, wicket_taken) ||
                other.wicket_taken == wicket_taken) &&
            (identical(other.bowling_average, bowling_average) ||
                other.bowling_average == bowling_average) &&
            (identical(other.bowling_strike_rate, bowling_strike_rate) ||
                other.bowling_strike_rate == bowling_strike_rate) &&
            (identical(other.economy_rate, economy_rate) ||
                other.economy_rate == economy_rate) &&
            (identical(other.catches, catches) || other.catches == catches) &&
            (identical(other.run_out, run_out) || other.run_out == run_out) &&
            (identical(other.stumping, stumping) ||
                other.stumping == stumping));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      run_scored,
      batting_average,
      batting_strike_rate,
      ball_faced,
      wicket_taken,
      bowling_average,
      bowling_strike_rate,
      economy_rate,
      catches,
      run_out,
      stumping);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatImplCopyWith<_$UserStatImpl> get copyWith =>
      __$$UserStatImplCopyWithImpl<_$UserStatImpl>(this, _$identity);
}

abstract class _UserStat implements UserStat {
  const factory _UserStat(
      {final int run_scored,
      final double batting_average,
      final double batting_strike_rate,
      final int ball_faced,
      final int wicket_taken,
      final double bowling_average,
      final double bowling_strike_rate,
      final double economy_rate,
      final int catches,
      final int run_out,
      final int stumping}) = _$UserStatImpl;

  @override
  int get run_scored;
  @override
  double get batting_average;
  @override
  double get batting_strike_rate;
  @override
  int get ball_faced;
  @override
  int get wicket_taken;
  @override
  double get bowling_average;
  @override
  double get bowling_strike_rate;
  @override
  double get economy_rate;
  @override
  int get catches;
  @override
  int get run_out;
  @override
  int get stumping;
  @override
  @JsonKey(ignore: true)
  _$$UserStatImplCopyWith<_$UserStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
