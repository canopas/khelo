// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_match_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddMatchViewState {
  DateTime get matchTime => throw _privateConstructorUsedError;
  TextEditingController get totalOverController =>
      throw _privateConstructorUsedError;
  TextEditingController get overPerBowlerController =>
      throw _privateConstructorUsedError;
  TextEditingController get cityController =>
      throw _privateConstructorUsedError;
  TextEditingController get groundController =>
      throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  Object? get actionError => throw _privateConstructorUsedError;
  TeamModel? get teamA => throw _privateConstructorUsedError;
  TeamModel? get teamB => throw _privateConstructorUsedError;
  List<MatchPlayer>? get squadA => throw _privateConstructorUsedError;
  List<MatchPlayer>? get squadB => throw _privateConstructorUsedError;
  String? get teamACaptainId => throw _privateConstructorUsedError;
  String? get teamBCaptainId => throw _privateConstructorUsedError;
  String? get teamAAdminId => throw _privateConstructorUsedError;
  String? get teamBAdminId => throw _privateConstructorUsedError;
  List<Officials> get officials => throw _privateConstructorUsedError;
  List<int>? get firstPowerPlay => throw _privateConstructorUsedError;
  List<int>? get secondPowerPlay => throw _privateConstructorUsedError;
  List<int>? get thirdPowerPlay => throw _privateConstructorUsedError;
  PitchType get pitchType => throw _privateConstructorUsedError;
  MatchType get matchType => throw _privateConstructorUsedError;
  BallType get ballType => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get isPowerPlayButtonEnable => throw _privateConstructorUsedError;
  AddMatchErrorType? get saveBtnError => throw _privateConstructorUsedError;
  AddMatchErrorType? get startBtnError => throw _privateConstructorUsedError;
  bool get isAddMatchInProgress => throw _privateConstructorUsedError;
  bool? get pushTossDetailScreen => throw _privateConstructorUsedError;
  MatchModel? get match => throw _privateConstructorUsedError;

  /// Create a copy of AddMatchViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddMatchViewStateCopyWith<AddMatchViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddMatchViewStateCopyWith<$Res> {
  factory $AddMatchViewStateCopyWith(
          AddMatchViewState value, $Res Function(AddMatchViewState) then) =
      _$AddMatchViewStateCopyWithImpl<$Res, AddMatchViewState>;
  @useResult
  $Res call(
      {DateTime matchTime,
      TextEditingController totalOverController,
      TextEditingController overPerBowlerController,
      TextEditingController cityController,
      TextEditingController groundController,
      Object? error,
      Object? actionError,
      TeamModel? teamA,
      TeamModel? teamB,
      List<MatchPlayer>? squadA,
      List<MatchPlayer>? squadB,
      String? teamACaptainId,
      String? teamBCaptainId,
      String? teamAAdminId,
      String? teamBAdminId,
      List<Officials> officials,
      List<int>? firstPowerPlay,
      List<int>? secondPowerPlay,
      List<int>? thirdPowerPlay,
      PitchType pitchType,
      MatchType matchType,
      BallType ballType,
      bool loading,
      bool isPowerPlayButtonEnable,
      AddMatchErrorType? saveBtnError,
      AddMatchErrorType? startBtnError,
      bool isAddMatchInProgress,
      bool? pushTossDetailScreen,
      MatchModel? match});

  $TeamModelCopyWith<$Res>? get teamA;
  $TeamModelCopyWith<$Res>? get teamB;
  $MatchModelCopyWith<$Res>? get match;
}

