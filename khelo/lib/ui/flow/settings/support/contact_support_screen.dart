import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/settings/support/contact_support_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';

import 'components/attachment_item.dart';

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

  void _errorObserve() {
    ref.listen(
      contactSupportStateNotifierProvider.select(
        (value) => value.actionError,
      ),
      (previous, next) {
        if (next != null) {
          showErrorSnackBar(context: context, error: next);
        }
      },
    );
  }

  void _popObserve() {
    ref.listen(
      contactSupportStateNotifierProvider.select(
        (value) => value.pop,
      ),
      (previous, next) {
        if (next) {
          context.pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(contactSupportStateNotifierProvider);
    _errorObserve();
    _popObserve();
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (!state.pop) return notifier.discardAttachments();
      },
      child: AppPage(
        title: context.l10n.contact_support_screen_title,
        body: Builder(builder: (context) {
          return _body(context, state);
        }),
      ),
    );
  }

  Widget _body(BuildContext context, ContactSupportViewState state) {
    return Padding(
      padding: context.mediaQueryPadding,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _textInputField(
            context,
            placeholderText:
                context.l10n.contact_support_title_placeholder_text,
            controller: state.titleController,
            onChanged: (value) => notifier.onValueChange(),
          ),
          const SizedBox(height: 16),
          _textInputField(
            context,
            placeholderText:
                context.l10n.contact_support_description_placeholder_text,
            controller: state.descriptionController,
            maxLines: 8,
          ),
          const SizedBox(height: 16),
          _attachmentButton(
            context: context,
            onAttachmentTap: notifier.pickAttachments,
          ),
          ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.attachments.length,
            itemBuilder: (context, index) => AttachmentItem(
              path: state.attachments[index].path,
              isLoading: state.attachments[index].uploadStatus.isUploading,
              onCancelTap: () => notifier.removeAttachment(index),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            enabled: !state.submitting && state.enableSubmit,
            progress: state.submitting,
            context.l10n.common_submit_title,
            onPressed: notifier.submitSupportCase,
          ),
        ],
      ),
    );
  }

  Widget _textInputField(
    BuildContext context, {
    required String placeholderText,
    required TextEditingController controller,
    Function(String)? onChanged,
    int? maxLines,
  }) {
    return AppTextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
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
            style: AppTextStyle.body2.copyWith(
              color: context.colorScheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
