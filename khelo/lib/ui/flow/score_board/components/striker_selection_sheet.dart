import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:khelo/ui/flow/score_board/components/user_cell_view.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class StrikerSelectionSheet extends ConsumerStatefulWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    bool isForStrikerSelection = true,
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
        return StrikerSelectionSheet(
          isForStrikerSelection: isForStrikerSelection,
        );
      },
    );
  }

  final bool isForStrikerSelection;

  const StrikerSelectionSheet({
    super.key,
    required this.isForStrikerSelection,
  });

  @override
  ConsumerState createState() => _StrikerSelectionSheetState();
}

class _StrikerSelectionSheetState extends ConsumerState<StrikerSelectionSheet> {
  UserModel? selectedUser;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scoreBoardStateProvider);

    return BottomSheetWrapper(
        content: _selectPlayerContent(context, state),
        action: [
          PrimaryButton(
            context.l10n.common_next_title,
            enabled: selectedUser != null,
            expanded: false,
            onPressed: () => context.pop(selectedUser),
          ),
        ]);
  }

  Widget _selectPlayerContent(BuildContext context, ScoreBoardViewState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.isForStrikerSelection
              ? context.l10n.score_board_who_on_strike_title
              : context.l10n.score_board_who_got_out_title,
          style: AppTextStyle.header3
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(height: 16),
        Wrap(
            spacing: 16,
            runSpacing: 16,
            children: state.batsMans
                    ?.map((player) => UserCellView(
                        title: player.player.name ??
                            context.l10n.common_anonymous_title,
                        imageUrl: player.player.profile_img_url,
                        initial: player.player.nameInitial,
                        isSelected: selectedUser?.id == player.player.id,
                        onTap: () {
                          setState(() {
                            selectedUser = player.player;
                          });
                        }))
                    .toList() ??
                []),
      ],
    );
  }
}
