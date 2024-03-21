import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/innings/inning_model.dart';
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
import 'package:khelo/ui/flow/score_board/components/is_boundary_dialog.dart';
import 'package:khelo/ui/flow/score_board/components/match_complete_dialog.dart';
import 'package:khelo/ui/flow/score_board/components/over_complete_dialog.dart';
import 'package:khelo/ui/flow/score_board/components/score_board_buttons.dart';
import 'package:khelo/ui/flow/score_board/components/select_player_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/select_wicket_taker_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/select_wicket_type_sheet.dart';
import 'package:khelo/ui/flow/score_board/components/striker_selection_dialog.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import 'components/inning_complete_dialog.dart';

class ScoreBoardScreen extends ConsumerStatefulWidget {
  final String matchId;

  const ScoreBoardScreen({super.key, required this.matchId});

  @override
  ConsumerState createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends ConsumerState<ScoreBoardScreen> {
  late ScoreBoardViewNotifier notifier;

  void _observeShowSelectBatsManSheet(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showSelectBatsManSheet),
        (previous, next) {
      if (next != null) {
        _showSelectPlayerSheet(context, PlayerSelectionType.batsMan);
      }
    });
  }

  void _observeShowSelectBowlerSheet(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showSelectBowlerSheet),
        (previous, next) {
      if (next != null) {
        _showSelectPlayerSheet(context, PlayerSelectionType.bowler);
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
        _showSelectPlayerSheet(context, PlayerSelectionType.batsManAndBowler);
      }
    });
  }

  void _observeShowSelectPlayerSheet(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.showSelectPlayerSheet),
        (previous, next) {
      if (next != null) {
        _showSelectPlayerSheet(context, PlayerSelectionType.all);
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
        _showUndoBallConfirmationDialog(
          context,
          onUndo: notifier.undoLastBall,
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

  void _observeShowInningCompleteDialog(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select(
            (value) => value.showInningCompleteDialog), (previous, next) {
      if (next != null) {
        _showInningCompleteDialog(context);
      }
    });
  }

  void _observeShowMatchCompleteDialog(BuildContext context, WidgetRef ref) {
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
        _showPauseScoringDialog(
          context,
          onPause: () => notifier.onPauseScoring(),
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

  void _observeInvalidUndoToast(BuildContext context, WidgetRef ref) {
    ref.listen(
        scoreBoardStateProvider.select((value) => value.invalidUndoToast),
        (previous, next) {
      if (next != null) {
        showSnackBar(
            context, context.l10n.score_board_can_undo_till_running_over_title,
            length: SnackBarLength.long);
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

    _observeShowSelectBatsManSheet(context, ref);
    _observeShowSelectBowlerSheet(context, ref);
    _observeShowSelectBowlerAndBatsManSheet(context, ref);
    _observeShowSelectPlayerSheet(context, ref);
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
    _observeInvalidUndoToast(context, ref);

    return PopScope(
      canPop: false,
      child: AppPage(
        title: context.l10n.score_board_screen_title,
        actions: [_moreOptionButton(context, notifier)],
        automaticallyImplyLeading: false,
        body: Padding(
          padding: context.mediaQueryPadding,
          child: _body(context, notifier, state),
        ),
      ),
    );
  }

  Widget _moreOptionButton(
      BuildContext context, ScoreBoardViewNotifier notifier) {
    return PopupMenuButton(
      color: context.colorScheme.containerNormalOnSurface,
      onSelected: notifier.onMatchOptionSelect,
      itemBuilder: (BuildContext context) {
        return MatchOption.values
            .map((option) => PopupMenuItem(
                  value: option,
                  child: Text(
                    option.getTitle(context),
                    style: AppTextStyle.subtitle1
                        .copyWith(color: context.colorScheme.textPrimary),
                  ),
                ))
            .toList();
      },
    );
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
        _scoreDisplayView(context, state),
        ScoreBoardButtons(
          onTap: notifier.onScoreButtonTap,
        ),
      ],
    );
  }

  Widget _scoreDisplayView(BuildContext context, ScoreBoardViewState state) {
    return Expanded(
      child: ListView(
        children: [
          _matchScoreView(context, state),
          const SizedBox(
            height: 24,
          ),
          _batsManDetailsView(context, state),
          _bowlerAndBallDetailView(context, state),
        ],
      ),
    );
  }

  Widget _matchScoreView(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    final currentOver = _getCurrentOver(state);

    return Stack(
      children: [
        _powerPlayTag(context, state),
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            direction: Axis.vertical,
            children: [
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${state.totalRuns}/${state.wicketCount}',
                      style: AppTextStyle.subtitle1.copyWith(
                          color: context.colorScheme.textPrimary, fontSize: 39),
                    ),
                    TextSpan(
                      text: '($currentOver/${state.match?.number_of_over})',
                      style: AppTextStyle.header4
                          .copyWith(color: context.colorScheme.textSecondary),
                    ),
                  ],
                ),
              ),
              _runNeededText(context, state),
            ],
          ),
        ),
      ],
    );
  }

  Widget _powerPlayTag(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    final powerPlay = _getPowerPlayCount(state);
    if (powerPlay != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(12))),
        child: Text(
          context.l10n.score_board_power_play_title + powerPlay.toString(),
          style: AppTextStyle.body1.copyWith(
              color: context.colorScheme.textInversePrimary,
              fontWeight: FontWeight.w500),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  int? _getPowerPlayCount(ScoreBoardViewState state) {
    if (state.match?.power_play_overs1.contains(state.overCount) ?? false) {
      return 1;
    } else if (state.match?.power_play_overs2.contains(state.overCount) ??
        false) {
      return 2;
    } else if (state.match?.power_play_overs3.contains(state.overCount) ??
        false) {
      return 3;
    }
    return null;
  }

  Widget _runNeededText(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    if (state.otherInning?.innings_status == InningStatus.finish) {
      final requiredRun = ((state.otherInning?.total_runs ?? 0) + 1) -
          (state.currentInning?.total_runs ?? 0);
      final pendingOver = (state.match?.number_of_over ?? 0) - state.overCount;
      final pendingBall = (pendingOver * 6) + (6 - state.ballCount);
      return Text(
        context.l10n.score_board_need_run_text(requiredRun, pendingBall),
        textAlign: TextAlign.center,
        style:
            AppTextStyle.subtitle1.copyWith(color: context.colorScheme.warning),
      );
    } else {
      return const SizedBox();
    }
  }

  String _getCurrentOver(ScoreBoardViewState state) {
    return "${state.overCount - 1}.${state.ballCount}";
  }

  Widget _batsManDetailsView(BuildContext context, ScoreBoardViewState state) {
    return Row(
      children: [
        _batManCellView(context, state, state.batsMans?.firstOrNull),
        _batManCellView(context, state, state.batsMans?.elementAtOrNull(1)),
      ],
    );
  }

  Widget _batManCellView(
    BuildContext context,
    ScoreBoardViewState state,
    MatchPlayer? user,
  ) {
    bool isOnStrike = state.strikerId == user?.player.id;
    final (run, ball) =
        _getBatsManTotalRuns(state, user?.player.id ?? "INVALID ID");
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.outline)),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.sports_cricket,
                  color: isOnStrike
                      ? context.colorScheme.primary
                      : context.colorScheme.textDisabled,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.player.name ?? context.l10n.score_board_player_title,
                    style: AppTextStyle.header1
                        .copyWith(color: context.colorScheme.textPrimary),
                  ),
                  Text(
                    "$run($ball)",
                    style: AppTextStyle.header4
                        .copyWith(color: context.colorScheme.textSecondary),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  (int, int) _getBatsManTotalRuns(ScoreBoardViewState state, String batsManId) {
    final scoresList = state.currentScoresList
        .where((element) => element.batsman_id == batsManId);

    int totalRuns = scoresList
        .where((element) => (element.extras_type == ExtrasType.noBall ||
            element.extras_type == null))
        .fold(0, (sum, element) => sum + (element.runs_scored ?? 0));

    final batsManFacedBall = scoresList
        .where((element) => (element.extras_type != ExtrasType.wide))
        .length;

    return (totalRuns, batsManFacedBall);
  }

  Widget _bowlerAndBallDetailView(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: context.colorScheme.secondaryVariant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bowlerNameView(
              context,
              state.bowler?.player.name ??
                  context.l10n.score_board_player_title),
          const SizedBox(
            height: 16,
          ),
          _ballHistoryListView(context, state),
        ],
      ),
    );
  }

  Widget _bowlerNameView(BuildContext context, String name) {
    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
              child: Icon(
            Icons.sports_baseball_outlined,
            color: context.colorScheme.surface,
          )),
          TextSpan(
            text: ' $name',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _ballHistoryListView(BuildContext context, ScoreBoardViewState state) {
    return SingleChildScrollView(
      reverse: true,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final ball in _getFilteredCurrentOverBall(state)) ...[
            _ballView(context, ball),
            const SizedBox(
              width: 8,
            )
          ]
        ],
      ),
    );
  }

  List<BallScoreModel> _getFilteredCurrentOverBall(ScoreBoardViewState state) {
    final list = state.currentScoresList
        .where((element) =>
            element.over_number == state.overCount &&
            element.extras_type != ExtrasType.penaltyRun)
        .toList();
    return list;
  }

  Widget _ballView(BuildContext context, BallScoreModel ball) {
    return Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.containerLow,
          border: Border.all(color: context.colorScheme.outline)),
      child: Text(_getTextBasedOnBall(context, ball)),
    );
  }

  String _getTextBasedOnBall(BuildContext context, BallScoreModel ball) {
    if (ball.wicket_type != null) {
      return context.l10n.score_board_wicket_short_text;
    } else if (ball.extras_type != null) {
      switch (ball.extras_type!) {
        case ExtrasType.wide:
          return context.l10n.score_board_wide_ball_short_text;
        case ExtrasType.noBall:
          return context.l10n.score_board_no_ball_short_text;
        case ExtrasType.bye:
          return context.l10n.score_board_run_sup_script_text(
              "${ball.extras_awarded ?? 0}",
              context.l10n.score_board_bye_short_text);
        case ExtrasType.legBye:
          return context.l10n.score_board_run_sup_script_text(
              "${ball.extras_awarded ?? 0}",
              context.l10n.score_board_leg_bye_short_text);
        case ExtrasType.penaltyRun:
          return "P";
      }
    } else if (ball.wicket_type == null && ball.extras_type == null) {
      return "${ball.runs_scored}";
    } else {
      return "";
    }
  }

  Future<void> _showSelectPlayerSheet(
    BuildContext context,
    PlayerSelectionType type,
  ) async {
    final players = await SelectPlayerSheet.show<
            List<({String teamId, List<MatchPlayer> players})>>(context,
        type: type);
    if (players != null && context.mounted) {
      notifier.setPlayers(players);
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
    final outBatsMan = await StrikerSelectionDialog.show<UserModel>(context,
        isForStrikerSelection: false); // who got out

    String? wicketTakerId;
    if ((type == WicketType.caught ||
            type == WicketType.bowled ||
            type == WicketType.stumped ||
            type == WicketType.runOut ||
            type == WicketType.caughtBehind) &&
        context.mounted) {
      wicketTakerId = await SelectWicketTakerSheet.show<String>(context);
    } // who caught the ball

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

  void _showUndoBallConfirmationDialog(
    BuildContext context, {
    required Function() onUndo,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(
            context.l10n.score_board_undo_last_ball_title,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          content: Text(
            context.l10n.score_board_undo_last_ball_description_text,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                context.l10n.common_cancel_title,
                style: TextStyle(color: context.colorScheme.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop();
                onUndo();
              },
              child: Text(
                context.l10n.score_board_undo_title,
                style: TextStyle(color: context.colorScheme.alert),
              ),
            ),
          ],
        );
      },
    );
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
      BuildContext context, ExtrasType? extra) async {
    final extraData = await AddExtraDialog.show<(int, bool, bool)>(context,
        extrasType: extra, isFiveSeven: extra == null);
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
        notifier.addBall(
          run: runs,
        );
      }
    }
  }

  void _showPauseScoringDialog(
    BuildContext context, {
    required Function() onPause,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(
            context.l10n.score_board_pause_scoring_title,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          content: Text(
            context.l10n.score_board_pause_scoring_description_text,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                context.l10n.common_cancel_title,
                style: TextStyle(color: context.colorScheme.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop();
                onPause();
              },
              child: Text(
                context.l10n.score_board_pause_title,
                style: TextStyle(color: context.colorScheme.alert),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddPenaltyRunDialog(BuildContext context) async {
    final penalty =
        await AddPenaltyRunDialog.show<({String teamId, int runs})>(context);

    if (penalty != null && context.mounted) {
      notifier.handlePenaltyRun(penalty);
    }
  }
}
