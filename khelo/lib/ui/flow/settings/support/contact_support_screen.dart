import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/settings/support/contact_support_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';

class ContactSupportScreen extends ConsumerStatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  ConsumerState<ContactSupportScreen> createState() =>
      _ContactSupportScreenState();
}

class _ContactSupportScreenState extends ConsumerState<ContactSupportScreen> {
  late ContactSupportViewStateNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(contactSupportStateNotifierProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: context.l10n.contact_support_title,
      body: Builder(builder: (context) {
        return _body(context);
      }),
    );
  }

  Widget _body(BuildContext context) {
    final state = ref.watch(contactSupportStateNotifierProvider);
    return ListView(
      padding: context.mediaQueryPadding + const EdgeInsets.all(16),
      children: [
        _textInputField(
          context,
          placeholderText: context.l10n.contact_support_title_text,
          controller: state.titleController,
        ),
        const SizedBox(height: 16),
        _textInputField(
          context,
          placeholderText: context.l10n.contact_support_description_title,
          controller: state.descriptionController,
          maxLines: 8,
        ),
        const SizedBox(height: 16),
        _attachmentButton(
          context: context,
          onAttachmentTap: () {},
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          context.l10n.common_submit_title,
          enabled: !state.submitting && state.enableSubmit,
          progress: state.submitting,
          onPressed: () {},
        )
      ],
    );
  }

  Widget _textInputField(
    BuildContext context, {
    required String placeholderText,
    required TextEditingController controller,
    int? maxLines,
  }) {
    return AppTextField(
      controller: controller,
      maxLines: maxLines,
      onChanged: (value) => notifier.onValueChange(),
      style: AppTextStyle.subtitle3
          .copyWith(color: context.colorScheme.textPrimary),
      borderRadius: BorderRadius.circular(12),
      borderType: AppTextFieldBorderType.outline,
      backgroundColor: context.colorScheme.containerLow,
      borderColor: BorderColor(
          focusColor: Colors.transparent, unFocusColor: Colors.transparent),
      hintText: placeholderText,
      hintStyle: AppTextStyle.subtitle3
          .copyWith(color: context.colorScheme.textDisabled),
    );
  }

  Widget _attachmentButton({
    required BuildContext context,
    required VoidCallback onAttachmentTap,
  }) {
    return OnTapScale(
      onTap: onAttachmentTap,
      child: Row(
        children: [
          Icon(
            CupertinoIcons.paperclip,
            color: context.colorScheme.textPrimary,
            size: 16,
          ),
          Text(
            context.l10n.contact_support_attachment,
            style: AppTextStyle.caption.copyWith(
              color: context.colorScheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
