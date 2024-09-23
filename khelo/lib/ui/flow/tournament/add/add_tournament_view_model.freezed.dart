// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_tournament_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddTournamentState {
  Object? get error => throw _privateConstructorUsedError;
  Object? get actionError => throw _privateConstructorUsedError;
  bool get imageUploading => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  String? get profileFilePath => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;

  /// Create a copy of AddTournamentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddTournamentStateCopyWith<AddTournamentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddTournamentStateCopyWith<$Res> {
  factory $AddTournamentStateCopyWith(
          AddTournamentState value, $Res Function(AddTournamentState) then) =
      _$AddTournamentStateCopyWithImpl<$Res, AddTournamentState>;
  @useResult
  $Res call(
      {Object? error,
      Object? actionError,
      bool imageUploading,
      bool loading,
      String? profileFilePath,
      String? profileImageUrl});
}

/// @nodoc
class _$AddTournamentStateCopyWithImpl<$Res, $Val extends AddTournamentState>
    implements $AddTournamentStateCopyWith<$Res> {
  _$AddTournamentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddTournamentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? actionError = freezed,
    Object? imageUploading = null,
    Object? loading = null,
    Object? profileFilePath = freezed,
    Object? profileImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
      imageUploading: null == imageUploading
          ? _value.imageUploading
          : imageUploading // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      profileFilePath: freezed == profileFilePath
          ? _value.profileFilePath
          : profileFilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddTournamentStateImplCopyWith<$Res>
    implements $AddTournamentStateCopyWith<$Res> {
  factory _$$AddTournamentStateImplCopyWith(_$AddTournamentStateImpl value,
          $Res Function(_$AddTournamentStateImpl) then) =
      __$$AddTournamentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error,
      Object? actionError,
      bool imageUploading,
      bool loading,
      String? profileFilePath,
      String? profileImageUrl});
}

/// @nodoc
class __$$AddTournamentStateImplCopyWithImpl<$Res>
    extends _$AddTournamentStateCopyWithImpl<$Res, _$AddTournamentStateImpl>
    implements _$$AddTournamentStateImplCopyWith<$Res> {
  __$$AddTournamentStateImplCopyWithImpl(_$AddTournamentStateImpl _value,
      $Res Function(_$AddTournamentStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddTournamentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? actionError = freezed,
    Object? imageUploading = null,
    Object? loading = null,
    Object? profileFilePath = freezed,
    Object? profileImageUrl = freezed,
  }) {
    return _then(_$AddTournamentStateImpl(
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
      imageUploading: null == imageUploading
          ? _value.imageUploading
          : imageUploading // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      profileFilePath: freezed == profileFilePath
          ? _value.profileFilePath
          : profileFilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AddTournamentStateImpl implements _AddTournamentState {
  const _$AddTournamentStateImpl(
      {this.error,
      this.actionError,
      this.imageUploading = false,
      this.loading = false,
      this.profileFilePath,
      this.profileImageUrl = null});

  @override
  final Object? error;
  @override
  final Object? actionError;
  @override
  @JsonKey()
  final bool imageUploading;
  @override
  @JsonKey()
  final bool loading;
  @override
  final String? profileFilePath;
  @override
  @JsonKey()
  final String? profileImageUrl;

  @override
  String toString() {
    return 'AddTournamentState(error: $error, actionError: $actionError, imageUploading: $imageUploading, loading: $loading, profileFilePath: $profileFilePath, profileImageUrl: $profileImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTournamentStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError) &&
            (identical(other.imageUploading, imageUploading) ||
                other.imageUploading == imageUploading) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.profileFilePath, profileFilePath) ||
                other.profileFilePath == profileFilePath) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(actionError),
      imageUploading,
      loading,
      profileFilePath,
      profileImageUrl);

  /// Create a copy of AddTournamentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTournamentStateImplCopyWith<_$AddTournamentStateImpl> get copyWith =>
      __$$AddTournamentStateImplCopyWithImpl<_$AddTournamentStateImpl>(
          this, _$identity);
}

abstract class _AddTournamentState implements AddTournamentState {
  const factory _AddTournamentState(
      {final Object? error,
      final Object? actionError,
      final bool imageUploading,
      final bool loading,
      final String? profileFilePath,
      final String? profileImageUrl}) = _$AddTournamentStateImpl;

  @override
  Object? get error;
  @override
  Object? get actionError;
  @override
  bool get imageUploading;
  @override
  bool get loading;
  @override
  String? get profileFilePath;
  @override
  String? get profileImageUrl;

  /// Create a copy of AddTournamentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTournamentStateImplCopyWith<_$AddTournamentStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
