// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournament_list_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TournamentListViewState {
  String? get currentUserId => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  Map<DateTime, List<TournamentModel>> get groupTournaments =>
      throw _privateConstructorUsedError;

  /// Create a copy of TournamentListViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TournamentListViewStateCopyWith<TournamentListViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentListViewStateCopyWith<$Res> {
  factory $TournamentListViewStateCopyWith(TournamentListViewState value,
          $Res Function(TournamentListViewState) then) =
      _$TournamentListViewStateCopyWithImpl<$Res, TournamentListViewState>;
  @useResult
  $Res call(
      {String? currentUserId,
      Object? error,
      bool loading,
      Map<DateTime, List<TournamentModel>> groupTournaments});
}

/// @nodoc
class _$TournamentListViewStateCopyWithImpl<$Res,
        $Val extends TournamentListViewState>
    implements $TournamentListViewStateCopyWith<$Res> {
  _$TournamentListViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TournamentListViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUserId = freezed,
    Object? error = freezed,
    Object? loading = null,
    Object? groupTournaments = null,
  }) {
    return _then(_value.copyWith(
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error ? _value.error : error,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      groupTournaments: null == groupTournaments
          ? _value.groupTournaments
          : groupTournaments // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List<TournamentModel>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TournamentListViewStateImplCopyWith<$Res>
    implements $TournamentListViewStateCopyWith<$Res> {
  factory _$$TournamentListViewStateImplCopyWith(
          _$TournamentListViewStateImpl value,
          $Res Function(_$TournamentListViewStateImpl) then) =
      __$$TournamentListViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? currentUserId,
      Object? error,
      bool loading,
      Map<DateTime, List<TournamentModel>> groupTournaments});
}

/// @nodoc
class __$$TournamentListViewStateImplCopyWithImpl<$Res>
    extends _$TournamentListViewStateCopyWithImpl<$Res,
        _$TournamentListViewStateImpl>
    implements _$$TournamentListViewStateImplCopyWith<$Res> {
  __$$TournamentListViewStateImplCopyWithImpl(
      _$TournamentListViewStateImpl _value,
      $Res Function(_$TournamentListViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TournamentListViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUserId = freezed,
    Object? error = freezed,
    Object? loading = null,
    Object? groupTournaments = null,
  }) {
    return _then(_$TournamentListViewStateImpl(
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error ? _value.error : error,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      groupTournaments: null == groupTournaments
          ? _value._groupTournaments
          : groupTournaments // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List<TournamentModel>>,
    ));
  }
}

/// @nodoc

class _$TournamentListViewStateImpl implements _TournamentListViewState {
  const _$TournamentListViewStateImpl(
      {this.currentUserId,
      this.error,
      this.loading = true,
      final Map<DateTime, List<TournamentModel>> groupTournaments = const {}})
      : _groupTournaments = groupTournaments;

  @override
  final String? currentUserId;
  @override
  final Object? error;
  @override
  @JsonKey()
  final bool loading;
  final Map<DateTime, List<TournamentModel>> _groupTournaments;
  @override
  @JsonKey()
  Map<DateTime, List<TournamentModel>> get groupTournaments {
    if (_groupTournaments is EqualUnmodifiableMapView) return _groupTournaments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_groupTournaments);
  }

  @override
  String toString() {
    return 'TournamentListViewState(currentUserId: $currentUserId, error: $error, loading: $loading, groupTournaments: $groupTournaments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentListViewStateImpl &&
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality()
                .equals(other._groupTournaments, _groupTournaments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentUserId,
      const DeepCollectionEquality().hash(error),
      loading,
      const DeepCollectionEquality().hash(_groupTournaments));

  /// Create a copy of TournamentListViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentListViewStateImplCopyWith<_$TournamentListViewStateImpl>
      get copyWith => __$$TournamentListViewStateImplCopyWithImpl<
          _$TournamentListViewStateImpl>(this, _$identity);
}

abstract class _TournamentListViewState implements TournamentListViewState {
  const factory _TournamentListViewState(
          {final String? currentUserId,
          final Object? error,
          final bool loading,
          final Map<DateTime, List<TournamentModel>> groupTournaments}) =
      _$TournamentListViewStateImpl;

  @override
  String? get currentUserId;
  @override
  Object? get error;
  @override
  bool get loading;
  @override
  Map<DateTime, List<TournamentModel>> get groupTournaments;

  /// Create a copy of TournamentListViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TournamentListViewStateImplCopyWith<_$TournamentListViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