/// @nodoc
class _$AddMatchViewStateCopyWithImpl<$Res, $Val extends AddMatchViewState>
    implements $AddMatchViewStateCopyWith<$Res> {
  _$AddMatchViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddMatchViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchTime = null,
    Object? totalOverController = null,
    Object? overPerBowlerController = null,
    Object? cityController = null,
    Object? groundController = null,
    Object? error = freezed,
    Object? actionError = freezed,
    Object? teamA = freezed,
    Object? teamB = freezed,
    Object? squadA = freezed,
    Object? squadB = freezed,
    Object? teamACaptainId = freezed,
    Object? teamBCaptainId = freezed,
    Object? teamAAdminId = freezed,
    Object? teamBAdminId = freezed,
    Object? officials = null,
    Object? firstPowerPlay = freezed,
    Object? secondPowerPlay = freezed,
    Object? thirdPowerPlay = freezed,
    Object? pitchType = null,
    Object? matchType = null,
    Object? ballType = null,
    Object? loading = null,
    Object? isPowerPlayButtonEnable = null,
    Object? saveBtnError = freezed,
    Object? startBtnError = freezed,
    Object? isAddMatchInProgress = null,
    Object? pushTossDetailScreen = freezed,
    Object? match = freezed,
  }) {
    return _then(_value.copyWith(
      matchTime: null == matchTime
          ? _value.matchTime
          : matchTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalOverController: null == totalOverController
          ? _value.totalOverController
          : totalOverController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      overPerBowlerController: null == overPerBowlerController
          ? _value.overPerBowlerController
          : overPerBowlerController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      cityController: null == cityController
          ? _value.cityController
          : cityController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      groundController: null == groundController
          ? _value.groundController
          : groundController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
      teamA: freezed == teamA
          ? _value.teamA
          : teamA // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      teamB: freezed == teamB
          ? _value.teamB
          : teamB // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      squadA: freezed == squadA
          ? _value.squadA
          : squadA // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>?,
      squadB: freezed == squadB
          ? _value.squadB
          : squadB // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>?,
      teamACaptainId: freezed == teamACaptainId
          ? _value.teamACaptainId
          : teamACaptainId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamBCaptainId: freezed == teamBCaptainId
          ? _value.teamBCaptainId
          : teamBCaptainId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamAAdminId: freezed == teamAAdminId
          ? _value.teamAAdminId
          : teamAAdminId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamBAdminId: freezed == teamBAdminId
          ? _value.teamBAdminId
          : teamBAdminId // ignore: cast_nullable_to_non_nullable
              as String?,
      officials: null == officials
          ? _value.officials
          : officials // ignore: cast_nullable_to_non_nullable
              as List<Officials>,
      firstPowerPlay: freezed == firstPowerPlay
          ? _value.firstPowerPlay
          : firstPowerPlay // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      secondPowerPlay: freezed == secondPowerPlay
          ? _value.secondPowerPlay
          : secondPowerPlay // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      thirdPowerPlay: freezed == thirdPowerPlay
          ? _value.thirdPowerPlay
          : thirdPowerPlay // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      pitchType: null == pitchType
          ? _value.pitchType
          : pitchType // ignore: cast_nullable_to_non_nullable
              as PitchType,
      matchType: null == matchType
          ? _value.matchType
          : matchType // ignore: cast_nullable_to_non_nullable
              as MatchType,
      ballType: null == ballType
          ? _value.ballType
          : ballType // ignore: cast_nullable_to_non_nullable
              as BallType,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      isPowerPlayButtonEnable: null == isPowerPlayButtonEnable
          ? _value.isPowerPlayButtonEnable
          : isPowerPlayButtonEnable // ignore: cast_nullable_to_non_nullable
              as bool,
      saveBtnError: freezed == saveBtnError
          ? _value.saveBtnError
          : saveBtnError // ignore: cast_nullable_to_non_nullable
              as AddMatchErrorType?,
      startBtnError: freezed == startBtnError
          ? _value.startBtnError
          : startBtnError // ignore: cast_nullable_to_non_nullable
              as AddMatchErrorType?,
      isAddMatchInProgress: null == isAddMatchInProgress
          ? _value.isAddMatchInProgress
          : isAddMatchInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      pushTossDetailScreen: freezed == pushTossDetailScreen
          ? _value.pushTossDetailScreen
          : pushTossDetailScreen // ignore: cast_nullable_to_non_nullable
              as bool?,
      match: freezed == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as MatchModel?,
    ) as $Val);
  }

  /// Create a copy of AddMatchViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamModelCopyWith<$Res>? get teamA {
    if (_value.teamA == null) {
      return null;
    }

    return $TeamModelCopyWith<$Res>(_value.teamA!, (value) {
      return _then(_value.copyWith(teamA: value) as $Val);
    });
  }

  /// Create a copy of AddMatchViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamModelCopyWith<$Res>? get teamB {
    if (_value.teamB == null) {
      return null;
    }

    return $TeamModelCopyWith<$Res>(_value.teamB!, (value) {
      return _then(_value.copyWith(teamB: value) as $Val);
    });
  }

  /// Create a copy of AddMatchViewState
  /// with the given fields replaced by the non-null parameter values.
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
}

