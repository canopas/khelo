import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class SelectWicketTypeSheet extends ConsumerStatefulWidget {
  static Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
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

    return Padding(
      padding: context.mediaQueryPadding +
          const EdgeInsets.symmetric(
            horizontal: 16,
          ),
      child: SizedBox(
        height: context.mediaQuerySize.height * 0.8,
        child: _body(context, state),
      ),
    );
  }

  Widget _body(BuildContext context, ScoreBoardViewState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.score_board_select_wicket_type_title,
                style: AppTextStyle.subtitle1.copyWith(
                    color: context.colorScheme.textPrimary, fontSize: 24),
              ),
              IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.close)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              _typeList(context, state),
              const SizedBox(height: 40),
              PrimaryButton(
                context.l10n.common_okay_title,
                onPressed: () => context.pop(selectedType),
                enabled: selectedType != null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _typeList(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    const filters = WicketType.values;
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      children: filters.map(
        (element) {
          final isSelected = selectedType == element;
          return OnTapScale(
            onTap: () {
              setState(() {
                selectedType = element;
              });
            },
            child: Chip(
              label: Text(
                element.getString(context),
                style: AppTextStyle.body2.copyWith(
                  color: isSelected
                      ? context.colorScheme.onPrimary
                      : context.colorScheme.textPrimary,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              side: BorderSide(
                color: isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.outline,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.surface,
            ),
          );
        },
      ).toList(),
    );
  }
}
