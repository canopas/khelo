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
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: context.l10n.add_match_pitch_type_title),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Row(
                children: PitchType.values
                    .map((type) => _capsuleCell(
                          context: context,
                          title: type.getString(context),
                          isSelected: state.pitchType == type,
                          onTap: () => notifier.onPitchTypeSelection(type),
                        ))
                    .toList(),
              )),
        ],
      ),
    );
  }

  Widget _capsuleCell({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: OnTapScale(
        onTap: () => onTap(),
        child: Chip(
          label: Text(
            title,
            style: AppTextStyle.body2.copyWith(
                color: isSelected
                    ? context.colorScheme.onPrimary
                    : context.colorScheme.textDisabled),
          ),
          backgroundColor: isSelected
              ? context.colorScheme.primary
              : context.colorScheme.containerLowOnSurface,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          side: const BorderSide(color: Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
