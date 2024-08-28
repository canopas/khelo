import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';

class ReviseTargetSheet extends ConsumerStatefulWidget {
  static Future<T?> show<T>(BuildContext context) {
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
          child: const ReviseTargetSheet(),
        );
      },
    );
  }

  const ReviseTargetSheet({super.key});

  @override
  ConsumerState createState() => _ReviseTargetSheetState();
}

class _ReviseTargetSheetState extends ConsumerState<ReviseTargetSheet> {
  bool isButtonEnabled = false;
  String? errorString;

  TextEditingController manualOverTextController = TextEditingController();
  TextEditingController manualRunsTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scoreBoardStateProvider);
    return BottomSheetWrapper(
      content: _content(context, state),
      action: [
        PrimaryButton(
          context.l10n.score_board_confirm_target_text,
          enabled: isButtonEnabled,
          onPressed: () {
            final runs = int.parse(manualRunsTextController.text);
            final overs = double.parse(manualOverTextController.text);

            if (_isValidInput(state, runs, overs)) {
              context.pop({'run': runs, 'over': overs});
            } else {
              setState(() => errorString =
                  context.l10n.score_board_target_invalid_input_error);
            }
          },
        ),
      ],
    );
  }

  bool _isValidInput(ScoreBoardViewState state, int runs, double overs) {
    final actualTarget = (state.match?.teams
                .where((element) =>
                    element.team.id != state.currentInning?.team_id)
                .firstOrNull
                ?.run ??
            0) +
        1;

    return !((overs.toInt() <= 0 &&
            overs.toInt() >= (state.match?.number_of_over ?? 0)) ||
        runs >= actualTarget);
  }

  Widget _content(BuildContext context, ScoreBoardViewState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.score_board_revised_target_title,
          style: AppTextStyle.header3
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(height: 16),
        _addRunsView(context, state),
      ],
    );
  }

  Widget _addRunsView(BuildContext context, ScoreBoardViewState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: context.colorScheme.containerLow,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.score_board_enter_manual_target_text,
            style: AppTextStyle.body2
                .copyWith(color: context.colorScheme.textSecondary),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _textField(
                  context,
                  title: context.l10n.score_board_runs_text,
                  controller: manualRunsTextController,
                  onTextChange: () => _onTextChange(state),
                  autoFocus: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _textField(
                  context,
                  title: context.l10n.score_board_in_overs_text,
                  controller: manualOverTextController,
                  onTextChange: () => _onTextChange(state),
                  autoFocus: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (errorString != null)
            Text(
              errorString!,
              style: AppTextStyle.caption
                  .copyWith(color: context.colorScheme.alert),
            )
        ],
      ),
    );
  }

  Widget _textField(
    BuildContext context, {
    required TextEditingController controller,
    required VoidCallback onTextChange,
    required String title,
    bool autoFocus = false,
  }) {
    return MediaQuery.withNoTextScaling(
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: AppTextStyle.body2
                  .copyWith(color: context.colorScheme.textDisabled),
            ),
            Expanded(
              child: AppTextField(
                controller: controller,
                onChanged: (_) => onTextChange(),
                autoFocus: autoFocus,
                maxLength: 5,
                borderType: AppTextFieldBorderType.outline,
                borderRadius: BorderRadius.circular(8),
                backgroundColor: context.colorScheme.surface,
                // inputFormatters: TextValidationType.numberOnly,
                keyboardType: TextInputType.number,
                borderColor: BorderColor(
                  focusColor: Colors.transparent,
                  unFocusColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTextChange(ScoreBoardViewState state) {
    setState(() {
      errorString = null;
      isButtonEnabled = manualOverTextController.text.trim().isNotEmpty &&
          manualRunsTextController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    manualRunsTextController.dispose();
    manualOverTextController.dispose();
    super.dispose();
  }
}