/// @nodoc
abstract class _$$AddMatchViewStateImplCopyWith<$Res>
    implements $AddMatchViewStateCopyWith<$Res> {
  factory _$$AddMatchViewStateImplCopyWith(_$AddMatchViewStateImpl value,
          $Res Function(_$AddMatchViewStateImpl) then) =
      __$$AddMatchViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime matchTime,
      TextEditingController totalOverController,
      TextEditingController overPerBowlerController,
      TextEditingController cityController,
      TextEditingController groundController,
      Object? error,
      Object? actionError,
      TeamModel? teamA,
      TeamModel? teamB,
      List<MatchPlayer>? squadA,
      List<MatchPlayer>? squadB,
      String? teamACaptainId,
      String? teamBCaptainId,
      String? teamAAdminId,
      String? teamBAdminId,
      List<Officials> officials,
      List<int>? firstPowerPlay,
      List<int>? secondPowerPlay,
      List<int>? thirdPowerPlay,
      PitchType pitchType,
      MatchType matchType,
      BallType ballType,
      bool loading,
      bool isPowerPlayButtonEnable,
      AddMatchErrorType? saveBtnError,
      AddMatchErrorType? startBtnError,
      bool isAddMatchInProgress,
      bool? pushTossDetailScreen,
      MatchModel? match});

  @override
  $TeamModelCopyWith<$Res>? get teamA;
  @override
  $TeamModelCopyWith<$Res>? get teamB;
  @override
  $MatchModelCopyWith<$Res>? get match;
}

/// @nodoc
class __$$AddMatchViewStateImplCopyWithImpl<$Res>
    extends _$AddMatchViewStateCopyWithImpl<$Res, _$AddMatchViewStateImpl>
    implements _$$AddMatchViewStateImplCopyWith<$Res> {
  __$$AddMatchViewStateImplCopyWithImpl(_$AddMatchViewStateImpl _value,
      $Res Function(_$AddMatchViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddMatchViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchTime = null,
    Object? totalOverController = null,
    Object? overPerBowlerController = null,
    Object? cityController = null,
    Object? groundController = null,
    Object? error = freezed,
    Object? actionError = freezed,
    Object? teamA = freezed,
    Object? teamB = freezed,
    Object? squadA = freezed,
    Object? squadB = freezed,
    Object? teamACaptainId = freezed,
    Object? teamBCaptainId = freezed,
    Object? teamAAdminId = freezed,
    Object? teamBAdminId = freezed,
    Object? officials = null,
    Object? firstPowerPlay = freezed,
    Object? secondPowerPlay = freezed,
    Object? thirdPowerPlay = freezed,
    Object? pitchType = null,
    Object? matchType = null,
    Object? ballType = null,
    Object? loading = null,
    Object? isPowerPlayButtonEnable = null,
    Object? saveBtnError = freezed,
    Object? startBtnError = freezed,
    Object? isAddMatchInProgress = null,
    Object? pushTossDetailScreen = freezed,
    Object? match = freezed,
  }) {
    return _then(_$AddMatchViewStateImpl(
      matchTime: null == matchTime
          ? _value.matchTime
          : matchTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalOverController: null == totalOverController
          ? _value.totalOverController
          : totalOverController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      overPerBowlerController: null == overPerBowlerController
          ? _value.overPerBowlerController
          : overPerBowlerController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      cityController: null == cityController
          ? _value.cityController
          : cityController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      groundController: null == groundController
          ? _value.groundController
          : groundController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
      teamA: freezed == teamA
          ? _value.teamA
          : teamA // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      teamB: freezed == teamB
          ? _value.teamB
          : teamB // ignore: cast_nullable_to_non_nullable
              as TeamModel?,
      squadA: freezed == squadA
          ? _value._squadA
          : squadA // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>?,
      squadB: freezed == squadB
          ? _value._squadB
          : squadB // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>?,
      teamACaptainId: freezed == teamACaptainId
          ? _value.teamACaptainId
          : teamACaptainId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamBCaptainId: freezed == teamBCaptainId
          ? _value.teamBCaptainId
          : teamBCaptainId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamAAdminId: freezed == teamAAdminId
          ? _value.teamAAdminId
          : teamAAdminId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamBAdminId: freezed == teamBAdminId
          ? _value.teamBAdminId
          : teamBAdminId // ignore: cast_nullable_to_non_nullable
              as String?,
      officials: null == officials
          ? _value._officials
          : officials // ignore: cast_nullable_to_non_nullable
              as List<Officials>,
      firstPowerPlay: freezed == firstPowerPlay
          ? _value._firstPowerPlay
          : firstPowerPlay // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      secondPowerPlay: freezed == secondPowerPlay
          ? _value._secondPowerPlay
          : secondPowerPlay // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      thirdPowerPlay: freezed == thirdPowerPlay
          ? _value._thirdPowerPlay
          : thirdPowerPlay // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      pitchType: null == pitchType
          ? _value.pitchType
          : pitchType // ignore: cast_nullable_to_non_nullable
              as PitchType,
      matchType: null == matchType
          ? _value.matchType
          : matchType // ignore: cast_nullable_to_non_nullable
              as MatchType,
      ballType: null == ballType
          ? _value.ballType
          : ballType // ignore: cast_nullable_to_non_nullable
              as BallType,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      isPowerPlayButtonEnable: null == isPowerPlayButtonEnable
          ? _value.isPowerPlayButtonEnable
          : isPowerPlayButtonEnable // ignore: cast_nullable_to_non_nullable
              as bool,
      saveBtnError: freezed == saveBtnError
          ? _value.saveBtnError
          : saveBtnError // ignore: cast_nullable_to_non_nullable
              as AddMatchErrorType?,
      startBtnError: freezed == startBtnError
          ? _value.startBtnError
          : startBtnError // ignore: cast_nullable_to_non_nullable
              as AddMatchErrorType?,
      isAddMatchInProgress: null == isAddMatchInProgress
          ? _value.isAddMatchInProgress
          : isAddMatchInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      pushTossDetailScreen: freezed == pushTossDetailScreen
          ? _value.pushTossDetailScreen
          : pushTossDetailScreen // ignore: cast_nullable_to_non_nullable
              as bool?,
      match: freezed == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as MatchModel?,
    ));
  }
}

