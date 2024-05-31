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

OverStatModel _$OverStatModelFromJson(Map<String, dynamic> json) {
  return _OverStatModel.fromJson(json);
}

/// @nodoc
mixin _$OverStatModel {
  int get run => throw _privateConstructorUsedError;
  int get wicket => throw _privateConstructorUsedError;
  int get extra => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, run, wicket, extra);

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
  _$$OverStatModelImplCopyWith<_$OverStatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserStat {
  BattingStat? get battingStat => throw _privateConstructorUsedError;
  BowlingStat? get bowlingStat => throw _privateConstructorUsedError;
  FieldingStat? get fieldingStat => throw _privateConstructorUsedError;

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

class _$UserStatImpl implements _UserStat {
  const _$UserStatImpl({this.battingStat, this.bowlingStat, this.fieldingStat});

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

  @override
  int get hashCode =>
      Object.hash(runtimeType, battingStat, bowlingStat, fieldingStat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatImplCopyWith<_$UserStatImpl> get copyWith =>
      __$$UserStatImplCopyWithImpl<_$UserStatImpl>(this, _$identity);
}

abstract class _UserStat implements UserStat {
  const factory _UserStat(
      {final BattingStat? battingStat,
      final BowlingStat? bowlingStat,
      final FieldingStat? fieldingStat}) = _$UserStatImpl;

  @override
  BattingStat? get battingStat;
  @override
  BowlingStat? get bowlingStat;
  @override
  FieldingStat? get fieldingStat;
  @override
  @JsonKey(ignore: true)
  _$$UserStatImplCopyWith<_$UserStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BattingStat {
  int get runScored => throw _privateConstructorUsedError;
  double get average => throw _privateConstructorUsedError;
  double get strikeRate => throw _privateConstructorUsedError;
  int get ballFaced => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BattingStatCopyWith<BattingStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattingStatCopyWith<$Res> {
  factory $BattingStatCopyWith(
          BattingStat value, $Res Function(BattingStat) then) =
      _$BattingStatCopyWithImpl<$Res, BattingStat>;
  @useResult
  $Res call({int runScored, double average, double strikeRate, int ballFaced});
}

/// @nodoc
class _$BattingStatCopyWithImpl<$Res, $Val extends BattingStat>
    implements $BattingStatCopyWith<$Res> {
  _$BattingStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? runScored = null,
    Object? average = null,
    Object? strikeRate = null,
    Object? ballFaced = null,
  }) {
    return _then(_value.copyWith(
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
  $Res call({int runScored, double average, double strikeRate, int ballFaced});
}

/// @nodoc
class __$$BattingStatImplCopyWithImpl<$Res>
    extends _$BattingStatCopyWithImpl<$Res, _$BattingStatImpl>
    implements _$$BattingStatImplCopyWith<$Res> {
  __$$BattingStatImplCopyWithImpl(
      _$BattingStatImpl _value, $Res Function(_$BattingStatImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? runScored = null,
    Object? average = null,
    Object? strikeRate = null,
    Object? ballFaced = null,
  }) {
    return _then(_$BattingStatImpl(
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
    ));
  }
}

/// @nodoc

class _$BattingStatImpl implements _BattingStat {
  const _$BattingStatImpl(
      {this.runScored = 0,
      this.average = 0.0,
      this.strikeRate = 0.0,
      this.ballFaced = 0});

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
  String toString() {
    return 'BattingStat(runScored: $runScored, average: $average, strikeRate: $strikeRate, ballFaced: $ballFaced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattingStatImpl &&
            (identical(other.runScored, runScored) ||
                other.runScored == runScored) &&
            (identical(other.average, average) || other.average == average) &&
            (identical(other.strikeRate, strikeRate) ||
                other.strikeRate == strikeRate) &&
            (identical(other.ballFaced, ballFaced) ||
                other.ballFaced == ballFaced));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, runScored, average, strikeRate, ballFaced);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BattingStatImplCopyWith<_$BattingStatImpl> get copyWith =>
      __$$BattingStatImplCopyWithImpl<_$BattingStatImpl>(this, _$identity);
}

abstract class _BattingStat implements BattingStat {
  const factory _BattingStat(
      {final int runScored,
      final double average,
      final double strikeRate,
      final int ballFaced}) = _$BattingStatImpl;

  @override
  int get runScored;
  @override
  double get average;
  @override
  double get strikeRate;
  @override
  int get ballFaced;
  @override
  @JsonKey(ignore: true)
  _$$BattingStatImplCopyWith<_$BattingStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BowlingStat {
  int get wicketTaken => throw _privateConstructorUsedError;
  double get average => throw _privateConstructorUsedError;
  double get strikeRate => throw _privateConstructorUsedError;
  double get economyRate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
      {int wicketTaken, double average, double strikeRate, double economyRate});
}

/// @nodoc
class _$BowlingStatCopyWithImpl<$Res, $Val extends BowlingStat>
    implements $BowlingStatCopyWith<$Res> {
  _$BowlingStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wicketTaken = null,
    Object? average = null,
    Object? strikeRate = null,
    Object? economyRate = null,
  }) {
    return _then(_value.copyWith(
      wicketTaken: null == wicketTaken
          ? _value.wicketTaken
          : wicketTaken // ignore: cast_nullable_to_non_nullable
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
      {int wicketTaken, double average, double strikeRate, double economyRate});
}

/// @nodoc
class __$$BowlingStatImplCopyWithImpl<$Res>
    extends _$BowlingStatCopyWithImpl<$Res, _$BowlingStatImpl>
    implements _$$BowlingStatImplCopyWith<$Res> {
  __$$BowlingStatImplCopyWithImpl(
      _$BowlingStatImpl _value, $Res Function(_$BowlingStatImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wicketTaken = null,
    Object? average = null,
    Object? strikeRate = null,
    Object? economyRate = null,
  }) {
    return _then(_$BowlingStatImpl(
      wicketTaken: null == wicketTaken
          ? _value.wicketTaken
          : wicketTaken // ignore: cast_nullable_to_non_nullable
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

class _$BowlingStatImpl implements _BowlingStat {
  const _$BowlingStatImpl(
      {this.wicketTaken = 0,
      this.average = 0.0,
      this.strikeRate = 0.0,
      this.economyRate = 0.0});

  @override
  @JsonKey()
  final int wicketTaken;
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
    return 'BowlingStat(wicketTaken: $wicketTaken, average: $average, strikeRate: $strikeRate, economyRate: $economyRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BowlingStatImpl &&
            (identical(other.wicketTaken, wicketTaken) ||
                other.wicketTaken == wicketTaken) &&
            (identical(other.average, average) || other.average == average) &&
            (identical(other.strikeRate, strikeRate) ||
                other.strikeRate == strikeRate) &&
            (identical(other.economyRate, economyRate) ||
                other.economyRate == economyRate));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, wicketTaken, average, strikeRate, economyRate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BowlingStatImplCopyWith<_$BowlingStatImpl> get copyWith =>
      __$$BowlingStatImplCopyWithImpl<_$BowlingStatImpl>(this, _$identity);
}

abstract class _BowlingStat implements BowlingStat {
  const factory _BowlingStat(
      {final int wicketTaken,
      final double average,
      final double strikeRate,
      final double economyRate}) = _$BowlingStatImpl;

  @override
  int get wicketTaken;
  @override
  double get average;
  @override
  double get strikeRate;
  @override
  double get economyRate;
  @override
  @JsonKey(ignore: true)
  _$$BowlingStatImplCopyWith<_$BowlingStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FieldingStat {
  int get catches => throw _privateConstructorUsedError;
  int get runOut => throw _privateConstructorUsedError;
  int get stumping => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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

class _$FieldingStatImpl implements _FieldingStat {
  const _$FieldingStatImpl(
      {this.catches = 0, this.runOut = 0, this.stumping = 0});

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

  @override
  int get hashCode => Object.hash(runtimeType, catches, runOut, stumping);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldingStatImplCopyWith<_$FieldingStatImpl> get copyWith =>
      __$$FieldingStatImplCopyWithImpl<_$FieldingStatImpl>(this, _$identity);
}

abstract class _FieldingStat implements FieldingStat {
  const factory _FieldingStat(
      {final int catches,
      final int runOut,
      final int stumping}) = _$FieldingStatImpl;

  @override
  int get catches;
  @override
  int get runOut;
  @override
  int get stumping;
  @override
  @JsonKey(ignore: true)
  _$$FieldingStatImplCopyWith<_$FieldingStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
