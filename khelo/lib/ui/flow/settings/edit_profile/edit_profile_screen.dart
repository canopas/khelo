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
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/settings/edit_profile/edit_profile_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/theme/colors.dart';

import '../../../../components/image_picker_sheet.dart';

class EditProfileScreen extends ConsumerWidget {
  final bool isToCreateAccount;

  const EditProfileScreen({super.key, required this.isToCreateAccount});

  final double profileViewHeight = 128;

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(editProfileStateProvider.notifier);
    final state = ref.watch(editProfileStateProvider);

    _observeActionError(context, ref);
    _observeIsSaved(context, ref);

    return PopScope(
      onPopInvoked: (didPop) async {
        await notifier.onBackBtnPressed();
      },
      child: AppPage(
        title: context.l10n.edit_profile_screen_title,
        actions: [
          if (!isToCreateAccount) ...[
            OnTapScale(
              onTap: () => showConfirmationDialog(context,
                  title: context.l10n.common_delete_title,
                  message: context.l10n.alert_confirm_default_message(
                      context.l10n.common_delete_title.toLowerCase()),
                  confirmBtnText: context.l10n.common_delete_title,
                  onConfirm: notifier.onDeleteTap),
              child: SvgPicture.asset(
                Assets.images.icBin,
                height: 24,
                width: 24,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                    context.colorScheme.primary, BlendMode.srcATop),
              ),
            )
          ]
        ],
        body: Builder(
          builder: (context) {
            return Stack(
              children: [
                ListView(
                  padding: context.mediaQueryPadding +
                      const EdgeInsets.all(16.0) +
                      BottomStickyOverlay.padding,
                  children: [
                    ProfileImageAvatar(
                        size: profileViewHeight,
                        placeHolderImage: Assets.images.icProfileThin,
                        imageUrl: state.imageUrl,
                        isLoading: state.isImageUploading,
                        onEditButtonTap: () async {
                          final imagePath = await ImagePickerSheet.show<String>(
                              context, true);
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
                  ],
                ),
                _stickyButton(context, notifier, state)
              ],
            );
          },
        ),
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
        const SizedBox(
          height: 8,
        ),
        _textInputField(context, notifier,
            placeholderText: context.l10n.edit_profile_email_placeholder,
            controller: state.emailController),
        const SizedBox(
          height: 8,
        ),
        _textInputField(context, notifier,
            placeholderText: context.l10n.edit_profile_location_placeholder,
            controller: state.locationController),
      ],
    );
  }

  Widget _textInputField(
    BuildContext context,
    EditProfileViewNotifier notifier, {
    required String placeholderText,
    required TextEditingController controller,
  }) {
    return AppTextField(
      controller: controller,
      onChanged: (value) => notifier.onValueChange(),
      style: AppTextStyle.subtitle3
          .copyWith(color: context.colorScheme.textPrimary),
      borderRadius: BorderRadius.circular(12),
      borderType: AppTextFieldBorderType.outline,
      backgroundColor: context.colorScheme.containerLow,
      borderColor: BorderColor(Colors.transparent, Colors.transparent),
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
          child: _selectionDropDownButton(
            context,
            headerText: context.l10n.edit_profile_dob_placeholder,
            title: state.dob.format(context, DateFormatType.shortDate),
            placeholder: context.l10n.edit_profile_dob_placeholder,
            onTap: () => _selectDate(context, notifier, state),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _selectionDropDownButton(
            context,
            headerText: context.l10n.edit_profile_gender_placeholder,
            title: state.gender?.getString(context),
            placeholder: context.l10n.edit_profile_gender_placeholder,
            showTrailingIcon: false,
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
        _selectionDropDownButton(
          context,
          title: state.playerRole?.getString(context),
          placeholder: context.l10n.edit_profile_player_role_placeholder,
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
                          },
                        ))
                    .toList());
          },
        ),
        const SizedBox(height: 24),
        _selectionDropDownButton(
          context,
          title: state.battingStyle?.getString(context),
          placeholder: context.l10n.edit_profile_batting_style_placeholder,
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
                          },
                        ))
                    .toList());
          },
        ),
        const SizedBox(height: 24),
        _selectionDropDownButton(
          context,
          title: state.bowlingStyle?.getString(context),
          placeholder: context.l10n.edit_profile_bowling_style_placeholder,
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
                          },
                        ))
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

  Widget _selectionDropDownButton(
    BuildContext context, {
    String? headerText,
    String? title,
    required String placeholder,
    bool showTrailingIcon = true,
    required Function() onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerText != null) ...[
          Text(
            headerText,
            style: AppTextStyle.caption
                .copyWith(color: context.colorScheme.textDisabled),
          ),
          const SizedBox(height: 4),
        ],
        OnTapScale(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.colorScheme.outline)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title ?? placeholder,
                    style: AppTextStyle.subtitle3.copyWith(
                        color: title != null
                            ? context.colorScheme.textPrimary
                            : context.colorScheme.textSecondary),
                  ),
                ),
                if (showTrailingIcon) ...[
                  SvgPicture.asset(
                    Assets.images.icArrowDown,
                    height: 18,
                    width: 18,
                    colorFilter: ColorFilter.mode(
                      context.colorScheme.textPrimary,
                      BlendMode.srcATop,
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    EditProfileViewNotifier notifier,
    EditProfileState state,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: context.l10n.edit_profile_select_birth_date_placeholder,
      initialDate: state.dob,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: context.brightness == Brightness.dark
              ? materialThemeDataDark
              : materialThemeDataLight,
          child: child!,
        );
      },
    );
    if (picked != null && picked != state.dob) {
      notifier.onDateSelect(selectedDate: picked);
    }
  }

  Widget _stickyButton(
    BuildContext context,
    EditProfileViewNotifier notifier,
    EditProfileState state,
  ) {
    return BottomStickyOverlay(
      child: PrimaryButton(
        context.l10n.edit_profile_save_title,
        progress: state.isSaveInProgress,
        enabled: state.isButtonEnable && !state.isImageUploading,
        onPressed: () => notifier.onSubmitTap(),
      ),
    );
  }
}
