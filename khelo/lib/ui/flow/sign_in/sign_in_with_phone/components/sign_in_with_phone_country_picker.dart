import 'package:canopas_country_picker/canopas_country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../sign_in_with_phone_view_model.dart';

class SignInWithPhoneCountryPicker extends ConsumerWidget {
  const SignInWithPhoneCountryPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(signInWithPhoneStateProvider.notifier);
    final countryCode = ref.watch(
      signInWithPhoneStateProvider.select((value) => value.code),
    );

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () async {
              final countryCode = await showCountryCodePickerSheet(
                customizationBuilders: CustomizationBuilders(
                  textFieldBuilder: (filter) =>
                      DefaultCountryCodeFilterTextField(
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: context.colorScheme.textPrimary,
                      size: 22,
                    ),
                    fillColor: context.colorScheme.containerLow,
                    style: AppTextStyle.body1
                        .copyWith(color: context.colorScheme.textPrimary),
                    hintStyle: AppTextStyle.body1
                        .copyWith(color: context.colorScheme.textDisabled),
                    filter: filter,
                  ),
                  codeBuilder: (code) => GestureDetector(
                    onTap: () => context.pop(code),
                    child: DefaultCountryCodeListItemView(
                      code: code,
                      dialCodeStyle: AppTextStyle.body1
                          .copyWith(color: context.colorScheme.textPrimary),
                      nameStyle: AppTextStyle.body1
                          .copyWith(color: context.colorScheme.textPrimary),
                    ),
                  ),
                  backgroundColor: () => context.colorScheme.surface,
                ),
                context: context,
              );
              if (countryCode != null) {
                notifier.changeCountryCode(countryCode);
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  countryCode.dialCode,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 24,
                    color: context.colorScheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
          width: 1,
        ),
      ],
    );
  }
}
