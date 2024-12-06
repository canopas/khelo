import 'package:collection/collection.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/action_bottom_sheet.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/confirmation_dialog.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/search_user/search_user_screen.dart';
import 'package:khelo/ui/flow/score_board/add_substitute_sheet/add_substitute_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/add_extra_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/add_penalty_run_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/match_complete_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/over_complete_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/score_board_buttons.dart';
import 'package:khelo/ui/flow/score_board/components/score_display_view.dart';
import 'package:khelo/ui/flow/score_board/components/select_fielding_position_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/select_player_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/select_wicket_taker_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/select_wicket_type_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/striker_selection_sheet.dart';
import 'package:khelo/ui/flow/score_board/revise_target_sheet/revise_target_sheet.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/button/more_option_button.dart';
import 'package:style/button/toggle_button.dart';
import 'package:style/indicator/progress_indicator.dart';

import 'components/inning_complete_sheet.dart';

class ScoreBoardScreen extends ConsumerStatefulWidget {
  final String matchId;

  const ScoreBoardScreen({super.key, required this.matchId});

  @override
  ConsumerState createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends ConsumerState<ScoreBoardScreen> {
  late ScoreBoardViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(scoreBoardStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.matchId));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scoreBoardStateProvider);

    _observeActionError(context, ref);
    _observeShowSelectFieldingPositionSheet(context, ref);
    _observeShowSelectBatsManSheet(context, ref);
    _observeShowSelectBowlerSheet(context, ref);
    _observeShowSelectBowlerAndBatsManSheet(context, ref);
    _observeShowSelectPlayerSheet(context, ref);
    _observeShowSelectWicketTypeSheet(context, ref);
    _observeShowStrikerSelectionSheet(context, ref);
    _observeShowUndoBallConfirmationDialog(context, ref);
    _observeShowOverCompleteSheet(context, ref);
    _observeShowInningCompleteSheet(context, ref);
    _observeShowMatchCompleteSheet(context, ref);
    _observeShowAddExtraSheetForNoBall(context, ref);
    _observeShowAddExtraSheetForLegBye(context, ref);
    _observeShowAddExtraSheetForBye(context, ref);
    _observeShowAddExtraSheetForFiveSeven(context, ref);
    _observeShowReviseTargetSheet(context, ref);
    _observePop(context, ref);
    _observeShowPauseScoringSheet(context, ref);
    _observeShowAddPenaltyRunSheet(context, ref);
    _observeShowAddSubstituteSheet(context, ref);
    _observeHandOverScoringSheet(context, ref);
    _observeEndMatchSheet(context, ref);
    _observeInvalidUndoToast(context, ref);

    return PopScope(
      canPop: false,
      child: AppPage(
        title: context.l10n.score_board_screen_title,
        actions: [_moreOptionButton(context, state)],
        automaticallyImplyLeading: false,
        resizeToAvoidBottomInset: false,
        body: Builder(builder: (context) {
          return _body(context, state);
        }),
      ),
    );
  }

  Widget _moreOptionButton(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    final matchOptions = MatchOption.values.toList();
    if (!(state.match?.isRevisedTargetApplicable ?? true)) {
      matchOptions.remove(MatchOption.reviseTarget);
    }

    return moreOptionButton(
      context,
      onPressed: () => showActionBottomSheet(
          context: context,
          items: matchOptions
              .map((option) => BottomSheetAction(
                    title: option.getTitle(context),
                    enabled: !option.showToggle(),
                    onTap: () {
                      context.pop();
                      notifier.onMatchOptionSelect(option, true);
                    },
                    child: option.showToggle()
                        ? toggleButton(
                            context,
                            defaultEnabled: _getDefaultValue(state, option),
                            onTap: (result) => notifier
                                .onToggleMatchOptionChange(result, option),
                          )
                        : null,
                  ))
              .toList()),
    );
  }

  bool _getDefaultValue(ScoreBoardViewState state, MatchOption option) {
    switch (option) {
      case MatchOption.continueWithInjuredPlayer:
        return state.matchSetting.continue_with_injured_player;
      case MatchOption.showForLessRuns:
        return state.matchSetting.show_wagon_wheel_for_less_run;
      case MatchOption.showForDotBall:
        return state.matchSetting.show_wagon_wheel_for_dot_ball;
      default:
        return false;
    }
  }

  Widget _body(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }
    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onResume,
      );
    }

    return Column(
      children: [
        ScoreDisplayView(
          currentOverBall: notifier.getCurrentOverBall(),
          overCountString: notifier.getOverCount(),
          battingTeamName: notifier.getTeamName(),
          bowlingTeamName: notifier.getTeamName(isBattingTeam: false),
        ),
        ScoreBoardButtons(onTap: notifier.onScoreButtonTap),
      ],
    );
  }

  Future<void> _showSelectPlayerSheet(
    BuildContext context,
    bool continueWithInjuredPlayers,
    PlayerSelectionType type,
  ) async {
    final result = await SelectPlayerSheet.show<
        ({
          List<({List<MatchPlayer> players, String teamId})>? selectedPlayer,
          bool contWithInjPlayer,
        })>(
      context,
      type: type,
      continueWithInjPlayer: continueWithInjuredPlayers,
    );
    if (result != null && context.mounted) {
      if (result.selectedPlayer != null) {
        notifier.setPlayers(
            currentPlayers: result.selectedPlayer!,
            contWithInjPlayer: result.contWithInjPlayer);
      } else {
        notifier.onReviewMatchResult(result.contWithInjPlayer);
      }
    }
  }

  Future<void> _showSelectWicketTypeSheet(
      BuildContext context, FieldingPositionType? position) async {
    final type = await SelectWicketTypeSheet.show<WicketType>(context);
    if (type != null && context.mounted) {
      _onWicketTypeSelect(context, type, position);
    }
  }

  Future<void> _onWicketTypeSelect(BuildContext context, WicketType type,
      FieldingPositionType? position) async {
    final outBatsMan = await StrikerSelectionSheet.show<UserModel>(
      context,
      isForStrikerSelection: false,
    );

    String? wicketTakerId;
    if ((type == WicketType.caught ||
            type == WicketType.bowled ||
            type == WicketType.stumped ||
            type == WicketType.runOut ||
            type == WicketType.caughtBehind) &&
        context.mounted) {
      wicketTakerId = await SelectWicketTakerSheet.show<String>(context,
          fielderList: notifier.getFielderList());
    }

    int? extra;
    if (type == WicketType.runOut && context.mounted) {
      final runBeforeWicket = await AddExtraSheet.show<(int, bool, bool)>(
          context,
          isOnWicket: true);
      extra = runBeforeWicket?.$1;
    }

    notifier.addBall(
        run: 0,
        extra: extra,
        playerOutId: outBatsMan?.id,
        wicketTakerId: wicketTakerId,
        wicketType: type,
        position: position);
  }

  Future<void> _showStrikerSelectionSheet(BuildContext context) async {
    final striker = await StrikerSelectionSheet.show<UserModel>(context);
    if (striker != null && context.mounted) {
      notifier.setOrSwitchStriker(batsManId: striker.id);
    }
  }

  Future<void> _showOverCompleteSheet(BuildContext context) async {
    final startNext = await OverCompleteSheet.show<bool>(
        context, notifier.getCurrentOverStatics());
    if (startNext != null && context.mounted) {
      if (startNext) {
        notifier.startNextOver();
      } else {
        notifier.undoLastBall();
      }
    }
  }

  Future<void> _showInningCompleteSheet(BuildContext context) async {
    final startNext = await InningCompleteSheet.show<bool>(context,
        extra: notifier.getExtras(),
        teamName: notifier.getTeamName() ??
            context.l10n.score_board_current_team_title,
        overCountString: notifier.getOverCount());
    if (startNext != null && context.mounted) {
      if (startNext) {
        notifier.startNextInning();
      } else {
        notifier.undoLastBall();
      }
    }
  }

  Future<void> _showMatchCompleteSheet(BuildContext context) async {
    final endMatch = await MatchCompleteSheet.show<bool>(context);
    if (endMatch != null && context.mounted) {
      if (endMatch) {
        notifier.endMatchWithStatus(MatchStatus.finish);
      } else {
        notifier.undoLastBall();
      }
    }
  }

  Future<void> _showAddExtraSheet(
    BuildContext context,
    ExtrasType? extra,
    FieldingPositionType? position,
  ) async {
    final extraData = await AddExtraSheet.show<(int, bool, bool)>(
      context,
      extrasType: extra,
      isFiveSeven: extra == null,
    );
    if (context.mounted && extraData != null) {
      int runs = extraData.$1;
      bool isBoundary = extraData.$2;
      bool notFromBat = extraData.$3;

      if (extra == ExtrasType.noBall) {
        notifier.addBall(
            run: notFromBat ? 0 : runs,
            extrasType: ExtrasType.noBall,
            extra: notFromBat ? 1 + runs : 1,
            isFour: isBoundary && runs == 4,
            isSix: isBoundary && runs == 6,
            position: position);
      } else if (extra == ExtrasType.legBye || extra == ExtrasType.bye) {
        notifier.addBall(
            run: 0, extrasType: extra, extra: runs, position: position);
      } else {
        notifier.addBall(run: runs, position: position);
      }
    }
  }

  Future<void> _showAddPenaltyRunSheet(BuildContext context) async {
    final penalty =
        await AddPenaltyRunSheet.show<({String teamId, int runs})>(context);

    if (penalty != null && context.mounted) {
      notifier.handlePenaltyRun(penalty);
    }
  }

  void _observeActionError(BuildContext context, WidgetRef ref) {
    ref.listen(scoreBoardStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  void _observeShowSelectFieldingPositionSheet(
      BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider
            .select((value) => value.showSelectFieldingPositionSheet),
        (previous, next) async {
      if (next != null) {
        final matchSetting = ref.read(
            scoreBoardStateProvider.select((value) => value.matchSetting));
        final showForLessRun = matchSetting.show_wagon_wheel_for_less_run;
        final showForDotBall = matchSetting.show_wagon_wheel_for_dot_ball;
        final tappedButton = ref.read(
            scoreBoardStateProvider.select((value) => value.tappedButton));
        final isLongTapped = ref
            .read(scoreBoardStateProvider.select((value) => value.isLongTap));
        final result = await SelectFieldingPositionSheet.show<
                (FieldingPositionType, bool, bool)>(context,
            showForLessRun: showForLessRun, showForDotBall: showForDotBall);
        if (context.mounted && result != null && tappedButton != null) {
          notifier.onFieldingPositionSelected(tappedButton,
              isLongTapped ?? false, result.$1, result.$2, result.$3);
        }
      }
    });
  }

  void _observeShowSelectBatsManSheet(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showSelectBatsManSheet),
        (previous, next) {
      if (next != null) {
        final continueWithInjuredPlayers = ref.read(
            scoreBoardStateProvider.select(
                (value) => value.matchSetting.continue_with_injured_player));
        _showSelectPlayerSheet(
          context,
          continueWithInjuredPlayers,
          PlayerSelectionType.batsMan,
        );
      }
    });
  }

  void _observeShowSelectBowlerSheet(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showSelectBowlerSheet),
        (previous, next) {
      if (next != null) {
        final continueWithInjuredPlayers = ref.read(
            scoreBoardStateProvider.select(
                (value) => value.matchSetting.continue_with_injured_player));
        _showSelectPlayerSheet(
          context,
          continueWithInjuredPlayers,
          PlayerSelectionType.bowler,
        );
      }
    });
  }

  void _observeShowSelectBowlerAndBatsManSheet(
      BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider
            .select((value) => value.showSelectBowlerAndBatsManSheet),
        (previous, next) {
      if (next != null) {
        final continueWithInjuredPlayers = ref.read(
            scoreBoardStateProvider.select(
                (value) => value.matchSetting.continue_with_injured_player));
        _showSelectPlayerSheet(
          context,
          continueWithInjuredPlayers,
          PlayerSelectionType.batsManAndBowler,
        );
      }
    });
  }

  void _observeShowSelectPlayerSheet(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showSelectPlayerSheet),
        (previous, next) {
      if (next != null) {
        final continueWithInjuredPlayers = ref.read(
            scoreBoardStateProvider.select(
                (value) => value.matchSetting.continue_with_injured_player));
        _showSelectPlayerSheet(
          context,
          continueWithInjuredPlayers,
          PlayerSelectionType.all,
        );
      }
    });
  }

  void _observeShowSelectWicketTypeSheet(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showSelectWicketTypeSheet), (previous, next) {
      if (next != null) {
        final position =
            ref.read(scoreBoardStateProvider.select((value) => value.position));
        _showSelectWicketTypeSheet(context, position);
      }
    });
  }

  void _observeShowStrikerSelectionSheet(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showStrikerSelectionSheet), (previous, next) {
      if (next != null) {
        _showStrikerSelectionSheet(context);
      }
    });
  }

  void _observeShowUndoBallConfirmationDialog(
      BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showUndoBallConfirmationDialog), (previous, next) {
      if (next != null) {
        showConfirmationDialog(context,
            title: context.l10n.score_board_undo_last_ball_title,
            message: context.l10n.score_board_undo_last_ball_description_text,
            confirmBtnText: context.l10n.score_board_undo_title,
            onConfirm: notifier.undoLastBall);
      }
    });
  }

  void _observeShowOverCompleteSheet(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showOverCompleteSheet),
        (previous, next) {
      if (next != null) {
        _showOverCompleteSheet(context);
      }
    });
  }

  void _observeShowInningCompleteSheet(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showInningCompleteSheet), (previous, next) {
      if (next != null) {
        _showInningCompleteSheet(context);
      }
    });
  }

  void _observeShowMatchCompleteSheet(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showMatchCompleteSheet),
        (previous, next) {
      if (next != null) {
        _showMatchCompleteSheet(context);
      }
    });
  }

  void _observeShowAddExtraSheetForNoBall(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showAddExtraSheetForNoBall), (previous, next) {
      if (next != null) {
        final position =
            ref.read(scoreBoardStateProvider.select((value) => value.position));
        _showAddExtraSheet(context, ExtrasType.noBall, position);
      }
    });
  }

  void _observeShowAddExtraSheetForLegBye(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showAddExtraSheetForLegBye), (previous, next) {
      if (next != null) {
        final position =
            ref.read(scoreBoardStateProvider.select((value) => value.position));
        _showAddExtraSheet(context, ExtrasType.legBye, position);
      }
    });
  }

  void _observeShowAddExtraSheetForBye(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showAddExtraSheetForBye), (previous, next) {
      if (next != null) {
        final position =
            ref.read(scoreBoardStateProvider.select((value) => value.position));
        _showAddExtraSheet(context, ExtrasType.bye, position);
      }
    });
  }

  void _observeShowAddExtraSheetForFiveSeven(
      BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showAddExtraSheetForFiveSeven), (previous, next) {
      if (next != null) {
        final position =
            ref.read(scoreBoardStateProvider.select((value) => value.position));
        _showAddExtraSheet(context, null, position);
      }
    });
  }

  void _observeShowReviseTargetSheet(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showReviseTargetSheet),
        (previous, next) async {
      if (next != null) {
        final actualTarget = ref.read(scoreBoardStateProvider.select((value) =>
            (value.match?.teams
                    .firstWhereOrNull((element) =>
                        element.team.id != value.currentInning?.team_id)
                    ?.run ??
                0) +
            1));
        final totalOver = ref.read(scoreBoardStateProvider
            .select((value) => value.match?.number_of_over ?? 0));

        final result = await ReviseTargetSheet.show<Map<String, dynamic>>(
          context,
          actualTarget: actualTarget,
          totalOver: totalOver,
        );
        if (context.mounted && result != null) {
          notifier.setRevisedTarget(result['run'], result['over']);
        }
      }
    });
  }

  void _observePop(BuildContext context, WidgetRef ref) {
    ref.listen(scoreBoardStateProvider.select((value) => value.pop),
        (previous, next) {
      if (next) {
        context.pop();
      }
    });
  }

  void _observeShowPauseScoringSheet(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showPauseScoringSheet),
        (previous, next) {
      if (next != null) {
        showConfirmationDialog(context,
            title: context.l10n.score_board_pause_scoring_title,
            message: context.l10n.score_board_pause_scoring_description_text,
            confirmBtnText: context.l10n.score_board_pause_title,
            onConfirm: notifier.onPauseScoring);
      }
    });
  }

  void _observeShowAddPenaltyRunSheet(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showAddPenaltyRunSheet),
        (previous, next) {
      if (next != null) {
        _showAddPenaltyRunSheet(
          context,
        );
      }
    });
  }

  void _observeShowAddSubstituteSheet(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showAddSubstituteSheet),
        (previous, next) async {
      if (next != null) {
        final player = await AddSubstituteSheet.show<UserModel>(
          context,
          nonPlayingMembers: notifier.getNonPlayingTeamMembers(),
          playingSquadIds: notifier.getPlayingSquadIds(),
        );
        if (context.mounted && player != null) {
          notifier.addSubstitute(player);
        }
      }
    });
  }

  void _observeHandOverScoringSheet(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showHandOverScoringSheet), (previous, next) async {
      if (next != null) {
        final newOwner = await SearchUserBottomSheet.show<UserModel>(
          context,
          emptyScreenTitle:
              context.l10n.score_board_handover_scoring_empty_title,
          emptyScreenDescription:
              context.l10n.score_board_handover_scoring_empty_description,
        );
        if (context.mounted && newOwner != null) {
          notifier.changeMatchOwner(newOwner);
        }
      }
    });
  }

  void _observeEndMatchSheet(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showEndMatchSheet),
        (previous, next) {
      if (next != null) {
        showConfirmationDialog(
          context,
          title: context.l10n.common_end_match_title,
          message: context.l10n.score_board_end_match_description_text,
          confirmBtnText: context.l10n.common_end_match_title,
          onConfirm: () => notifier.endMatchWithStatus(MatchStatus.abandoned),
        );
      }
    });
  }

  void _observeInvalidUndoToast(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.invalidUndoToast),
        (previous, next) {
      if (next != null) {
        showSnackBar(
          context,
          context.l10n.score_board_can_undo_till_running_over_title,
          length: SnackBarLength.long,
        );
      }
    });
  }
}
