// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score_board_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ScoreBoardViewState {
  Object? get error => throw _privateConstructorUsedError;
  Object? get actionError => throw _privateConstructorUsedError;
  MatchModel? get match => throw _privateConstructorUsedError;
  InningModel? get currentInning => throw _privateConstructorUsedError;
  InningModel? get otherInning => throw _privateConstructorUsedError;
  MatchPlayer? get bowler => throw _privateConstructorUsedError;
  String? get strikerId => throw _privateConstructorUsedError;
  List<MatchPlayer>? get batsMans => throw _privateConstructorUsedError;
  InningModel? get nextInning => throw _privateConstructorUsedError;
  DateTime? get showSelectFieldingPositionSheet =>
      throw _privateConstructorUsedError;
  DateTime? get showSelectBatsManSheet => throw _privateConstructorUsedError;
  DateTime? get showSelectBowlerSheet => throw _privateConstructorUsedError;
  DateTime? get showSelectBowlerAndBatsManSheet =>
      throw _privateConstructorUsedError;
  DateTime? get showSelectPlayerSheet => throw _privateConstructorUsedError;
  DateTime? get showSelectWicketTypeSheet => throw _privateConstructorUsedError;
  DateTime? get showStrikerSelectionSheet => throw _privateConstructorUsedError;
  DateTime? get showUndoBallConfirmationDialog =>
      throw _privateConstructorUsedError;
  DateTime? get showOverCompleteSheet => throw _privateConstructorUsedError;
  DateTime? get showInningCompleteSheet => throw _privateConstructorUsedError;
  DateTime? get showMatchCompleteSheet => throw _privateConstructorUsedError;
  DateTime? get showAddExtraSheetForNoBall =>
      throw _privateConstructorUsedError;
  DateTime? get showAddExtraSheetForLegBye =>
      throw _privateConstructorUsedError;
  DateTime? get showAddExtraSheetForBye => throw _privateConstructorUsedError;
  DateTime? get showAddExtraSheetForFiveSeven =>
      throw _privateConstructorUsedError;
  DateTime? get showPauseScoringSheet => throw _privateConstructorUsedError;
  DateTime? get showAddPenaltyRunSheet => throw _privateConstructorUsedError;
  DateTime? get showEndMatchSheet => throw _privateConstructorUsedError;
  DateTime? get showAddSubstituteSheet => throw _privateConstructorUsedError;
  DateTime? get invalidUndoToast => throw _privateConstructorUsedError;
  DateTime? get showReviseTargetSheet => throw _privateConstructorUsedError;
  DateTime? get showHandOverScoringSheet => throw _privateConstructorUsedError;
  ScoreButton? get tappedButton => throw _privateConstructorUsedError;
  bool? get isLongTap => throw _privateConstructorUsedError;
  FieldingPositionType? get position => throw _privateConstructorUsedError;
  List<InningModel> get allInnings => throw _privateConstructorUsedError;
  List<BallScoreModel> get currentScoresList =>
      throw _privateConstructorUsedError;
  List<BallScoreModel> get previousScoresList =>
      throw _privateConstructorUsedError;
  MatchSetting get matchSetting => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get pop => throw _privateConstructorUsedError;
  bool get ballScoreQueryListenerSet => throw _privateConstructorUsedError;
  bool get isMatchUpdated => throw _privateConstructorUsedError;
  bool get isActionInProgress => throw _privateConstructorUsedError;
  int get ballCount => throw _privateConstructorUsedError;
  int get overCount => throw _privateConstructorUsedError;
  int get lastAssignedIndex => throw _privateConstructorUsedError;

  /// Create a copy of ScoreBoardViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScoreBoardViewStateCopyWith<ScoreBoardViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreBoardViewStateCopyWith<$Res> {
  factory $ScoreBoardViewStateCopyWith(
          ScoreBoardViewState value, $Res Function(ScoreBoardViewState) then) =
      _$ScoreBoardViewStateCopyWithImpl<$Res, ScoreBoardViewState>;
  @useResult
  $Res call(
      {Object? error,
      Object? actionError,
      MatchModel? match,
      InningModel? currentInning,
      InningModel? otherInning,
      MatchPlayer? bowler,
      String? strikerId,
      List<MatchPlayer>? batsMans,
      InningModel? nextInning,
      DateTime? showSelectFieldingPositionSheet,
      DateTime? showSelectBatsManSheet,
      DateTime? showSelectBowlerSheet,
      DateTime? showSelectBowlerAndBatsManSheet,
      DateTime? showSelectPlayerSheet,
      DateTime? showSelectWicketTypeSheet,
      DateTime? showStrikerSelectionSheet,
      DateTime? showUndoBallConfirmationDialog,
      DateTime? showOverCompleteSheet,
      DateTime? showInningCompleteSheet,
      DateTime? showMatchCompleteSheet,
      DateTime? showAddExtraSheetForNoBall,
      DateTime? showAddExtraSheetForLegBye,
      DateTime? showAddExtraSheetForBye,
      DateTime? showAddExtraSheetForFiveSeven,
      DateTime? showPauseScoringSheet,
      DateTime? showAddPenaltyRunSheet,
      DateTime? showEndMatchSheet,
      DateTime? showAddSubstituteSheet,
      DateTime? invalidUndoToast,
      DateTime? showReviseTargetSheet,
      DateTime? showHandOverScoringSheet,
      ScoreButton? tappedButton,
      bool? isLongTap,
      FieldingPositionType? position,
      List<InningModel> allInnings,
      List<BallScoreModel> currentScoresList,
      List<BallScoreModel> previousScoresList,
      MatchSetting matchSetting,
      bool loading,
      bool pop,
      bool ballScoreQueryListenerSet,
      bool isMatchUpdated,
      bool isActionInProgress,
      int ballCount,
      int overCount,
      int lastAssignedIndex});

  $MatchModelCopyWith<$Res>? get match;
  $InningModelCopyWith<$Res>? get currentInning;
  $InningModelCopyWith<$Res>? get otherInning;
  $MatchPlayerCopyWith<$Res>? get bowler;
  $InningModelCopyWith<$Res>? get nextInning;
  $MatchSettingCopyWith<$Res> get matchSetting;
}

