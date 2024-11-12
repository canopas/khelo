// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_view_all_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeViewAllViewState {
  Object? get error => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  List<TournamentModel> get tournaments => throw _privateConstructorUsedError;
  List<MatchModel> get matches => throw _privateConstructorUsedError;

  /// Create a copy of HomeViewAllViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeViewAllViewStateCopyWith<HomeViewAllViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeViewAllViewStateCopyWith<$Res> {
  factory $HomeViewAllViewStateCopyWith(HomeViewAllViewState value,
          $Res Function(HomeViewAllViewState) then) =
      _$HomeViewAllViewStateCopyWithImpl<$Res, HomeViewAllViewState>;
  @useResult
  $Res call(
      {Object? error,
      bool loading,
      List<TournamentModel> tournaments,
      List<MatchModel> matches});
}

/// @nodoc
class _$HomeViewAllViewStateCopyWithImpl<$Res,
        $Val extends HomeViewAllViewState>
    implements $HomeViewAllViewStateCopyWith<$Res> {
  _$HomeViewAllViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeViewAllViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? loading = null,
    Object? tournaments = null,
    Object? matches = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      tournaments: null == tournaments
          ? _value.tournaments
          : tournaments // ignore: cast_nullable_to_non_nullable
              as List<TournamentModel>,
      matches: null == matches
          ? _value.matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeViewAllViewStateImplCopyWith<$Res>
    implements $HomeViewAllViewStateCopyWith<$Res> {
  factory _$$HomeViewAllViewStateImplCopyWith(_$HomeViewAllViewStateImpl value,
          $Res Function(_$HomeViewAllViewStateImpl) then) =
      __$$HomeViewAllViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error,
      bool loading,
      List<TournamentModel> tournaments,
      List<MatchModel> matches});
}

/// @nodoc
class __$$HomeViewAllViewStateImplCopyWithImpl<$Res>
    extends _$HomeViewAllViewStateCopyWithImpl<$Res, _$HomeViewAllViewStateImpl>
    implements _$$HomeViewAllViewStateImplCopyWith<$Res> {
  __$$HomeViewAllViewStateImplCopyWithImpl(_$HomeViewAllViewStateImpl _value,
      $Res Function(_$HomeViewAllViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeViewAllViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? loading = null,
    Object? tournaments = null,
    Object? matches = null,
  }) {
    return _then(_$HomeViewAllViewStateImpl(
      error: freezed == error ? _value.error : error,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      tournaments: null == tournaments
          ? _value._tournaments
          : tournaments // ignore: cast_nullable_to_non_nullable
              as List<TournamentModel>,
      matches: null == matches
          ? _value._matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
    ));
  }
}

/// @nodoc

class _$HomeViewAllViewStateImpl implements _HomeViewAllViewState {
  const _$HomeViewAllViewStateImpl(
      {this.error,
      this.loading = false,
      final List<TournamentModel> tournaments = const [],
      final List<MatchModel> matches = const []})
      : _tournaments = tournaments,
        _matches = matches;

  @override
  final Object? error;
  @override
  @JsonKey()
  final bool loading;
  final List<TournamentModel> _tournaments;
  @override
  @JsonKey()
  List<TournamentModel> get tournaments {
    if (_tournaments is EqualUnmodifiableListView) return _tournaments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tournaments);
  }

  final List<MatchModel> _matches;
  @override
  @JsonKey()
  List<MatchModel> get matches {
    if (_matches is EqualUnmodifiableListView) return _matches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matches);
  }

  @override
  String toString() {
    return 'HomeViewAllViewState(error: $error, loading: $loading, tournaments: $tournaments, matches: $matches)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeViewAllViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality()
                .equals(other._tournaments, _tournaments) &&
            const DeepCollectionEquality().equals(other._matches, _matches));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      loading,
      const DeepCollectionEquality().hash(_tournaments),
      const DeepCollectionEquality().hash(_matches));

  /// Create a copy of HomeViewAllViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeViewAllViewStateImplCopyWith<_$HomeViewAllViewStateImpl>
      get copyWith =>
          __$$HomeViewAllViewStateImplCopyWithImpl<_$HomeViewAllViewStateImpl>(
              this, _$identity);
}

abstract class _HomeViewAllViewState implements HomeViewAllViewState {
  const factory _HomeViewAllViewState(
      {final Object? error,
      final bool loading,
      final List<TournamentModel> tournaments,
      final List<MatchModel> matches}) = _$HomeViewAllViewStateImpl;

  @override
  Object? get error;
  @override
  bool get loading;
  @override
  List<TournamentModel> get tournaments;
  @override
  List<MatchModel> get matches;

  /// Create a copy of HomeViewAllViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeViewAllViewStateImplCopyWith<_$HomeViewAllViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
