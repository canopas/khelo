// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MatchEventModel _$MatchEventModelFromJson(Map<String, dynamic> json) {
  return _MatchEventModel.fromJson(json);
}

/// @nodoc
mixin _$MatchEventModel {
  String get id => throw _privateConstructorUsedError;
  String get match_id => throw _privateConstructorUsedError;
  String get inning_id => throw _privateConstructorUsedError;
  EventType get type => throw _privateConstructorUsedError;
  @TimeStampJsonConverter()
  DateTime get time => throw _privateConstructorUsedError;
  String? get bowler_id => throw _privateConstructorUsedError;
  String? get batsman_id => throw _privateConstructorUsedError;
  FieldingPositionType? get fielding_position =>
      throw _privateConstructorUsedError;
  double get over => throw _privateConstructorUsedError;
  List<String> get ball_ids => throw _privateConstructorUsedError;
  List<MatchEventWicket> get wickets => throw _privateConstructorUsedError;
  List<MatchEventMilestone> get milestone => throw _privateConstructorUsedError;

  /// Serializes this MatchEventModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchEventModelCopyWith<MatchEventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchEventModelCopyWith<$Res> {
  factory $MatchEventModelCopyWith(
          MatchEventModel value, $Res Function(MatchEventModel) then) =
      _$MatchEventModelCopyWithImpl<$Res, MatchEventModel>;
  @useResult
  $Res call(
      {String id,
      String match_id,
      String inning_id,
      EventType type,
      @TimeStampJsonConverter() DateTime time,
      String? bowler_id,
      String? batsman_id,
      FieldingPositionType? fielding_position,
      double over,
      List<String> ball_ids,
      List<MatchEventWicket> wickets,
      List<MatchEventMilestone> milestone});
}

/// @nodoc
class _$MatchEventModelCopyWithImpl<$Res, $Val extends MatchEventModel>
    implements $MatchEventModelCopyWith<$Res> {
  _$MatchEventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? match_id = null,
    Object? inning_id = null,
    Object? type = null,
    Object? time = null,
    Object? bowler_id = freezed,
    Object? batsman_id = freezed,
    Object? fielding_position = freezed,
    Object? over = null,
    Object? ball_ids = null,
    Object? wickets = null,
    Object? milestone = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      match_id: null == match_id
          ? _value.match_id
          : match_id // ignore: cast_nullable_to_non_nullable
              as String,
      inning_id: null == inning_id
          ? _value.inning_id
          : inning_id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as EventType,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      bowler_id: freezed == bowler_id
          ? _value.bowler_id
          : bowler_id // ignore: cast_nullable_to_non_nullable
              as String?,
      batsman_id: freezed == batsman_id
          ? _value.batsman_id
          : batsman_id // ignore: cast_nullable_to_non_nullable
              as String?,
      fielding_position: freezed == fielding_position
          ? _value.fielding_position
          : fielding_position // ignore: cast_nullable_to_non_nullable
              as FieldingPositionType?,
      over: null == over
          ? _value.over
          : over // ignore: cast_nullable_to_non_nullable
              as double,
      ball_ids: null == ball_ids
          ? _value.ball_ids
          : ball_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      wickets: null == wickets
          ? _value.wickets
          : wickets // ignore: cast_nullable_to_non_nullable
              as List<MatchEventWicket>,
      milestone: null == milestone
          ? _value.milestone
          : milestone // ignore: cast_nullable_to_non_nullable
              as List<MatchEventMilestone>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchEventModelImplCopyWith<$Res>
    implements $MatchEventModelCopyWith<$Res> {
  factory _$$MatchEventModelImplCopyWith(_$MatchEventModelImpl value,
          $Res Function(_$MatchEventModelImpl) then) =
      __$$MatchEventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String match_id,
      String inning_id,
      EventType type,
      @TimeStampJsonConverter() DateTime time,
      String? bowler_id,
      String? batsman_id,
      FieldingPositionType? fielding_position,
      double over,
      List<String> ball_ids,
      List<MatchEventWicket> wickets,
      List<MatchEventMilestone> milestone});
}

