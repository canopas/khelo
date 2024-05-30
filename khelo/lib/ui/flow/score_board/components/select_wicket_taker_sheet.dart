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

class SelectWicketTakerSheet extends ConsumerStatefulWidget {
  static Future<T?> show<T>(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      showDragHandle: false,
      enableDrag: false,
      isScrollControlled: true,
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
    return BottomSheetWrapper(
      content: _wicketTakerContent(context, state),
      action: [
        PrimaryButton(
          context.l10n.score_board_select_title,
          enabled: selectedId != null,
          onPressed: () => context.pop(selectedId),
        )
      ],
    );
  }

  Widget _wicketTakerContent(BuildContext context, ScoreBoardViewState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.score_board_choose_fielder_title,
          style: AppTextStyle.header3
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
            spacing: 16,
            runSpacing: 16,
            children: getFilteredList(state)
                .map(
                  (player) => UserCellView(
                    title: player.player.name ??
                        context.l10n.common_anonymous_title,
                    imageUrl: player.player.profile_img_url,
                    initial: player.player.nameInitial,
                    isSelected: selectedId == player.player.id,
                    onTap: () {
                      setState(() {
                        selectedId = player.player.id;
                      });
                    },
                  ),
                )
                .toList()),
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
}
