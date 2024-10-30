import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:khelo/ui/flow/matches/add_match/add_match_view_model.dart';
import 'package:khelo/ui/flow/matches/add_match/components/section_title.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class BallSelectionView extends StatelessWidget {
  final AddMatchViewNotifier notifier;
  final AddMatchViewState state;

  const BallSelectionView({
    super.key,
    required this.notifier,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: context.l10n.add_match_ball_type_title),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            child: Row(
                children: BallType.values
                    .map((type) => _ballTypeCell(
                          context: context,
                          title: type.getString(context),
                          image: _getBallTypeImage(context, type),
                          isSelected: state.ballType == type,
                          onTap: () => notifier.onBallTypeSelection(type),
                        ))
                    .toList())),
      ],
    );
  }

  Widget _ballTypeCell({
    required BuildContext context,
    required String title,
    required String image,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return OnTapScale(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        margin: const EdgeInsets.only(right: 16),
        constraints: const BoxConstraints(minWidth: 121),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outline),
          borderRadius: BorderRadius.circular(16),
          color: isSelected
              ? context.colorScheme.containerLowOnSurface
              : Colors.transparent,
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              image,
              height: 40,
              width: 40,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyle.subtitle3
                  .copyWith(color: context.colorScheme.textPrimary),
            )
          ],
        ),
      ),
    );
  }

  String _getBallTypeImage(BuildContext context, BallType type) {
    switch (type) {
      case BallType.leather:
        return Assets.images.leatherBall;
      case BallType.tennis:
        return Assets.images.tennisBall;
      case BallType.other:
        return Assets.images.otherBall;
    }
  }
}