/// @nodoc

class _$AddMatchViewStateImpl implements _AddMatchViewState {
  const _$AddMatchViewStateImpl(
      {required this.matchTime,
      required this.totalOverController,
      required this.overPerBowlerController,
      required this.cityController,
      required this.groundController,
      this.error,
      this.actionError,
      this.teamA,
      this.teamB,
      final List<MatchPlayer>? squadA,
      final List<MatchPlayer>? squadB,
      this.teamACaptainId,
      this.teamBCaptainId,
      this.teamAAdminId,
      this.teamBAdminId,
      final List<Officials> officials = const [],
      final List<int>? firstPowerPlay = const [],
      final List<int>? secondPowerPlay = const [],
      final List<int>? thirdPowerPlay = const [],
      this.pitchType = PitchType.rough,
      this.matchType = MatchType.limitedOvers,
      this.ballType = BallType.leather,
      this.loading = false,
      this.isPowerPlayButtonEnable = false,
      this.saveBtnError,
      this.startBtnError,
      this.isAddMatchInProgress = false,
      this.pushTossDetailScreen = null,
      this.match = null})
      : _squadA = squadA,
        _squadB = squadB,
        _officials = officials,
        _firstPowerPlay = firstPowerPlay,
        _secondPowerPlay = secondPowerPlay,
        _thirdPowerPlay = thirdPowerPlay;

