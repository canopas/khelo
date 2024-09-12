import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/button/primary_button.dart';

import '../../app_route.dart';

class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen({super.key});

  @override
  ConsumerState createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      body: Builder(builder: (context) {
        return Stack(
          children: [
            ListView(
              padding: BottomStickyOverlay.padding +
                  EdgeInsets.only(top: context.mediaQueryPadding.top + 24),
              children: [
                SizedBox(
                  height: context.mediaQuerySize.height * 0.65,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 16.0 + context.mediaQueryPadding.right),
                    child: SvgPicture.asset(
                      context.brightness == Brightness.dark
                          ? Assets.images.introGraphicDark
                          : Assets.images.introGraphicLight,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0 + context.mediaQueryPadding.horizontal,
                      vertical: 34),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.intro_get_your_cricket_title,
                        style: AppTextStyle.header1
                            .copyWith(color: context.colorScheme.textPrimary),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        context.l10n.intro_get_your_cricket_description,
                        style: AppTextStyle.subtitle1
                            .copyWith(color: context.colorScheme.textDisabled),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
            BottomStickyOverlay(
              child: PrimaryButton(
                context.l10n.intro_continue_btn_text,
                onPressed: () => AppRoute.phoneLogin.push(context),
              ),
            ),
          ],
        );
      }),
    );
  }
}
