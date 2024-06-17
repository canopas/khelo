// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_support_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ContactSupportViewStat {
  bool get submitting => throw _privateConstructorUsedError;
  bool get enableSubmit => throw _privateConstructorUsedError;
  TextEditingController get titleController =>
      throw _privateConstructorUsedError;
  TextEditingController get descriptionController =>
      throw _privateConstructorUsedError;
  Object? get actionError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ContactSupportViewStatCopyWith<ContactSupportViewStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactSupportViewStatCopyWith<$Res> {
  factory $ContactSupportViewStatCopyWith(ContactSupportViewStat value,
          $Res Function(ContactSupportViewStat) then) =
      _$ContactSupportViewStatCopyWithImpl<$Res, ContactSupportViewStat>;
  @useResult
  $Res call(
      {bool submitting,
      bool enableSubmit,
      TextEditingController titleController,
      TextEditingController descriptionController,
      Object? actionError});
}

/// @nodoc
class _$ContactSupportViewStatCopyWithImpl<$Res,
        $Val extends ContactSupportViewStat>
    implements $ContactSupportViewStatCopyWith<$Res> {
  _$ContactSupportViewStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? submitting = null,
    Object? enableSubmit = null,
    Object? titleController = null,
    Object? descriptionController = null,
    Object? actionError = freezed,
  }) {
    return _then(_value.copyWith(
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSubmit: null == enableSubmit
          ? _value.enableSubmit
          : enableSubmit // ignore: cast_nullable_to_non_nullable
              as bool,
      titleController: null == titleController
          ? _value.titleController
          : titleController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      descriptionController: null == descriptionController
          ? _value.descriptionController
          : descriptionController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      actionError: freezed == actionError ? _value.actionError : actionError,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactSupportViewStatImplCopyWith<$Res>
    implements $ContactSupportViewStatCopyWith<$Res> {
  factory _$$ContactSupportViewStatImplCopyWith(
          _$ContactSupportViewStatImpl value,
          $Res Function(_$ContactSupportViewStatImpl) then) =
      __$$ContactSupportViewStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool submitting,
      bool enableSubmit,
      TextEditingController titleController,
      TextEditingController descriptionController,
      Object? actionError});
}

/// @nodoc
class __$$ContactSupportViewStatImplCopyWithImpl<$Res>
    extends _$ContactSupportViewStatCopyWithImpl<$Res,
        _$ContactSupportViewStatImpl>
    implements _$$ContactSupportViewStatImplCopyWith<$Res> {
  __$$ContactSupportViewStatImplCopyWithImpl(
      _$ContactSupportViewStatImpl _value,
      $Res Function(_$ContactSupportViewStatImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? submitting = null,
    Object? enableSubmit = null,
    Object? titleController = null,
    Object? descriptionController = null,
    Object? actionError = freezed,
  }) {
    return _then(_$ContactSupportViewStatImpl(
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSubmit: null == enableSubmit
          ? _value.enableSubmit
          : enableSubmit // ignore: cast_nullable_to_non_nullable
              as bool,
      titleController: null == titleController
          ? _value.titleController
          : titleController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      descriptionController: null == descriptionController
          ? _value.descriptionController
          : descriptionController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      actionError: freezed == actionError ? _value.actionError : actionError,
    ));
  }
}

/// @nodoc

class _$ContactSupportViewStatImpl implements _ContactSupportViewStat {
  const _$ContactSupportViewStatImpl(
      {this.submitting = false,
      this.enableSubmit = false,
      required this.titleController,
      required this.descriptionController,
      this.actionError});

  @override
  @JsonKey()
  final bool submitting;
  @override
  @JsonKey()
  final bool enableSubmit;
  @override
  final TextEditingController titleController;
  @override
  final TextEditingController descriptionController;
  @override
  final Object? actionError;

  @override
  String toString() {
    return 'ContactSupportViewStat(submitting: $submitting, enableSubmit: $enableSubmit, titleController: $titleController, descriptionController: $descriptionController, actionError: $actionError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactSupportViewStatImpl &&
            (identical(other.submitting, submitting) ||
                other.submitting == submitting) &&
            (identical(other.enableSubmit, enableSubmit) ||
                other.enableSubmit == enableSubmit) &&
            (identical(other.titleController, titleController) ||
                other.titleController == titleController) &&
            (identical(other.descriptionController, descriptionController) ||
                other.descriptionController == descriptionController) &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      submitting,
      enableSubmit,
      titleController,
      descriptionController,
      const DeepCollectionEquality().hash(actionError));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactSupportViewStatImplCopyWith<_$ContactSupportViewStatImpl>
      get copyWith => __$$ContactSupportViewStatImplCopyWithImpl<
          _$ContactSupportViewStatImpl>(this, _$identity);
}

abstract class _ContactSupportViewStat implements ContactSupportViewStat {
  const factory _ContactSupportViewStat(
      {final bool submitting,
      final bool enableSubmit,
      required final TextEditingController titleController,
      required final TextEditingController descriptionController,
      final Object? actionError}) = _$ContactSupportViewStatImpl;

  @override
  bool get submitting;
  @override
  bool get enableSubmit;
  @override
  TextEditingController get titleController;
  @override
  TextEditingController get descriptionController;
  @override
  Object? get actionError;
  @override
  @JsonKey(ignore: true)
  _$$ContactSupportViewStatImplCopyWith<_$ContactSupportViewStatImpl>
      get copyWith => throw _privateConstructorUsedError;
}
