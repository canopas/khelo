import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/components/action_bottom_sheet.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/confirmation_dialog.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/components/profile_image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/settings/edit_profile/component/transfer_teams_sheet.dart';
import 'package:khelo/ui/flow/settings/edit_profile/edit_profile_view_model.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/pickers/date_and_time_picker.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/widgets/adaptive_outlined_tile.dart';

import '../../../../components/image_picker_sheet.dart';

class EditProfileScreen extends ConsumerWidget {
  final bool isToCreateAccount;

  const EditProfileScreen({super.key, required this.isToCreateAccount});

  final double profileViewHeight = 128;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(editProfileStateProvider.notifier);
    final state = ref.watch(editProfileStateProvider);

    _observeActionError(context, ref);
    _observeIsSaved(context, ref);
    _observeShowDeleteConfirmationDialog(context, ref, notifier.onDeleteTap);
    _observeShowTransferTeamsSheet(context, ref);

    return AppPage(
      title: isToCreateAccount
          ? context.l10n.edit_profile_create_profile_screen_title
          : context.l10n.edit_profile_screen_title,
      actions: [
        actionButton(context,
            onPressed: (state.isButtonEnable && !state.isImageUploading)
                ? () => notifier.onSubmitTap()
                : null,
            icon: SvgPicture.asset(
              Assets.images.icCheck,
              height: 24,
              width: 24,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                  state.isButtonEnable && !state.isImageUploading
                      ? context.colorScheme.textPrimary
                      : context.colorScheme.textDisabled,
                  BlendMode.srcIn),
            )),
      ],
      body: Builder(
        builder: (context) {
          return Padding(
            padding: context.mediaQueryPadding,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                ProfileImageAvatar(
                    size: profileViewHeight,
                    placeHolderImage: Assets.images.icProfileThin,
                    imageUrl: state.imageUrl,
                    filePath: state.filePath,
                    isLoading: state.isImageUploading,
                    onEditButtonTap: () async {
                      final imagePath = await ImagePickerSheet.show<String>(
                        context,
                        allowCrop: true,
                      );
                      if (imagePath != null) {
                        notifier.onImageChange(imagePath);
                      }
                    }),
                const SizedBox(height: 24),
                _userContactDetailsView(context, notifier, state),
                const SizedBox(height: 24),
                _userPersonalDetailsView(context, notifier, state),
                const SizedBox(height: 24),
                _userPlayStyleView(context, notifier, state),
                const SizedBox(height: 24),
                if (!isToCreateAccount) ...[
                  _deleteButton(
                    context,
                    onDelete: notifier.checkUserOwnershipAndShowDialog,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      context.l10n.edit_profile_delete_account_description_text,
                      style: AppTextStyle.body2.copyWith(
                        color: context.colorScheme.textDisabled,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _userContactDetailsView(
    BuildContext context,
    EditProfileViewNotifier notifier,
    EditProfileState state,
  ) {
    return Column(
      children: [
        _textInputField(context, notifier,
            placeholderText: context.l10n.edit_profile_name_placeholder,
            controller: state.nameController),
        const SizedBox(height: 8),
        _textInputField(context, notifier,
            placeholderText: context.l10n.edit_profile_email_placeholder,
            controller: state.emailController,
            keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 8),
        _textInputField(context, notifier,
            placeholderText: context.l10n.common_location_title,
            controller: state.locationController),
      ],
    );
  }

  Widget _textInputField(
    BuildContext context,
    EditProfileViewNotifier notifier, {
    required String placeholderText,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return AppTextField(
      controller: controller,
      onChanged: (value) => notifier.onValueChange(),
      keyboardType: keyboardType,
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

  Widget _userPersonalDetailsView(
    BuildContext context,
    EditProfileViewNotifier notifier,
    EditProfileState state,
  ) {
    return Row(
      children: [
        Expanded(
          child: AdaptiveOutlinedTile(
            headerText: context.l10n.edit_profile_dob_placeholder,
            title: state.dob.format(context, DateFormatType.shortDate),
            showTrailingIcon: true,
            placeholder: context.l10n.edit_profile_dob_placeholder,
            onTap: () => selectDate(
              context,
              helpText: context.l10n.edit_profile_select_birth_date_placeholder,
              initialDate: state.dob,
              startDate: DateTime(1950),
              endDate: DateTime.now(),
              onDateSelected: (date) {
                if (date != state.dob) {
                  notifier.onDateSelect(selectedDate: date);
                }
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AdaptiveOutlinedTile(
            headerText: context.l10n.common_gender_title,
            title: state.gender?.getString(context),
            placeholder: context.l10n.common_gender_title,
            onTap: () {
              showActionBottomSheet(
                  context: context,
                  items: [UserGender.male, UserGender.female, UserGender.other]
                      .map((gender) => BottomSheetAction(
                            title: gender.getString(context),
                            child: showCheckMark(
                              context,
                              showCheck: state.gender == gender,
                            ),
                            onTap: () {
                              context.pop();
                              notifier.onGenderSelect(gender: gender);
                            },
                          ))
                      .toList());
            },
          ),
        ),
      ],
    );
  }

  Widget _userPlayStyleView(
    BuildContext context,
    EditProfileViewNotifier notifier,
    EditProfileState state,
  ) {
    return Column(
      children: [
        AdaptiveOutlinedTile(
          title: state.playerRole?.getString(context),
          placeholder: context.l10n.edit_profile_player_role_placeholder,
          showTrailingIcon: true,
          onTap: () {
            showActionBottomSheet(
                context: context,
                items: PlayerRole.values
                    .map((role) => BottomSheetAction(
                        title: role.getString(context),
                        child: showCheckMark(
                          context,
                          showCheck: state.playerRole == role,
                        ),
                        onTap: () {
                          context.pop();
                          notifier.onPlayerRoleChange(role);
                        }))
                    .toList());
          },
        ),
        const SizedBox(height: 24),
        AdaptiveOutlinedTile(
          title: state.battingStyle?.getString(context),
          placeholder: context.l10n.common_batting_style_title,
          showTrailingIcon: true,
          onTap: () {
            showActionBottomSheet(
                context: context,
                items: BattingStyle.values
                    .map((style) => BottomSheetAction(
                        title: style.getString(context),
                        child: showCheckMark(
                          context,
                          showCheck: state.battingStyle == style,
                        ),
                        onTap: () {
                          context.pop();
                          notifier.onBattingStyleChange(style);
                        }))
                    .toList());
          },
        ),
        const SizedBox(height: 24),
        AdaptiveOutlinedTile(
          title: state.bowlingStyle?.getString(context),
          placeholder: context.l10n.common_bowling_style_title,
          showTrailingIcon: true,
          onTap: () {
            showActionBottomSheet(
                context: context,
                items: BowlingStyle.values
                    .map((style) => BottomSheetAction(
                        title: style.getString(context),
                        child: showCheckMark(
                          context,
                          showCheck: state.bowlingStyle == style,
                        ),
                        onTap: () {
                          context.pop();
                          notifier.onBowlingStyleChange(style);
                        }))
                    .toList());
          },
        ),
      ],
    );
  }

  Widget? showCheckMark(
    BuildContext context, {
    required bool showCheck,
  }) {
    return showCheck
        ? SvgPicture.asset(
            Assets.images.icCheck,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
              context.colorScheme.primary,
              BlendMode.srcATop,
            ),
          )
        : null;
  }

  Widget _deleteButton(
    BuildContext context, {
    required VoidCallback onDelete,
  }) {
    return PrimaryButton(
      onPressed: onDelete,
      context.l10n.edit_profile_delete_account_btn_title,
      background: context.colorScheme.containerLow,
      foreground: context.colorScheme.alert,
    );
  }

  void _observeActionError(BuildContext context, WidgetRef ref) {
    ref.listen(editProfileStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  void _observeIsSaved(BuildContext context, WidgetRef ref) {
    ref.listen(editProfileStateProvider.select((state) => state.isSaved),
        (previous, next) {
      if (next) {
        if (isToCreateAccount) {
          AppRoute.main.go(context);
        } else {
          context.pop();
        }
      }
    });
  }

  void _observeShowDeleteConfirmationDialog(
    BuildContext context,
    WidgetRef ref,
    VoidCallback onDeleteTap,
  ) {
    ref.listen(
        editProfileStateProvider.select(
            (state) => state.showDeleteConfirmationDialog), (previous, next) {
      if (next) {
        showConfirmationDialog(
          context,
          title: context.l10n.common_delete_title,
          message: context.l10n.alert_confirm_default_message(
              context.l10n.common_delete_title.toLowerCase()),
          confirmBtnText: context.l10n.common_delete_title,
          onConfirm: onDeleteTap,
        );
      }
    });
  }

  void _observeShowTransferTeamsSheet(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen(
        editProfileStateProvider
            .select((state) => state.showTransferTeamsSheet), (previous, next) {
      if (next) {
        TransferTeamsSheet.show(
          context,
          onButtonTap: () {
            context.pop();
            context.pop(true);
          },
        );
      }
    });
  }
}