/// @nodoc
class __$$MatchEventModelImplCopyWithImpl<$Res>
    extends _$MatchEventModelCopyWithImpl<$Res, _$MatchEventModelImpl>
    implements _$$MatchEventModelImplCopyWith<$Res> {
  __$$MatchEventModelImplCopyWithImpl(
      _$MatchEventModelImpl _value, $Res Function(_$MatchEventModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? match_id = null,
    Object? inning_id = null,
    Object? type = null,
    Object? time = null,
    Object? bowler_id = freezed,
    Object? batsman_id = freezed,
    Object? fielding_position = freezed,
    Object? over = null,
    Object? ball_ids = null,
    Object? wickets = null,
    Object? milestone = null,
  }) {
    return _then(_$MatchEventModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      match_id: null == match_id
          ? _value.match_id
          : match_id // ignore: cast_nullable_to_non_nullable
              as String,
      inning_id: null == inning_id
          ? _value.inning_id
          : inning_id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as EventType,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      bowler_id: freezed == bowler_id
          ? _value.bowler_id
          : bowler_id // ignore: cast_nullable_to_non_nullable
              as String?,
      batsman_id: freezed == batsman_id
          ? _value.batsman_id
          : batsman_id // ignore: cast_nullable_to_non_nullable
              as String?,
      fielding_position: freezed == fielding_position
          ? _value.fielding_position
          : fielding_position // ignore: cast_nullable_to_non_nullable
              as FieldingPositionType?,
      over: null == over
          ? _value.over
          : over // ignore: cast_nullable_to_non_nullable
              as double,
      ball_ids: null == ball_ids
          ? _value._ball_ids
          : ball_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      wickets: null == wickets
          ? _value._wickets
          : wickets // ignore: cast_nullable_to_non_nullable
              as List<MatchEventWicket>,
      milestone: null == milestone
          ? _value._milestone
          : milestone // ignore: cast_nullable_to_non_nullable
              as List<MatchEventMilestone>,
    ));
  }
}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true, includeIfNull: false)
class _$MatchEventModelImpl implements _MatchEventModel {
  const _$MatchEventModelImpl(
      {required this.id,
      required this.match_id,
      required this.inning_id,
      required this.type,
      @TimeStampJsonConverter() required this.time,
      this.bowler_id,
      this.batsman_id,
      this.fielding_position,
      this.over = 0,
      final List<String> ball_ids = const [],
      final List<MatchEventWicket> wickets = const [],
      final List<MatchEventMilestone> milestone = const []})
      : _ball_ids = ball_ids,
        _wickets = wickets,
        _milestone = milestone;

  factory _$MatchEventModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchEventModelImplFromJson(json);

