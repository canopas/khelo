// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_detail_stat_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MatchDetailStatViewState {
  Object? get error => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  String? get matchId => throw _privateConstructorUsedError;
  MatchModel? get match => throw _privateConstructorUsedError;
  InningModel? get firstInning => throw _privateConstructorUsedError;
  InningModel? get secondInning => throw _privateConstructorUsedError;
  List<BallScoreModel>? get firstScore => throw _privateConstructorUsedError;
  List<BallScoreModel>? get secondScore => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MatchDetailStatViewStateCopyWith<MatchDetailStatViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchDetailStatViewStateCopyWith<$Res> {
  factory $MatchDetailStatViewStateCopyWith(MatchDetailStatViewState value,
          $Res Function(MatchDetailStatViewState) then) =
      _$MatchDetailStatViewStateCopyWithImpl<$Res, MatchDetailStatViewState>;
  @useResult
  $Res call(
      {Object? error,
      bool loading,
      String? matchId,
      MatchModel? match,
      InningModel? firstInning,
      InningModel? secondInning,
      List<BallScoreModel>? firstScore,
      List<BallScoreModel>? secondScore});

  $MatchModelCopyWith<$Res>? get match;
  $InningModelCopyWith<$Res>? get firstInning;
  $InningModelCopyWith<$Res>? get secondInning;
}

