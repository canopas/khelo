import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:khelo/ui/flow/score_board/revise_target_sheet/revise_target_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';

class ReviseTargetSheet extends ConsumerStatefulWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    required int actualTarget,
    required int totalOver,
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
          child: ReviseTargetSheet(
            actualTarget: actualTarget,
            totalOver: totalOver,
          ),
        );
      },
    );
  }

  final int actualTarget;
  final int totalOver;

  const ReviseTargetSheet({
    super.key,
    required this.actualTarget,
    required this.totalOver,
  });

  @override
  ConsumerState createState() => _ReviseTargetSheetState();
}

class _ReviseTargetSheetState extends ConsumerState<ReviseTargetSheet> {
  late ReviseTargetViewNotifier notifier;

  @override
  void initState() {
    notifier = ref.read(reviseTargetStateProvider.notifier);

    runPostFrame(() => notifier.setData(
          widget.actualTarget,
          widget.totalOver,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reviseTargetStateProvider);
    _observeIsPop(context, ref);

    return BottomSheetWrapper(
      content: _content(context, state),
      action: [
        PrimaryButton(
          context.l10n.score_board_confirm_target_text,
          enabled: state.isButtonEnabled,
          onPressed: notifier.onConfirmTarget,
        ),
      ],
    );
  }

  Widget _content(BuildContext context, ReviseTargetViewState state) {
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

  Widget _addRunsView(BuildContext context, ReviseTargetViewState state) {
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
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.score_board_current_target_text(
                state.actualTarget, state.totalOvers),
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
                  controller: state.manualRunsTextController,
                  onTextChange: notifier.onTextChange,
                  autoFocus: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _textField(
                  context,
                  title: context.l10n.score_board_in_overs_text,
                  controller: state.manualOverTextController,
                  onTextChange: notifier.onTextChange,
                  autoFocus: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (state.showErrorString == true)
            Text(
              context.l10n.score_board_target_invalid_input_error,
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
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
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

  void _observeIsPop(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen(reviseTargetStateProvider.select((value) => value.isPop),
        (previous, next) async {
      if (next == true) {
        final targetRun = ref.read(reviseTargetStateProvider
            .select((value) => int.parse(value.manualRunsTextController.text)));
        final targetOver = ref.read(reviseTargetStateProvider
            .select((value) => int.parse(value.manualOverTextController.text)));
        context.pop({'run': targetRun, 'over': targetOver});
      }
    });
  }
}
