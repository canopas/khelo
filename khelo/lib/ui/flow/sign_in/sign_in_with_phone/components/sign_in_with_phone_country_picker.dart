import 'package:canopas_country_picker/canopas_country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';
import 'package:twemoji_v2/twemoji_v2.dart';

import '../sign_in_with_phone_view_model.dart';

class SignInWithPhoneCountryPicker extends ConsumerWidget {
  const SignInWithPhoneCountryPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(signInWithPhoneStateProvider.notifier);
    final countryCode = ref.watch(
      signInWithPhoneStateProvider.select((value) => value.code),
    );

    return OnTapScale(
      onTap: () => _showCountryPickerSheet(context, notifier),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
            color: context.colorScheme.containerLow,
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            ClipPath(
              clipper: const _FlagClipper(12),
              child: Twemoji(
                emoji: countryCode.flag,
                height: 35,
                twemojiFormat: TwemojiFormat.svg,
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              Assets.images.icArrowDown,
              colorFilter: ColorFilter.mode(
                  context.colorScheme.textPrimary, BlendMode.srcATop),
              height: 18,
              width: 18,
            )
          ],
        ),
      ),
    );
  }

  void _showCountryPickerSheet(
      BuildContext context, SignInWithPhoneViewNotifier notifier) async {
    final countryCode = await showCountryCodePickerSheet(
      customizationBuilders: _getCustomizationBuilder(context),
      context: context,
    );
    if (countryCode != null) {
      notifier.changeCountryCode(countryCode);
    }
  }

  CustomizationBuilders _getCustomizationBuilder(BuildContext context) {
    return CustomizationBuilders(
      backgroundColor: () => context.colorScheme.surface,
      textFieldBuilder: (filter) => DefaultCountryCodeFilterTextField(
        filter: filter,
        fillColor: context.colorScheme.containerLow,
        prefixIcon: Icon(
          CupertinoIcons.search,
          color: context.colorScheme.textSecondary,
          size: 22,
        ),
        style: AppTextStyle.body1.copyWith(
          color: context.colorScheme.textPrimary,
        ),
        hintStyle: AppTextStyle.body1.copyWith(
          color: context.colorScheme.textSecondary,
        ),
      ),
      codeBuilder: (code) => GestureDetector(
        onTap: () => context.pop(code),
        child: DefaultCountryCodeListItemView(
          code: code,
          dialCodeStyle: AppTextStyle.body1.copyWith(
            color: context.colorScheme.textPrimary,
          ),
          nameStyle: AppTextStyle.body1.copyWith(
            color: context.colorScheme.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _FlagClipper extends CustomClipper<Path> {
  const _FlagClipper(this.radius);

  final double radius;

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);

    path.addOval(Rect.fromCircle(center: center, radius: radius));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
