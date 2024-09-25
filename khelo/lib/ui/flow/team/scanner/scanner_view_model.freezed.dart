// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scanner_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ScannerState {
  Object? get error => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  bool get flashOn => throw _privateConstructorUsedError;
  bool get hasPermission => throw _privateConstructorUsedError;
  MobileScannerController get controller => throw _privateConstructorUsedError;

  /// Create a copy of ScannerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScannerStateCopyWith<ScannerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScannerStateCopyWith<$Res> {
  factory $ScannerStateCopyWith(
          ScannerState value, $Res Function(ScannerState) then) =
      _$ScannerStateCopyWithImpl<$Res, ScannerState>;
  @useResult
  $Res call(
      {Object? error,
      String userId,
      bool flashOn,
      bool hasPermission,
      MobileScannerController controller});
}

/// @nodoc
class _$ScannerStateCopyWithImpl<$Res, $Val extends ScannerState>
    implements $ScannerStateCopyWith<$Res> {
  _$ScannerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScannerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? userId = null,
    Object? flashOn = null,
    Object? hasPermission = null,
    Object? controller = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      flashOn: null == flashOn
          ? _value.flashOn
          : flashOn // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPermission: null == hasPermission
          ? _value.hasPermission
          : hasPermission // ignore: cast_nullable_to_non_nullable
              as bool,
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as MobileScannerController,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScannerStateImplCopyWith<$Res>
    implements $ScannerStateCopyWith<$Res> {
  factory _$$ScannerStateImplCopyWith(
          _$ScannerStateImpl value, $Res Function(_$ScannerStateImpl) then) =
      __$$ScannerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error,
      String userId,
      bool flashOn,
      bool hasPermission,
      MobileScannerController controller});
}

/// @nodoc
class __$$ScannerStateImplCopyWithImpl<$Res>
    extends _$ScannerStateCopyWithImpl<$Res, _$ScannerStateImpl>
    implements _$$ScannerStateImplCopyWith<$Res> {
  __$$ScannerStateImplCopyWithImpl(
      _$ScannerStateImpl _value, $Res Function(_$ScannerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScannerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? userId = null,
    Object? flashOn = null,
    Object? hasPermission = null,
    Object? controller = null,
  }) {
    return _then(_$ScannerStateImpl(
      error: freezed == error ? _value.error : error,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      flashOn: null == flashOn
          ? _value.flashOn
          : flashOn // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPermission: null == hasPermission
          ? _value.hasPermission
          : hasPermission // ignore: cast_nullable_to_non_nullable
              as bool,
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as MobileScannerController,
    ));
  }
}

/// @nodoc

class _$ScannerStateImpl implements _ScannerState {
  const _$ScannerStateImpl(
      {this.error,
      this.userId = '',
      this.flashOn = false,
      this.hasPermission = false,
      required this.controller});

  @override
  final Object? error;
  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final bool flashOn;
  @override
  @JsonKey()
  final bool hasPermission;
  @override
  final MobileScannerController controller;

  @override
  String toString() {
    return 'ScannerState(error: $error, userId: $userId, flashOn: $flashOn, hasPermission: $hasPermission, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScannerStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.flashOn, flashOn) || other.flashOn == flashOn) &&
            (identical(other.hasPermission, hasPermission) ||
                other.hasPermission == hasPermission) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      userId,
      flashOn,
      hasPermission,
      controller);

  /// Create a copy of ScannerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScannerStateImplCopyWith<_$ScannerStateImpl> get copyWith =>
      __$$ScannerStateImplCopyWithImpl<_$ScannerStateImpl>(this, _$identity);
}

abstract class _ScannerState implements ScannerState {
  const factory _ScannerState(
      {final Object? error,
      final String userId,
      final bool flashOn,
      final bool hasPermission,
      required final MobileScannerController controller}) = _$ScannerStateImpl;

  @override
  Object? get error;
  @override
  String get userId;
  @override
  bool get flashOn;
  @override
  bool get hasPermission;
  @override
  MobileScannerController get controller;

  /// Create a copy of ScannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScannerStateImplCopyWith<_$ScannerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