  @override
  final DateTime matchTime;
  @override
  final TextEditingController totalOverController;
  @override
  final TextEditingController overPerBowlerController;
  @override
  final TextEditingController cityController;
  @override
  final TextEditingController groundController;
  @override
  final Object? error;
  @override
  final Object? actionError;
  @override
  final TeamModel? teamA;
  @override
  final TeamModel? teamB;
  final List<MatchPlayer>? _squadA;
  @override
  List<MatchPlayer>? get squadA {
    final value = _squadA;
    if (value == null) return null;
    if (_squadA is EqualUnmodifiableListView) return _squadA;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<MatchPlayer>? _squadB;
  @override
  List<MatchPlayer>? get squadB {
    final value = _squadB;
    if (value == null) return null;
    if (_squadB is EqualUnmodifiableListView) return _squadB;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? teamACaptainId;
  @override
  final String? teamBCaptainId;
  @override
  final String? teamAAdminId;
  @override
  final String? teamBAdminId;
  final List<Officials> _officials;
  @override
  @JsonKey()
  List<Officials> get officials {
    if (_officials is EqualUnmodifiableListView) return _officials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_officials);
  }

  final List<int>? _firstPowerPlay;
  @override
  @JsonKey()
  List<int>? get firstPowerPlay {
    final value = _firstPowerPlay;
    if (value == null) return null;
    if (_firstPowerPlay is EqualUnmodifiableListView) return _firstPowerPlay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _secondPowerPlay;
  @override
  @JsonKey()
  List<int>? get secondPowerPlay {
    final value = _secondPowerPlay;
    if (value == null) return null;
    if (_secondPowerPlay is EqualUnmodifiableListView) return _secondPowerPlay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _thirdPowerPlay;
  @override
  @JsonKey()
  List<int>? get thirdPowerPlay {
    final value = _thirdPowerPlay;
    if (value == null) return null;
    if (_thirdPowerPlay is EqualUnmodifiableListView) return _thirdPowerPlay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final PitchType pitchType;
  @override
  @JsonKey()
  final MatchType matchType;
  @override
  @JsonKey()
  final BallType ballType;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool isPowerPlayButtonEnable;
  @override
  final AddMatchErrorType? saveBtnError;
  @override
  final AddMatchErrorType? startBtnError;
  @override
  @JsonKey()
  final bool isAddMatchInProgress;
  @override
  @JsonKey()
  final bool? pushTossDetailScreen;
  @override
  @JsonKey()
  final MatchModel? match;

  @override
  String toString() {
    return 'AddMatchViewState(matchTime: $matchTime, totalOverController: $totalOverController, overPerBowlerController: $overPerBowlerController, cityController: $cityController, groundController: $groundController, error: $error, actionError: $actionError, teamA: $teamA, teamB: $teamB, squadA: $squadA, squadB: $squadB, teamACaptainId: $teamACaptainId, teamBCaptainId: $teamBCaptainId, teamAAdminId: $teamAAdminId, teamBAdminId: $teamBAdminId, officials: $officials, firstPowerPlay: $firstPowerPlay, secondPowerPlay: $secondPowerPlay, thirdPowerPlay: $thirdPowerPlay, pitchType: $pitchType, matchType: $matchType, ballType: $ballType, loading: $loading, isPowerPlayButtonEnable: $isPowerPlayButtonEnable, saveBtnError: $saveBtnError, startBtnError: $startBtnError, isAddMatchInProgress: $isAddMatchInProgress, pushTossDetailScreen: $pushTossDetailScreen, match: $match)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddMatchViewStateImpl &&
            (identical(other.matchTime, matchTime) ||
                other.matchTime == matchTime) &&
            (identical(other.totalOverController, totalOverController) ||
                other.totalOverController == totalOverController) &&
            (identical(
                    other.overPerBowlerController, overPerBowlerController) ||
                other.overPerBowlerController == overPerBowlerController) &&
            (identical(other.cityController, cityController) ||
                other.cityController == cityController) &&
            (identical(other.groundController, groundController) ||
                other.groundController == groundController) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError) &&
            (identical(other.teamA, teamA) || other.teamA == teamA) &&
            (identical(other.teamB, teamB) || other.teamB == teamB) &&
            const DeepCollectionEquality().equals(other._squadA, _squadA) &&
            const DeepCollectionEquality().equals(other._squadB, _squadB) &&
            (identical(other.teamACaptainId, teamACaptainId) ||
                other.teamACaptainId == teamACaptainId) &&
            (identical(other.teamBCaptainId, teamBCaptainId) ||
                other.teamBCaptainId == teamBCaptainId) &&
            (identical(other.teamAAdminId, teamAAdminId) ||
                other.teamAAdminId == teamAAdminId) &&
            (identical(other.teamBAdminId, teamBAdminId) ||
                other.teamBAdminId == teamBAdminId) &&
            const DeepCollectionEquality()
                .equals(other._officials, _officials) &&
            const DeepCollectionEquality()
                .equals(other._firstPowerPlay, _firstPowerPlay) &&
            const DeepCollectionEquality()
                .equals(other._secondPowerPlay, _secondPowerPlay) &&
            const DeepCollectionEquality()
                .equals(other._thirdPowerPlay, _thirdPowerPlay) &&
            (identical(other.pitchType, pitchType) ||
                other.pitchType == pitchType) &&
            (identical(other.matchType, matchType) ||
                other.matchType == matchType) &&
            (identical(other.ballType, ballType) ||
                other.ballType == ballType) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(
                    other.isPowerPlayButtonEnable, isPowerPlayButtonEnable) ||
                other.isPowerPlayButtonEnable == isPowerPlayButtonEnable) &&
            (identical(other.saveBtnError, saveBtnError) ||
                other.saveBtnError == saveBtnError) &&
            (identical(other.startBtnError, startBtnError) ||
                other.startBtnError == startBtnError) &&
            (identical(other.isAddMatchInProgress, isAddMatchInProgress) ||
                other.isAddMatchInProgress == isAddMatchInProgress) &&
            (identical(other.pushTossDetailScreen, pushTossDetailScreen) ||
                other.pushTossDetailScreen == pushTossDetailScreen) &&
            (identical(other.match, match) || other.match == match));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        matchTime,
        totalOverController,
        overPerBowlerController,
        cityController,
        groundController,
        const DeepCollectionEquality().hash(error),
        const DeepCollectionEquality().hash(actionError),
        teamA,
        teamB,
        const DeepCollectionEquality().hash(_squadA),
        const DeepCollectionEquality().hash(_squadB),
        teamACaptainId,
        teamBCaptainId,
        teamAAdminId,
        teamBAdminId,
        const DeepCollectionEquality().hash(_officials),
        const DeepCollectionEquality().hash(_firstPowerPlay),
        const DeepCollectionEquality().hash(_secondPowerPlay),
        const DeepCollectionEquality().hash(_thirdPowerPlay),
        pitchType,
        matchType,
        ballType,
        loading,
        isPowerPlayButtonEnable,
        saveBtnError,
        startBtnError,
        isAddMatchInProgress,
        pushTossDetailScreen,
        match
      ]);

