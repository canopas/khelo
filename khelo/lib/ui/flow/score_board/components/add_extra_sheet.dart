import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/theme/colors.dart';

class AddExtraSheet extends StatefulWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    ExtrasType? extrasType,
    bool isOnWicket = false,
    bool isFiveSeven = false,
  }) {
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
  bool isButtonEnable = false;

  TextEditingController runController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(
      content: _addExtraContent(context),
      action: [
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
        _addRunsView(context),
      ],
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
                    keyboardType: TextInputType.number,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    borderColor: BorderColor(
                        focusColor: Colors.transparent,
                        unFocusColor: Colors.transparent),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    style: AppTextStyle.subtitle2
                        .copyWith(color: context.colorScheme.textPrimary),
                    onChanged: (value) =>
                        setState(() => isButtonEnable = value.isNotEmpty),
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
            _checkBoxView(
              context,
              title: context.l10n.score_board_not_from_bat_text,
              value: notFromBat,
              onChange: (value) => setState(() => notFromBat = value),
            ),
            _checkBoxView(
              context,
              title: context.l10n.score_board_is_boundary_text,
              value: isBoundary,
              onChange: (value) => setState(() => isBoundary = value),
            ),
          ],
        ],
      ),
    );
  }

  Widget _checkBoxView(
    BuildContext context, {
    required String title,
    required bool value,
    required Function(bool) onChange,
  }) {
    return Theme(
      data: context.brightness == Brightness.dark
          ? materialThemeDataDark.copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory)
          : materialThemeDataLight.copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory),
      child: ListTileTheme(
          horizontalTitleGap: 0.0,
          child: CheckboxListTile(
            value: value,
            side:
                BorderSide(color: context.colorScheme.containerHigh, width: 2),
            onChanged: (value) {
              if (value != null) {
                onChange(value);
              }
            },
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              title,
              style: AppTextStyle.body1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          )),
    );
  }

  String _getExtraTitle(BuildContext context, ExtrasType? type) {
    if (widget.isFiveSeven) {
      return context.l10n.score_board_five_or_seven_text;
    } else if (type == ExtrasType.noBall) {
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