  @override
  final String id;
  @override
  final String match_id;
  @override
  final String inning_id;
  @override
  final EventType type;
  @override
  @TimeStampJsonConverter()
  final DateTime time;
  @override
  final String? bowler_id;
  @override
  final String? batsman_id;
  @override
  final FieldingPositionType? fielding_position;
  @override
  @JsonKey()
  final double over;
  final List<String> _ball_ids;
  @override
  @JsonKey()
  List<String> get ball_ids {
    if (_ball_ids is EqualUnmodifiableListView) return _ball_ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ball_ids);
  }

  final List<MatchEventWicket> _wickets;
  @override
  @JsonKey()
  List<MatchEventWicket> get wickets {
    if (_wickets is EqualUnmodifiableListView) return _wickets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wickets);
  }

  final List<MatchEventMilestone> _milestone;
  @override
  @JsonKey()
  List<MatchEventMilestone> get milestone {
    if (_milestone is EqualUnmodifiableListView) return _milestone;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_milestone);
  }

  @override
  String toString() {
    return 'MatchEventModel(id: $id, match_id: $match_id, inning_id: $inning_id, type: $type, time: $time, bowler_id: $bowler_id, batsman_id: $batsman_id, fielding_position: $fielding_position, over: $over, ball_ids: $ball_ids, wickets: $wickets, milestone: $milestone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchEventModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.match_id, match_id) ||
                other.match_id == match_id) &&
            (identical(other.inning_id, inning_id) ||
                other.inning_id == inning_id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.bowler_id, bowler_id) ||
                other.bowler_id == bowler_id) &&
            (identical(other.batsman_id, batsman_id) ||
                other.batsman_id == batsman_id) &&
            (identical(other.fielding_position, fielding_position) ||
                other.fielding_position == fielding_position) &&
            (identical(other.over, over) || other.over == over) &&
            const DeepCollectionEquality().equals(other._ball_ids, _ball_ids) &&
            const DeepCollectionEquality().equals(other._wickets, _wickets) &&
            const DeepCollectionEquality()
                .equals(other._milestone, _milestone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      match_id,
      inning_id,
      type,
      time,
      bowler_id,
      batsman_id,
      fielding_position,
      over,
      const DeepCollectionEquality().hash(_ball_ids),
      const DeepCollectionEquality().hash(_wickets),
      const DeepCollectionEquality().hash(_milestone));

  /// Create a copy of MatchEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchEventModelImplCopyWith<_$MatchEventModelImpl> get copyWith =>
      __$$MatchEventModelImplCopyWithImpl<_$MatchEventModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchEventModelImplToJson(
      this,
    );
  }
}

abstract class _MatchEventModel implements MatchEventModel {
  const factory _MatchEventModel(
      {required final String id,
      required final String match_id,
      required final String inning_id,
      required final EventType type,
      @TimeStampJsonConverter() required final DateTime time,
      final String? bowler_id,
      final String? batsman_id,
      final FieldingPositionType? fielding_position,
      final double over,
      final List<String> ball_ids,
      final List<MatchEventWicket> wickets,
      final List<MatchEventMilestone> milestone}) = _$MatchEventModelImpl;

  factory _MatchEventModel.fromJson(Map<String, dynamic> json) =
      _$MatchEventModelImpl.fromJson;

  @override
  String get id;
  @override
  String get match_id;
  @override
  String get inning_id;
  @override
  EventType get type;
  @override
  @TimeStampJsonConverter()
  DateTime get time;
  @override
  String? get bowler_id;
  @override
  String? get batsman_id;
  @override
  FieldingPositionType? get fielding_position;
  @override
  double get over;
  @override
  List<String> get ball_ids;
  @override
  List<MatchEventWicket> get wickets;
  @override
  List<MatchEventMilestone> get milestone;

  /// Create a copy of MatchEventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchEventModelImplCopyWith<_$MatchEventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchEventWicket _$MatchEventWicketFromJson(Map<String, dynamic> json) {
  return _MatchEventWicket.fromJson(json);
}

/// @nodoc
mixin _$MatchEventWicket {
  @TimeStampJsonConverter()
  DateTime get time => throw _privateConstructorUsedError;
  String get ball_id => throw _privateConstructorUsedError;
  String get batsman_id => throw _privateConstructorUsedError;
  WicketType get wicket_type => throw _privateConstructorUsedError;
  double get over => throw _privateConstructorUsedError;
  String? get wicket_taker_id => throw _privateConstructorUsedError;

  /// Serializes this MatchEventWicket to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchEventWicket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchEventWicketCopyWith<MatchEventWicket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchEventWicketCopyWith<$Res> {
  factory $MatchEventWicketCopyWith(
          MatchEventWicket value, $Res Function(MatchEventWicket) then) =
      _$MatchEventWicketCopyWithImpl<$Res, MatchEventWicket>;
  @useResult
  $Res call(
      {@TimeStampJsonConverter() DateTime time,
      String ball_id,
      String batsman_id,
      WicketType wicket_type,
      double over,
      String? wicket_taker_id});
}

