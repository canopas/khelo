// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileState {
  Object? get actionError => throw _privateConstructorUsedError;
  UserModel? get currentUser => throw _privateConstructorUsedError;
  String? get appVersion => throw _privateConstructorUsedError;
  bool get enableUserNotification => throw _privateConstructorUsedError;
  bool get shouldShowNotificationBanner => throw _privateConstructorUsedError;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileStateCopyWith<ProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
          ProfileState value, $Res Function(ProfileState) then) =
      _$ProfileStateCopyWithImpl<$Res, ProfileState>;
  @useResult
  $Res call(
      {Object? actionError,
      UserModel? currentUser,
      String? appVersion,
      bool enableUserNotification,
      bool shouldShowNotificationBanner});

  $UserModelCopyWith<$Res>? get currentUser;
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionError = freezed,
    Object? currentUser = freezed,
    Object? appVersion = freezed,
    Object? enableUserNotification = null,
    Object? shouldShowNotificationBanner = null,
  }) {
    return _then(_value.copyWith(
      actionError: freezed == actionError ? _value.actionError : actionError,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      appVersion: freezed == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      enableUserNotification: null == enableUserNotification
          ? _value.enableUserNotification
          : enableUserNotification // ignore: cast_nullable_to_non_nullable
              as bool,
      shouldShowNotificationBanner: null == shouldShowNotificationBanner
          ? _value.shouldShowNotificationBanner
          : shouldShowNotificationBanner // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get currentUser {
    if (_value.currentUser == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.currentUser!, (value) {
      return _then(_value.copyWith(currentUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileStateImplCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$$ProfileStateImplCopyWith(
          _$ProfileStateImpl value, $Res Function(_$ProfileStateImpl) then) =
      __$$ProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? actionError,
      UserModel? currentUser,
      String? appVersion,
      bool enableUserNotification,
      bool shouldShowNotificationBanner});

  @override
  $UserModelCopyWith<$Res>? get currentUser;
}

/// @nodoc
class __$$ProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileStateImpl>
    implements _$$ProfileStateImplCopyWith<$Res> {
  __$$ProfileStateImplCopyWithImpl(
      _$ProfileStateImpl _value, $Res Function(_$ProfileStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionError = freezed,
    Object? currentUser = freezed,
    Object? appVersion = freezed,
    Object? enableUserNotification = null,
    Object? shouldShowNotificationBanner = null,
  }) {
    return _then(_$ProfileStateImpl(
      actionError: freezed == actionError ? _value.actionError : actionError,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      appVersion: freezed == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      enableUserNotification: null == enableUserNotification
          ? _value.enableUserNotification
          : enableUserNotification // ignore: cast_nullable_to_non_nullable
              as bool,
      shouldShowNotificationBanner: null == shouldShowNotificationBanner
          ? _value.shouldShowNotificationBanner
          : shouldShowNotificationBanner // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ProfileStateImpl with DiagnosticableTreeMixin implements _ProfileState {
  const _$ProfileStateImpl(
      {this.actionError,
      this.currentUser,
      this.appVersion,
      this.enableUserNotification = true,
      this.shouldShowNotificationBanner = false});

  @override
  final Object? actionError;
  @override
  final UserModel? currentUser;
  @override
  final String? appVersion;
  @override
  @JsonKey()
  final bool enableUserNotification;
  @override
  @JsonKey()
  final bool shouldShowNotificationBanner;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileState(actionError: $actionError, currentUser: $currentUser, appVersion: $appVersion, enableUserNotification: $enableUserNotification, shouldShowNotificationBanner: $shouldShowNotificationBanner)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileState'))
      ..add(DiagnosticsProperty('actionError', actionError))
      ..add(DiagnosticsProperty('currentUser', currentUser))
      ..add(DiagnosticsProperty('appVersion', appVersion))
      ..add(
          DiagnosticsProperty('enableUserNotification', enableUserNotification))
      ..add(DiagnosticsProperty(
          'shouldShowNotificationBanner', shouldShowNotificationBanner));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileStateImpl &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError) &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.enableUserNotification, enableUserNotification) ||
                other.enableUserNotification == enableUserNotification) &&
            (identical(other.shouldShowNotificationBanner,
                    shouldShowNotificationBanner) ||
                other.shouldShowNotificationBanner ==
                    shouldShowNotificationBanner));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(actionError),
      currentUser,
      appVersion,
      enableUserNotification,
      shouldShowNotificationBanner);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      __$$ProfileStateImplCopyWithImpl<_$ProfileStateImpl>(this, _$identity);
}

abstract class _ProfileState implements ProfileState {
  const factory _ProfileState(
      {final Object? actionError,
      final UserModel? currentUser,
      final String? appVersion,
      final bool enableUserNotification,
      final bool shouldShowNotificationBanner}) = _$ProfileStateImpl;

  @override
  Object? get actionError;
  @override
  UserModel? get currentUser;
  @override
  String? get appVersion;
  @override
  bool get enableUserNotification;
  @override
  bool get shouldShowNotificationBanner;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
