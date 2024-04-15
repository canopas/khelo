import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/innings/inning_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class SelectPlayerSheet extends ConsumerStatefulWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    required PlayerSelectionType type,
    required bool continueWithInjPlayer,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
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

    return Padding(
      padding: context.mediaQueryPadding +
          const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: context.mediaQuerySize.height * 0.8,
        child: _body(context, state),
      ),
    );
  }

  Widget _body(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
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

    return Stack(
      children: [
        ListView(
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
              _sectionTitle(
                  context,
                  context.l10n.score_board_choose_bowler_for_over_title(
                      state.overCount)),
              _remainingPlayerGrid(
                context,
                state,
                bowlerList,
                PlayerSelectionType.bowler,
              ),
            ],
          ],
        ),
        _stickyButton(context, state, showCheckBox, injuredPlayerRemained),
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
        const SizedBox(height: 24),
        Text(
          title,
          style: AppTextStyle.header1
              .copyWith(color: context.colorScheme.textSecondary),
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
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final player = list[index];

        return _userCellWithTag(
          context: context,
          state: state,
          showOverCount: type == PlayerSelectionType.bowler,
          user: player.player,
          tag: player.status == PlayerStatus.injured &&
                  type == PlayerSelectionType.batsMan
              ? context.l10n.score_board_injured_tag_title
              : null,
          isSelected: type == PlayerSelectionType.batsMan
              ? [batsMan1?.player.id, batsMan2?.player.id]
                  .contains(player.player.id)
              : bowler?.player.id == player.player.id,
          disableCell: player.status == PlayerStatus.injured &&
              type == PlayerSelectionType.batsMan &&
              !isEnabled,
          onTap: () {
            setState(() {
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
            });
          },
        );
      },
    );
  }

  Widget _userCellWithTag({
    required BuildContext context,
    required ScoreBoardViewState state,
    UserModel? user,
    String? tag,
    bool showOverCount = false,
    required bool isSelected,
    required bool disableCell,
    required Function() onTap,
  }) {
    final overCount =
        showOverCount ? _getOverCount(state, user?.id ?? "INVALID ID") : 0;

    return OnTapScale(
      enabled: !disableCell,
      onTap: disableCell ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.primary
              : disableCell
                  ? Colors.transparent
                  : context.colorScheme.containerNormalOnSurface,
          border: Border.all(color: context.colorScheme.outline),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            user != null
                ? ImageAvatar(
                    imageUrl: user.profile_img_url,
                    initial: user.nameInitial,
                    size: 60,
                  )
                : _profilePlaceHolder(context, size: 60),
            const SizedBox(
              height: 16,
            ),
            Text(
              user?.name ?? context.l10n.score_board_select_player_title,
              style: AppTextStyle.subtitle1.copyWith(
                  color: disableCell
                      ? context.colorScheme.textDisabled
                      : context.colorScheme.textPrimary),
            ),
            if (showOverCount) ...[
              Text(
                "(${context.l10n.match_list_overs_title(overCount)})",
                style: AppTextStyle.body1
                    .copyWith(color: context.colorScheme.textDisabled),
              )
            ],
            if (tag != null) ...[
              Text(
                tag,
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.alert),
              ),
            ]
          ],
        ),
      ),
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

  Widget _profilePlaceHolder(
    BuildContext context, {
    required double size,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: context.colorScheme.containerLow,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person),
    );
  }

  Widget _stickyButton(
    BuildContext context,
    ScoreBoardViewState state,
    bool showContWithInjPlayerOption,
    bool injuredPlayerRemained,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showContWithInjPlayerOption) ...[
            _contWithInjPlayerOption(context),
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
      ),
    );
  }

  Widget _contWithInjPlayerOption(BuildContext context) {
    return OnTapScale(
      onTap: () {
        setState(() {
          isEnabled = !isEnabled;
          if (!isEnabled) {
            if (batsMan1?.status == PlayerStatus.injured) {
              batsMan1 = null;
            }
            if (batsMan2?.status == PlayerStatus.injured) {
              batsMan2 = null;
            }
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Icon(isEnabled ? Icons.check_box : Icons.check_box_outline_blank),
            const SizedBox(width: 8),
            Text(
              context.l10n.score_board_continue_with_injured_player_title,
              style: AppTextStyle.subtitle1.copyWith(
                  color: context.colorScheme.textPrimary, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  String _getButtonTitle(
    bool isSecondInningRunning,
    bool injuredPlayerRemained,
  ) {
    if (injuredPlayerRemained && !isEnabled && widget.playerSelectionType != PlayerSelectionType.bowler) {
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
}

enum PlayerSelectionType {
  bowler,
  batsMan,
  all,
  batsManAndBowler,
}
