// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournament_detail_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TournamentDetailState {
  TournamentModel? get tournament => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  int get selectedTab => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  Object? get actionError => throw _privateConstructorUsedError;

  /// Create a copy of TournamentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TournamentDetailStateCopyWith<TournamentDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentDetailStateCopyWith<$Res> {
  factory $TournamentDetailStateCopyWith(TournamentDetailState value,
          $Res Function(TournamentDetailState) then) =
      _$TournamentDetailStateCopyWithImpl<$Res, TournamentDetailState>;
  @useResult
  $Res call(
      {TournamentModel? tournament,
      bool loading,
      int selectedTab,
      Object? error,
      Object? actionError});

  $TournamentModelCopyWith<$Res>? get tournament;
}

/// @nodoc
class _$TournamentDetailStateCopyWithImpl<$Res,
        $Val extends TournamentDetailState>
    implements $TournamentDetailStateCopyWith<$Res> {
  _$TournamentDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TournamentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournament = freezed,
    Object? loading = null,
    Object? selectedTab = null,
    Object? error = freezed,
    Object? actionError = freezed,
  }) {
    return _then(_value.copyWith(
      tournament: freezed == tournament
          ? _value.tournament
          : tournament // ignore: cast_nullable_to_non_nullable
              as TournamentModel?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
    ) as $Val);
  }

  /// Create a copy of TournamentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TournamentModelCopyWith<$Res>? get tournament {
    if (_value.tournament == null) {
      return null;
    }

    return $TournamentModelCopyWith<$Res>(_value.tournament!, (value) {
      return _then(_value.copyWith(tournament: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TournamentDetailStateImplCopyWith<$Res>
    implements $TournamentDetailStateCopyWith<$Res> {
  factory _$$TournamentDetailStateImplCopyWith(
          _$TournamentDetailStateImpl value,
          $Res Function(_$TournamentDetailStateImpl) then) =
      __$$TournamentDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TournamentModel? tournament,
      bool loading,
      int selectedTab,
      Object? error,
      Object? actionError});

  @override
  $TournamentModelCopyWith<$Res>? get tournament;
}

/// @nodoc
class __$$TournamentDetailStateImplCopyWithImpl<$Res>
    extends _$TournamentDetailStateCopyWithImpl<$Res,
        _$TournamentDetailStateImpl>
    implements _$$TournamentDetailStateImplCopyWith<$Res> {
  __$$TournamentDetailStateImplCopyWithImpl(_$TournamentDetailStateImpl _value,
      $Res Function(_$TournamentDetailStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TournamentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournament = freezed,
    Object? loading = null,
    Object? selectedTab = null,
    Object? error = freezed,
    Object? actionError = freezed,
  }) {
    return _then(_$TournamentDetailStateImpl(
      tournament: freezed == tournament
          ? _value.tournament
          : tournament // ignore: cast_nullable_to_non_nullable
              as TournamentModel?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
    ));
  }
}

/// @nodoc

class _$TournamentDetailStateImpl implements _TournamentDetailState {
  const _$TournamentDetailStateImpl(
      {this.tournament = null,
      this.loading = false,
      this.selectedTab = 0,
      this.error,
      this.actionError});

  @override
  @JsonKey()
  final TournamentModel? tournament;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final int selectedTab;
  @override
  final Object? error;
  @override
  final Object? actionError;

  @override
  String toString() {
    return 'TournamentDetailState(tournament: $tournament, loading: $loading, selectedTab: $selectedTab, error: $error, actionError: $actionError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentDetailStateImpl &&
            (identical(other.tournament, tournament) ||
                other.tournament == tournament) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      tournament,
      loading,
      selectedTab,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(actionError));

  /// Create a copy of TournamentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentDetailStateImplCopyWith<_$TournamentDetailStateImpl>
      get copyWith => __$$TournamentDetailStateImplCopyWithImpl<
          _$TournamentDetailStateImpl>(this, _$identity);
}

abstract class _TournamentDetailState implements TournamentDetailState {
  const factory _TournamentDetailState(
      {final TournamentModel? tournament,
      final bool loading,
      final int selectedTab,
      final Object? error,
      final Object? actionError}) = _$TournamentDetailStateImpl;

  @override
  TournamentModel? get tournament;
  @override
  bool get loading;
  @override
  int get selectedTab;
  @override
  Object? get error;
  @override
  Object? get actionError;

  /// Create a copy of TournamentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TournamentDetailStateImplCopyWith<_$TournamentDetailStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
