import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/flow/matches/add_match/add_match_view_model.dart';
import 'package:khelo/ui/flow/matches/add_match/components/section_title.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';
import 'package:data/api/match/match_model.dart';

class PitchSelectionView extends StatelessWidget {
  final AddMatchViewNotifier notifier;
  final AddMatchViewState state;

  const PitchSelectionView({
    super.key,
    required this.notifier,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: context.l10n.add_match_pitch_type_title),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                for (final value in PitchType.values) ...[
                  _capsuleCell(
                    context: context,
                    title: value.getString(context),
                    isSelected: state.pitchType == value,
                    onTap: () =>
                        notifier.onPitchTypeSelection(value),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ],
            )),
      ],
    );
  }

  Widget _capsuleCell({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required Function() onTap,
  }) {
    return OnTapScale(
      onTap: () => onTap(),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.containerLowOnSurface,
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          title,
          style: AppTextStyle.body2.copyWith(
              color: isSelected
                  ? context.colorScheme.onPrimary
                  : context.colorScheme.textDisabled),
        ),
      ),
    );
  }
}
