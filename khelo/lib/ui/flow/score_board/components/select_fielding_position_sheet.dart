import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/ground_layout_view.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/button/toggle_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class SelectFieldingPositionSheet extends StatefulWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    required bool showForLessRun,
    required bool showForDotBall,
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
        return SelectFieldingPositionSheet(
          showForDotBall: showForDotBall,
          showForLessRun: showForLessRun,
        );
      },
    );
  }

  final bool showForLessRun;
  final bool showForDotBall;

  const SelectFieldingPositionSheet({
    super.key,
    required this.showForLessRun,
    required this.showForDotBall,
  });

  @override
  State<SelectFieldingPositionSheet> createState() =>
      _SelectFieldingPositionSheetState();
}

class _SelectFieldingPositionSheetState
    extends State<SelectFieldingPositionSheet> {
  late bool showForLessRun;
  late bool showForDotBall;
  FieldingPositionType? fieldingPosition;

  @override
  void initState() {
    super.initState();
    showForDotBall = widget.showForDotBall;
    showForLessRun = widget.showForLessRun;
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(content: _content(context), action: [
      PrimaryButton(
        context.l10n.common_select_title,
        enabled: fieldingPosition != null,
        onPressed: () =>
            context.pop((fieldingPosition, showForLessRun, showForDotBall)),
      ),
    ]);
  }

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.score_board_select_fielding_position_title,
          style: AppTextStyle.header3
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(height: 24),
        Center(
          child: GroundLayoutView(
            onPositionSelect: (position) =>
                setState(() => fieldingPosition = position.type),
          ),
        ),
        const SizedBox(height: 24),
        ToggleButtonTile(
          title: context.l10n.score_board_show_wheel_for_less_run_title,
          defaultEnabled: showForLessRun,
          onTap: (show) => showForLessRun = show,
        ),
        const SizedBox(height: 8),
        ToggleButtonTile(
          title: context.l10n.score_board_show_wheel_for_dot_ball_title,
          defaultEnabled: showForDotBall,
          onTap: (show) => showForDotBall = show,
        ),
      ],
    );
  }
}
