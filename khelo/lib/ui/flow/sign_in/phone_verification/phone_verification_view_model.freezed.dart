// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_verification_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PhoneVerificationState {
  bool get verifying => throw _privateConstructorUsedError;
  bool get enableVerify => throw _privateConstructorUsedError;
  bool get isVerificationComplete => throw _privateConstructorUsedError;
  bool get showErrorVerificationCodeText => throw _privateConstructorUsedError;
  String? get verificationId => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;
  Duration get activeResendDuration => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PhoneVerificationStateCopyWith<PhoneVerificationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneVerificationStateCopyWith<$Res> {
  factory $PhoneVerificationStateCopyWith(PhoneVerificationState value,
          $Res Function(PhoneVerificationState) then) =
      _$PhoneVerificationStateCopyWithImpl<$Res, PhoneVerificationState>;
  @useResult
  $Res call(
      {bool verifying,
      bool enableVerify,
      bool isVerificationComplete,
      bool showErrorVerificationCodeText,
      String? verificationId,
      String otp,
      Duration activeResendDuration,
      Object? error});
}

/// @nodoc
class _$PhoneVerificationStateCopyWithImpl<$Res,
        $Val extends PhoneVerificationState>
    implements $PhoneVerificationStateCopyWith<$Res> {
  _$PhoneVerificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verifying = null,
    Object? enableVerify = null,
    Object? isVerificationComplete = null,
    Object? showErrorVerificationCodeText = null,
    Object? verificationId = freezed,
    Object? otp = null,
    Object? activeResendDuration = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      verifying: null == verifying
          ? _value.verifying
          : verifying // ignore: cast_nullable_to_non_nullable
              as bool,
      enableVerify: null == enableVerify
          ? _value.enableVerify
          : enableVerify // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerificationComplete: null == isVerificationComplete
          ? _value.isVerificationComplete
          : isVerificationComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorVerificationCodeText: null == showErrorVerificationCodeText
          ? _value.showErrorVerificationCodeText
          : showErrorVerificationCodeText // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationId: freezed == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      activeResendDuration: null == activeResendDuration
          ? _value.activeResendDuration
          : activeResendDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      error: freezed == error ? _value.error : error,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhoneVerificationStateImplCopyWith<$Res>
    implements $PhoneVerificationStateCopyWith<$Res> {
  factory _$$PhoneVerificationStateImplCopyWith(
          _$PhoneVerificationStateImpl value,
          $Res Function(_$PhoneVerificationStateImpl) then) =
      __$$PhoneVerificationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool verifying,
      bool enableVerify,
      bool isVerificationComplete,
      bool showErrorVerificationCodeText,
      String? verificationId,
      String otp,
      Duration activeResendDuration,
      Object? error});
}

/// @nodoc
class __$$PhoneVerificationStateImplCopyWithImpl<$Res>
    extends _$PhoneVerificationStateCopyWithImpl<$Res,
        _$PhoneVerificationStateImpl>
    implements _$$PhoneVerificationStateImplCopyWith<$Res> {
  __$$PhoneVerificationStateImplCopyWithImpl(
      _$PhoneVerificationStateImpl _value,
      $Res Function(_$PhoneVerificationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verifying = null,
    Object? enableVerify = null,
    Object? isVerificationComplete = null,
    Object? showErrorVerificationCodeText = null,
    Object? verificationId = freezed,
    Object? otp = null,
    Object? activeResendDuration = null,
    Object? error = freezed,
  }) {
    return _then(_$PhoneVerificationStateImpl(
      verifying: null == verifying
          ? _value.verifying
          : verifying // ignore: cast_nullable_to_non_nullable
              as bool,
      enableVerify: null == enableVerify
          ? _value.enableVerify
          : enableVerify // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerificationComplete: null == isVerificationComplete
          ? _value.isVerificationComplete
          : isVerificationComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorVerificationCodeText: null == showErrorVerificationCodeText
          ? _value.showErrorVerificationCodeText
          : showErrorVerificationCodeText // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationId: freezed == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      activeResendDuration: null == activeResendDuration
          ? _value.activeResendDuration
          : activeResendDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$PhoneVerificationStateImpl implements _PhoneVerificationState {
  const _$PhoneVerificationStateImpl(
      {this.verifying = false,
      this.enableVerify = false,
      this.isVerificationComplete = false,
      this.showErrorVerificationCodeText = false,
      this.verificationId,
      this.otp = '',
      this.activeResendDuration = const Duration(seconds: 30),
      this.error});

  @override
  @JsonKey()
  final bool verifying;
  @override
  @JsonKey()
  final bool enableVerify;
  @override
  @JsonKey()
  final bool isVerificationComplete;
  @override
  @JsonKey()
  final bool showErrorVerificationCodeText;
  @override
  final String? verificationId;
  @override
  @JsonKey()
  final String otp;
  @override
  @JsonKey()
  final Duration activeResendDuration;
  @override
  final Object? error;

  @override
  String toString() {
    return 'PhoneVerificationState(verifying: $verifying, enableVerify: $enableVerify, isVerificationComplete: $isVerificationComplete, showErrorVerificationCodeText: $showErrorVerificationCodeText, verificationId: $verificationId, otp: $otp, activeResendDuration: $activeResendDuration, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneVerificationStateImpl &&
            (identical(other.verifying, verifying) ||
                other.verifying == verifying) &&
            (identical(other.enableVerify, enableVerify) ||
                other.enableVerify == enableVerify) &&
            (identical(other.isVerificationComplete, isVerificationComplete) ||
                other.isVerificationComplete == isVerificationComplete) &&
            (identical(other.showErrorVerificationCodeText,
                    showErrorVerificationCodeText) ||
                other.showErrorVerificationCodeText ==
                    showErrorVerificationCodeText) &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.activeResendDuration, activeResendDuration) ||
                other.activeResendDuration == activeResendDuration) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      verifying,
      enableVerify,
      isVerificationComplete,
      showErrorVerificationCodeText,
      verificationId,
      otp,
      activeResendDuration,
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneVerificationStateImplCopyWith<_$PhoneVerificationStateImpl>
      get copyWith => __$$PhoneVerificationStateImplCopyWithImpl<
          _$PhoneVerificationStateImpl>(this, _$identity);
}

abstract class _PhoneVerificationState implements PhoneVerificationState {
  const factory _PhoneVerificationState(
      {final bool verifying,
      final bool enableVerify,
      final bool isVerificationComplete,
      final bool showErrorVerificationCodeText,
      final String? verificationId,
      final String otp,
      final Duration activeResendDuration,
      final Object? error}) = _$PhoneVerificationStateImpl;

  @override
  bool get verifying;
  @override
  bool get enableVerify;
  @override
  bool get isVerificationComplete;
  @override
  bool get showErrorVerificationCodeText;
  @override
  String? get verificationId;
  @override
  String get otp;
  @override
  Duration get activeResendDuration;
  @override
  Object? get error;
  @override
  @JsonKey(ignore: true)
  _$$PhoneVerificationStateImplCopyWith<_$PhoneVerificationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
