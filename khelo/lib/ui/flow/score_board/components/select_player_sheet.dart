import 'package:data/api/ball_score/ball_score_model.dart';
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
    List<String>? excludedIds,
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
          type: type,
          excludedIds: excludedIds,
        );
      },
    );
  }

  final PlayerSelectionType type;
  final List<String>? excludedIds;

  const SelectPlayerSheet({super.key, required this.type, this.excludedIds});

  @override
  ConsumerState createState() => _SelectPlayerSheetState();
}

class _SelectPlayerSheetState extends ConsumerState<SelectPlayerSheet> {
  MatchPlayer? batsMan1;
  MatchPlayer? batsMan2;
  MatchPlayer? bowler;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scoreBoardStateProvider);

    return Padding(
      padding: context.mediaQueryPadding +
          const EdgeInsets.symmetric(
            horizontal: 16,
          ),
      child: SizedBox(
        height: context.mediaQuerySize.height * 0.8,
        child: _body(context, state),
      ),
    );
  }

  Widget _body(BuildContext context, ScoreBoardViewState state) {
    if (widget.type == PlayerSelectionType.all) {
      return _allPlayerSelectionView(context, state);
    }
    return _specificPlayerSelectionView(context, state);
  }

  Widget _allPlayerSelectionView(
      BuildContext context, ScoreBoardViewState state) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.only(bottom: 80),
          children: [
            _sectionTitle(context, context.l10n.score_board_batsman_title),
            Row(
              children: [
                _userCell(
                  context: context,
                  user: batsMan1?.player,
                  onTap: () async {
                    final player = await SelectPlayerSheet.show<
                            List<({String teamId, List<MatchPlayer> players})>>(
                        context,
                        type: PlayerSelectionType.batsMan,
                        excludedIds: [
                          batsMan1?.player.id ?? "INVALID ID",
                          batsMan2?.player.id ?? "INVALID ID"
                        ]);
                    if (player != null && context.mounted) {
                      setState(() {
                        batsMan1 = player.first.players.first;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                _userCell(
                  context: context,
                  user: batsMan2?.player,
                  onTap: () async {
                    final player = await SelectPlayerSheet.show<
                            List<({List<MatchPlayer> players, String teamId})>>(
                        context,
                        type: PlayerSelectionType.batsMan,
                        excludedIds: [
                          batsMan1?.player.id ?? "INVALID ID",
                          batsMan2?.player.id ?? "INVALID ID"
                        ]);
                    if (player != null && context.mounted) {
                      setState(() {
                        batsMan2 = player.first.players.first;
                      });
                    }
                  },
                ),
              ],
            ),
            _sectionTitle(context, context.l10n.score_board_bowler_title),
            Row(
              children: [
                _userCell(
                  context: context,
                  user: bowler?.player,
                  onTap: () async {
                    // call itSelf for bowler selection
                    final player = await SelectPlayerSheet.show<
                            List<({String teamId, List<MatchPlayer> players})>>(
                        context,
                        type: PlayerSelectionType.bowler,
                        excludedIds: [bowler?.player.id ?? "INVALID ID"]);
                    if (player != null && context.mounted) {
                      setState(() {
                        bowler = player.first.players.first;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
        _stickyButton(context, state),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          title,
          style: AppTextStyle.header1
              .copyWith(color: context.colorScheme.textSecondary),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _userCell({
    required BuildContext context,
    UserModel? user,
    required Function() onTap,
  }) {
    return Expanded(
      child: OnTapScale(
        onTap: () => onTap(),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colorScheme.containerNormalOnSurface,
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
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textPrimary),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _profilePlaceHolder(BuildContext context, {required double size}) {
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

  Widget _specificPlayerSelectionView(
      BuildContext context, ScoreBoardViewState state) {
    final list = getFilteredList(state);
    return Stack(
      children: [
        ListView(
          children: [
            _sectionTitle(
                context,
                (widget.type == PlayerSelectionType.batsMan)
                    ? context.l10n.score_board_choose_batsman_title
                    : context.l10n.score_board_choose_bowler_for_over_title(
                        state.overCount)),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return _userCell1(
                  context: context,
                  state: state,
                  user: list[index].player,
                  tag: list[index].status == PlayerStatus.injured
                      ? "Injured"
                      : null,
                  isSelected: widget.type == PlayerSelectionType.batsMan
                      ? batsMan1?.player.id == list[index].player.id
                      : bowler?.player.id == list[index].player.id,
                  onTap: () {
                    setState(() {
                      if (widget.type == PlayerSelectionType.batsMan) {
                        batsMan1 = list[index];
                      } else {
                        bowler = list[index];
                      }
                    });
                  },
                );
              },
            )
          ],
        ),
        _stickyButton(context, state)
      ],
    );
  }

  List<MatchPlayer> getFilteredList(ScoreBoardViewState state) {
    if (state.match == null) {
      return [];
    }

    final teamId = (widget.type == PlayerSelectionType.batsMan
            ? state.currentInning?.team_id
            : state.otherInning?.team_id) ??
        "INVALID ID";
    final teamPlayers = state.match?.teams
        .firstWhere((element) => element.team.id == teamId)
        .squad;

    return teamPlayers
            ?.where((element) =>
                !(widget.excludedIds ?? []).contains(element.player.id) &&
                ((widget.type == PlayerSelectionType.batsMan)
                    ? _isPlayerEligibleForBatsman(element.status)
                    : true))
            .toList() ??
        [];
  }

  bool _isPlayerEligibleForBatsman(PlayerStatus? status) {
    return status != PlayerStatus.played &&
        status != PlayerStatus.playing &&
        status != PlayerStatus.suspended;
  }

  Widget _userCell1({
    required BuildContext context,
    required ScoreBoardViewState state,
    UserModel? user,
    String? tag,
    required bool isSelected,
    required Function() onTap,
  }) {
    final overCount = _getOverCount(state, user?.id ?? "INVALID_ID");
    return OnTapScale(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.primary
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
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            if (widget.type == PlayerSelectionType.bowler) ...[
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
                    .copyWith(color: context.colorScheme.textPrimary),
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
            element.extras_type != ExtrasType.wide)
        .toList();

    return (scores.length / 6).floor();
  }

  Widget _stickyButton(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: PrimaryButton(
        context.l10n.score_board_select_title,
        enabled: widget.type == PlayerSelectionType.all
            ? (batsMan1 != null && batsMan2 != null && bowler != null)
            : widget.type == PlayerSelectionType.batsMan
                ? batsMan1 != null
                : bowler != null,
        onPressed: () {
          final List<({List<MatchPlayer> players, String teamId})>
              selectedPlayer = [];

          if (widget.type != PlayerSelectionType.batsMan) {
            selectedPlayer.add(
              (
                teamId: state.otherInning?.team_id ?? "INVALID ID",
                players: [bowler!]
              ),
            );
          }

          if (widget.type != PlayerSelectionType.bowler) {
            List<MatchPlayer> players = [batsMan1!];

            if (widget.type == PlayerSelectionType.all) {
              players.add(batsMan2!);
            }

            selectedPlayer.add(
              (
                teamId: state.currentInning?.team_id ?? "INVALID ID",
                players: players
              ),
            );
          }

          context.pop(selectedPlayer);
        },
      ),
    );
  }
}

enum PlayerSelectionType { bowler, batsMan, all, batsManAndBowler }