/// @nodoc
class _$MatchEventWicketCopyWithImpl<$Res, $Val extends MatchEventWicket>
    implements $MatchEventWicketCopyWith<$Res> {
  _$MatchEventWicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchEventWicket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? ball_id = null,
    Object? batsman_id = null,
    Object? wicket_type = null,
    Object? over = null,
    Object? wicket_taker_id = freezed,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ball_id: null == ball_id
          ? _value.ball_id
          : ball_id // ignore: cast_nullable_to_non_nullable
              as String,
      batsman_id: null == batsman_id
          ? _value.batsman_id
          : batsman_id // ignore: cast_nullable_to_non_nullable
              as String,
      wicket_type: null == wicket_type
          ? _value.wicket_type
          : wicket_type // ignore: cast_nullable_to_non_nullable
              as WicketType,
      over: null == over
          ? _value.over
          : over // ignore: cast_nullable_to_non_nullable
              as double,
      wicket_taker_id: freezed == wicket_taker_id
          ? _value.wicket_taker_id
          : wicket_taker_id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchEventWicketImplCopyWith<$Res>
    implements $MatchEventWicketCopyWith<$Res> {
  factory _$$MatchEventWicketImplCopyWith(_$MatchEventWicketImpl value,
          $Res Function(_$MatchEventWicketImpl) then) =
      __$$MatchEventWicketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@TimeStampJsonConverter() DateTime time,
      String ball_id,
      String batsman_id,
      WicketType wicket_type,
      double over,
      String? wicket_taker_id});
}

