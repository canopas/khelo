import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:style/extensions/context_extensions.dart';

class IntroGradientBackground extends StatelessWidget {
  final Widget? child;

  const IntroGradientBackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _gradientView(context),
        if (child != null) ...[child!]
      ],
    );
  }

  Widget _gradientView(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: MediaQuery.of(context).viewPadding,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          context.colorScheme.surface,
          context.colorScheme.surface,
          context.colorScheme.surface,
          context.colorScheme.primaryVariantOnSurface,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: SvgPicture.asset(
        context.colorScheme.themeMode == ThemeMode.dark
            ? Assets.images.introCricketDark
            : Assets.images.introCricketLight,
        fit: BoxFit.fitWidth,
        colorFilter: context.colorScheme.themeMode == ThemeMode.light
            ? ColorFilter.mode(
                context.colorScheme.primaryVariantOnSurface.withOpacity(0.8),
                BlendMode.srcATop)
            : null,
      ),
    );
  }
}
