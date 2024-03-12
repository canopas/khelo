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

class SelectWicketTakerSheet extends ConsumerStatefulWidget {
  static Future<T?> show<T>(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return const SelectWicketTakerSheet();
      },
    );
  }

  const SelectWicketTakerSheet({super.key});

  @override
  ConsumerState createState() => _SelectWicketTakerSheetState();
}

class _SelectWicketTakerSheetState
    extends ConsumerState<SelectWicketTakerSheet> {
  String? selectedId;

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
    return _specificPlayerSelectionView(context, state);
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
                context, context.l10n.score_board_choose_fielder_title),
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
                  user: list[index].player,
                  isSelected: selectedId == list[index].player.id,
                  onTap: () {
                    setState(() {
                      selectedId = list[index].player.id;
                    });
                  },
                );
              },
            )
          ],
        ),
        _stickyButton(context)
      ],
    );
  }

  List<MatchPlayer> getFilteredList(ScoreBoardViewState state) {
    if (state.match == null) {
      return [];
    }

    final teamId = state.otherInning?.team_id ?? "INVALID ID";
    final teamPlayers = state.match?.teams
        .firstWhere((element) => element.team.id == teamId)
        .squad;

    return teamPlayers ?? [];
  }

  Widget _userCell1({
    required BuildContext context,
    UserModel? user,
    required bool isSelected,
    required Function() onTap,
  }) {
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
            )
          ],
        ),
      ),
    );
  }

  Widget _stickyButton(
    BuildContext context,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: PrimaryButton(
        context.l10n.score_board_select_title,
        enabled: selectedId != null,
        onPressed: () {
          context.pop(selectedId);
        },
      ),
    );
  }
}
