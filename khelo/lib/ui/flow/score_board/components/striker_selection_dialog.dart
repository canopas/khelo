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

class StrikerSelectionDialog extends ConsumerStatefulWidget {
  static Future<T?> show<T>(BuildContext context,
      {bool isForStrikerSelection = true}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StrikerSelectionDialog(
          isForStrikerSelection: isForStrikerSelection,
        );
      },
    );
  }

  final bool isForStrikerSelection;

  const StrikerSelectionDialog({
    super.key,
    required this.isForStrikerSelection,
  });

  @override
  ConsumerState createState() => _StrikerSelectionDialogState();
}

class _StrikerSelectionDialogState
    extends ConsumerState<StrikerSelectionDialog> {
  UserModel? selectedUser;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scoreBoardStateProvider);

    return AlertDialog(
      backgroundColor: context.colorScheme.containerLowOnSurface,
      title: Text(
        widget.isForStrikerSelection
            ? context.l10n.score_board_who_on_strike_title
            : context.l10n.score_board_who_got_out_title,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary),
      ),
      content: _selectPlayerContent(context, state),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        PrimaryButton(
          context.l10n.common_next_title,
          enabled: selectedUser != null,
          onPressed: () => context.pop(selectedUser),
        ),
      ],
    );
  }

  Widget _selectPlayerContent(BuildContext context, ScoreBoardViewState state) {
    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          spacing: 16,
          children: [
            for (final player in state.batsMans ?? []) ...[
              _userCell(
                context: context,
                user: player.player,
                isSelected: selectedUser?.id == player.player.id,
                onTap: () {
                  setState(() {
                    selectedUser = player.player;
                  });
                },
              )
            ],
          ],
        ),
      ),
    );
  }

  Widget _userCell({
    required BuildContext context,
    UserModel? user,
    required bool isSelected,
    required Function() onTap,
  }) {
    return OnTapScale(
      onTap: onTap,
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
              user?.name ?? context.l10n.common_anonymous_title,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            )
          ],
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
}
