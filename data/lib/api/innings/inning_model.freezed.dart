// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inning_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InningModel _$InningModelFromJson(Map<String, dynamic> json) {
  return _InningModel.fromJson(json);
}

/// @nodoc
mixin _$InningModel {
  String? get id => throw _privateConstructorUsedError;
  String get match_id => throw _privateConstructorUsedError;
  String get team_id => throw _privateConstructorUsedError;
  double? get overs => throw _privateConstructorUsedError;
  int? get total_runs => throw _privateConstructorUsedError;
  int? get total_wickets => throw _privateConstructorUsedError;
  InningStatus? get innings_status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InningModelCopyWith<InningModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InningModelCopyWith<$Res> {
  factory $InningModelCopyWith(
          InningModel value, $Res Function(InningModel) then) =
      _$InningModelCopyWithImpl<$Res, InningModel>;
  @useResult
  $Res call(
      {String? id,
      String match_id,
      String team_id,
      double? overs,
      int? total_runs,
      int? total_wickets,
      InningStatus? innings_status});
}

/// @nodoc
class _$InningModelCopyWithImpl<$Res, $Val extends InningModel>
    implements $InningModelCopyWith<$Res> {
  _$InningModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? match_id = null,
    Object? team_id = null,
    Object? overs = freezed,
    Object? total_runs = freezed,
    Object? total_wickets = freezed,
    Object? innings_status = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      match_id: null == match_id
          ? _value.match_id
          : match_id // ignore: cast_nullable_to_non_nullable
              as String,
      team_id: null == team_id
          ? _value.team_id
          : team_id // ignore: cast_nullable_to_non_nullable
              as String,
      overs: freezed == overs
          ? _value.overs
          : overs // ignore: cast_nullable_to_non_nullable
              as double?,
      total_runs: freezed == total_runs
          ? _value.total_runs
          : total_runs // ignore: cast_nullable_to_non_nullable
              as int?,
      total_wickets: freezed == total_wickets
          ? _value.total_wickets
          : total_wickets // ignore: cast_nullable_to_non_nullable
              as int?,
      innings_status: freezed == innings_status
          ? _value.innings_status
          : innings_status // ignore: cast_nullable_to_non_nullable
              as InningStatus?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InningModelImplCopyWith<$Res>
    implements $InningModelCopyWith<$Res> {
  factory _$$InningModelImplCopyWith(
          _$InningModelImpl value, $Res Function(_$InningModelImpl) then) =
      __$$InningModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String match_id,
      String team_id,
      double? overs,
      int? total_runs,
      int? total_wickets,
      InningStatus? innings_status});
}

/// @nodoc
class __$$InningModelImplCopyWithImpl<$Res>
    extends _$InningModelCopyWithImpl<$Res, _$InningModelImpl>
    implements _$$InningModelImplCopyWith<$Res> {
  __$$InningModelImplCopyWithImpl(
      _$InningModelImpl _value, $Res Function(_$InningModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? match_id = null,
    Object? team_id = null,
    Object? overs = freezed,
    Object? total_runs = freezed,
    Object? total_wickets = freezed,
    Object? innings_status = freezed,
  }) {
    return _then(_$InningModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      match_id: null == match_id
          ? _value.match_id
          : match_id // ignore: cast_nullable_to_non_nullable
              as String,
      team_id: null == team_id
          ? _value.team_id
          : team_id // ignore: cast_nullable_to_non_nullable
              as String,
      overs: freezed == overs
          ? _value.overs
          : overs // ignore: cast_nullable_to_non_nullable
              as double?,
      total_runs: freezed == total_runs
          ? _value.total_runs
          : total_runs // ignore: cast_nullable_to_non_nullable
              as int?,
      total_wickets: freezed == total_wickets
          ? _value.total_wickets
          : total_wickets // ignore: cast_nullable_to_non_nullable
              as int?,
      innings_status: freezed == innings_status
          ? _value.innings_status
          : innings_status // ignore: cast_nullable_to_non_nullable
              as InningStatus?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InningModelImpl implements _InningModel {
  const _$InningModelImpl(
      {this.id,
      required this.match_id,
      required this.team_id,
      this.overs,
      this.total_runs,
      this.total_wickets,
      this.innings_status});

  factory _$InningModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InningModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String match_id;
  @override
  final String team_id;
  @override
  final double? overs;
  @override
  final int? total_runs;
  @override
  final int? total_wickets;
  @override
  final InningStatus? innings_status;

  @override
  String toString() {
    return 'InningModel(id: $id, match_id: $match_id, team_id: $team_id, overs: $overs, total_runs: $total_runs, total_wickets: $total_wickets, innings_status: $innings_status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InningModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.match_id, match_id) ||
                other.match_id == match_id) &&
            (identical(other.team_id, team_id) || other.team_id == team_id) &&
            (identical(other.overs, overs) || other.overs == overs) &&
            (identical(other.total_runs, total_runs) ||
                other.total_runs == total_runs) &&
            (identical(other.total_wickets, total_wickets) ||
                other.total_wickets == total_wickets) &&
            (identical(other.innings_status, innings_status) ||
                other.innings_status == innings_status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, match_id, team_id, overs,
      total_runs, total_wickets, innings_status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InningModelImplCopyWith<_$InningModelImpl> get copyWith =>
      __$$InningModelImplCopyWithImpl<_$InningModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InningModelImplToJson(
      this,
    );
  }
}

abstract class _InningModel implements InningModel {
  const factory _InningModel(
      {final String? id,
      required final String match_id,
      required final String team_id,
      final double? overs,
      final int? total_runs,
      final int? total_wickets,
      final InningStatus? innings_status}) = _$InningModelImpl;

  factory _InningModel.fromJson(Map<String, dynamic> json) =
      _$InningModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get match_id;
  @override
  String get team_id;
  @override
  double? get overs;
  @override
  int? get total_runs;
  @override
  int? get total_wickets;
  @override
  InningStatus? get innings_status;
  @override
  @JsonKey(ignore: true)
  _$$InningModelImplCopyWith<_$InningModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
