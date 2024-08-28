// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'power_play_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PowerPlayViewState {
  List<int> get firstPowerPlay => throw _privateConstructorUsedError;
  List<int> get secondPowerPlay => throw _privateConstructorUsedError;
  List<int> get thirdPowerPlay => throw _privateConstructorUsedError;

  /// Create a copy of PowerPlayViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PowerPlayViewStateCopyWith<PowerPlayViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PowerPlayViewStateCopyWith<$Res> {
  factory $PowerPlayViewStateCopyWith(
          PowerPlayViewState value, $Res Function(PowerPlayViewState) then) =
      _$PowerPlayViewStateCopyWithImpl<$Res, PowerPlayViewState>;
  @useResult
  $Res call(
      {List<int> firstPowerPlay,
      List<int> secondPowerPlay,
      List<int> thirdPowerPlay});
}

/// @nodoc
class _$PowerPlayViewStateCopyWithImpl<$Res, $Val extends PowerPlayViewState>
    implements $PowerPlayViewStateCopyWith<$Res> {
  _$PowerPlayViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PowerPlayViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstPowerPlay = null,
    Object? secondPowerPlay = null,
    Object? thirdPowerPlay = null,
  }) {
    return _then(_value.copyWith(
      firstPowerPlay: null == firstPowerPlay
          ? _value.firstPowerPlay
          : firstPowerPlay // ignore: cast_nullable_to_non_nullable
              as List<int>,
      secondPowerPlay: null == secondPowerPlay
          ? _value.secondPowerPlay
          : secondPowerPlay // ignore: cast_nullable_to_non_nullable
              as List<int>,
      thirdPowerPlay: null == thirdPowerPlay
          ? _value.thirdPowerPlay
          : thirdPowerPlay // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PowerPlayViewStateImplCopyWith<$Res>
    implements $PowerPlayViewStateCopyWith<$Res> {
  factory _$$PowerPlayViewStateImplCopyWith(_$PowerPlayViewStateImpl value,
          $Res Function(_$PowerPlayViewStateImpl) then) =
      __$$PowerPlayViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<int> firstPowerPlay,
      List<int> secondPowerPlay,
      List<int> thirdPowerPlay});
}

/// @nodoc
class __$$PowerPlayViewStateImplCopyWithImpl<$Res>
    extends _$PowerPlayViewStateCopyWithImpl<$Res, _$PowerPlayViewStateImpl>
    implements _$$PowerPlayViewStateImplCopyWith<$Res> {
  __$$PowerPlayViewStateImplCopyWithImpl(_$PowerPlayViewStateImpl _value,
      $Res Function(_$PowerPlayViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PowerPlayViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstPowerPlay = null,
    Object? secondPowerPlay = null,
    Object? thirdPowerPlay = null,
  }) {
    return _then(_$PowerPlayViewStateImpl(
      firstPowerPlay: null == firstPowerPlay
          ? _value._firstPowerPlay
          : firstPowerPlay // ignore: cast_nullable_to_non_nullable
              as List<int>,
      secondPowerPlay: null == secondPowerPlay
          ? _value._secondPowerPlay
          : secondPowerPlay // ignore: cast_nullable_to_non_nullable
              as List<int>,
      thirdPowerPlay: null == thirdPowerPlay
          ? _value._thirdPowerPlay
          : thirdPowerPlay // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$PowerPlayViewStateImpl implements _PowerPlayViewState {
  const _$PowerPlayViewStateImpl(
      {final List<int> firstPowerPlay = const [],
      final List<int> secondPowerPlay = const [],
      final List<int> thirdPowerPlay = const []})
      : _firstPowerPlay = firstPowerPlay,
        _secondPowerPlay = secondPowerPlay,
        _thirdPowerPlay = thirdPowerPlay;

  final List<int> _firstPowerPlay;
  @override
  @JsonKey()
  List<int> get firstPowerPlay {
    if (_firstPowerPlay is EqualUnmodifiableListView) return _firstPowerPlay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_firstPowerPlay);
  }

  final List<int> _secondPowerPlay;
  @override
  @JsonKey()
  List<int> get secondPowerPlay {
    if (_secondPowerPlay is EqualUnmodifiableListView) return _secondPowerPlay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_secondPowerPlay);
  }

  final List<int> _thirdPowerPlay;
  @override
  @JsonKey()
  List<int> get thirdPowerPlay {
    if (_thirdPowerPlay is EqualUnmodifiableListView) return _thirdPowerPlay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_thirdPowerPlay);
  }

  @override
  String toString() {
    return 'PowerPlayViewState(firstPowerPlay: $firstPowerPlay, secondPowerPlay: $secondPowerPlay, thirdPowerPlay: $thirdPowerPlay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PowerPlayViewStateImpl &&
            const DeepCollectionEquality()
                .equals(other._firstPowerPlay, _firstPowerPlay) &&
            const DeepCollectionEquality()
                .equals(other._secondPowerPlay, _secondPowerPlay) &&
            const DeepCollectionEquality()
                .equals(other._thirdPowerPlay, _thirdPowerPlay));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_firstPowerPlay),
      const DeepCollectionEquality().hash(_secondPowerPlay),
      const DeepCollectionEquality().hash(_thirdPowerPlay));

  /// Create a copy of PowerPlayViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PowerPlayViewStateImplCopyWith<_$PowerPlayViewStateImpl> get copyWith =>
      __$$PowerPlayViewStateImplCopyWithImpl<_$PowerPlayViewStateImpl>(
          this, _$identity);
}

abstract class _PowerPlayViewState implements PowerPlayViewState {
  const factory _PowerPlayViewState(
      {final List<int> firstPowerPlay,
      final List<int> secondPowerPlay,
      final List<int> thirdPowerPlay}) = _$PowerPlayViewStateImpl;

  @override
  List<int> get firstPowerPlay;
  @override
  List<int> get secondPowerPlay;
  @override
  List<int> get thirdPowerPlay;

  /// Create a copy of PowerPlayViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PowerPlayViewStateImplCopyWith<_$PowerPlayViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
