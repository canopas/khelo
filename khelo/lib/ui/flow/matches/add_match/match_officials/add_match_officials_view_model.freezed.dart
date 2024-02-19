// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_match_officials_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddMatchOfficialsState {
  Object? get error => throw _privateConstructorUsedError;
  List<Officials> get officials => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddMatchOfficialsStateCopyWith<AddMatchOfficialsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddMatchOfficialsStateCopyWith<$Res> {
  factory $AddMatchOfficialsStateCopyWith(AddMatchOfficialsState value,
          $Res Function(AddMatchOfficialsState) then) =
      _$AddMatchOfficialsStateCopyWithImpl<$Res, AddMatchOfficialsState>;
  @useResult
  $Res call({Object? error, List<Officials> officials});
}

/// @nodoc
class _$AddMatchOfficialsStateCopyWithImpl<$Res,
        $Val extends AddMatchOfficialsState>
    implements $AddMatchOfficialsStateCopyWith<$Res> {
  _$AddMatchOfficialsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? officials = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      officials: null == officials
          ? _value.officials
          : officials // ignore: cast_nullable_to_non_nullable
              as List<Officials>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddMatchOfficialsStateImplCopyWith<$Res>
    implements $AddMatchOfficialsStateCopyWith<$Res> {
  factory _$$AddMatchOfficialsStateImplCopyWith(
          _$AddMatchOfficialsStateImpl value,
          $Res Function(_$AddMatchOfficialsStateImpl) then) =
      __$$AddMatchOfficialsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Object? error, List<Officials> officials});
}

/// @nodoc
class __$$AddMatchOfficialsStateImplCopyWithImpl<$Res>
    extends _$AddMatchOfficialsStateCopyWithImpl<$Res,
        _$AddMatchOfficialsStateImpl>
    implements _$$AddMatchOfficialsStateImplCopyWith<$Res> {
  __$$AddMatchOfficialsStateImplCopyWithImpl(
      _$AddMatchOfficialsStateImpl _value,
      $Res Function(_$AddMatchOfficialsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? officials = null,
  }) {
    return _then(_$AddMatchOfficialsStateImpl(
      error: freezed == error ? _value.error : error,
      officials: null == officials
          ? _value._officials
          : officials // ignore: cast_nullable_to_non_nullable
              as List<Officials>,
    ));
  }
}

/// @nodoc

class _$AddMatchOfficialsStateImpl implements _AddMatchOfficialsState {
  const _$AddMatchOfficialsStateImpl(
      {this.error, final List<Officials> officials = const []})
      : _officials = officials;

  @override
  final Object? error;
  final List<Officials> _officials;
  @override
  @JsonKey()
  List<Officials> get officials {
    if (_officials is EqualUnmodifiableListView) return _officials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_officials);
  }

  @override
  String toString() {
    return 'AddMatchOfficialsState(error: $error, officials: $officials)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddMatchOfficialsStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other._officials, _officials));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(_officials));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddMatchOfficialsStateImplCopyWith<_$AddMatchOfficialsStateImpl>
      get copyWith => __$$AddMatchOfficialsStateImplCopyWithImpl<
          _$AddMatchOfficialsStateImpl>(this, _$identity);
}

abstract class _AddMatchOfficialsState implements AddMatchOfficialsState {
  const factory _AddMatchOfficialsState(
      {final Object? error,
      final List<Officials> officials}) = _$AddMatchOfficialsStateImpl;

  @override
  Object? get error;
  @override
  List<Officials> get officials;
  @override
  @JsonKey(ignore: true)
  _$$AddMatchOfficialsStateImplCopyWith<_$AddMatchOfficialsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
