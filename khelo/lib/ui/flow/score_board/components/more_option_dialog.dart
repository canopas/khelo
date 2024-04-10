import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class MoreOptionDialog extends StatefulWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    required bool continueWithInjPlayer,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return MoreOptionDialog(
          continueWithInjPlayer: continueWithInjPlayer,
        );
      },
    );
  }

  final bool continueWithInjPlayer;

  const MoreOptionDialog({
    super.key,
    required this.continueWithInjPlayer,
  });

  @override
  State<MoreOptionDialog> createState() => _MoreOptionDialogState();
}

class _MoreOptionDialogState extends State<MoreOptionDialog> {
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    isEnabled = widget.continueWithInjPlayer;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colorScheme.containerLowOnSurface,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.l10n.score_board_more_options_title,
            style: AppTextStyle.header2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          IconButton(
              onPressed: () {
                context.pop((
                  option: MatchOption.continueWithInjuredPlayer,
                  contWithInjPlayer: isEnabled
                ));
              },
              icon: const Icon(Icons.close)),
        ],
      ),
      content: _optionListContent(context),
      actionsOverflowButtonSpacing: 8,
    );
  }

  Widget _optionListContent(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 16,
        children: [
          for (final option in MatchOption.values) ...[
            _optionCellView(context, option)
          ],
        ],
      ),
    );
  }

  Widget _optionCellView(
    BuildContext context,
    MatchOption option,
  ) {
    return OnTapScale(
      onTap: () {
        switch (option) {
          case MatchOption.continueWithInjuredPlayer:
            setState(() {
              isEnabled = !isEnabled;
            });
          default:
            context.pop((option: option, contWithInjPlayer: isEnabled));
        }
      },
      child: Row(
        children: [
          Text(
            option.getTitle(context),
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary, fontSize: 20),
          ),
          const Spacer(),
          option == MatchOption.continueWithInjuredPlayer
              ? Icon(
                  isEnabled ? Icons.check_box : Icons.check_box_outline_blank)
              : const SizedBox(),
        ],
      ),
    );
  }
}