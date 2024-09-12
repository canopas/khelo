import 'package:canopas_country_picker/canopas_country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/country_code_view.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';

import 'confirm_number_view_model.dart';

class ConfirmNumberSheet extends ConsumerStatefulWidget {
  final CountryCode? code;
  final String? defaultNumber;

  static Future<T?> show<T>(
    BuildContext context, {
    CountryCode? code,
    String? defaultNumber,
  }) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      showDragHandle: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return ConfirmNumberSheet(
          code: code,
          defaultNumber: defaultNumber,
        );
      },
    );
  }

  const ConfirmNumberSheet({
    super.key,
    this.code,
    this.defaultNumber,
  });

  @override
  ConsumerState createState() => _ConfirmNumberSheetState();
}

class _ConfirmNumberSheetState extends ConsumerState<ConfirmNumberSheet> {
  late ConfirmNumberViewNotifier notifier;

  @override
  void initState() {
    notifier = ref.read(confirmNumberStateProvider.notifier);
    runPostFrame(() => notifier.setDate(widget.code, widget.defaultNumber));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(confirmNumberStateProvider);

    _observeIsPop(state);

    return Container(
      padding: context.mediaQueryPadding +
          const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.confirm_number_confirm_phone_title,
              style: AppTextStyle.header3
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            _phoneInputField(context, state),
            PrimaryButton(
              context.l10n.confirm_number_confirm_title,
              onPressed: notifier.onConfirmTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _phoneInputField(
    BuildContext context,
    ConfirmNumberViewState state,
  ) {
    return MediaQuery.withNoTextScaling(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CountryCodeView(
              countryCode: state.code,
              onCodeChange: notifier.onCodeChange,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTextField(
                controller: state.phoneController,
                autoFocus: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                style: AppTextStyle.header2.copyWith(
                  color: context.colorScheme.textSecondary,
                ),
                hintStyle: AppTextStyle.header2.copyWith(
                  color: context.colorScheme.outline,
                ),
                hintText: context.l10n.sign_in_phone_number_placeholder,
                backgroundColor: context.colorScheme.containerLowOnSurface,
                borderRadius: BorderRadius.circular(40),
                borderType: AppTextFieldBorderType.outline,
                borderColor: BorderColor(
                    focusColor: Colors.transparent,
                    unFocusColor: Colors.transparent),
                prefixIcon: _inputFieldPrefix(context, state),
                prefixIconConstraints: const BoxConstraints.tightFor(),
                onChanged: (_) => notifier.onTextChange(),
                onSubmitted: (_) => notifier.onConfirmTap(),
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputFieldPrefix(
    BuildContext context,
    ConfirmNumberViewState state,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              state.code.dialCode,
              style: AppTextStyle.header2
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            VerticalDivider(
              width: 24,
              color: context.colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }

  void _observeIsPop(ConfirmNumberViewState state) {
    ref.listen(confirmNumberStateProvider.select((value) => value.isPop),
        (previous, next) {
      if (next == true && context.mounted) {
        String number = state.phoneController.text;
        context.pop((state.code, number));
      }
    });
  }
}
