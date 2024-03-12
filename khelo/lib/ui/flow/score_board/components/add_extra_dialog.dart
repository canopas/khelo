import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class AddExtraDialog extends ConsumerStatefulWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    ExtrasType? extrasType,
    bool isOnWicket = false,
    bool isFiveSeven = false,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AddExtraDialog(
          extrasType: extrasType,
          isOnWicket: isOnWicket,
          isFiveSeven: isFiveSeven,
        );
      },
    );
  }

  final ExtrasType? extrasType;
  final bool isOnWicket;
  final bool isFiveSeven;

  const AddExtraDialog({
    super.key,
    required this.extrasType,
    required this.isOnWicket,
    required this.isFiveSeven,
  });

  @override
  ConsumerState createState() => _AddExtraDialogState();
}

class _AddExtraDialogState extends ConsumerState<AddExtraDialog> {
  bool notFromBat = false;
  bool isBoundary = false;
  bool isButtonEnable = false;

  TextEditingController runController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colorScheme.containerLowOnSurface,
      title: Text(
        widget.isFiveSeven || widget.isOnWicket
            ? context.l10n.score_board_runs_title
            : context.l10n.score_board_extras_title,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary),
      ),
      content: _addExtraContent(context),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        PrimaryButton(
          context.l10n.common_next_title,
          enabled: isButtonEnable,
          onPressed: () {
            context.pop((
              int.parse(runController.text),
              isBoundary,
              notFromBat,
            ));
          },
        ),
      ],
    );
  }

  Widget _addExtraContent(BuildContext context) {
    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.extrasType == ExtrasType.noBall ||
                widget.isFiveSeven) ...[
              Text(
                widget.extrasType == ExtrasType.noBall
                    ? "${context.l10n.score_board_no_ball_short_text} +"
                    : context.l10n.score_board_five_or_seven_text,
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
            ],
            SizedBox(
              width: 70,
              child: TextField(
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textPrimary),
                textAlign: TextAlign.center,
                controller: runController,
                onChanged: (value) {
                  setState(() {
                    isButtonEnable = value.isNotEmpty;
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            ),
            Text(
              context.l10n.score_board_runs_title,
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ],
        ),
        if (widget.extrasType == ExtrasType.noBall) ...[
          Row(
            children: [
              Checkbox(
                activeColor: context.colorScheme.primary,
                value: notFromBat,
                onChanged: (value) {
                  setState(() {
                    notFromBat = value ?? !notFromBat;
                  });
                },
              ),
              Text(
                context.l10n.score_board_not_from_bat_text,
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textPrimary),
              )
            ],
          ),
          Row(
            children: [
              Checkbox(
                activeColor: context.colorScheme.primary,
                value: isBoundary,
                onChanged: (value) {
                  setState(() {
                    isBoundary = value ?? !isBoundary;
                  });
                },
              ),
              Text(
                context.l10n.score_board_is_boundary_text,
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textPrimary),
              )
            ],
          )
        ]
      ],
    );
  }
}