/// @nodoc
class _$ScoreBoardViewStateCopyWithImpl<$Res, $Val extends ScoreBoardViewState>
    implements $ScoreBoardViewStateCopyWith<$Res> {
  _$ScoreBoardViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScoreBoardViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? actionError = freezed,
    Object? match = freezed,
    Object? currentInning = freezed,
    Object? otherInning = freezed,
    Object? bowler = freezed,
    Object? strikerId = freezed,
    Object? batsMans = freezed,
    Object? nextInning = freezed,
    Object? showSelectFieldingPositionSheet = freezed,
    Object? showSelectBatsManSheet = freezed,
    Object? showSelectBowlerSheet = freezed,
    Object? showSelectBowlerAndBatsManSheet = freezed,
    Object? showSelectPlayerSheet = freezed,
    Object? showSelectWicketTypeSheet = freezed,
    Object? showStrikerSelectionSheet = freezed,
    Object? showUndoBallConfirmationDialog = freezed,
    Object? showOverCompleteSheet = freezed,
    Object? showInningCompleteSheet = freezed,
    Object? showMatchCompleteSheet = freezed,
    Object? showAddExtraSheetForNoBall = freezed,
    Object? showAddExtraSheetForLegBye = freezed,
    Object? showAddExtraSheetForBye = freezed,
    Object? showAddExtraSheetForFiveSeven = freezed,
    Object? showPauseScoringSheet = freezed,
    Object? showAddPenaltyRunSheet = freezed,
    Object? showEndMatchSheet = freezed,
    Object? showAddSubstituteSheet = freezed,
    Object? invalidUndoToast = freezed,
    Object? showReviseTargetSheet = freezed,
    Object? showHandOverScoringSheet = freezed,
    Object? tappedButton = freezed,
    Object? isLongTap = freezed,
    Object? position = freezed,
    Object? allInnings = null,
    Object? currentScoresList = null,
    Object? previousScoresList = null,
    Object? matchSetting = null,
    Object? loading = null,
    Object? pop = null,
    Object? ballScoreQueryListenerSet = null,
    Object? isMatchUpdated = null,
    Object? isActionInProgress = null,
    Object? ballCount = null,
    Object? overCount = null,
    Object? lastAssignedIndex = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
      match: freezed == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as MatchModel?,
      currentInning: freezed == currentInning
          ? _value.currentInning
          : currentInning // ignore: cast_nullable_to_non_nullable
              as InningModel?,
      otherInning: freezed == otherInning
          ? _value.otherInning
          : otherInning // ignore: cast_nullable_to_non_nullable
              as InningModel?,
      bowler: freezed == bowler
          ? _value.bowler
          : bowler // ignore: cast_nullable_to_non_nullable
              as MatchPlayer?,
      strikerId: freezed == strikerId
          ? _value.strikerId
          : strikerId // ignore: cast_nullable_to_non_nullable
              as String?,
      batsMans: freezed == batsMans
          ? _value.batsMans
          : batsMans // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>?,
      nextInning: freezed == nextInning
          ? _value.nextInning
          : nextInning // ignore: cast_nullable_to_non_nullable
              as InningModel?,
      showSelectFieldingPositionSheet: freezed ==
              showSelectFieldingPositionSheet
          ? _value.showSelectFieldingPositionSheet
          : showSelectFieldingPositionSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showSelectBatsManSheet: freezed == showSelectBatsManSheet
          ? _value.showSelectBatsManSheet
          : showSelectBatsManSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showSelectBowlerSheet: freezed == showSelectBowlerSheet
          ? _value.showSelectBowlerSheet
          : showSelectBowlerSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showSelectBowlerAndBatsManSheet: freezed ==
              showSelectBowlerAndBatsManSheet
          ? _value.showSelectBowlerAndBatsManSheet
          : showSelectBowlerAndBatsManSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showSelectPlayerSheet: freezed == showSelectPlayerSheet
          ? _value.showSelectPlayerSheet
          : showSelectPlayerSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showSelectWicketTypeSheet: freezed == showSelectWicketTypeSheet
          ? _value.showSelectWicketTypeSheet
          : showSelectWicketTypeSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showStrikerSelectionSheet: freezed == showStrikerSelectionSheet
          ? _value.showStrikerSelectionSheet
          : showStrikerSelectionSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showUndoBallConfirmationDialog: freezed == showUndoBallConfirmationDialog
          ? _value.showUndoBallConfirmationDialog
          : showUndoBallConfirmationDialog // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showOverCompleteSheet: freezed == showOverCompleteSheet
          ? _value.showOverCompleteSheet
          : showOverCompleteSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showInningCompleteSheet: freezed == showInningCompleteSheet
          ? _value.showInningCompleteSheet
          : showInningCompleteSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showMatchCompleteSheet: freezed == showMatchCompleteSheet
          ? _value.showMatchCompleteSheet
          : showMatchCompleteSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showAddExtraSheetForNoBall: freezed == showAddExtraSheetForNoBall
          ? _value.showAddExtraSheetForNoBall
          : showAddExtraSheetForNoBall // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showAddExtraSheetForLegBye: freezed == showAddExtraSheetForLegBye
          ? _value.showAddExtraSheetForLegBye
          : showAddExtraSheetForLegBye // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showAddExtraSheetForBye: freezed == showAddExtraSheetForBye
          ? _value.showAddExtraSheetForBye
          : showAddExtraSheetForBye // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showAddExtraSheetForFiveSeven: freezed == showAddExtraSheetForFiveSeven
          ? _value.showAddExtraSheetForFiveSeven
          : showAddExtraSheetForFiveSeven // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showPauseScoringSheet: freezed == showPauseScoringSheet
          ? _value.showPauseScoringSheet
          : showPauseScoringSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showAddPenaltyRunSheet: freezed == showAddPenaltyRunSheet
          ? _value.showAddPenaltyRunSheet
          : showAddPenaltyRunSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showEndMatchSheet: freezed == showEndMatchSheet
          ? _value.showEndMatchSheet
          : showEndMatchSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showAddSubstituteSheet: freezed == showAddSubstituteSheet
          ? _value.showAddSubstituteSheet
          : showAddSubstituteSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      invalidUndoToast: freezed == invalidUndoToast
          ? _value.invalidUndoToast
          : invalidUndoToast // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showReviseTargetSheet: freezed == showReviseTargetSheet
          ? _value.showReviseTargetSheet
          : showReviseTargetSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showHandOverScoringSheet: freezed == showHandOverScoringSheet
          ? _value.showHandOverScoringSheet
          : showHandOverScoringSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tappedButton: freezed == tappedButton
          ? _value.tappedButton
          : tappedButton // ignore: cast_nullable_to_non_nullable
              as ScoreButton?,
      isLongTap: freezed == isLongTap
          ? _value.isLongTap
          : isLongTap // ignore: cast_nullable_to_non_nullable
              as bool?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as FieldingPositionType?,
      allInnings: null == allInnings
          ? _value.allInnings
          : allInnings // ignore: cast_nullable_to_non_nullable
              as List<InningModel>,
      currentScoresList: null == currentScoresList
          ? _value.currentScoresList
          : currentScoresList // ignore: cast_nullable_to_non_nullable
              as List<BallScoreModel>,
      previousScoresList: null == previousScoresList
          ? _value.previousScoresList
          : previousScoresList // ignore: cast_nullable_to_non_nullable
              as List<BallScoreModel>,
      matchSetting: null == matchSetting
          ? _value.matchSetting
          : matchSetting // ignore: cast_nullable_to_non_nullable
              as MatchSetting,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      pop: null == pop
          ? _value.pop
          : pop // ignore: cast_nullable_to_non_nullable
              as bool,
      ballScoreQueryListenerSet: null == ballScoreQueryListenerSet
          ? _value.ballScoreQueryListenerSet
          : ballScoreQueryListenerSet // ignore: cast_nullable_to_non_nullable
              as bool,
      isMatchUpdated: null == isMatchUpdated
          ? _value.isMatchUpdated
          : isMatchUpdated // ignore: cast_nullable_to_non_nullable
              as bool,
      isActionInProgress: null == isActionInProgress
          ? _value.isActionInProgress
          : isActionInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      ballCount: null == ballCount
          ? _value.ballCount
          : ballCount // ignore: cast_nullable_to_non_nullable
              as int,
      overCount: null == overCount
          ? _value.overCount
          : overCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastAssignedIndex: null == lastAssignedIndex
          ? _value.lastAssignedIndex
          : lastAssignedIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of ScoreBoardViewState
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

  /// Create a copy of ScoreBoardViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InningModelCopyWith<$Res>? get currentInning {
    if (_value.currentInning == null) {
      return null;
    }

    return $InningModelCopyWith<$Res>(_value.currentInning!, (value) {
      return _then(_value.copyWith(currentInning: value) as $Val);
    });
  }

  /// Create a copy of ScoreBoardViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InningModelCopyWith<$Res>? get otherInning {
    if (_value.otherInning == null) {
      return null;
    }

    return $InningModelCopyWith<$Res>(_value.otherInning!, (value) {
      return _then(_value.copyWith(otherInning: value) as $Val);
    });
  }

  /// Create a copy of ScoreBoardViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchPlayerCopyWith<$Res>? get bowler {
    if (_value.bowler == null) {
      return null;
    }

    return $MatchPlayerCopyWith<$Res>(_value.bowler!, (value) {
      return _then(_value.copyWith(bowler: value) as $Val);
    });
  }

  /// Create a copy of ScoreBoardViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InningModelCopyWith<$Res>? get nextInning {
    if (_value.nextInning == null) {
      return null;
    }

    return $InningModelCopyWith<$Res>(_value.nextInning!, (value) {
      return _then(_value.copyWith(nextInning: value) as $Val);
    });
  }

  /// Create a copy of ScoreBoardViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchSettingCopyWith<$Res> get matchSetting {
    return $MatchSettingCopyWith<$Res>(_value.matchSetting, (value) {
      return _then(_value.copyWith(matchSetting: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScoreBoardViewStateImplCopyWith<$Res>
    implements $ScoreBoardViewStateCopyWith<$Res> {
  factory _$$ScoreBoardViewStateImplCopyWith(_$ScoreBoardViewStateImpl value,
          $Res Function(_$ScoreBoardViewStateImpl) then) =
      __$$ScoreBoardViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error,
      Object? actionError,
      MatchModel? match,
      InningModel? currentInning,
      InningModel? otherInning,
      MatchPlayer? bowler,
      String? strikerId,
      List<MatchPlayer>? batsMans,
      InningModel? nextInning,
      DateTime? showSelectFieldingPositionSheet,
      DateTime? showSelectBatsManSheet,
      DateTime? showSelectBowlerSheet,
      DateTime? showSelectBowlerAndBatsManSheet,
      DateTime? showSelectPlayerSheet,
      DateTime? showSelectWicketTypeSheet,
      DateTime? showStrikerSelectionSheet,
      DateTime? showUndoBallConfirmationDialog,
      DateTime? showOverCompleteSheet,
      DateTime? showInningCompleteSheet,
      DateTime? showMatchCompleteSheet,
      DateTime? showAddExtraSheetForNoBall,
      DateTime? showAddExtraSheetForLegBye,
      DateTime? showAddExtraSheetForBye,
      DateTime? showAddExtraSheetForFiveSeven,
      DateTime? showPauseScoringSheet,
      DateTime? showAddPenaltyRunSheet,
      DateTime? showEndMatchSheet,
      DateTime? showAddSubstituteSheet,
      DateTime? invalidUndoToast,
      DateTime? showReviseTargetSheet,
      DateTime? showHandOverScoringSheet,
      ScoreButton? tappedButton,
      bool? isLongTap,
      FieldingPositionType? position,
      List<InningModel> allInnings,
      List<BallScoreModel> currentScoresList,
      List<BallScoreModel> previousScoresList,
      MatchSetting matchSetting,
      bool loading,
      bool pop,
      bool ballScoreQueryListenerSet,
      bool isMatchUpdated,
      bool isActionInProgress,
      int ballCount,
      int overCount,
      int lastAssignedIndex});

  @override
  $MatchModelCopyWith<$Res>? get match;
  @override
  $InningModelCopyWith<$Res>? get currentInning;
  @override
  $InningModelCopyWith<$Res>? get otherInning;
  @override
  $MatchPlayerCopyWith<$Res>? get bowler;
  @override
  $InningModelCopyWith<$Res>? get nextInning;
  @override
  $MatchSettingCopyWith<$Res> get matchSetting;
}

/// @nodoc
class __$$ScoreBoardViewStateImplCopyWithImpl<$Res>
    extends _$ScoreBoardViewStateCopyWithImpl<$Res, _$ScoreBoardViewStateImpl>
    implements _$$ScoreBoardViewStateImplCopyWith<$Res> {
  __$$ScoreBoardViewStateImplCopyWithImpl(_$ScoreBoardViewStateImpl _value,
      $Res Function(_$ScoreBoardViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScoreBoardViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? actionError = freezed,
    Object? match = freezed,
    Object? currentInning = freezed,
    Object? otherInning = freezed,
    Object? bowler = freezed,
    Object? strikerId = freezed,
    Object? batsMans = freezed,
    Object? nextInning = freezed,
    Object? showSelectFieldingPositionSheet = freezed,
    Object? showSelectBatsManSheet = freezed,
    Object? showSelectBowlerSheet = freezed,
    Object? showSelectBowlerAndBatsManSheet = freezed,
    Object? showSelectPlayerSheet = freezed,
    Object? showSelectWicketTypeSheet = freezed,
    Object? showStrikerSelectionSheet = freezed,
    Object? showUndoBallConfirmationDialog = freezed,
    Object? showOverCompleteSheet = freezed,
    Object? showInningCompleteSheet = freezed,
    Object? showMatchCompleteSheet = freezed,
    Object? showAddExtraSheetForNoBall = freezed,
    Object? showAddExtraSheetForLegBye = freezed,
    Object? showAddExtraSheetForBye = freezed,
    Object? showAddExtraSheetForFiveSeven = freezed,
    Object? showPauseScoringSheet = freezed,
    Object? showAddPenaltyRunSheet = freezed,
    Object? showEndMatchSheet = freezed,
    Object? showAddSubstituteSheet = freezed,
    Object? invalidUndoToast = freezed,
    Object? showReviseTargetSheet = freezed,
    Object? showHandOverScoringSheet = freezed,
    Object? tappedButton = freezed,
    Object? isLongTap = freezed,
    Object? position = freezed,
    Object? allInnings = null,
    Object? currentScoresList = null,
    Object? previousScoresList = null,
    Object? matchSetting = null,
    Object? loading = null,
    Object? pop = null,
    Object? ballScoreQueryListenerSet = null,
    Object? isMatchUpdated = null,
    Object? isActionInProgress = null,
    Object? ballCount = null,
    Object? overCount = null,
    Object? lastAssignedIndex = null,
  }) {
    return _then(_$ScoreBoardViewStateImpl(
      error: freezed == error ? _value.error : error,
      actionError: freezed == actionError ? _value.actionError : actionError,
      match: freezed == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as MatchModel?,
      currentInning: freezed == currentInning
          ? _value.currentInning
          : currentInning // ignore: cast_nullable_to_non_nullable
              as InningModel?,
      otherInning: freezed == otherInning
          ? _value.otherInning
          : otherInning // ignore: cast_nullable_to_non_nullable
              as InningModel?,
      bowler: freezed == bowler
          ? _value.bowler
          : bowler // ignore: cast_nullable_to_non_nullable
              as MatchPlayer?,
      strikerId: freezed == strikerId
          ? _value.strikerId
          : strikerId // ignore: cast_nullable_to_non_nullable
              as String?,
      batsMans: freezed == batsMans
          ? _value._batsMans
          : batsMans // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>?,
      nextInning: freezed == nextInning
          ? _value.nextInning
          : nextInning // ignore: cast_nullable_to_non_nullable
              as InningModel?,
      showSelectFieldingPositionSheet: freezed ==
              showSelectFieldingPositionSheet
          ? _value.showSelectFieldingPositionSheet
          : showSelectFieldingPositionSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showSelectBatsManSheet: freezed == showSelectBatsManSheet
          ? _value.showSelectBatsManSheet
          : showSelectBatsManSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showSelectBowlerSheet: freezed == showSelectBowlerSheet
          ? _value.showSelectBowlerSheet
          : showSelectBowlerSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showSelectBowlerAndBatsManSheet: freezed ==
              showSelectBowlerAndBatsManSheet
          ? _value.showSelectBowlerAndBatsManSheet
          : showSelectBowlerAndBatsManSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showSelectPlayerSheet: freezed == showSelectPlayerSheet
          ? _value.showSelectPlayerSheet
          : showSelectPlayerSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showSelectWicketTypeSheet: freezed == showSelectWicketTypeSheet
          ? _value.showSelectWicketTypeSheet
          : showSelectWicketTypeSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showStrikerSelectionSheet: freezed == showStrikerSelectionSheet
          ? _value.showStrikerSelectionSheet
          : showStrikerSelectionSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showUndoBallConfirmationDialog: freezed == showUndoBallConfirmationDialog
          ? _value.showUndoBallConfirmationDialog
          : showUndoBallConfirmationDialog // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showOverCompleteSheet: freezed == showOverCompleteSheet
          ? _value.showOverCompleteSheet
          : showOverCompleteSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showInningCompleteSheet: freezed == showInningCompleteSheet
          ? _value.showInningCompleteSheet
          : showInningCompleteSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showMatchCompleteSheet: freezed == showMatchCompleteSheet
          ? _value.showMatchCompleteSheet
          : showMatchCompleteSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showAddExtraSheetForNoBall: freezed == showAddExtraSheetForNoBall
          ? _value.showAddExtraSheetForNoBall
          : showAddExtraSheetForNoBall // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showAddExtraSheetForLegBye: freezed == showAddExtraSheetForLegBye
          ? _value.showAddExtraSheetForLegBye
          : showAddExtraSheetForLegBye // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showAddExtraSheetForBye: freezed == showAddExtraSheetForBye
          ? _value.showAddExtraSheetForBye
          : showAddExtraSheetForBye // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showAddExtraSheetForFiveSeven: freezed == showAddExtraSheetForFiveSeven
          ? _value.showAddExtraSheetForFiveSeven
          : showAddExtraSheetForFiveSeven // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showPauseScoringSheet: freezed == showPauseScoringSheet
          ? _value.showPauseScoringSheet
          : showPauseScoringSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showAddPenaltyRunSheet: freezed == showAddPenaltyRunSheet
          ? _value.showAddPenaltyRunSheet
          : showAddPenaltyRunSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showEndMatchSheet: freezed == showEndMatchSheet
          ? _value.showEndMatchSheet
          : showEndMatchSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showAddSubstituteSheet: freezed == showAddSubstituteSheet
          ? _value.showAddSubstituteSheet
          : showAddSubstituteSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      invalidUndoToast: freezed == invalidUndoToast
          ? _value.invalidUndoToast
          : invalidUndoToast // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showReviseTargetSheet: freezed == showReviseTargetSheet
          ? _value.showReviseTargetSheet
          : showReviseTargetSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showHandOverScoringSheet: freezed == showHandOverScoringSheet
          ? _value.showHandOverScoringSheet
          : showHandOverScoringSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tappedButton: freezed == tappedButton
          ? _value.tappedButton
          : tappedButton // ignore: cast_nullable_to_non_nullable
              as ScoreButton?,
      isLongTap: freezed == isLongTap
          ? _value.isLongTap
          : isLongTap // ignore: cast_nullable_to_non_nullable
              as bool?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as FieldingPositionType?,
      allInnings: null == allInnings
          ? _value._allInnings
          : allInnings // ignore: cast_nullable_to_non_nullable
              as List<InningModel>,
      currentScoresList: null == currentScoresList
          ? _value._currentScoresList
          : currentScoresList // ignore: cast_nullable_to_non_nullable
              as List<BallScoreModel>,
      previousScoresList: null == previousScoresList
          ? _value._previousScoresList
          : previousScoresList // ignore: cast_nullable_to_non_nullable
              as List<BallScoreModel>,
      matchSetting: null == matchSetting
          ? _value.matchSetting
          : matchSetting // ignore: cast_nullable_to_non_nullable
              as MatchSetting,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      pop: null == pop
          ? _value.pop
          : pop // ignore: cast_nullable_to_non_nullable
              as bool,
      ballScoreQueryListenerSet: null == ballScoreQueryListenerSet
          ? _value.ballScoreQueryListenerSet
          : ballScoreQueryListenerSet // ignore: cast_nullable_to_non_nullable
              as bool,
      isMatchUpdated: null == isMatchUpdated
          ? _value.isMatchUpdated
          : isMatchUpdated // ignore: cast_nullable_to_non_nullable
              as bool,
      isActionInProgress: null == isActionInProgress
          ? _value.isActionInProgress
          : isActionInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      ballCount: null == ballCount
          ? _value.ballCount
          : ballCount // ignore: cast_nullable_to_non_nullable
              as int,
      overCount: null == overCount
          ? _value.overCount
          : overCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastAssignedIndex: null == lastAssignedIndex
          ? _value.lastAssignedIndex
          : lastAssignedIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ScoreBoardViewStateImpl implements _ScoreBoardViewState {
  const _$ScoreBoardViewStateImpl(
      {this.error,
      this.actionError,
      this.match,
      this.currentInning,
      this.otherInning,
      this.bowler,
      this.strikerId,
      final List<MatchPlayer>? batsMans,
      this.nextInning,
      this.showSelectFieldingPositionSheet,
      this.showSelectBatsManSheet,
      this.showSelectBowlerSheet,
      this.showSelectBowlerAndBatsManSheet,
      this.showSelectPlayerSheet,
      this.showSelectWicketTypeSheet,
      this.showStrikerSelectionSheet,
      this.showUndoBallConfirmationDialog,
      this.showOverCompleteSheet,
      this.showInningCompleteSheet,
      this.showMatchCompleteSheet,
      this.showAddExtraSheetForNoBall,
      this.showAddExtraSheetForLegBye,
      this.showAddExtraSheetForBye,
      this.showAddExtraSheetForFiveSeven,
      this.showPauseScoringSheet,
      this.showAddPenaltyRunSheet,
      this.showEndMatchSheet,
      this.showAddSubstituteSheet,
      this.invalidUndoToast,
      this.showReviseTargetSheet,
      this.showHandOverScoringSheet,
      this.tappedButton,
      this.isLongTap,
      this.position,
      final List<InningModel> allInnings = const [],
      final List<BallScoreModel> currentScoresList = const [],
      final List<BallScoreModel> previousScoresList = const [],
      this.matchSetting = const MatchSetting(),
      this.loading = false,
      this.pop = false,
      this.ballScoreQueryListenerSet = false,
      this.isMatchUpdated = true,
      this.isActionInProgress = false,
      this.ballCount = 0,
      this.overCount = 1,
      this.lastAssignedIndex = 0})
      : _batsMans = batsMans,
        _allInnings = allInnings,
        _currentScoresList = currentScoresList,
        _previousScoresList = previousScoresList;

  @override
  final Object? error;
  @override
  final Object? actionError;
  @override
  final MatchModel? match;
  @override
  final InningModel? currentInning;
  @override
  final InningModel? otherInning;
  @override
  final MatchPlayer? bowler;
  @override
  final String? strikerId;
  final List<MatchPlayer>? _batsMans;
  @override
  List<MatchPlayer>? get batsMans {
    final value = _batsMans;
    if (value == null) return null;
    if (_batsMans is EqualUnmodifiableListView) return _batsMans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final InningModel? nextInning;
  @override
  final DateTime? showSelectFieldingPositionSheet;
  @override
  final DateTime? showSelectBatsManSheet;
  @override
  final DateTime? showSelectBowlerSheet;
  @override
  final DateTime? showSelectBowlerAndBatsManSheet;
  @override
  final DateTime? showSelectPlayerSheet;
  @override
  final DateTime? showSelectWicketTypeSheet;
  @override
  final DateTime? showStrikerSelectionSheet;
  @override
  final DateTime? showUndoBallConfirmationDialog;
  @override
  final DateTime? showOverCompleteSheet;
  @override
  final DateTime? showInningCompleteSheet;
  @override
  final DateTime? showMatchCompleteSheet;
  @override
  final DateTime? showAddExtraSheetForNoBall;
  @override
  final DateTime? showAddExtraSheetForLegBye;
  @override
  final DateTime? showAddExtraSheetForBye;
  @override
  final DateTime? showAddExtraSheetForFiveSeven;
  @override
  final DateTime? showPauseScoringSheet;
  @override
  final DateTime? showAddPenaltyRunSheet;
  @override
  final DateTime? showEndMatchSheet;
  @override
  final DateTime? showAddSubstituteSheet;
  @override
  final DateTime? invalidUndoToast;
  @override
  final DateTime? showReviseTargetSheet;
  @override
  final DateTime? showHandOverScoringSheet;
  @override
  final ScoreButton? tappedButton;
  @override
  final bool? isLongTap;
  @override
  final FieldingPositionType? position;
  final List<InningModel> _allInnings;
  @override
  @JsonKey()
  List<InningModel> get allInnings {
    if (_allInnings is EqualUnmodifiableListView) return _allInnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allInnings);
  }

  final List<BallScoreModel> _currentScoresList;
  @override
  @JsonKey()
  List<BallScoreModel> get currentScoresList {
    if (_currentScoresList is EqualUnmodifiableListView)
      return _currentScoresList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentScoresList);
  }

  final List<BallScoreModel> _previousScoresList;
  @override
  @JsonKey()
  List<BallScoreModel> get previousScoresList {
    if (_previousScoresList is EqualUnmodifiableListView)
      return _previousScoresList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_previousScoresList);
  }

  @override
  @JsonKey()
  final MatchSetting matchSetting;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool pop;
  @override
  @JsonKey()
  final bool ballScoreQueryListenerSet;
  @override
  @JsonKey()
  final bool isMatchUpdated;
  @override
  @JsonKey()
  final bool isActionInProgress;
  @override
  @JsonKey()
  final int ballCount;
  @override
  @JsonKey()
  final int overCount;
  @override
  @JsonKey()
  final int lastAssignedIndex;

  @override
  String toString() {
    return 'ScoreBoardViewState(error: $error, actionError: $actionError, match: $match, currentInning: $currentInning, otherInning: $otherInning, bowler: $bowler, strikerId: $strikerId, batsMans: $batsMans, nextInning: $nextInning, showSelectFieldingPositionSheet: $showSelectFieldingPositionSheet, showSelectBatsManSheet: $showSelectBatsManSheet, showSelectBowlerSheet: $showSelectBowlerSheet, showSelectBowlerAndBatsManSheet: $showSelectBowlerAndBatsManSheet, showSelectPlayerSheet: $showSelectPlayerSheet, showSelectWicketTypeSheet: $showSelectWicketTypeSheet, showStrikerSelectionSheet: $showStrikerSelectionSheet, showUndoBallConfirmationDialog: $showUndoBallConfirmationDialog, showOverCompleteSheet: $showOverCompleteSheet, showInningCompleteSheet: $showInningCompleteSheet, showMatchCompleteSheet: $showMatchCompleteSheet, showAddExtraSheetForNoBall: $showAddExtraSheetForNoBall, showAddExtraSheetForLegBye: $showAddExtraSheetForLegBye, showAddExtraSheetForBye: $showAddExtraSheetForBye, showAddExtraSheetForFiveSeven: $showAddExtraSheetForFiveSeven, showPauseScoringSheet: $showPauseScoringSheet, showAddPenaltyRunSheet: $showAddPenaltyRunSheet, showEndMatchSheet: $showEndMatchSheet, showAddSubstituteSheet: $showAddSubstituteSheet, invalidUndoToast: $invalidUndoToast, showReviseTargetSheet: $showReviseTargetSheet, showHandOverScoringSheet: $showHandOverScoringSheet, tappedButton: $tappedButton, isLongTap: $isLongTap, position: $position, allInnings: $allInnings, currentScoresList: $currentScoresList, previousScoresList: $previousScoresList, matchSetting: $matchSetting, loading: $loading, pop: $pop, ballScoreQueryListenerSet: $ballScoreQueryListenerSet, isMatchUpdated: $isMatchUpdated, isActionInProgress: $isActionInProgress, ballCount: $ballCount, overCount: $overCount, lastAssignedIndex: $lastAssignedIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScoreBoardViewStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError) &&
            (identical(other.match, match) || other.match == match) &&
            (identical(other.currentInning, currentInning) ||
                other.currentInning == currentInning) &&
            (identical(other.otherInning, otherInning) ||
                other.otherInning == otherInning) &&
            (identical(other.bowler, bowler) || other.bowler == bowler) &&
            (identical(other.strikerId, strikerId) ||
                other.strikerId == strikerId) &&
            const DeepCollectionEquality().equals(other._batsMans, _batsMans) &&
            (identical(other.nextInning, nextInning) ||
                other.nextInning == nextInning) &&
            (identical(other.showSelectFieldingPositionSheet, showSelectFieldingPositionSheet) ||
                other.showSelectFieldingPositionSheet ==
                    showSelectFieldingPositionSheet) &&
            (identical(other.showSelectBatsManSheet, showSelectBatsManSheet) ||
                other.showSelectBatsManSheet == showSelectBatsManSheet) &&
            (identical(other.showSelectBowlerSheet, showSelectBowlerSheet) ||
                other.showSelectBowlerSheet == showSelectBowlerSheet) &&
            (identical(other.showSelectBowlerAndBatsManSheet, showSelectBowlerAndBatsManSheet) ||
                other.showSelectBowlerAndBatsManSheet ==
                    showSelectBowlerAndBatsManSheet) &&
            (identical(other.showSelectPlayerSheet, showSelectPlayerSheet) ||
                other.showSelectPlayerSheet == showSelectPlayerSheet) &&
            (identical(other.showSelectWicketTypeSheet, showSelectWicketTypeSheet) ||
                other.showSelectWicketTypeSheet == showSelectWicketTypeSheet) &&
            (identical(other.showStrikerSelectionSheet, showStrikerSelectionSheet) ||
                other.showStrikerSelectionSheet == showStrikerSelectionSheet) &&
            (identical(other.showUndoBallConfirmationDialog, showUndoBallConfirmationDialog) ||
                other.showUndoBallConfirmationDialog ==
                    showUndoBallConfirmationDialog) &&
            (identical(other.showOverCompleteSheet, showOverCompleteSheet) ||
                other.showOverCompleteSheet == showOverCompleteSheet) &&
            (identical(other.showInningCompleteSheet, showInningCompleteSheet) ||
                other.showInningCompleteSheet == showInningCompleteSheet) &&
            (identical(other.showMatchCompleteSheet, showMatchCompleteSheet) ||
                other.showMatchCompleteSheet == showMatchCompleteSheet) &&
            (identical(other.showAddExtraSheetForNoBall, showAddExtraSheetForNoBall) ||
                other.showAddExtraSheetForNoBall ==
                    showAddExtraSheetForNoBall) &&
            (identical(other.showAddExtraSheetForLegBye, showAddExtraSheetForLegBye) ||
                other.showAddExtraSheetForLegBye ==
                    showAddExtraSheetForLegBye) &&
            (identical(other.showAddExtraSheetForBye, showAddExtraSheetForBye) ||
                other.showAddExtraSheetForBye == showAddExtraSheetForBye) &&
            (identical(other.showAddExtraSheetForFiveSeven, showAddExtraSheetForFiveSeven) ||
                other.showAddExtraSheetForFiveSeven ==
                    showAddExtraSheetForFiveSeven) &&
            (identical(other.showPauseScoringSheet, showPauseScoringSheet) ||
                other.showPauseScoringSheet == showPauseScoringSheet) &&
            (identical(other.showAddPenaltyRunSheet, showAddPenaltyRunSheet) || other.showAddPenaltyRunSheet == showAddPenaltyRunSheet) &&
            (identical(other.showEndMatchSheet, showEndMatchSheet) || other.showEndMatchSheet == showEndMatchSheet) &&
            (identical(other.showAddSubstituteSheet, showAddSubstituteSheet) || other.showAddSubstituteSheet == showAddSubstituteSheet) &&
            (identical(other.invalidUndoToast, invalidUndoToast) || other.invalidUndoToast == invalidUndoToast) &&
            (identical(other.showReviseTargetSheet, showReviseTargetSheet) || other.showReviseTargetSheet == showReviseTargetSheet) &&
            (identical(other.showHandOverScoringSheet, showHandOverScoringSheet) || other.showHandOverScoringSheet == showHandOverScoringSheet) &&
            (identical(other.tappedButton, tappedButton) || other.tappedButton == tappedButton) &&
            (identical(other.isLongTap, isLongTap) || other.isLongTap == isLongTap) &&
            (identical(other.position, position) || other.position == position) &&
            const DeepCollectionEquality().equals(other._allInnings, _allInnings) &&
            const DeepCollectionEquality().equals(other._currentScoresList, _currentScoresList) &&
            const DeepCollectionEquality().equals(other._previousScoresList, _previousScoresList) &&
            (identical(other.matchSetting, matchSetting) || other.matchSetting == matchSetting) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.pop, pop) || other.pop == pop) &&
            (identical(other.ballScoreQueryListenerSet, ballScoreQueryListenerSet) || other.ballScoreQueryListenerSet == ballScoreQueryListenerSet) &&
            (identical(other.isMatchUpdated, isMatchUpdated) || other.isMatchUpdated == isMatchUpdated) &&
            (identical(other.isActionInProgress, isActionInProgress) || other.isActionInProgress == isActionInProgress) &&
            (identical(other.ballCount, ballCount) || other.ballCount == ballCount) &&
            (identical(other.overCount, overCount) || other.overCount == overCount) &&
            (identical(other.lastAssignedIndex, lastAssignedIndex) || other.lastAssignedIndex == lastAssignedIndex));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(error),
        const DeepCollectionEquality().hash(actionError),
        match,
        currentInning,
        otherInning,
        bowler,
        strikerId,
        const DeepCollectionEquality().hash(_batsMans),
        nextInning,
        showSelectFieldingPositionSheet,
        showSelectBatsManSheet,
        showSelectBowlerSheet,
        showSelectBowlerAndBatsManSheet,
        showSelectPlayerSheet,
        showSelectWicketTypeSheet,
        showStrikerSelectionSheet,
        showUndoBallConfirmationDialog,
        showOverCompleteSheet,
        showInningCompleteSheet,
        showMatchCompleteSheet,
        showAddExtraSheetForNoBall,
        showAddExtraSheetForLegBye,
        showAddExtraSheetForBye,
        showAddExtraSheetForFiveSeven,
        showPauseScoringSheet,
        showAddPenaltyRunSheet,
        showEndMatchSheet,
        showAddSubstituteSheet,
        invalidUndoToast,
        showReviseTargetSheet,
        showHandOverScoringSheet,
        tappedButton,
        isLongTap,
        position,
        const DeepCollectionEquality().hash(_allInnings),
        const DeepCollectionEquality().hash(_currentScoresList),
        const DeepCollectionEquality().hash(_previousScoresList),
        matchSetting,
        loading,
        pop,
        ballScoreQueryListenerSet,
        isMatchUpdated,
        isActionInProgress,
        ballCount,
        overCount,
        lastAssignedIndex
      ]);

  /// Create a copy of ScoreBoardViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreBoardViewStateImplCopyWith<_$ScoreBoardViewStateImpl> get copyWith =>
      __$$ScoreBoardViewStateImplCopyWithImpl<_$ScoreBoardViewStateImpl>(
          this, _$identity);
}

