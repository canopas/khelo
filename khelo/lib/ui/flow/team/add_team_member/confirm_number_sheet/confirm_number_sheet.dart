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
  final bool isForCreateUser;

  static Future<T?> show<T>(
    BuildContext context, {
    CountryCode? code,
    String? defaultNumber,
    bool isForCreateUser = false,
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
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ConfirmNumberSheet(
            code: code,
            defaultNumber: defaultNumber,
            isForCreateUser: isForCreateUser,
          ),
        );
      },
    );
  }

  const ConfirmNumberSheet({
    super.key,
    this.code,
    this.defaultNumber,
    this.isForCreateUser = false,
  });

  @override
  ConsumerState createState() => _ConfirmNumberSheetState();
}

class _ConfirmNumberSheetState extends ConsumerState<ConfirmNumberSheet> {
  late ConfirmNumberViewNotifier notifier;

  @override
  void initState() {
    notifier = ref.read(confirmNumberStateProvider.notifier);
    runPostFrame(() => notifier.setData(
        widget.code, widget.defaultNumber, widget.isForCreateUser));
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
              state.isForCreateUser
                  ? context.l10n.confirm_number_add_user_manually_title
                  : context.l10n.confirm_number_confirm_phone_title,
              style: AppTextStyle.header3
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            const SizedBox(height: 24),
            if (state.isForCreateUser) ...[
              AppTextField(
                controller: state.nameController,
                autoFocus: true,
                style: AppTextStyle.subtitle3.copyWith(
                  color: context.colorScheme.textPrimary,
                ),
                hintStyle: AppTextStyle.subtitle3.copyWith(
                  color: context.colorScheme.textDisabled,
                ),
                hintText: context.l10n.confirm_number_name_title,
                backgroundColor: context.colorScheme.containerLowOnSurface,
                borderRadius: BorderRadius.circular(30),
                borderType: AppTextFieldBorderType.outline,
                borderColor: BorderColor(
                    focusColor: Colors.transparent,
                    unFocusColor: Colors.transparent),
                onChanged: (_) => notifier.onTextChange(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
              ),
              const SizedBox(height: 24),
            ],
            _phoneInputField(context, state),
            const SizedBox(height: 40),
            PrimaryButton(
              context.l10n.confirm_number_confirm_title,
              enabled: state.isButtonEnable,
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
        String name = state.nameController.text;
        String number = state.phoneController.text;
        context.pop((name, state.code, number));
      }
    });
  }
}
