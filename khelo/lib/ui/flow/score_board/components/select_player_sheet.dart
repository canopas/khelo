import 'package:collection/collection.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/innings/inning_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:khelo/ui/flow/score_board/components/user_cell_view.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/button/toggle_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class SelectPlayerSheet extends ConsumerStatefulWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    required PlayerSelectionType type,
    required bool continueWithInjPlayer,
  }) {
    HapticFeedback.mediumImpact();
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
  late List<MatchPlayer> batsManList;
  late List<MatchPlayer> bowlerList;
  late ScoreBoardViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(scoreBoardStateProvider.notifier);
    isEnabled = widget.continueWithInjPlayer;

    batsManList = notifier.getFilteredPlayerList(PlayerSelectionType.batsMan);
    bowlerList = notifier.getFilteredPlayerList(PlayerSelectionType.bowler);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scoreBoardStateProvider);

    final showCheckBox =
        widget.playerSelectionType != PlayerSelectionType.bowler
            ? batsManList.any((element) => element.performance.any(
                  (element) =>
                      element.inning_id == state.currentInning?.id &&
                      element.status == PlayerStatus.injured,
                ))
            : false;

    final injuredPlayerRemained =
        widget.playerSelectionType != PlayerSelectionType.bowler
            ? batsManList.every((e) => e.performance.any(
                  (element) =>
                      element.inning_id == state.currentInning?.id &&
                      element.status == PlayerStatus.injured,
                ))
            : false;
    return BottomSheetWrapper(
        content: _selectPlayerContent(
          context,
          state,
          batsManList: batsManList,
          bowlerList: bowlerList,
        ),
        options: [
          if (showCheckBox) ...[
            _contWithInjPlayerOption(context, notifier, state),
            const SizedBox(height: 16)
          ],
        ],
        action: [
          _stickyButton(context, state, injuredPlayerRemained)
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
      children: list.map((player) {
        final status = player.performance
            .firstWhereOrNull(
                (element) => element.inning_id == state.currentInning?.id)
            ?.status;

        final isSelected = type == PlayerSelectionType.batsMan
            ? [batsMan1?.player.id, batsMan2?.player.id]
                .contains(player.player.id)
            : bowler?.player.id == player.player.id;

        final tag = status == PlayerStatus.injured &&
                type == PlayerSelectionType.batsMan
            ? context.l10n.score_board_injured_tag_title
            : null;

        final disableCell = status == PlayerStatus.injured &&
            type == PlayerSelectionType.batsMan &&
            !isEnabled;

        return UserCellView(
          title: player.player.name ?? context.l10n.common_anonymous_title,
          imageUrl: player.player.profile_img_url,
          initial: player.player.nameInitial,
          subtitle: showOverCount
              ? "(${context.l10n.match_list_overs_title(_getOverCount(state, player.player.id))})"
              : null,
          isSelected: isSelected,
          tag: tag,
          disableCell: disableCell,
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
        );
      }).toList(),
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
    ScoreBoardViewState state,
    bool injuredPlayerRemained,
  ) {
    return PrimaryButton(
      _getButtonTitle(state.otherInning?.innings_status == InningStatus.finish,
          injuredPlayerRemained),
      enabled: _isStickyButtonEnable(injuredPlayerRemained),
      onPressed: () => _onSelectButton(context, state, injuredPlayerRemained),
    );
  }

  Widget _contWithInjPlayerOption(
    BuildContext context,
    ScoreBoardViewNotifier notifier,
    ScoreBoardViewState state,
  ) {
    return ToggleButtonTile(
      title: context.l10n.score_board_continue_with_injured_player_title,
      defaultEnabled: isEnabled,
      onTap: (value) => setState(() {
        isEnabled = !isEnabled;
        notifier.onToggleMatchOptionChange(
            isEnabled, MatchOption.continueWithInjuredPlayer);
        if (!isEnabled) {
          if (batsMan1?.performance
                  .firstWhereOrNull(
                      (element) => element.inning_id == state.currentInning?.id)
                  ?.status ==
              PlayerStatus.injured) {
            batsMan1 = null;
          }
          if (batsMan2?.performance
                  .firstWhereOrNull(
                      (element) => element.inning_id == state.currentInning?.id)
                  ?.status ==
              PlayerStatus.injured) {
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
          ? context.l10n.common_end_match_title
          : context.l10n.score_board_end_inning_title;
    } else {
      return context.l10n.common_select_title.toLowerCase();
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
}

enum PlayerSelectionType {
  bowler,
  batsMan,
  all,
  batsManAndBowler,
}