  /// Create a copy of AddMatchViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddMatchViewStateImplCopyWith<_$AddMatchViewStateImpl> get copyWith =>
      __$$AddMatchViewStateImplCopyWithImpl<_$AddMatchViewStateImpl>(
          this, _$identity);
}

abstract class _AddMatchViewState implements AddMatchViewState {
  const factory _AddMatchViewState(
      {required final DateTime matchTime,
      required final TextEditingController totalOverController,
      required final TextEditingController overPerBowlerController,
      required final TextEditingController cityController,
      required final TextEditingController groundController,
      final Object? error,
      final Object? actionError,
      final TeamModel? teamA,
      final TeamModel? teamB,
      final List<MatchPlayer>? squadA,
      final List<MatchPlayer>? squadB,
      final String? teamACaptainId,
      final String? teamBCaptainId,
      final String? teamAAdminId,
      final String? teamBAdminId,
      final List<Officials> officials,
      final List<int>? firstPowerPlay,
      final List<int>? secondPowerPlay,
      final List<int>? thirdPowerPlay,
      final PitchType pitchType,
      final MatchType matchType,
      final BallType ballType,
      final bool loading,
      final bool isPowerPlayButtonEnable,
      final AddMatchErrorType? saveBtnError,
      final AddMatchErrorType? startBtnError,
      final bool isAddMatchInProgress,
      final bool? pushTossDetailScreen,
      final MatchModel? match}) = _$AddMatchViewStateImpl;

  @override
  DateTime get matchTime;
  @override
  TextEditingController get totalOverController;
  @override
  TextEditingController get overPerBowlerController;
  @override
  TextEditingController get cityController;
  @override
  TextEditingController get groundController;
  @override
  Object? get error;
  @override
  Object? get actionError;
  @override
  TeamModel? get teamA;
  @override
  TeamModel? get teamB;
  @override
  List<MatchPlayer>? get squadA;
  @override
  List<MatchPlayer>? get squadB;
  @override
  String? get teamACaptainId;
  @override
  String? get teamBCaptainId;
  @override
  String? get teamAAdminId;
  @override
  String? get teamBAdminId;
  @override
  List<Officials> get officials;
  @override
  List<int>? get firstPowerPlay;
  @override
  List<int>? get secondPowerPlay;
  @override
  List<int>? get thirdPowerPlay;
  @override
  PitchType get pitchType;
  @override
  MatchType get matchType;
  @override
  BallType get ballType;
  @override
  bool get loading;
  @override
  bool get isPowerPlayButtonEnable;
  @override
  AddMatchErrorType? get saveBtnError;
  @override
  AddMatchErrorType? get startBtnError;
  @override
  bool get isAddMatchInProgress;
  @override
  bool? get pushTossDetailScreen;
  @override
  MatchModel? get match;

  /// Create a copy of AddMatchViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddMatchViewStateImplCopyWith<_$AddMatchViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
