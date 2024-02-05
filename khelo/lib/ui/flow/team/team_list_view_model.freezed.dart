// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_list_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TeamListViewState {
  Object? get error => throw _privateConstructorUsedError;
  List<TeamModel> get teams => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TeamListViewStateCopyWith<TeamListViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamListViewStateCopyWith<$Res> {
  factory $TeamListViewStateCopyWith(
          TeamListViewState value, $Res Function(TeamListViewState) then) =
      _$TeamListViewStateCopyWithImpl<$Res, TeamListViewState>;
  @useResult
  $Res call({Object? error, List<TeamModel> teams, bool loading});
}

/// @nodoc
class _$TeamListViewStateCopyWithImpl<$Res, $Val extends TeamListViewState>
    implements $TeamListViewStateCopyWith<$Res> {
  _$TeamListViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? teams = null,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamListViewStateImplCopyWith<$Res>
    implements $TeamListViewStateCopyWith<$Res> {
  factory _$$TeamListViewStateImplCopyWith(_$TeamListViewStateImpl value,
          $Res Function(_$TeamListViewStateImpl) then) =
      __$$TeamListViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Object? error, List<TeamModel> teams, bool loading});
}

/// @nodoc
class __$$TeamListViewStateImplCopyWithImpl<$Res>
    extends _$TeamListViewStateCopyWithImpl<$Res, _$TeamListViewStateImpl>
    implements _$$TeamListViewStateImplCopyWith<$Res> {
  __$$TeamListViewStateImplCopyWithImpl(_$TeamListViewStateImpl _value,
      $Res Function(_$TeamListViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? teams = null,
    Object? loading = null,
  }) {
    return _then(_$TeamListViewStateImpl(
      error: freezed == error ? _value.error : error,
      teams: null == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TeamListViewStateImpl implements _TeamListViewState {
  const _$TeamListViewStateImpl(
      {this.error, final List<TeamModel> teams = const [], this.loading = true})
      : _teams = teams;

  @override
  final Object? error;
  final List<TeamModel> _teams;
  @override
  @JsonKey()
  List<TeamModel> get teams {
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teams);
  }

  @override
  @JsonKey()
  final bool loading;

  @override
  String toString() {
    return 'TeamListViewState(error: $error, teams: $teams, loading: $loading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamListViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(_teams),
      loading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamListViewStateImplCopyWith<_$TeamListViewStateImpl> get copyWith =>
      __$$TeamListViewStateImplCopyWithImpl<_$TeamListViewStateImpl>(
          this, _$identity);
}

abstract class _TeamListViewState implements TeamListViewState {
  const factory _TeamListViewState(
      {final Object? error,
      final List<TeamModel> teams,
      final bool loading}) = _$TeamListViewStateImpl;

  @override
  Object? get error;
  @override
  List<TeamModel> get teams;
  @override
  bool get loading;
  @override
  @JsonKey(ignore: true)
  _$$TeamListViewStateImplCopyWith<_$TeamListViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
