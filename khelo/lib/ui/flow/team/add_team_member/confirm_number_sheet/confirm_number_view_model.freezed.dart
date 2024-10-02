// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'confirm_number_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ConfirmNumberViewState {
  TextEditingController get phoneController =>
      throw _privateConstructorUsedError;
  TextEditingController get nameController =>
      throw _privateConstructorUsedError;
  CountryCode get code => throw _privateConstructorUsedError;
  bool get isButtonEnable => throw _privateConstructorUsedError;
  bool get isForCreateUser => throw _privateConstructorUsedError;
  bool get isPop => throw _privateConstructorUsedError;

  /// Create a copy of ConfirmNumberViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfirmNumberViewStateCopyWith<ConfirmNumberViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfirmNumberViewStateCopyWith<$Res> {
  factory $ConfirmNumberViewStateCopyWith(ConfirmNumberViewState value,
          $Res Function(ConfirmNumberViewState) then) =
      _$ConfirmNumberViewStateCopyWithImpl<$Res, ConfirmNumberViewState>;
  @useResult
  $Res call(
      {TextEditingController phoneController,
      TextEditingController nameController,
      CountryCode code,
      bool isButtonEnable,
      bool isForCreateUser,
      bool isPop});
}

/// @nodoc
class _$ConfirmNumberViewStateCopyWithImpl<$Res,
        $Val extends ConfirmNumberViewState>
    implements $ConfirmNumberViewStateCopyWith<$Res> {
  _$ConfirmNumberViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfirmNumberViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneController = null,
    Object? nameController = null,
    Object? code = null,
    Object? isButtonEnable = null,
    Object? isForCreateUser = null,
    Object? isPop = null,
  }) {
    return _then(_value.copyWith(
      phoneController: null == phoneController
          ? _value.phoneController
          : phoneController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      nameController: null == nameController
          ? _value.nameController
          : nameController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CountryCode,
      isButtonEnable: null == isButtonEnable
          ? _value.isButtonEnable
          : isButtonEnable // ignore: cast_nullable_to_non_nullable
              as bool,
      isForCreateUser: null == isForCreateUser
          ? _value.isForCreateUser
          : isForCreateUser // ignore: cast_nullable_to_non_nullable
              as bool,
      isPop: null == isPop
          ? _value.isPop
          : isPop // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfirmNumberViewStateImplCopyWith<$Res>
    implements $ConfirmNumberViewStateCopyWith<$Res> {
  factory _$$ConfirmNumberViewStateImplCopyWith(
          _$ConfirmNumberViewStateImpl value,
          $Res Function(_$ConfirmNumberViewStateImpl) then) =
      __$$ConfirmNumberViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController phoneController,
      TextEditingController nameController,
      CountryCode code,
      bool isButtonEnable,
      bool isForCreateUser,
      bool isPop});
}

/// @nodoc
class __$$ConfirmNumberViewStateImplCopyWithImpl<$Res>
    extends _$ConfirmNumberViewStateCopyWithImpl<$Res,
        _$ConfirmNumberViewStateImpl>
    implements _$$ConfirmNumberViewStateImplCopyWith<$Res> {
  __$$ConfirmNumberViewStateImplCopyWithImpl(
      _$ConfirmNumberViewStateImpl _value,
      $Res Function(_$ConfirmNumberViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConfirmNumberViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneController = null,
    Object? nameController = null,
    Object? code = null,
    Object? isButtonEnable = null,
    Object? isForCreateUser = null,
    Object? isPop = null,
  }) {
    return _then(_$ConfirmNumberViewStateImpl(
      phoneController: null == phoneController
          ? _value.phoneController
          : phoneController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      nameController: null == nameController
          ? _value.nameController
          : nameController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CountryCode,
      isButtonEnable: null == isButtonEnable
          ? _value.isButtonEnable
          : isButtonEnable // ignore: cast_nullable_to_non_nullable
              as bool,
      isForCreateUser: null == isForCreateUser
          ? _value.isForCreateUser
          : isForCreateUser // ignore: cast_nullable_to_non_nullable
              as bool,
      isPop: null == isPop
          ? _value.isPop
          : isPop // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ConfirmNumberViewStateImpl implements _ConfirmNumberViewState {
  const _$ConfirmNumberViewStateImpl(
      {required this.phoneController,
      required this.nameController,
      required this.code,
      this.isButtonEnable = false,
      this.isForCreateUser = false,
      this.isPop = false});

  @override
  final TextEditingController phoneController;
  @override
  final TextEditingController nameController;
  @override
  final CountryCode code;
  @override
  @JsonKey()
  final bool isButtonEnable;
  @override
  @JsonKey()
  final bool isForCreateUser;
  @override
  @JsonKey()
  final bool isPop;

  @override
  String toString() {
    return 'ConfirmNumberViewState(phoneController: $phoneController, nameController: $nameController, code: $code, isButtonEnable: $isButtonEnable, isForCreateUser: $isForCreateUser, isPop: $isPop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmNumberViewStateImpl &&
            (identical(other.phoneController, phoneController) ||
                other.phoneController == phoneController) &&
            (identical(other.nameController, nameController) ||
                other.nameController == nameController) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.isButtonEnable, isButtonEnable) ||
                other.isButtonEnable == isButtonEnable) &&
            (identical(other.isForCreateUser, isForCreateUser) ||
                other.isForCreateUser == isForCreateUser) &&
            (identical(other.isPop, isPop) || other.isPop == isPop));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneController, nameController,
      code, isButtonEnable, isForCreateUser, isPop);

  /// Create a copy of ConfirmNumberViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmNumberViewStateImplCopyWith<_$ConfirmNumberViewStateImpl>
      get copyWith => __$$ConfirmNumberViewStateImplCopyWithImpl<
          _$ConfirmNumberViewStateImpl>(this, _$identity);
}

abstract class _ConfirmNumberViewState implements ConfirmNumberViewState {
  const factory _ConfirmNumberViewState(
      {required final TextEditingController phoneController,
      required final TextEditingController nameController,
      required final CountryCode code,
      final bool isButtonEnable,
      final bool isForCreateUser,
      final bool isPop}) = _$ConfirmNumberViewStateImpl;

  @override
  TextEditingController get phoneController;
  @override
  TextEditingController get nameController;
  @override
  CountryCode get code;
  @override
  bool get isButtonEnable;
  @override
  bool get isForCreateUser;
  @override
  bool get isPop;

  /// Create a copy of ConfirmNumberViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmNumberViewStateImplCopyWith<_$ConfirmNumberViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
