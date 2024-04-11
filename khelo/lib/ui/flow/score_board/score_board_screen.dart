import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/score_board/components/add_extra_dialog.dart';
import 'package:khelo/ui/flow/score_board/components/add_penalty_run_dialog.dart';
import 'package:khelo/ui/flow/score_board/components/confirm_action_dialog.dart';
import 'package:khelo/ui/flow/score_board/components/is_boundary_dialog.dart';
import 'package:khelo/ui/flow/score_board/components/match_complete_dialog.dart';
import 'package:khelo/ui/flow/score_board/components/more_option_dialog.dart';
import 'package:khelo/ui/flow/score_board/components/over_complete_dialog.dart';
import 'package:khelo/ui/flow/score_board/components/score_board_buttons.dart';
import 'package:khelo/ui/flow/score_board/components/score_display_view.dart';
import 'package:khelo/ui/flow/score_board/components/select_player_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/select_wicket_taker_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/select_wicket_type_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/striker_selection_dialog.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/indicator/progress_indicator.dart';

import 'components/inning_complete_dialog.dart';

class ScoreBoardScreen extends ConsumerStatefulWidget {
  final String matchId;

  const ScoreBoardScreen({super.key, required this.matchId});

  @override
  ConsumerState createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends ConsumerState<ScoreBoardScreen> {
  late ScoreBoardViewNotifier notifier;

  void _observeShowSelectBatsManSheet(
    BuildContext context,
    WidgetRef ref,
    bool continueWithInjuredPlayers,
  ) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showSelectBatsManSheet),
        (previous, next) {
      if (next != null) {
        _showSelectPlayerSheet(
          context,
          continueWithInjuredPlayers,
          PlayerSelectionType.batsMan,
        );
      }
    });
  }

  void _observeShowSelectBowlerSheet(
    BuildContext context,
    WidgetRef ref,
    bool continueWithInjuredPlayers,
  ) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showSelectBowlerSheet),
        (previous, next) {
      if (next != null) {
        _showSelectPlayerSheet(
          context,
          continueWithInjuredPlayers,
          PlayerSelectionType.bowler,
        );
      }
    });
  }

  void _observeShowSelectBowlerAndBatsManSheet(
    BuildContext context,
    WidgetRef ref,
    bool continueWithInjuredPlayers,
  ) {
    ref.listen(
        scoreBoardStateProvider
            .select((value) => value.showSelectBowlerAndBatsManSheet),
        (previous, next) {
      if (next != null) {
        _showSelectPlayerSheet(
          context,
          continueWithInjuredPlayers,
          PlayerSelectionType.batsManAndBowler,
        );
      }
    });
  }

  void _observeShowSelectPlayerSheet(
    BuildContext context,
    WidgetRef ref,
    bool continueWithInjuredPlayers,
  ) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showSelectPlayerSheet),
        (previous, next) {
      if (next != null) {
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
        _showSelectWicketTypeSheet(context);
      }
    });
  }

  void _observeShowStrikerSelectionDialog(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showStrikerSelectionDialog), (previous, next) {
      if (next != null) {
        _showStrikerSelectionDialog(context);
      }
    });
  }

  void _observeShowUndoBallConfirmationDialog(
      BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showUndoBallConfirmationDialog), (previous, next) {
      if (next != null) {
        ConfirmActionDialog.show(
          context,
          title: context.l10n.score_board_undo_last_ball_title,
          description: context.l10n.score_board_undo_last_ball_description_text,
          primaryButtonText: context.l10n.score_board_undo_title,
          onConfirmation: notifier.undoLastBall,
        );
      }
    });
  }

  void _observeShowOverCompleteDialog(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showOverCompleteDialog),
        (previous, next) {
      if (next != null) {
        _showOverCompleteDialog(context);
      }
    });
  }

  void _observeShowInningCompleteDialog(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showInningCompleteDialog), (previous, next) {
      if (next != null) {
        _showInningCompleteDialog(context);
      }
    });
  }

  void _observeShowMatchCompleteDialog(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showMatchCompleteDialog), (previous, next) {
      if (next != null) {
        _showMatchCompleteDialog(context);
      }
    });
  }

  void _observeShowBoundaryDialogForSix(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showBoundaryDialogForSix), (previous, next) {
      if (next != null) {
        _showBoundaryDialog(context, 6);
      }
    });
  }

  void _observeShowBoundaryDialogForFour(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showBoundaryDialogForFour), (previous, next) {
      if (next != null) {
        _showBoundaryDialog(context, 4);
      }
    });
  }

  void _observeShowAddExtraDialogForNoBall(
      BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showAddExtraDialogForNoBall), (previous, next) {
      if (next != null) {
        _showAddExtraDialog(context, ExtrasType.noBall);
      }
    });
  }

  void _observeShowAddExtraDialogForLegBye(
      BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showAddExtraDialogForLegBye), (previous, next) {
      if (next != null) {
        _showAddExtraDialog(context, ExtrasType.legBye);
      }
    });
  }

  void _observeShowAddExtraDialogForBye(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showAddExtraDialogForBye), (previous, next) {
      if (next != null) {
        _showAddExtraDialog(context, ExtrasType.bye);
      }
    });
  }

  void _observeShowAddExtraDialogForFiveSeven(
      BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showAddExtraDialogForFiveSeven), (previous, next) {
      if (next != null) {
        _showAddExtraDialog(context, null);
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

  void _observeShowPauseScoringDialog(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showPauseScoringDialog),
        (previous, next) {
      if (next != null) {
        ConfirmActionDialog.show(
          context,
          title: context.l10n.score_board_pause_scoring_title,
          description: context.l10n.score_board_pause_scoring_description_text,
          primaryButtonText: context.l10n.score_board_pause_title,
          onConfirmation: notifier.onPauseScoring,
        );
      }
    });
  }

  void _observeShowAddPenaltyRunDialog(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showAddPenaltyRunDialog), (previous, next) {
      if (next != null) {
        _showAddPenaltyRunDialog(
          context,
        );
      }
    });
  }

  void _observeEndMatchDialogue(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
                (value) => value.showEndMatchDialog), (previous, next) {
      if (next != null) {
        ConfirmActionDialog.show(
          context,
          title: context.l10n.score_board_end_match_title,
          description: context.l10n.score_board_end_match_description_text,
          primaryButtonText: context.l10n.common_okay_title,
          onConfirmation:notifier.abandonMatch,
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

  @override
  void initState() {
    super.initState();
    notifier = ref.read(scoreBoardStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.matchId));
  }

  @override
  Widget build(BuildContext context) {
    notifier = ref.watch(scoreBoardStateProvider.notifier);
    final state = ref.watch(scoreBoardStateProvider);

    _observeShowSelectBatsManSheet(
        context, ref, state.continueWithInjuredPlayers);
    _observeShowSelectBowlerSheet(
        context, ref, state.continueWithInjuredPlayers);
    _observeShowSelectBowlerAndBatsManSheet(
        context, ref, state.continueWithInjuredPlayers);
    _observeShowSelectPlayerSheet(
        context, ref, state.continueWithInjuredPlayers);
    _observeShowSelectWicketTypeSheet(context, ref);
    _observeShowStrikerSelectionDialog(context, ref);
    _observeShowUndoBallConfirmationDialog(context, ref);
    _observeShowOverCompleteDialog(context, ref);
    _observeShowInningCompleteDialog(context, ref);
    _observeShowMatchCompleteDialog(context, ref);
    _observeShowBoundaryDialogForSix(context, ref);
    _observeShowBoundaryDialogForFour(context, ref);
    _observeShowAddExtraDialogForNoBall(context, ref);
    _observeShowAddExtraDialogForLegBye(context, ref);
    _observeShowAddExtraDialogForBye(context, ref);
    _observeShowAddExtraDialogForFiveSeven(context, ref);
    _observePop(context, ref);
    _observeShowPauseScoringDialog(context, ref);
    _observeShowAddPenaltyRunDialog(context, ref);
    _observeEndMatchDialogue(context, ref);
    _observeInvalidUndoToast(context, ref);

    return PopScope(
      canPop: false,
      child: AppPage(
        title: context.l10n.score_board_screen_title,
        actions: [_moreOptionButton(context, notifier, state)],
        automaticallyImplyLeading: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: _body(context, notifier, state),
        ),
      ),
    );
  }

  Widget _moreOptionButton(
    BuildContext context,
    ScoreBoardViewNotifier notifier,
    ScoreBoardViewState state,
  ) {
    return IconButton(
        onPressed: () async {
          final selection = await MoreOptionDialog.show<
                  ({MatchOption option, bool contWithInjPlayer})>(context,
              continueWithInjPlayer: state.continueWithInjuredPlayers);

          if (selection != null && context.mounted) {
            notifier.onMatchOptionSelect(
              selection.option,
              selection.contWithInjPlayer,
            );
          }
        },
        icon: const Icon(Icons.more_horiz));
  }

  Widget _body(
    BuildContext context,
    ScoreBoardViewNotifier notifier,
    ScoreBoardViewState state,
  ) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }

    return Column(
      children: [
        const ScoreDisplayView(),
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

  Future<void> _showSelectWicketTypeSheet(BuildContext context) async {
    final type = await SelectWicketTypeSheet.show<WicketType>(context);
    if (type != null && context.mounted) {
      _onWicketTypeSelect(context, type);
    }
  }

  Future<void> _onWicketTypeSelect(
      BuildContext context, WicketType type) async {
    final outBatsMan = await StrikerSelectionDialog.show<UserModel>(
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
      wicketTakerId = await SelectWicketTakerSheet.show<String>(context);
    }

    int? extra;
    if (type == WicketType.runOut && context.mounted) {
      final runBeforeWicket = await AddExtraDialog.show<(int, bool, bool)>(
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
        switchStrike: extra != null ? extra % 2 == 0 : false);
  }

  Future<void> _showStrikerSelectionDialog(BuildContext context) async {
    final striker = await StrikerSelectionDialog.show<UserModel>(context);
    if (striker != null && context.mounted) {
      notifier.setOrSwitchStriker(batsMan: striker);
    }
  }

  Future<void> _showOverCompleteDialog(BuildContext context) async {
    final startNext = await OverCompleteDialog.show<bool>(context);
    if (startNext != null && context.mounted) {
      if (startNext) {
        notifier.startNextOver();
      } else {
        notifier.undoLastBall();
      }
    }
  }

  Future<void> _showInningCompleteDialog(BuildContext context) async {
    final startNext = await InningCompleteDialog.show<bool>(context);
    if (startNext != null && context.mounted) {
      if (startNext) {
        notifier.startNextInning();
      } else {
        notifier.undoLastBall();
      }
    }
  }

  Future<void> _showMatchCompleteDialog(BuildContext context) async {
    final endMatch = await MatchCompleteDialog.show<bool>(context);
    if (endMatch != null && context.mounted) {
      if (endMatch) {
        notifier.endMatch();
      } else {
        notifier.undoLastBall();
      }
    }
  }

  Future<void> _showBoundaryDialog(BuildContext context, int run) async {
    final isBoundary = await IsBoundaryDialog.show<bool>(context);
    if (context.mounted && isBoundary != null) {
      notifier.addBall(
          run: run,
          isSix: (run == 6 && isBoundary),
          isFour: (run == 4 && isBoundary));
    }
  }

  Future<void> _showAddExtraDialog(
    BuildContext context,
    ExtrasType? extra,
  ) async {
    final extraData = await AddExtraDialog.show<(int, bool, bool)>(
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
        );
      } else if (extra == ExtrasType.legBye || extra == ExtrasType.bye) {
        notifier.addBall(
          run: 0,
          extrasType: extra,
          extra: runs,
        );
      } else {
        notifier.addBall(run: runs);
      }
    }
  }

  Future<void> _showAddPenaltyRunDialog(BuildContext context) async {
    final penalty =
        await AddPenaltyRunDialog.show<({String teamId, int runs})>(context);

    if (penalty != null && context.mounted) {
      notifier.handlePenaltyRun(penalty);
    }
  }
}