abstract class _ScoreBoardViewState implements ScoreBoardViewState {
  const factory _ScoreBoardViewState(
      {final Object? error,
      final Object? actionError,
      final MatchModel? match,
      final InningModel? currentInning,
      final InningModel? otherInning,
      final MatchPlayer? bowler,
      final String? strikerId,
      final List<MatchPlayer>? batsMans,
      final InningModel? nextInning,
      final DateTime? showSelectFieldingPositionSheet,
      final DateTime? showSelectBatsManSheet,
      final DateTime? showSelectBowlerSheet,
      final DateTime? showSelectBowlerAndBatsManSheet,
      final DateTime? showSelectPlayerSheet,
      final DateTime? showSelectWicketTypeSheet,
      final DateTime? showStrikerSelectionSheet,
      final DateTime? showUndoBallConfirmationDialog,
      final DateTime? showOverCompleteSheet,
      final DateTime? showInningCompleteSheet,
      final DateTime? showMatchCompleteSheet,
      final DateTime? showAddExtraSheetForNoBall,
      final DateTime? showAddExtraSheetForLegBye,
      final DateTime? showAddExtraSheetForBye,
      final DateTime? showAddExtraSheetForFiveSeven,
      final DateTime? showPauseScoringSheet,
      final DateTime? showAddPenaltyRunSheet,
      final DateTime? showEndMatchSheet,
      final DateTime? showAddSubstituteSheet,
      final DateTime? invalidUndoToast,
      final DateTime? showReviseTargetSheet,
      final DateTime? showHandOverScoringSheet,
      final ScoreButton? tappedButton,
      final bool? isLongTap,
      final FieldingPositionType? position,
      final List<InningModel> allInnings,
      final List<BallScoreModel> currentScoresList,
      final List<BallScoreModel> previousScoresList,
      final MatchSetting matchSetting,
      final bool loading,
      final bool pop,
      final bool ballScoreQueryListenerSet,
      final bool isMatchUpdated,
      final bool isActionInProgress,
      final int ballCount,
      final int overCount,
      final int lastAssignedIndex}) = _$ScoreBoardViewStateImpl;

