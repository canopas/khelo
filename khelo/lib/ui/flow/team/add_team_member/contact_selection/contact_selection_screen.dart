import 'dart:typed_data';

import 'package:canopas_country_picker/canopas_country_picker.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/team/add_team_member/confirm_number_sheet/confirm_number_sheet.dart';
import 'package:khelo/ui/flow/team/add_team_member/contact_selection/contact_selection_view_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/secondary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../components/error_snackbar.dart';

class ContactSelectionScreen extends ConsumerStatefulWidget {
  final List<String> memberIds;

  const ContactSelectionScreen({super.key, required this.memberIds});

  @override
  ConsumerState createState() => _ContactSelectionScreenState();
}

class _ContactSelectionScreenState
    extends ConsumerState<ContactSelectionScreen> {
  late ContactSelectionViewNotifier notifier;

  @override
  void initState() {
    notifier = ref.read(contactSelectionStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.memberIds));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(contactSelectionStateProvider);

    _observeActionError();
    _observeAlreadyAdded();
    _observeSelectedUser();

    return AppPage(
      title: context.l10n.contact_selection_contact_title,
      actions: [
        (state.isActionInProgress)
            ? const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: AppProgressIndicator(
                  size: AppProgressIndicatorSize.small,
                ),
              )
            : actionButton(
                context,
                icon: Icon(
                  Icons.add,
                  color: context.colorScheme.textPrimary,
                ),
                onPressed: () async {
                  final confirmedNumber = await ConfirmNumberSheet.show<
                      (String, CountryCode, String)>(
                    context,
                    code: CountryCode.getCountryCodeByAlpha2(
                      countryAlpha2Code: state.deviceCountryCode,
                    ),
                    isForCreateUser: true,
                  );
                  if (context.mounted && confirmedNumber != null) {
                    notifier.getUserByPhoneNumber(
                      confirmedNumber.$1,
                      "${confirmedNumber.$2.dialCode} ${confirmedNumber.$3}",
                    );
                  }
                },
              ),
      ],
      body: Builder(
          builder: (context) => Padding(
                padding: context.mediaQueryPadding,
                child: _body(context, state),
              )),
    );
  }

  Widget _body(BuildContext context, ContactSelectionState state) {
    if (state.loading) {
      return const Center(
        child: AppProgressIndicator(),
      );
    }

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.fetchContacts,
      );
    }
    if (state.contacts.isEmpty && state.hasContactPermission) {
      return EmptyScreen(
        title: context.l10n.contact_selection_empty_contact,
        description: context.l10n.contact_selection_empty_contact_description,
        isShowButton: false,
      );
    }

    if (!state.hasContactPermission) {
      return EmptyScreen(
        title: context.l10n.contact_selection_access_permission,
        description:
            context.l10n.contact_selection_access_permission_description,
        buttonTitle: context.l10n.contact_selection_allow_title,
        onTap: () => _requestContactPermission(context),
      );
    }

    return ListView.separated(
      itemCount: state.contacts.length,
      separatorBuilder: (context, index) => Divider(
        color: context.colorScheme.outline,
        height: 32,
      ),
      itemBuilder: (context, index) {
        final contact = state.contacts.elementAt(index);
        return _contactCellView(context, state.isActionInProgress, contact);
      },
    );
  }

  Widget _contactCellView(
    BuildContext context,
    bool isActionInProgress,
    Contact contact,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _profileImageView(context, contact.avatar,
              contact.displayName?.characters.firstOrNull),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              contact.displayName ?? '',
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ),
          const SizedBox(width: 4),
          SecondaryButton(
            context.l10n.common_add_title,
            enabled: contact.phones != null &&
                contact.phones!.isNotEmpty &&
                !isActionInProgress,
            onPressed: () async {
              if (contact.phones == null || contact.phones!.isEmpty) {
                return;
              }
              if ((contact.phones?.length ?? 0) > 1) {
                _showSelectNumberDialog(context, contact);
              } else {
                final firstNumber = contact.phones?.first.value;
                if (firstNumber != null && firstNumber.isNotEmpty) {
                  showConfirmNumberSheet(
                      context, contact.displayName, firstNumber);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showSelectNumberDialog(
    BuildContext context,
    Contact contact,
  ) async {
    final number = await showAdaptiveDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog.adaptive(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: contact.phones?.map((e) {
                  final showDivider = contact.phones?.lastOrNull != e;
                  if (e.value == null || e.value!.isEmpty) {
                    return const SizedBox();
                  }
                  return OnTapScale(
                    onTap: () => context.pop(e.value),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.value ?? '',
                          style: AppTextStyle.subtitle3
                              .copyWith(color: context.colorScheme.textPrimary),
                        ),
                        if (showDivider)
                          Divider(
                            height: 36,
                            color: context.colorScheme.outline,
                          ),
                      ],
                    ),
                  );
                }).toList() ??
                [],
          ),
        ),
      ),
    );

    if (context.mounted && number != null) {
      showConfirmNumberSheet(context, contact.displayName, number);
    }
  }

  Future<void> showConfirmNumberSheet(
    BuildContext context,
    String? displayName,
    String phoneNumber,
  ) async {
    final (code, number) = notifier.getNormalisedNumber(phoneNumber);
    final confirmedNumber =
        await ConfirmNumberSheet.show<(String, CountryCode, String)>(
      context,
      code: code,
      defaultNumber: number,
    );
    if (context.mounted && confirmedNumber != null) {
      notifier.getUserByPhoneNumber(
        displayName,
        "${confirmedNumber.$2.dialCode} ${confirmedNumber.$3}",
      );
    }
  }

  Widget _profileImageView(
    BuildContext context,
    Uint8List? image,
    String? initial,
  ) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.containerHigh,
          image: image != null && image.isNotEmpty
              ? DecorationImage(
                  image: MemoryImage(image),
                )
              : null),
      child: image != null && image.isNotEmpty
          ? null
          : Text(
              initial ?? '?',
              textScaler: TextScaler.noScaling,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
    );
  }

  Future<void> _requestContactPermission(
    BuildContext context,
  ) async {
    final PermissionStatus status = await Permission.contacts.status;

    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
      return;
    }

    if (status == PermissionStatus.denied) {
      await Permission.contacts.request();
      if (!context.mounted) return;
    }

    notifier.checkContactPermission(requestIfNotGranted: false);
  }

  void _observeActionError() {
    ref.listen(
        contactSelectionStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  void _observeAlreadyAdded() {
    ref.listen(
        contactSelectionStateProvider.select((value) => value.alreadyAdded),
        (previous, next) {
      if (next == true && context.mounted) {
        showErrorSnackBar(
          context: context,
          error: context.l10n.add_team_member_already_added,
        );
      }
    });
  }

  void _observeSelectedUser() {
    ref.listen(
        contactSelectionStateProvider.select((value) => value.selectedUser),
        (previous, next) {
      if (next != null && context.mounted) {
        context.pop(next);
      }
    });
  }
}
