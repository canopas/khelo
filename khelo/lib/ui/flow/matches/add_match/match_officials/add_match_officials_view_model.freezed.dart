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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddMatchOfficialsState {
  List<Officials> get officials => throw _privateConstructorUsedError;

  /// Create a copy of AddMatchOfficialsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddMatchOfficialsStateCopyWith<AddMatchOfficialsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddMatchOfficialsStateCopyWith<$Res> {
  factory $AddMatchOfficialsStateCopyWith(AddMatchOfficialsState value,
          $Res Function(AddMatchOfficialsState) then) =
      _$AddMatchOfficialsStateCopyWithImpl<$Res, AddMatchOfficialsState>;
  @useResult
  $Res call({List<Officials> officials});
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

  /// Create a copy of AddMatchOfficialsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? officials = null,
  }) {
    return _then(_value.copyWith(
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
  $Res call({List<Officials> officials});
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

  /// Create a copy of AddMatchOfficialsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? officials = null,
  }) {
    return _then(_$AddMatchOfficialsStateImpl(
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
      {final List<Officials> officials = const []})
      : _officials = officials;

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
    return 'AddMatchOfficialsState(officials: $officials)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddMatchOfficialsStateImpl &&
            const DeepCollectionEquality()
                .equals(other._officials, _officials));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_officials));

  /// Create a copy of AddMatchOfficialsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddMatchOfficialsStateImplCopyWith<_$AddMatchOfficialsStateImpl>
      get copyWith => __$$AddMatchOfficialsStateImplCopyWithImpl<
          _$AddMatchOfficialsStateImpl>(this, _$identity);
}

abstract class _AddMatchOfficialsState implements AddMatchOfficialsState {
  const factory _AddMatchOfficialsState({final List<Officials> officials}) =
      _$AddMatchOfficialsStateImpl;

  @override
  List<Officials> get officials;

  /// Create a copy of AddMatchOfficialsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddMatchOfficialsStateImplCopyWith<_$AddMatchOfficialsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
