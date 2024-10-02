// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_selection_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ContactSelectionState {
  Object? get error => throw _privateConstructorUsedError;
  Object? get actionError => throw _privateConstructorUsedError;
  String? get deviceCountryCode => throw _privateConstructorUsedError;
  UserModel? get selectedUser => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get isActionInProgress => throw _privateConstructorUsedError;
  bool get alreadyAdded => throw _privateConstructorUsedError;
  bool get hasContactPermission => throw _privateConstructorUsedError;
  List<Contact> get contacts => throw _privateConstructorUsedError;

  /// Create a copy of ContactSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactSelectionStateCopyWith<ContactSelectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactSelectionStateCopyWith<$Res> {
  factory $ContactSelectionStateCopyWith(ContactSelectionState value,
          $Res Function(ContactSelectionState) then) =
      _$ContactSelectionStateCopyWithImpl<$Res, ContactSelectionState>;
  @useResult
  $Res call(
      {Object? error,
      Object? actionError,
      String? deviceCountryCode,
      UserModel? selectedUser,
      bool loading,
      bool isActionInProgress,
      bool alreadyAdded,
      bool hasContactPermission,
      List<Contact> contacts});

  $UserModelCopyWith<$Res>? get selectedUser;
}

/// @nodoc
class _$ContactSelectionStateCopyWithImpl<$Res,
        $Val extends ContactSelectionState>
    implements $ContactSelectionStateCopyWith<$Res> {
  _$ContactSelectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? actionError = freezed,
    Object? deviceCountryCode = freezed,
    Object? selectedUser = freezed,
    Object? loading = null,
    Object? isActionInProgress = null,
    Object? alreadyAdded = null,
    Object? hasContactPermission = null,
    Object? contacts = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
      deviceCountryCode: freezed == deviceCountryCode
          ? _value.deviceCountryCode
          : deviceCountryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedUser: freezed == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      isActionInProgress: null == isActionInProgress
          ? _value.isActionInProgress
          : isActionInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      alreadyAdded: null == alreadyAdded
          ? _value.alreadyAdded
          : alreadyAdded // ignore: cast_nullable_to_non_nullable
              as bool,
      hasContactPermission: null == hasContactPermission
          ? _value.hasContactPermission
          : hasContactPermission // ignore: cast_nullable_to_non_nullable
              as bool,
      contacts: null == contacts
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
    ) as $Val);
  }

  /// Create a copy of ContactSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get selectedUser {
    if (_value.selectedUser == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.selectedUser!, (value) {
      return _then(_value.copyWith(selectedUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ContactSelectionStateImplCopyWith<$Res>
    implements $ContactSelectionStateCopyWith<$Res> {
  factory _$$ContactSelectionStateImplCopyWith(
          _$ContactSelectionStateImpl value,
          $Res Function(_$ContactSelectionStateImpl) then) =
      __$$ContactSelectionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error,
      Object? actionError,
      String? deviceCountryCode,
      UserModel? selectedUser,
      bool loading,
      bool isActionInProgress,
      bool alreadyAdded,
      bool hasContactPermission,
      List<Contact> contacts});

  @override
  $UserModelCopyWith<$Res>? get selectedUser;
}

/// @nodoc
class __$$ContactSelectionStateImplCopyWithImpl<$Res>
    extends _$ContactSelectionStateCopyWithImpl<$Res,
        _$ContactSelectionStateImpl>
    implements _$$ContactSelectionStateImplCopyWith<$Res> {
  __$$ContactSelectionStateImplCopyWithImpl(_$ContactSelectionStateImpl _value,
      $Res Function(_$ContactSelectionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContactSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? actionError = freezed,
    Object? deviceCountryCode = freezed,
    Object? selectedUser = freezed,
    Object? loading = null,
    Object? isActionInProgress = null,
    Object? alreadyAdded = null,
    Object? hasContactPermission = null,
    Object? contacts = null,
  }) {
    return _then(_$ContactSelectionStateImpl(
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
      deviceCountryCode: freezed == deviceCountryCode
          ? _value.deviceCountryCode
          : deviceCountryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedUser: freezed == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      isActionInProgress: null == isActionInProgress
          ? _value.isActionInProgress
          : isActionInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      alreadyAdded: null == alreadyAdded
          ? _value.alreadyAdded
          : alreadyAdded // ignore: cast_nullable_to_non_nullable
              as bool,
      hasContactPermission: null == hasContactPermission
          ? _value.hasContactPermission
          : hasContactPermission // ignore: cast_nullable_to_non_nullable
              as bool,
      contacts: null == contacts
          ? _value._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
    ));
  }
}

/// @nodoc

class _$ContactSelectionStateImpl implements _ContactSelectionState {
  const _$ContactSelectionStateImpl(
      {this.error,
      this.actionError,
      this.deviceCountryCode,
      this.selectedUser,
      this.loading = false,
      this.isActionInProgress = false,
      this.alreadyAdded = false,
      this.hasContactPermission = false,
      final List<Contact> contacts = const []})
      : _contacts = contacts;

  @override
  final Object? error;
  @override
  final Object? actionError;
  @override
  final String? deviceCountryCode;
  @override
  final UserModel? selectedUser;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool isActionInProgress;
  @override
  @JsonKey()
  final bool alreadyAdded;
  @override
  @JsonKey()
  final bool hasContactPermission;
  final List<Contact> _contacts;
  @override
  @JsonKey()
  List<Contact> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  @override
  String toString() {
    return 'ContactSelectionState(error: $error, actionError: $actionError, deviceCountryCode: $deviceCountryCode, selectedUser: $selectedUser, loading: $loading, isActionInProgress: $isActionInProgress, alreadyAdded: $alreadyAdded, hasContactPermission: $hasContactPermission, contacts: $contacts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactSelectionStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError) &&
            (identical(other.deviceCountryCode, deviceCountryCode) ||
                other.deviceCountryCode == deviceCountryCode) &&
            (identical(other.selectedUser, selectedUser) ||
                other.selectedUser == selectedUser) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.isActionInProgress, isActionInProgress) ||
                other.isActionInProgress == isActionInProgress) &&
            (identical(other.alreadyAdded, alreadyAdded) ||
                other.alreadyAdded == alreadyAdded) &&
            (identical(other.hasContactPermission, hasContactPermission) ||
                other.hasContactPermission == hasContactPermission) &&
            const DeepCollectionEquality().equals(other._contacts, _contacts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(actionError),
      deviceCountryCode,
      selectedUser,
      loading,
      isActionInProgress,
      alreadyAdded,
      hasContactPermission,
      const DeepCollectionEquality().hash(_contacts));

  /// Create a copy of ContactSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactSelectionStateImplCopyWith<_$ContactSelectionStateImpl>
      get copyWith => __$$ContactSelectionStateImplCopyWithImpl<
          _$ContactSelectionStateImpl>(this, _$identity);
}

abstract class _ContactSelectionState implements ContactSelectionState {
  const factory _ContactSelectionState(
      {final Object? error,
      final Object? actionError,
      final String? deviceCountryCode,
      final UserModel? selectedUser,
      final bool loading,
      final bool isActionInProgress,
      final bool alreadyAdded,
      final bool hasContactPermission,
      final List<Contact> contacts}) = _$ContactSelectionStateImpl;

  @override
  Object? get error;
  @override
  Object? get actionError;
  @override
  String? get deviceCountryCode;
  @override
  UserModel? get selectedUser;
  @override
  bool get loading;
  @override
  bool get isActionInProgress;
  @override
  bool get alreadyAdded;
  @override
  bool get hasContactPermission;
  @override
  List<Contact> get contacts;

  /// Create a copy of ContactSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactSelectionStateImplCopyWith<_$ContactSelectionStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