/// @nodoc
class _$MatchDetailStatViewStateCopyWithImpl<$Res,
        $Val extends MatchDetailStatViewState>
    implements $MatchDetailStatViewStateCopyWith<$Res> {
  _$MatchDetailStatViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? loading = null,
    Object? matchId = freezed,
    Object? match = freezed,
    Object? firstInning = freezed,
    Object? secondInning = freezed,
    Object? firstScore = freezed,
    Object? secondScore = freezed,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      matchId: freezed == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String?,
      match: freezed == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as MatchModel?,
      firstInning: freezed == firstInning
          ? _value.firstInning
          : firstInning // ignore: cast_nullable_to_non_nullable
              as InningModel?,
      secondInning: freezed == secondInning
          ? _value.secondInning
          : secondInning // ignore: cast_nullable_to_non_nullable
              as InningModel?,
      firstScore: freezed == firstScore
          ? _value.firstScore
          : firstScore // ignore: cast_nullable_to_non_nullable
              as List<BallScoreModel>?,
      secondScore: freezed == secondScore
          ? _value.secondScore
          : secondScore // ignore: cast_nullable_to_non_nullable
              as List<BallScoreModel>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MatchModelCopyWith<$Res>? get match {
    if (_value.match == null) {
      return null;
    }

    return $MatchModelCopyWith<$Res>(_value.match!, (value) {
      return _then(_value.copyWith(match: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $InningModelCopyWith<$Res>? get firstInning {
    if (_value.firstInning == null) {
      return null;
    }

    return $InningModelCopyWith<$Res>(_value.firstInning!, (value) {
      return _then(_value.copyWith(firstInning: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $InningModelCopyWith<$Res>? get secondInning {
    if (_value.secondInning == null) {
      return null;
    }

    return $InningModelCopyWith<$Res>(_value.secondInning!, (value) {
      return _then(_value.copyWith(secondInning: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MatchDetailStatViewStateImplCopyWith<$Res>
    implements $MatchDetailStatViewStateCopyWith<$Res> {
  factory _$$MatchDetailStatViewStateImplCopyWith(
          _$MatchDetailStatViewStateImpl value,
          $Res Function(_$MatchDetailStatViewStateImpl) then) =
      __$$MatchDetailStatViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error,
      bool loading,
      String? matchId,
      MatchModel? match,
      InningModel? firstInning,
      InningModel? secondInning,
      List<BallScoreModel>? firstScore,
      List<BallScoreModel>? secondScore});

  @override
  $MatchModelCopyWith<$Res>? get match;
  @override
  $InningModelCopyWith<$Res>? get firstInning;
  @override
  $InningModelCopyWith<$Res>? get secondInning;
}

/// @nodoc
class __$$MatchDetailStatViewStateImplCopyWithImpl<$Res>
    extends _$MatchDetailStatViewStateCopyWithImpl<$Res,
        _$MatchDetailStatViewStateImpl>
    implements _$$MatchDetailStatViewStateImplCopyWith<$Res> {
  __$$MatchDetailStatViewStateImplCopyWithImpl(
      _$MatchDetailStatViewStateImpl _value,
      $Res Function(_$MatchDetailStatViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? loading = null,
    Object? matchId = freezed,
    Object? match = freezed,
    Object? firstInning = freezed,
    Object? secondInning = freezed,
    Object? firstScore = freezed,
    Object? secondScore = freezed,
  }) {
    return _then(_$MatchDetailStatViewStateImpl(
      error: freezed == error ? _value.error : error,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      matchId: freezed == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String?,
      match: freezed == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as MatchModel?,
      firstInning: freezed == firstInning
          ? _value.firstInning
          : firstInning // ignore: cast_nullable_to_non_nullable
              as InningModel?,
      secondInning: freezed == secondInning
          ? _value.secondInning
          : secondInning // ignore: cast_nullable_to_non_nullable
              as InningModel?,
      firstScore: freezed == firstScore
          ? _value._firstScore
          : firstScore // ignore: cast_nullable_to_non_nullable
              as List<BallScoreModel>?,
      secondScore: freezed == secondScore
          ? _value._secondScore
          : secondScore // ignore: cast_nullable_to_non_nullable
              as List<BallScoreModel>?,
    ));
  }
}

/// @nodoc

class _$MatchDetailStatViewStateImpl implements _MatchDetailStatViewState {
  const _$MatchDetailStatViewStateImpl(
      {this.error,
      this.loading = false,
      this.matchId,
      this.match,
      this.firstInning,
      this.secondInning,
      final List<BallScoreModel>? firstScore,
      final List<BallScoreModel>? secondScore})
      : _firstScore = firstScore,
        _secondScore = secondScore;

  @override
  final Object? error;
  @override
  @JsonKey()
  final bool loading;
  @override
  final String? matchId;
  @override
  final MatchModel? match;
  @override
  final InningModel? firstInning;
  @override
  final InningModel? secondInning;
  final List<BallScoreModel>? _firstScore;
  @override
  List<BallScoreModel>? get firstScore {
    final value = _firstScore;
    if (value == null) return null;
    if (_firstScore is EqualUnmodifiableListView) return _firstScore;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<BallScoreModel>? _secondScore;
  @override
  List<BallScoreModel>? get secondScore {
    final value = _secondScore;
    if (value == null) return null;
    if (_secondScore is EqualUnmodifiableListView) return _secondScore;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MatchDetailStatViewState(error: $error, loading: $loading, matchId: $matchId, match: $match, firstInning: $firstInning, secondInning: $secondInning, firstScore: $firstScore, secondScore: $secondScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchDetailStatViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.match, match) || other.match == match) &&
            (identical(other.firstInning, firstInning) ||
                other.firstInning == firstInning) &&
            (identical(other.secondInning, secondInning) ||
                other.secondInning == secondInning) &&
            const DeepCollectionEquality()
                .equals(other._firstScore, _firstScore) &&
            const DeepCollectionEquality()
                .equals(other._secondScore, _secondScore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      loading,
      matchId,
      match,
      firstInning,
      secondInning,
      const DeepCollectionEquality().hash(_firstScore),
      const DeepCollectionEquality().hash(_secondScore));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchDetailStatViewStateImplCopyWith<_$MatchDetailStatViewStateImpl>
      get copyWith => __$$MatchDetailStatViewStateImplCopyWithImpl<
          _$MatchDetailStatViewStateImpl>(this, _$identity);
}

abstract class _MatchDetailStatViewState implements MatchDetailStatViewState {
  const factory _MatchDetailStatViewState(
          {final Object? error,
          final bool loading,
          final String? matchId,
          final MatchModel? match,
          final InningModel? firstInning,
          final InningModel? secondInning,
          final List<BallScoreModel>? firstScore,
          final List<BallScoreModel>? secondScore}) =
      _$MatchDetailStatViewStateImpl;

  @override
  Object? get error;
  @override
  bool get loading;
  @override
  String? get matchId;
  @override
  MatchModel? get match;
  @override
  InningModel? get firstInning;
  @override
  InningModel? get secondInning;
  @override
  List<BallScoreModel>? get firstScore;
  @override
  List<BallScoreModel>? get secondScore;
  @override
  @JsonKey(ignore: true)
  _$$MatchDetailStatViewStateImplCopyWith<_$MatchDetailStatViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
