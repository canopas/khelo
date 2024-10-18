import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/widgets/rounded_check_box.dart';

class AddExtraSheet extends StatefulWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    ExtrasType? extrasType,
    bool isOnWicket = false,
    bool isFiveSeven = false,
  }) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet(
      context: context,
      showDragHandle: false,
      enableDrag: false,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddExtraSheet(
            extrasType: extrasType,
            isOnWicket: isOnWicket,
            isFiveSeven: isFiveSeven,
          ),
        );
      },
    );
  }

  final ExtrasType? extrasType;
  final bool isOnWicket;
  final bool isFiveSeven;

  const AddExtraSheet({
    super.key,
    required this.extrasType,
    required this.isOnWicket,
    required this.isFiveSeven,
  });

  @override
  State<AddExtraSheet> createState() => _AddExtraSheetState();
}

class _AddExtraSheetState extends State<AddExtraSheet> {
  bool notFromBat = false;
  bool isBoundary = false;

  TextEditingController runController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(
      content: _addExtraContent(context),
      action: [
        PrimaryButton(
          context.l10n.common_next_title,
          enabled: runController.text.isNotEmpty,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.isFiveSeven || widget.isOnWicket
              ? context.l10n.score_board_runs_title
              : context.l10n.score_board_extras_title,
          style: AppTextStyle.header3
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(height: 16),
        if (widget.isFiveSeven) ...[
          Wrap(
            spacing: 16,
            children: [
              _runButton(
                text: context.l10n.score_board_five_text,
                onTap: () {
                  setState(() {
                    runController.text = context.l10n.score_board_five_text;
                  });
                },
                selected: runController.text.contains(
                  context.l10n.score_board_five_text,
                ),
              ),
              _runButton(
                text: context.l10n.score_board_seven_text,
                onTap: () {
                  setState(() {
                    runController.text = context.l10n.score_board_seven_text;
                  });
                },
                selected: runController.text.contains(
                  context.l10n.score_board_seven_text,
                ),
              ),
            ],
          ),
        ] else ...[
          _addRunsView(context),
        ],
      ],
    );
  }

  Widget _runButton({
    required text,
    required VoidCallback onTap,
    required bool selected,
  }) {
    return OnTapScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        decoration: BoxDecoration(
            color: context.colorScheme.containerLow,
            borderRadius: BorderRadius.circular(12),
            border: selected
                ? Border.all(color: context.colorScheme.primary)
                : null),
        child: Text(
          text,
          style: AppTextStyle.subtitle1.copyWith(
            color: context.colorScheme.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _addRunsView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: context.colorScheme.containerLow,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                _getExtraTitle(context, widget.extrasType),
                style: AppTextStyle.header3
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              const SizedBox(width: 16),
              IntrinsicWidth(
                child: Container(
                  constraints: const BoxConstraints(minWidth: 70),
                  child: AppTextField(
                    controller: runController,
                    textAlign: TextAlign.center,
                    backgroundColor: context.colorScheme.surface,
                    borderType: AppTextFieldBorderType.outline,
                    maxLength: 2,
                    autoFocus: true,
                    borderRadius: BorderRadius.circular(8),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    borderColor: BorderColor(
                        focusColor: Colors.transparent,
                        unFocusColor: Colors.transparent),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: AppTextStyle.subtitle2
                        .copyWith(color: context.colorScheme.textPrimary),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                context.l10n.score_board_runs_title,
                style: AppTextStyle.header3
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
            ],
          ),
          if (widget.extrasType == ExtrasType.noBall) ...[
            const SizedBox(height: 16),
            RoundedCheckBoxTile(
              title: context.l10n.score_board_not_from_bat_text,
              isSelected: notFromBat,
              onTap: (value) => setState(() => notFromBat = value),
            ),
            const SizedBox(height: 16),
            RoundedCheckBoxTile(
              title: context.l10n.score_board_is_boundary_text,
              isSelected: isBoundary,
              onTap: (value) => setState(() => isBoundary = value),
            ),
          ],
        ],
      ),
    );
  }

  String _getExtraTitle(BuildContext context, ExtrasType? type) {
    if (type == ExtrasType.noBall) {
      return "${context.l10n.score_board_no_ball_short_text} +";
    } else if (type == ExtrasType.bye) {
      return context.l10n.score_board_bye_text;
    } else if (type == ExtrasType.legBye) {
      return context.l10n.score_board_leg_bye_text;
    } else {
      return "";
    }
  }
}
