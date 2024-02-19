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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectSquadViewState {
  Object? get error => throw _privateConstructorUsedError;
  TeamModel? get team => throw _privateConstructorUsedError;
  bool get isOkayBtnEnable => throw _privateConstructorUsedError;
  bool get isDoneBtnEnable => throw _privateConstructorUsedError;
  List<MatchPlayer> get squad => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
      {Object? error,
      TeamModel? team,
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? team = freezed,
    Object? isOkayBtnEnable = null,
    Object? isDoneBtnEnable = null,
    Object? squad = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
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
      {Object? error,
      TeamModel? team,
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? team = freezed,
    Object? isOkayBtnEnable = null,
    Object? isDoneBtnEnable = null,
    Object? squad = null,
  }) {
    return _then(_$SelectSquadViewStateImpl(
      error: freezed == error ? _value.error : error,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
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
      {this.error,
      this.team,
      this.isOkayBtnEnable = false,
      this.isDoneBtnEnable = false,
      final List<MatchPlayer> squad = const []})
      : _squad = squad;

  @override
  final Object? error;
  @override
  final TeamModel? team;
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
    return 'SelectSquadViewState(error: $error, team: $team, isOkayBtnEnable: $isOkayBtnEnable, isDoneBtnEnable: $isDoneBtnEnable, squad: $squad)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectSquadViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.isOkayBtnEnable, isOkayBtnEnable) ||
                other.isOkayBtnEnable == isOkayBtnEnable) &&
            (identical(other.isDoneBtnEnable, isDoneBtnEnable) ||
                other.isDoneBtnEnable == isDoneBtnEnable) &&
            const DeepCollectionEquality().equals(other._squad, _squad));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      team,
      isOkayBtnEnable,
      isDoneBtnEnable,
      const DeepCollectionEquality().hash(_squad));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectSquadViewStateImplCopyWith<_$SelectSquadViewStateImpl>
      get copyWith =>
          __$$SelectSquadViewStateImplCopyWithImpl<_$SelectSquadViewStateImpl>(
              this, _$identity);
}

abstract class _SelectSquadViewState implements SelectSquadViewState {
  const factory _SelectSquadViewState(
      {final Object? error,
      final TeamModel? team,
      final bool isOkayBtnEnable,
      final bool isDoneBtnEnable,
      final List<MatchPlayer> squad}) = _$SelectSquadViewStateImpl;

  @override
  Object? get error;
  @override
  TeamModel? get team;
  @override
  bool get isOkayBtnEnable;
  @override
  bool get isDoneBtnEnable;
  @override
  List<MatchPlayer> get squad;
  @override
  @JsonKey(ignore: true)
  _$$SelectSquadViewStateImplCopyWith<_$SelectSquadViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
