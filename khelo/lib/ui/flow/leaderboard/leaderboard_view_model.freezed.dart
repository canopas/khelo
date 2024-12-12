// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LeaderboardViewState {
  Object? get error => throw _privateConstructorUsedError;
  List<LeaderboardModel> get leaderboard => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  int get selectedTab => throw _privateConstructorUsedError;

  /// Create a copy of LeaderboardViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardViewStateCopyWith<LeaderboardViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardViewStateCopyWith<$Res> {
  factory $LeaderboardViewStateCopyWith(LeaderboardViewState value,
          $Res Function(LeaderboardViewState) then) =
      _$LeaderboardViewStateCopyWithImpl<$Res, LeaderboardViewState>;
  @useResult
  $Res call(
      {Object? error,
      List<LeaderboardModel> leaderboard,
      bool loading,
      int selectedTab});
}

/// @nodoc
class _$LeaderboardViewStateCopyWithImpl<$Res,
        $Val extends LeaderboardViewState>
    implements $LeaderboardViewStateCopyWith<$Res> {
  _$LeaderboardViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderboardViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? leaderboard = null,
    Object? loading = null,
    Object? selectedTab = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      leaderboard: null == leaderboard
          ? _value.leaderboard
          : leaderboard // ignore: cast_nullable_to_non_nullable
              as List<LeaderboardModel>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaderboardViewStateImplCopyWith<$Res>
    implements $LeaderboardViewStateCopyWith<$Res> {
  factory _$$LeaderboardViewStateImplCopyWith(_$LeaderboardViewStateImpl value,
          $Res Function(_$LeaderboardViewStateImpl) then) =
      __$$LeaderboardViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error,
      List<LeaderboardModel> leaderboard,
      bool loading,
      int selectedTab});
}

/// @nodoc
class __$$LeaderboardViewStateImplCopyWithImpl<$Res>
    extends _$LeaderboardViewStateCopyWithImpl<$Res, _$LeaderboardViewStateImpl>
    implements _$$LeaderboardViewStateImplCopyWith<$Res> {
  __$$LeaderboardViewStateImplCopyWithImpl(_$LeaderboardViewStateImpl _value,
      $Res Function(_$LeaderboardViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaderboardViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? leaderboard = null,
    Object? loading = null,
    Object? selectedTab = null,
  }) {
    return _then(_$LeaderboardViewStateImpl(
      error: freezed == error ? _value.error : error,
      leaderboard: null == leaderboard
          ? _value._leaderboard
          : leaderboard // ignore: cast_nullable_to_non_nullable
              as List<LeaderboardModel>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LeaderboardViewStateImpl implements _LeaderboardViewState {
  const _$LeaderboardViewStateImpl(
      {this.error,
      final List<LeaderboardModel> leaderboard = const [],
      this.loading = false,
      this.selectedTab = 0})
      : _leaderboard = leaderboard;

  @override
  final Object? error;
  final List<LeaderboardModel> _leaderboard;
  @override
  @JsonKey()
  List<LeaderboardModel> get leaderboard {
    if (_leaderboard is EqualUnmodifiableListView) return _leaderboard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_leaderboard);
  }

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final int selectedTab;

  @override
  String toString() {
    return 'LeaderboardViewState(error: $error, leaderboard: $leaderboard, loading: $loading, selectedTab: $selectedTab)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other._leaderboard, _leaderboard) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(_leaderboard),
      loading,
      selectedTab);

  /// Create a copy of LeaderboardViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardViewStateImplCopyWith<_$LeaderboardViewStateImpl>
      get copyWith =>
          __$$LeaderboardViewStateImplCopyWithImpl<_$LeaderboardViewStateImpl>(
              this, _$identity);
}

abstract class _LeaderboardViewState implements LeaderboardViewState {
  const factory _LeaderboardViewState(
      {final Object? error,
      final List<LeaderboardModel> leaderboard,
      final bool loading,
      final int selectedTab}) = _$LeaderboardViewStateImpl;

  @override
  Object? get error;
  @override
  List<LeaderboardModel> get leaderboard;
  @override
  bool get loading;
  @override
  int get selectedTab;

  /// Create a copy of LeaderboardViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardViewStateImplCopyWith<_$LeaderboardViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