/// @nodoc
class __$$MatchEventWicketImplCopyWithImpl<$Res>
    extends _$MatchEventWicketCopyWithImpl<$Res, _$MatchEventWicketImpl>
    implements _$$MatchEventWicketImplCopyWith<$Res> {
  __$$MatchEventWicketImplCopyWithImpl(_$MatchEventWicketImpl _value,
      $Res Function(_$MatchEventWicketImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchEventWicket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? ball_id = null,
    Object? batsman_id = null,
    Object? wicket_type = null,
    Object? over = null,
    Object? wicket_taker_id = freezed,
  }) {
    return _then(_$MatchEventWicketImpl(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ball_id: null == ball_id
          ? _value.ball_id
          : ball_id // ignore: cast_nullable_to_non_nullable
              as String,
      batsman_id: null == batsman_id
          ? _value.batsman_id
          : batsman_id // ignore: cast_nullable_to_non_nullable
              as String,
      wicket_type: null == wicket_type
          ? _value.wicket_type
          : wicket_type // ignore: cast_nullable_to_non_nullable
              as WicketType,
      over: null == over
          ? _value.over
          : over // ignore: cast_nullable_to_non_nullable
              as double,
      wicket_taker_id: freezed == wicket_taker_id
          ? _value.wicket_taker_id
          : wicket_taker_id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true)
class _$MatchEventWicketImpl implements _MatchEventWicket {
  const _$MatchEventWicketImpl(
      {@TimeStampJsonConverter() required this.time,
      required this.ball_id,
      required this.batsman_id,
      required this.wicket_type,
      required this.over,
      this.wicket_taker_id});

  factory _$MatchEventWicketImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchEventWicketImplFromJson(json);

  @override
  @TimeStampJsonConverter()
  final DateTime time;
  @override
  final String ball_id;
  @override
  final String batsman_id;
  @override
  final WicketType wicket_type;
  @override
  final double over;
  @override
  final String? wicket_taker_id;

  @override
  String toString() {
    return 'MatchEventWicket(time: $time, ball_id: $ball_id, batsman_id: $batsman_id, wicket_type: $wicket_type, over: $over, wicket_taker_id: $wicket_taker_id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchEventWicketImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.ball_id, ball_id) || other.ball_id == ball_id) &&
            (identical(other.batsman_id, batsman_id) ||
                other.batsman_id == batsman_id) &&
            (identical(other.wicket_type, wicket_type) ||
                other.wicket_type == wicket_type) &&
            (identical(other.over, over) || other.over == over) &&
            (identical(other.wicket_taker_id, wicket_taker_id) ||
                other.wicket_taker_id == wicket_taker_id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, time, ball_id, batsman_id,
      wicket_type, over, wicket_taker_id);

  /// Create a copy of MatchEventWicket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchEventWicketImplCopyWith<_$MatchEventWicketImpl> get copyWith =>
      __$$MatchEventWicketImplCopyWithImpl<_$MatchEventWicketImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchEventWicketImplToJson(
      this,
    );
  }
}

abstract class _MatchEventWicket implements MatchEventWicket {
  const factory _MatchEventWicket(
      {@TimeStampJsonConverter() required final DateTime time,
      required final String ball_id,
      required final String batsman_id,
      required final WicketType wicket_type,
      required final double over,
      final String? wicket_taker_id}) = _$MatchEventWicketImpl;

  factory _MatchEventWicket.fromJson(Map<String, dynamic> json) =
      _$MatchEventWicketImpl.fromJson;

  @override
  @TimeStampJsonConverter()
  DateTime get time;
  @override
  String get ball_id;
  @override
  String get batsman_id;
  @override
  WicketType get wicket_type;
  @override
  double get over;
  @override
  String? get wicket_taker_id;

  /// Create a copy of MatchEventWicket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchEventWicketImplCopyWith<_$MatchEventWicketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchEventMilestone _$MatchEventMilestoneFromJson(Map<String, dynamic> json) {
  return _MatchEventMilestone.fromJson(json);
}

/// @nodoc
mixin _$MatchEventMilestone {
  @TimeStampJsonConverter()
  DateTime get time => throw _privateConstructorUsedError;
  String get ball_id => throw _privateConstructorUsedError;
  double get over => throw _privateConstructorUsedError;
  int get runs => throw _privateConstructorUsedError;
  int get ball_faced => throw _privateConstructorUsedError;
  int get fours => throw _privateConstructorUsedError;
  int get sixes => throw _privateConstructorUsedError;

  /// Serializes this MatchEventMilestone to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchEventMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchEventMilestoneCopyWith<MatchEventMilestone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchEventMilestoneCopyWith<$Res> {
  factory $MatchEventMilestoneCopyWith(
          MatchEventMilestone value, $Res Function(MatchEventMilestone) then) =
      _$MatchEventMilestoneCopyWithImpl<$Res, MatchEventMilestone>;
  @useResult
  $Res call(
      {@TimeStampJsonConverter() DateTime time,
      String ball_id,
      double over,
      int runs,
      int ball_faced,
      int fours,
      int sixes});
}

/// @nodoc
class _$MatchEventMilestoneCopyWithImpl<$Res, $Val extends MatchEventMilestone>
    implements $MatchEventMilestoneCopyWith<$Res> {
  _$MatchEventMilestoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchEventMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? ball_id = null,
    Object? over = null,
    Object? runs = null,
    Object? ball_faced = null,
    Object? fours = null,
    Object? sixes = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ball_id: null == ball_id
          ? _value.ball_id
          : ball_id // ignore: cast_nullable_to_non_nullable
              as String,
      over: null == over
          ? _value.over
          : over // ignore: cast_nullable_to_non_nullable
              as double,
      runs: null == runs
          ? _value.runs
          : runs // ignore: cast_nullable_to_non_nullable
              as int,
      ball_faced: null == ball_faced
          ? _value.ball_faced
          : ball_faced // ignore: cast_nullable_to_non_nullable
              as int,
      fours: null == fours
          ? _value.fours
          : fours // ignore: cast_nullable_to_non_nullable
              as int,
      sixes: null == sixes
          ? _value.sixes
          : sixes // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchEventMilestoneImplCopyWith<$Res>
    implements $MatchEventMilestoneCopyWith<$Res> {
  factory _$$MatchEventMilestoneImplCopyWith(_$MatchEventMilestoneImpl value,
          $Res Function(_$MatchEventMilestoneImpl) then) =
      __$$MatchEventMilestoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@TimeStampJsonConverter() DateTime time,
      String ball_id,
      double over,
      int runs,
      int ball_faced,
      int fours,
      int sixes});
}

/// @nodoc
class __$$MatchEventMilestoneImplCopyWithImpl<$Res>
    extends _$MatchEventMilestoneCopyWithImpl<$Res, _$MatchEventMilestoneImpl>
    implements _$$MatchEventMilestoneImplCopyWith<$Res> {
  __$$MatchEventMilestoneImplCopyWithImpl(_$MatchEventMilestoneImpl _value,
      $Res Function(_$MatchEventMilestoneImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchEventMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? ball_id = null,
    Object? over = null,
    Object? runs = null,
    Object? ball_faced = null,
    Object? fours = null,
    Object? sixes = null,
  }) {
    return _then(_$MatchEventMilestoneImpl(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ball_id: null == ball_id
          ? _value.ball_id
          : ball_id // ignore: cast_nullable_to_non_nullable
              as String,
      over: null == over
          ? _value.over
          : over // ignore: cast_nullable_to_non_nullable
              as double,
      runs: null == runs
          ? _value.runs
          : runs // ignore: cast_nullable_to_non_nullable
              as int,
      ball_faced: null == ball_faced
          ? _value.ball_faced
          : ball_faced // ignore: cast_nullable_to_non_nullable
              as int,
      fours: null == fours
          ? _value.fours
          : fours // ignore: cast_nullable_to_non_nullable
              as int,
      sixes: null == sixes
          ? _value.sixes
          : sixes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true)
class _$MatchEventMilestoneImpl implements _MatchEventMilestone {
  const _$MatchEventMilestoneImpl(
      {@TimeStampJsonConverter() required this.time,
      required this.ball_id,
      this.over = 0.0,
      this.runs = 0,
      this.ball_faced = 0,
      this.fours = 0,
      this.sixes = 0});

  factory _$MatchEventMilestoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchEventMilestoneImplFromJson(json);

  @override
  @TimeStampJsonConverter()
  final DateTime time;
  @override
  final String ball_id;
  @override
  @JsonKey()
  final double over;
  @override
  @JsonKey()
  final int runs;
  @override
  @JsonKey()
  final int ball_faced;
  @override
  @JsonKey()
  final int fours;
  @override
  @JsonKey()
  final int sixes;

  @override
  String toString() {
    return 'MatchEventMilestone(time: $time, ball_id: $ball_id, over: $over, runs: $runs, ball_faced: $ball_faced, fours: $fours, sixes: $sixes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchEventMilestoneImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.ball_id, ball_id) || other.ball_id == ball_id) &&
            (identical(other.over, over) || other.over == over) &&
            (identical(other.runs, runs) || other.runs == runs) &&
            (identical(other.ball_faced, ball_faced) ||
                other.ball_faced == ball_faced) &&
            (identical(other.fours, fours) || other.fours == fours) &&
            (identical(other.sixes, sixes) || other.sixes == sixes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, time, ball_id, over, runs, ball_faced, fours, sixes);

  /// Create a copy of MatchEventMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchEventMilestoneImplCopyWith<_$MatchEventMilestoneImpl> get copyWith =>
      __$$MatchEventMilestoneImplCopyWithImpl<_$MatchEventMilestoneImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchEventMilestoneImplToJson(
      this,
    );
  }
}

abstract class _MatchEventMilestone implements MatchEventMilestone {
  const factory _MatchEventMilestone(
      {@TimeStampJsonConverter() required final DateTime time,
      required final String ball_id,
      final double over,
      final int runs,
      final int ball_faced,
      final int fours,
      final int sixes}) = _$MatchEventMilestoneImpl;

  factory _MatchEventMilestone.fromJson(Map<String, dynamic> json) =
      _$MatchEventMilestoneImpl.fromJson;

  @override
  @TimeStampJsonConverter()
  DateTime get time;
  @override
  String get ball_id;
  @override
  double get over;
  @override
  int get runs;
  @override
  int get ball_faced;
  @override
  int get fours;
  @override
  int get sixes;

  /// Create a copy of MatchEventMilestone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchEventMilestoneImplCopyWith<_$MatchEventMilestoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
