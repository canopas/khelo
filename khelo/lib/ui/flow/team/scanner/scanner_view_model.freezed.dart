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
  QRViewController? get controller => throw _privateConstructorUsedError;
  String get scannedId => throw _privateConstructorUsedError;
  bool get flashOn => throw _privateConstructorUsedError;
  bool get hasPermission => throw _privateConstructorUsedError;

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
      QRViewController? controller,
      String scannedId,
      bool flashOn,
      bool hasPermission});
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
    Object? controller = freezed,
    Object? scannedId = null,
    Object? flashOn = null,
    Object? hasPermission = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as QRViewController?,
      scannedId: null == scannedId
          ? _value.scannedId
          : scannedId // ignore: cast_nullable_to_non_nullable
              as String,
      flashOn: null == flashOn
          ? _value.flashOn
          : flashOn // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPermission: null == hasPermission
          ? _value.hasPermission
          : hasPermission // ignore: cast_nullable_to_non_nullable
              as bool,
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
      QRViewController? controller,
      String scannedId,
      bool flashOn,
      bool hasPermission});
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
    Object? controller = freezed,
    Object? scannedId = null,
    Object? flashOn = null,
    Object? hasPermission = null,
  }) {
    return _then(_$ScannerStateImpl(
      error: freezed == error ? _value.error : error,
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as QRViewController?,
      scannedId: null == scannedId
          ? _value.scannedId
          : scannedId // ignore: cast_nullable_to_non_nullable
              as String,
      flashOn: null == flashOn
          ? _value.flashOn
          : flashOn // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPermission: null == hasPermission
          ? _value.hasPermission
          : hasPermission // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ScannerStateImpl implements _ScannerState {
  const _$ScannerStateImpl(
      {this.error,
      this.controller,
      this.scannedId = '',
      this.flashOn = false,
      this.hasPermission = false});

  @override
  final Object? error;
  @override
  final QRViewController? controller;
  @override
  @JsonKey()
  final String scannedId;
  @override
  @JsonKey()
  final bool flashOn;
  @override
  @JsonKey()
  final bool hasPermission;

  @override
  String toString() {
    return 'ScannerState(error: $error, controller: $controller, scannedId: $scannedId, flashOn: $flashOn, hasPermission: $hasPermission)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScannerStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.controller, controller) ||
                other.controller == controller) &&
            (identical(other.scannedId, scannedId) ||
                other.scannedId == scannedId) &&
            (identical(other.flashOn, flashOn) || other.flashOn == flashOn) &&
            (identical(other.hasPermission, hasPermission) ||
                other.hasPermission == hasPermission));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      controller,
      scannedId,
      flashOn,
      hasPermission);

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
      final QRViewController? controller,
      final String scannedId,
      final bool flashOn,
      final bool hasPermission}) = _$ScannerStateImpl;

  @override
  Object? get error;
  @override
  QRViewController? get controller;
  @override
  String get scannedId;
  @override
  bool get flashOn;
  @override
  bool get hasPermission;

  /// Create a copy of ScannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScannerStateImplCopyWith<_$ScannerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