  @override
  Object? get error;
  @override
  Object? get actionError;
  @override
  MatchModel? get match;
  @override
  InningModel? get currentInning;
  @override
  InningModel? get otherInning;
  @override
  MatchPlayer? get bowler;
  @override
  String? get strikerId;
  @override
  List<MatchPlayer>? get batsMans;
  @override
  InningModel? get nextInning;
  @override
  DateTime? get showSelectFieldingPositionSheet;
  @override
  DateTime? get showSelectBatsManSheet;
  @override
  DateTime? get showSelectBowlerSheet;
  @override
  DateTime? get showSelectBowlerAndBatsManSheet;
  @override
  DateTime? get showSelectPlayerSheet;
  @override
  DateTime? get showSelectWicketTypeSheet;
  @override
  DateTime? get showStrikerSelectionSheet;
  @override
  DateTime? get showUndoBallConfirmationDialog;
  @override
  DateTime? get showOverCompleteSheet;
  @override
  DateTime? get showInningCompleteSheet;
  @override
  DateTime? get showMatchCompleteSheet;
  @override
  DateTime? get showAddExtraSheetForNoBall;
  @override
  DateTime? get showAddExtraSheetForLegBye;
  @override
  DateTime? get showAddExtraSheetForBye;
  @override
  DateTime? get showAddExtraSheetForFiveSeven;
  @override
  DateTime? get showPauseScoringSheet;
  @override
  DateTime? get showAddPenaltyRunSheet;
  @override
  DateTime? get showEndMatchSheet;
  @override
  DateTime? get showAddSubstituteSheet;
  @override
  DateTime? get invalidUndoToast;
  @override
  DateTime? get showReviseTargetSheet;
  @override
  DateTime? get showHandOverScoringSheet;
  @override
  ScoreButton? get tappedButton;
  @override
  bool? get isLongTap;
  @override
  FieldingPositionType? get position;
  @override
  List<InningModel> get allInnings;
  @override
  List<BallScoreModel> get currentScoresList;
  @override
  List<BallScoreModel> get previousScoresList;
  @override
  MatchSetting get matchSetting;
  @override
  bool get loading;
  @override
  bool get pop;
  @override
  bool get ballScoreQueryListenerSet;
  @override
  bool get isMatchUpdated;
  @override
  bool get isActionInProgress;
  @override
  int get ballCount;
  @override
  int get overCount;
  @override
  int get lastAssignedIndex;

  /// Create a copy of ScoreBoardViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScoreBoardViewStateImplCopyWith<_$ScoreBoardViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
