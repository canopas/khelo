import 'package:flutter/material.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/flow/matches/add_match/add_match_view_model.dart';
import 'package:khelo/ui/flow/matches/add_match/components/section_title.dart';
import 'package:style/button/chip_button.dart';
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
                    .map((type) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChipButton(
                            title: type.getString(context),
                            isSelected: state.pitchType == type,
                            onTap: () => notifier.onPitchTypeSelection(type),
                          ),
                        ))
                    .toList(),
              )),
        ],
      ),
    );
  }
}
