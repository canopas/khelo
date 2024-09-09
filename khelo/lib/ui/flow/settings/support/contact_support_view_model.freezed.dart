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
mixin _$ContactSupportViewState {
  Object? get actionError => throw _privateConstructorUsedError;
  bool get submitting => throw _privateConstructorUsedError;
  bool get enableSubmit => throw _privateConstructorUsedError;
  bool get pop => throw _privateConstructorUsedError;
  TextEditingController get titleController =>
      throw _privateConstructorUsedError;
  TextEditingController get descriptionController =>
      throw _privateConstructorUsedError;
  List<Attachment> get attachments => throw _privateConstructorUsedError;

  /// Create a copy of ContactSupportViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactSupportViewStateCopyWith<ContactSupportViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactSupportViewStateCopyWith<$Res> {
  factory $ContactSupportViewStateCopyWith(ContactSupportViewState value,
          $Res Function(ContactSupportViewState) then) =
      _$ContactSupportViewStateCopyWithImpl<$Res, ContactSupportViewState>;
  @useResult
  $Res call(
      {Object? actionError,
      bool submitting,
      bool enableSubmit,
      bool pop,
      TextEditingController titleController,
      TextEditingController descriptionController,
      List<Attachment> attachments});
}

/// @nodoc
class _$ContactSupportViewStateCopyWithImpl<$Res,
        $Val extends ContactSupportViewState>
    implements $ContactSupportViewStateCopyWith<$Res> {
  _$ContactSupportViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactSupportViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionError = freezed,
    Object? submitting = null,
    Object? enableSubmit = null,
    Object? pop = null,
    Object? titleController = null,
    Object? descriptionController = null,
    Object? attachments = null,
  }) {
    return _then(_value.copyWith(
      actionError: freezed == actionError ? _value.actionError : actionError,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSubmit: null == enableSubmit
          ? _value.enableSubmit
          : enableSubmit // ignore: cast_nullable_to_non_nullable
              as bool,
      pop: null == pop
          ? _value.pop
          : pop // ignore: cast_nullable_to_non_nullable
              as bool,
      titleController: null == titleController
          ? _value.titleController
          : titleController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      descriptionController: null == descriptionController
          ? _value.descriptionController
          : descriptionController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactSupportViewStateImplCopyWith<$Res>
    implements $ContactSupportViewStateCopyWith<$Res> {
  factory _$$ContactSupportViewStateImplCopyWith(
          _$ContactSupportViewStateImpl value,
          $Res Function(_$ContactSupportViewStateImpl) then) =
      __$$ContactSupportViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? actionError,
      bool submitting,
      bool enableSubmit,
      bool pop,
      TextEditingController titleController,
      TextEditingController descriptionController,
      List<Attachment> attachments});
}

/// @nodoc
class __$$ContactSupportViewStateImplCopyWithImpl<$Res>
    extends _$ContactSupportViewStateCopyWithImpl<$Res,
        _$ContactSupportViewStateImpl>
    implements _$$ContactSupportViewStateImplCopyWith<$Res> {
  __$$ContactSupportViewStateImplCopyWithImpl(
      _$ContactSupportViewStateImpl _value,
      $Res Function(_$ContactSupportViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContactSupportViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionError = freezed,
    Object? submitting = null,
    Object? enableSubmit = null,
    Object? pop = null,
    Object? titleController = null,
    Object? descriptionController = null,
    Object? attachments = null,
  }) {
    return _then(_$ContactSupportViewStateImpl(
      actionError: freezed == actionError ? _value.actionError : actionError,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSubmit: null == enableSubmit
          ? _value.enableSubmit
          : enableSubmit // ignore: cast_nullable_to_non_nullable
              as bool,
      pop: null == pop
          ? _value.pop
          : pop // ignore: cast_nullable_to_non_nullable
              as bool,
      titleController: null == titleController
          ? _value.titleController
          : titleController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      descriptionController: null == descriptionController
          ? _value.descriptionController
          : descriptionController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
    ));
  }
}

/// @nodoc

class _$ContactSupportViewStateImpl implements _ContactSupportViewState {
  const _$ContactSupportViewStateImpl(
      {this.actionError,
      this.submitting = false,
      this.enableSubmit = false,
      this.pop = false,
      required this.titleController,
      required this.descriptionController,
      final List<Attachment> attachments = const []})
      : _attachments = attachments;

  @override
  final Object? actionError;
  @override
  @JsonKey()
  final bool submitting;
  @override
  @JsonKey()
  final bool enableSubmit;
  @override
  @JsonKey()
  final bool pop;
  @override
  final TextEditingController titleController;
  @override
  final TextEditingController descriptionController;
  final List<Attachment> _attachments;
  @override
  @JsonKey()
  List<Attachment> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  String toString() {
    return 'ContactSupportViewState(actionError: $actionError, submitting: $submitting, enableSubmit: $enableSubmit, pop: $pop, titleController: $titleController, descriptionController: $descriptionController, attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactSupportViewStateImpl &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError) &&
            (identical(other.submitting, submitting) ||
                other.submitting == submitting) &&
            (identical(other.enableSubmit, enableSubmit) ||
                other.enableSubmit == enableSubmit) &&
            (identical(other.pop, pop) || other.pop == pop) &&
            (identical(other.titleController, titleController) ||
                other.titleController == titleController) &&
            (identical(other.descriptionController, descriptionController) ||
                other.descriptionController == descriptionController) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(actionError),
      submitting,
      enableSubmit,
      pop,
      titleController,
      descriptionController,
      const DeepCollectionEquality().hash(_attachments));

  /// Create a copy of ContactSupportViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactSupportViewStateImplCopyWith<_$ContactSupportViewStateImpl>
      get copyWith => __$$ContactSupportViewStateImplCopyWithImpl<
          _$ContactSupportViewStateImpl>(this, _$identity);
}

abstract class _ContactSupportViewState implements ContactSupportViewState {
  const factory _ContactSupportViewState(
      {final Object? actionError,
      final bool submitting,
      final bool enableSubmit,
      final bool pop,
      required final TextEditingController titleController,
      required final TextEditingController descriptionController,
      final List<Attachment> attachments}) = _$ContactSupportViewStateImpl;

  @override
  Object? get actionError;
  @override
  bool get submitting;
  @override
  bool get enableSubmit;
  @override
  bool get pop;
  @override
  TextEditingController get titleController;
  @override
  TextEditingController get descriptionController;
  @override
  List<Attachment> get attachments;

  /// Create a copy of ContactSupportViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactSupportViewStateImplCopyWith<_$ContactSupportViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
