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
