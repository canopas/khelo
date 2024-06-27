import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class SelectWicketTypeSheet extends ConsumerStatefulWidget {
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
        return const SelectWicketTypeSheet();
      },
    );
  }

  const SelectWicketTypeSheet({super.key});

  @override
  ConsumerState createState() => _SelectWicketTypeSheetState();
}

class _SelectWicketTypeSheetState extends ConsumerState<SelectWicketTypeSheet> {
  WicketType? selectedType;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scoreBoardStateProvider);

    return BottomSheetWrapper(
      content: _typeList(context, state),
      action: [
        PrimaryButton(
          context.l10n.common_okay_title,
          enabled: selectedType != null,
          onPressed: () => context.pop(selectedType),
        )
      ],
    );
  }

  Widget _typeList(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children: WicketType.values.map(
        (element) {
          final isSelected = selectedType == element;
          return OnTapScale(
            onTap: () => setState(() => selectedType = element),
            child: Chip(
              label: Text(
                element.getString(context),
                style: AppTextStyle.body2.copyWith(
                  color: isSelected
                      ? context.colorScheme.onPrimary
                      : context.colorScheme.textSecondary,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              side: const BorderSide(color: Colors.transparent),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.containerLowOnSurface,
            ),
          );
        },
      ).toList(),
    );
  }
}
