import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/widgets/rounded_check_box.dart';

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
  ReviseTargetOption _selectedOption = ReviseTargetOption.builtInDLS;
  final ExpansionTileController controller = ExpansionTileController();
  bool isButtonEnabled = false;

  TextEditingController dlsOverTextController = TextEditingController();
  TextEditingController manualOverTextController = TextEditingController();
  TextEditingController manualRunsTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(
      content: _content(context),
      action: [
        PrimaryButton(
          context.l10n.score_board_confirm_target_text,
          enabled: isButtonEnabled,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.score_board_revised_target_title,
          style: AppTextStyle.header3
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        ...ReviseTargetOption.values.map((option) => _checkBoxExpansionTile(
              context,
              isSelected: _selectedOption == option,
              title: option.getTitle(context),
              children: option == ReviseTargetOption.builtInDLS
                  ? builtInDLSWidgets(context)
                  : manualTargetWidgets(context),
              onExpansionChange: () {
                setState(() {
                  _selectedOption = option;
                });
              },
            )),
      ],
    );
  }

  Widget _titleView(BuildContext context, String text) {
    return Text(
      text,
      style: AppTextStyle.subtitle3
          .copyWith(color: context.colorScheme.textPrimary),
    );
  }

  Widget _subTitleView(BuildContext context, String text) {
    return Text(
      text,
      style:
          AppTextStyle.body1.copyWith(color: context.colorScheme.textPrimary),
    );
  }

  List<Widget> builtInDLSWidgets(
    BuildContext context,
  ) {
    return [
      _titleView(
          context, context.l10n.score_board_enter_lost_over_description_text),
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: _textField(
              context,
              controller: dlsOverTextController,
              onTextChange: () => setState(() {}),
              autoFocus: _selectedOption == ReviseTargetOption.builtInDLS,
            ),
          ),
          const SizedBox(width: 8),
          actionButton(
            context,
            onPressed: () {},
            icon: SvgPicture.asset(
              Assets.images.icCheck,
              height: 24,
              width: 24,
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                  dlsOverTextController.text.isNotEmpty
                      ? context.colorScheme.secondary
                      : context.colorScheme.textDisabled,
                  BlendMode.srcIn),
            ),
          )
        ],
      ),
      const SizedBox(height: 16),
      Text(
        context.l10n.score_board_revised_target_summary_text(170, 12),
        style:
            AppTextStyle.subtitle1.copyWith(color: context.colorScheme.primary),
      )
    ];
  }

  Widget _textField(
    BuildContext context, {
    required TextEditingController controller,
    required VoidCallback onTextChange,
    bool autoFocus = false,
  }) {
    return AppTextField(
      controller: controller,
      onChanged: (_) => onTextChange(),
      autoFocus: autoFocus,
      borderType: AppTextFieldBorderType.outline,
      borderRadius: BorderRadius.circular(8),
      backgroundColor: context.colorScheme.surface,
      inputFormatters: TextValidationType.numberOnly,
      borderColor: BorderColor(
        focusColor: Colors.transparent,
        unFocusColor: Colors.transparent,
      ),
    );
  }

  _checkIfValidInput() {
    bool isValid = false;
    if (_selectedOption == ReviseTargetOption.builtInDLS) {
      isValid = dlsOverTextController.text
          .trim()
          .isNotEmpty; // && is not greater than total over's of team
      // TODO: check calculated revised target not user input
    } else {
      isValid = manualOverTextController.text.trim().isNotEmpty &&
          manualRunsTextController.text.trim().isNotEmpty;
    }
    setState(() {
      isButtonEnabled = isValid;
    });
  }

  List<Widget> manualTargetWidgets(
    BuildContext context,
  ) {
    return [
      _titleView(context,
          context.l10n.score_board_enter_manual_target_description_text),
      const SizedBox(height: 16),
      Row(
        children: [
          IntrinsicWidth(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 70),
              child: _textField(
                context,
                controller: manualRunsTextController,
                onTextChange: _checkIfValidInput,
              ),
            ),
          ),
          const SizedBox(width: 16),
          _subTitleView(context, context.l10n.score_board_runs_in_text)
        ],
      ),
      Row(
        children: [
          IntrinsicWidth(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 70),
              child: _textField(
                context,
                controller: manualOverTextController,
                onTextChange: _checkIfValidInput,
              ),
            ),
          ),
          const SizedBox(width: 16),
          _subTitleView(context, context.l10n.score_board_overs_text)
        ],
      )
    ];
  }

  Widget _checkBoxExpansionTile(
    BuildContext context, {
    required String title,
    required List<Widget> children,
    required bool isSelected,
    required Function() onExpansionChange,
  }) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: CustomExpansionTile(
        onTap: () => onExpansionChange(),
        title: title,
        isExpanded: isSelected,
        leading: RoundedCheckBox(
          isSelected: isSelected,
          onTap: (p0) {},
        ),
        child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 36, bottom: 24),
            decoration: BoxDecoration(
              color: context.colorScheme.containerLow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            )),
      ),
    );
  }
}

class CustomExpansionTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? trailing;
  final Widget child;
  final bool isExpanded;
  final VoidCallback onTap;

  const CustomExpansionTile({
    super.key,
    this.leading,
    this.title = "",
    this.trailing,
    required this.child,
    this.isExpanded = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OnTapScale(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: 16),
                ],
                Text(
                  title,
                  style: AppTextStyle.subtitle1
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: 16),
                  trailing!,
                ],
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(height: 0),
          secondChild: child,
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
