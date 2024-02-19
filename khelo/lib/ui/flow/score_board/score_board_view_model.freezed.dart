// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score_board_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ScoreBoardViewState {
  Object? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScoreBoardViewStateCopyWith<ScoreBoardViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreBoardViewStateCopyWith<$Res> {
  factory $ScoreBoardViewStateCopyWith(
          ScoreBoardViewState value, $Res Function(ScoreBoardViewState) then) =
      _$ScoreBoardViewStateCopyWithImpl<$Res, ScoreBoardViewState>;
  @useResult
  $Res call({Object? error});
}

/// @nodoc
class _$ScoreBoardViewStateCopyWithImpl<$Res, $Val extends ScoreBoardViewState>
    implements $ScoreBoardViewStateCopyWith<$Res> {
  _$ScoreBoardViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScoreBoardViewStateImplCopyWith<$Res>
    implements $ScoreBoardViewStateCopyWith<$Res> {
  factory _$$ScoreBoardViewStateImplCopyWith(_$ScoreBoardViewStateImpl value,
          $Res Function(_$ScoreBoardViewStateImpl) then) =
      __$$ScoreBoardViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Object? error});
}

/// @nodoc
class __$$ScoreBoardViewStateImplCopyWithImpl<$Res>
    extends _$ScoreBoardViewStateCopyWithImpl<$Res, _$ScoreBoardViewStateImpl>
    implements _$$ScoreBoardViewStateImplCopyWith<$Res> {
  __$$ScoreBoardViewStateImplCopyWithImpl(_$ScoreBoardViewStateImpl _value,
      $Res Function(_$ScoreBoardViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$ScoreBoardViewStateImpl(
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$ScoreBoardViewStateImpl implements _ScoreBoardViewState {
  const _$ScoreBoardViewStateImpl({this.error});

  @override
  final Object? error;

  @override
  String toString() {
    return 'ScoreBoardViewState(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScoreBoardViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreBoardViewStateImplCopyWith<_$ScoreBoardViewStateImpl> get copyWith =>
      __$$ScoreBoardViewStateImplCopyWithImpl<_$ScoreBoardViewStateImpl>(
          this, _$identity);
}

abstract class _ScoreBoardViewState implements ScoreBoardViewState {
  const factory _ScoreBoardViewState({final Object? error}) =
      _$ScoreBoardViewStateImpl;

  @override
  Object? get error;
  @override
  @JsonKey(ignore: true)
  _$$ScoreBoardViewStateImplCopyWith<_$ScoreBoardViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
