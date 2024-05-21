import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/intro_gradient_background.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
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
        return IntroGradientBackground(
          child: Padding(
            padding: context.mediaQueryPadding +
                const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.intro_get_start_text,
                      style: AppTextStyle.header1
                          .copyWith(color: context.colorScheme.textPrimary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      context.l10n.intro_description_text,
                      style: AppTextStyle.body1
                          .copyWith(color: context.colorScheme.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    PrimaryButton(
                      context.l10n.intro_register_btn_text,
                      onPressed: () => AppRoute.phoneLogin.pushReplacement(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
