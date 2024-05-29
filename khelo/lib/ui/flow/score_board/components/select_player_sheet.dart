import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/innings/inning_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:khelo/ui/flow/score_board/components/user_cell_view.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/theme/colors.dart';

class SelectPlayerSheet extends ConsumerStatefulWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    required PlayerSelectionType type,
    required bool continueWithInjPlayer,
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      showDragHandle: false,
      enableDrag: false,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return SelectPlayerSheet(
          playerSelectionType: type,
          continueWithInjPlayer: continueWithInjPlayer,
        );
      },
    );
  }

  final PlayerSelectionType playerSelectionType;
  final bool continueWithInjPlayer;

  const SelectPlayerSheet({
    super.key,
    required this.playerSelectionType,
    required this.continueWithInjPlayer,
  });

  @override
  ConsumerState createState() => _SelectPlayerSheetState();
}

class _SelectPlayerSheetState extends ConsumerState<SelectPlayerSheet> {
  MatchPlayer? batsMan1;
  MatchPlayer? batsMan2;
  MatchPlayer? bowler;
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    isEnabled = widget.continueWithInjPlayer;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scoreBoardStateProvider);
    final notifier = ref.watch(scoreBoardStateProvider.notifier);

    final List<MatchPlayer> batsManList =
        widget.playerSelectionType != PlayerSelectionType.bowler
            ? _getFilteredList(state, type: PlayerSelectionType.batsMan)
            : [];
    final List<MatchPlayer> bowlerList =
        widget.playerSelectionType != PlayerSelectionType.batsMan
            ? _getFilteredList(state, type: PlayerSelectionType.bowler)
            : [];

    final showCheckBox = widget.playerSelectionType !=
            PlayerSelectionType.bowler
        ? batsManList.any((element) => element.status == PlayerStatus.injured)
        : false;

    final injuredPlayerRemained =
        widget.playerSelectionType != PlayerSelectionType.bowler
            ? batsManList.every((e) => e.status == PlayerStatus.injured)
            : false;
    return BottomSheetWrapper(
        content: _selectPlayerContent(
          context,
          state,
          batsManList: batsManList,
          bowlerList: bowlerList,
        ),
        action: [
          _stickyButton(
              context, notifier, state, showCheckBox, injuredPlayerRemained)
        ]);
  }

  Widget _selectPlayerContent(
    BuildContext context,
    ScoreBoardViewState state, {
    required List<MatchPlayer> batsManList,
    required List<MatchPlayer> bowlerList,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // batsman
        if (widget.playerSelectionType != PlayerSelectionType.bowler &&
            batsManList.isNotEmpty) ...[
          _sectionTitle(
              context,
              (widget.playerSelectionType == PlayerSelectionType.all)
                  ? context.l10n.score_board_choose_opening_batsmen_title
                  : context.l10n.score_board_choose_batsman_title(
                      state.lastAssignedIndex + 1)),
          _remainingPlayerGrid(
            context,
            state,
            batsManList,
            PlayerSelectionType.batsMan,
          ),
        ],

        // bowler
        if (widget.playerSelectionType != PlayerSelectionType.batsMan) ...[
          const SizedBox(height: 24),
          _sectionTitle(
              context,
              context.l10n
                  .score_board_choose_bowler_for_over_title(state.overCount)),
          _remainingPlayerGrid(
            context,
            state,
            bowlerList,
            PlayerSelectionType.bowler,
          ),
        ],
      ],
    );
  }

  List<MatchPlayer> _getFilteredList(
    ScoreBoardViewState state, {
    required PlayerSelectionType type,
  }) {
    if (state.match == null) {
      return [];
    }

    final teamId = (type == PlayerSelectionType.batsMan
            ? state.currentInning?.team_id
            : state.otherInning?.team_id) ??
        "INVALID ID";
    final teamPlayers = state.match?.teams
        .where((element) => element.team.id == teamId)
        .firstOrNull
        ?.squad;

    if (type == PlayerSelectionType.bowler) {
      return teamPlayers ?? [];
    } else {
      return teamPlayers
              ?.where((element) => _isPlayerEligibleForBatsman(element.status))
              .toList() ??
          [];
    }
  }

  bool _isPlayerEligibleForBatsman(PlayerStatus? status) {
    return status != PlayerStatus.played &&
        status != PlayerStatus.playing &&
        status != PlayerStatus.suspended;
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.header3
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _remainingPlayerGrid(
    BuildContext context,
    ScoreBoardViewState state,
    List<MatchPlayer> list,
    PlayerSelectionType type,
  ) {
    final showOverCount = type == PlayerSelectionType.bowler;
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        for (final player in list) ...[
          UserCellView(
            title: player.player.name ?? context.l10n.common_anonymous_title,
            imageUrl: player.player.profile_img_url,
            initial: player.player.nameInitial,
            subtitle: showOverCount
                ? "(${context.l10n.match_list_overs_title(_getOverCount(state, player.player.id))})"
                : null,
            isSelected: type == PlayerSelectionType.batsMan
                ? [batsMan1?.player.id, batsMan2?.player.id]
                    .contains(player.player.id)
                : bowler?.player.id == player.player.id,
            tag: player.status == PlayerStatus.injured &&
                    type == PlayerSelectionType.batsMan
                ? context.l10n.score_board_injured_tag_title
                : null,
            disableCell: player.status == PlayerStatus.injured &&
                type == PlayerSelectionType.batsMan &&
                !isEnabled,
            onTap: () => setState(() {
              if (type == PlayerSelectionType.batsMan) {
                if (widget.playerSelectionType == PlayerSelectionType.all) {
                  if (batsMan1?.player.id == player.player.id) {
                    batsMan1 = null;
                  } else if (batsMan2?.player.id == player.player.id) {
                    batsMan2 = null;
                  } else if (batsMan1 == null) {
                    batsMan1 = player;
                  } else if (batsMan2 == null) {
                    batsMan2 = player;
                  } else {
                    return;
                    // extra else to suppress lint suggestion of using ??= for batsMan2 assignment
                  }
                } else {
                  batsMan1 = player;
                }
              } else {
                bowler = player;
              }
            }),
          )
        ],
      ],
    );
  }

  int _getOverCount(ScoreBoardViewState state, String id) {
    final scores = state.currentScoresList
        .where((element) =>
            element.bowler_id == id &&
            element.extras_type != ExtrasType.noBall &&
            element.extras_type != ExtrasType.penaltyRun &&
            element.extras_type != ExtrasType.wide &&
            element.wicket_type != WicketType.retired &&
            element.wicket_type != WicketType.retiredHurt &&
            element.wicket_type != WicketType.timedOut)
        .toList();
    return (scores.length / 6).floor();
  }

  Widget _stickyButton(
    BuildContext context,
    ScoreBoardViewNotifier notifier,
    ScoreBoardViewState state,
    bool showContWithInjPlayerOption,
    bool injuredPlayerRemained,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showContWithInjPlayerOption) ...[
          _contWithInjPlayerOption(context, notifier),
          const SizedBox(height: 16)
        ],
        PrimaryButton(
          _getButtonTitle(
              state.otherInning?.innings_status == InningStatus.finish,
              injuredPlayerRemained),
          enabled: _isStickyButtonEnable(injuredPlayerRemained),
          onPressed: () =>
              _onSelectButton(context, state, injuredPlayerRemained),
        ),
      ],
    );
  }

  Widget _contWithInjPlayerOption(
      BuildContext context, ScoreBoardViewNotifier notifier) {
    return _checkBoxView(
      context,
      title: context.l10n.score_board_continue_with_injured_player_title,
      value: isEnabled,
      onChange: (value) => setState(() {
        isEnabled = !isEnabled;
        notifier.onContinueWithInjuredPlayersChange(isEnabled);
        if (!isEnabled) {
          if (batsMan1?.status == PlayerStatus.injured) {
            batsMan1 = null;
          }
          if (batsMan2?.status == PlayerStatus.injured) {
            batsMan2 = null;
          }
        }
      }),
    );
  }

  String _getButtonTitle(
    bool isSecondInningRunning,
    bool injuredPlayerRemained,
  ) {
    if (injuredPlayerRemained &&
        !isEnabled &&
        widget.playerSelectionType != PlayerSelectionType.bowler) {
      return isSecondInningRunning
          ? context.l10n.score_board_end_match_title
          : context.l10n.score_board_end_inning_title;
    } else {
      return context.l10n.score_board_select_title;
    }
  }

  bool _isStickyButtonEnable(bool injuredPlayerRemained) {
    if (injuredPlayerRemained &&
        !isEnabled &&
        widget.playerSelectionType != PlayerSelectionType.bowler) {
      return true;
    }

    switch (widget.playerSelectionType) {
      case PlayerSelectionType.bowler:
        return bowler != null;
      case PlayerSelectionType.batsMan:
        return batsMan1 != null;
      case PlayerSelectionType.all:
        return batsMan1 != null && batsMan2 != null && bowler != null;
      case PlayerSelectionType.batsManAndBowler:
        return batsMan1 != null && bowler != null;
    }
  }

  void _onSelectButton(
    BuildContext context,
    ScoreBoardViewState state,
    bool injuredPlayerRemained,
  ) {
    if (injuredPlayerRemained && !isEnabled) {
      context.pop((
        selectedPlayer: null,
        contWithInjPlayer: isEnabled,
      ));
    } else {
      final List<({List<MatchPlayer> players, String teamId})> selectedPlayer =
          [];

      if (widget.playerSelectionType != PlayerSelectionType.batsMan) {
        selectedPlayer.add(
          (
            teamId: state.otherInning?.team_id ?? "INVALID ID",
            players: [bowler!]
          ),
        );
      }

      if (widget.playerSelectionType != PlayerSelectionType.bowler) {
        List<MatchPlayer> players = [batsMan1!];

        if (widget.playerSelectionType == PlayerSelectionType.all) {
          players.add(batsMan2!);
        }

        selectedPlayer.add(
          (
            teamId: state.currentInning?.team_id ?? "INVALID ID",
            players: players
          ),
        );
      }

      context.pop((
        selectedPlayer: selectedPlayer,
        contWithInjPlayer: isEnabled,
      ));
    }
  }

  Widget _checkBoxView(
    BuildContext context, {
    required String title,
    required bool value,
    required Function(bool) onChange,
  }) {
    return Theme(
      data: context.brightness == Brightness.dark
          ? materialThemeDataDark.copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory)
          : materialThemeDataLight.copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory),
      child: ListTileTheme(
          horizontalTitleGap: 0.0,
          child: CheckboxListTile(
            value: value,
            side:
                BorderSide(color: context.colorScheme.containerHigh, width: 2),
            onChanged: (value) {
              if (value != null) {
                onChange(value);
              }
            },
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              title,
              style: AppTextStyle.body1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          )),
    );
  }
}

enum PlayerSelectionType {
  bowler,
  batsMan,
  all,
  batsManAndBowler,
}
