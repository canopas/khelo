// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_squad_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectSquadViewState {
  TeamModel? get team => throw _privateConstructorUsedError;
  String? get captainId => throw _privateConstructorUsedError;
  String? get adminId => throw _privateConstructorUsedError;
  bool get isOkayBtnEnable => throw _privateConstructorUsedError;
  bool get isDoneBtnEnable => throw _privateConstructorUsedError;
  List<MatchPlayer> get squad => throw _privateConstructorUsedError;

  /// Create a copy of SelectSquadViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectSquadViewStateCopyWith<SelectSquadViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectSquadViewStateCopyWith<$Res> {
  factory $SelectSquadViewStateCopyWith(SelectSquadViewState value,
          $Res Function(SelectSquadViewState) then) =
      _$SelectSquadViewStateCopyWithImpl<$Res, SelectSquadViewState>;
  @useResult
  $Res call(
      {TeamModel? team,
      String? captainId,
      String? adminId,
      bool isOkayBtnEnable,
      bool isDoneBtnEnable,
      List<MatchPlayer> squad});

  $TeamModelCopyWith<$Res>? get team;
}

/// @nodoc
class _$SelectSquadViewStateCopyWithImpl<$Res,
        $Val extends SelectSquadViewState>
    implements $SelectSquadViewStateCopyWith<$Res> {
  _$SelectSquadViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectSquadViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team = freezed,
    Object? captainId = freezed,
    Object? adminId = freezed,
    Object? isOkayBtnEnable = null,
    Object? isDoneBtnEnable = null,
    Object? squad = null,
  }) {
    return _then(_value.copyWith(
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      captainId: freezed == captainId
          ? _value.captainId
          : captainId // ignore: cast_nullable_to_non_nullable
              as String?,
      adminId: freezed == adminId
          ? _value.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String?,
      isOkayBtnEnable: null == isOkayBtnEnable
          ? _value.isOkayBtnEnable
          : isOkayBtnEnable // ignore: cast_nullable_to_non_nullable
              as bool,
      isDoneBtnEnable: null == isDoneBtnEnable
          ? _value.isDoneBtnEnable
          : isDoneBtnEnable // ignore: cast_nullable_to_non_nullable
              as bool,
      squad: null == squad
          ? _value.squad
          : squad // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>,
    ) as $Val);
  }

  /// Create a copy of SelectSquadViewState
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
abstract class _$$SelectSquadViewStateImplCopyWith<$Res>
    implements $SelectSquadViewStateCopyWith<$Res> {
  factory _$$SelectSquadViewStateImplCopyWith(_$SelectSquadViewStateImpl value,
          $Res Function(_$SelectSquadViewStateImpl) then) =
      __$$SelectSquadViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TeamModel? team,
      String? captainId,
      String? adminId,
      bool isOkayBtnEnable,
      bool isDoneBtnEnable,
      List<MatchPlayer> squad});

  @override
  $TeamModelCopyWith<$Res>? get team;
}

/// @nodoc
class __$$SelectSquadViewStateImplCopyWithImpl<$Res>
    extends _$SelectSquadViewStateCopyWithImpl<$Res, _$SelectSquadViewStateImpl>
    implements _$$SelectSquadViewStateImplCopyWith<$Res> {
  __$$SelectSquadViewStateImplCopyWithImpl(_$SelectSquadViewStateImpl _value,
      $Res Function(_$SelectSquadViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectSquadViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team = freezed,
    Object? captainId = freezed,
    Object? adminId = freezed,
    Object? isOkayBtnEnable = null,
    Object? isDoneBtnEnable = null,
    Object? squad = null,
  }) {
    return _then(_$SelectSquadViewStateImpl(
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      captainId: freezed == captainId
          ? _value.captainId
          : captainId // ignore: cast_nullable_to_non_nullable
              as String?,
      adminId: freezed == adminId
          ? _value.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String?,
      isOkayBtnEnable: null == isOkayBtnEnable
          ? _value.isOkayBtnEnable
          : isOkayBtnEnable // ignore: cast_nullable_to_non_nullable
              as bool,
      isDoneBtnEnable: null == isDoneBtnEnable
          ? _value.isDoneBtnEnable
          : isDoneBtnEnable // ignore: cast_nullable_to_non_nullable
              as bool,
      squad: null == squad
          ? _value._squad
          : squad // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>,
    ));
  }
}

/// @nodoc

class _$SelectSquadViewStateImpl implements _SelectSquadViewState {
  const _$SelectSquadViewStateImpl(
      {this.team,
      this.captainId,
      this.adminId,
      this.isOkayBtnEnable = false,
      this.isDoneBtnEnable = false,
      final List<MatchPlayer> squad = const []})
      : _squad = squad;

  @override
  final TeamModel? team;
  @override
  final String? captainId;
  @override
  final String? adminId;
  @override
  @JsonKey()
  final bool isOkayBtnEnable;
  @override
  @JsonKey()
  final bool isDoneBtnEnable;
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
    return 'SelectSquadViewState(team: $team, captainId: $captainId, adminId: $adminId, isOkayBtnEnable: $isOkayBtnEnable, isDoneBtnEnable: $isDoneBtnEnable, squad: $squad)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectSquadViewStateImpl &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.captainId, captainId) ||
                other.captainId == captainId) &&
            (identical(other.adminId, adminId) || other.adminId == adminId) &&
            (identical(other.isOkayBtnEnable, isOkayBtnEnable) ||
                other.isOkayBtnEnable == isOkayBtnEnable) &&
            (identical(other.isDoneBtnEnable, isDoneBtnEnable) ||
                other.isDoneBtnEnable == isDoneBtnEnable) &&
            const DeepCollectionEquality().equals(other._squad, _squad));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      team,
      captainId,
      adminId,
      isOkayBtnEnable,
      isDoneBtnEnable,
      const DeepCollectionEquality().hash(_squad));

  /// Create a copy of SelectSquadViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectSquadViewStateImplCopyWith<_$SelectSquadViewStateImpl>
      get copyWith =>
          __$$SelectSquadViewStateImplCopyWithImpl<_$SelectSquadViewStateImpl>(
              this, _$identity);
}

abstract class _SelectSquadViewState implements SelectSquadViewState {
  const factory _SelectSquadViewState(
      {final TeamModel? team,
      final String? captainId,
      final String? adminId,
      final bool isOkayBtnEnable,
      final bool isDoneBtnEnable,
      final List<MatchPlayer> squad}) = _$SelectSquadViewStateImpl;

  @override
  TeamModel? get team;
  @override
  String? get captainId;
  @override
  String? get adminId;
  @override
  bool get isOkayBtnEnable;
  @override
  bool get isDoneBtnEnable;
  @override
  List<MatchPlayer> get squad;

  /// Create a copy of SelectSquadViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectSquadViewStateImplCopyWith<_$SelectSquadViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
