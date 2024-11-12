import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style/extensions/context_extensions.dart';

import '../gen/assets.gen.dart';

class TournamentBadge extends StatelessWidget {
  const TournamentBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(Assets.images.icTournaments,
          height: 16,
          width: 16,
          colorFilter: ColorFilter.mode(
            context.colorScheme.onPrimary,
            BlendMode.srcATop,
          )),
    );
  }
}
