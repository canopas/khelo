import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/settings/edit_profile/edit_profile_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../components/image_picker_sheet.dart';

class EditProfileScreen extends ConsumerWidget {
  final bool isToCreateAccount;

  const EditProfileScreen({super.key, required this.isToCreateAccount});

  final double profileViewHeight = 130;

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

    _observeIsSaved(context, ref);

    return PopScope(
      canPop: !state.isButtonEnable,
      onPopInvoked: (didPop) {
        notifier.onBackBtnPressed();
        context.pop();
      },
      child: AppPage(
        title: context.l10n.edit_profile_screen_title,
        actions: [
          if (!isToCreateAccount) ...[
            IconButton(
                onPressed: () =>
                    _showDeleteAlert(context, () => notifier.onDeleteTap()),
                icon: const Icon(Icons.delete_outline))
          ]
        ],
        body: Material(
          color: Colors.transparent,
          child: Builder(
            builder: (context) {
              return Stack(
                children: [
                  ListView(
                    padding: context.mediaQueryPadding +
                        const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0) +
                        BottomStickyOverlay.padding,
                    children: [
                      _profileImageView(context, notifier, state),
                      const SizedBox(
                        height: 16,
                      ),
                      _textInputField(
                          context,
                          notifier,
                          state,
                          context.l10n.edit_profile_name_placeholder,
                          state.nameController),
                      const SizedBox(
                        height: 16,
                      ),
                      _textInputField(
                          context,
                          notifier,
                          state,
                          context.l10n.edit_profile_email_placeholder,
                          state.emailController),
                      const SizedBox(
                        height: 16,
                      ),
                      _textInputField(
                          context,
                          notifier,
                          state,
                          context.l10n.edit_profile_location_placeholder,
                          state.locationController),
                      _sectionTitle(
                          context, context.l10n.edit_profile_dob_placeholder),
                      OnTapScale(
                        onTap: () => _selectDate(context, notifier, state),
                        child: Text.rich(TextSpan(children: [
                          WidgetSpan(
                              child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.cake_rounded,
                                color: context.colorScheme.textPrimary),
                          )),
                          TextSpan(
                              text: DateFormat.yMMMMd().format(state.dob),
                              style: AppTextStyle.subtitle1.copyWith(
                                  color: context.colorScheme.textSecondary)),
                        ])),
                      ),
                      _sectionTitle(context,
                          context.l10n.edit_profile_gender_placeholder),
                      _genderOptionView(context, notifier, state),
                      const SizedBox(
                        height: 16,
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          DropdownButton(
                              alignment: Alignment.center,
                              value: state.playerRole,
                              dropdownColor:
                                  context.colorScheme.containerLowOnSurface,
                              isExpanded: false,
                              hint: Text(
                                  context.l10n
                                      .edit_profile_player_role_placeholder,
                                  style: AppTextStyle.header4.copyWith(
                                      color: context.colorScheme.textDisabled)),
                              items: PlayerRole.values.map((PlayerRole items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items.getString(context),
                                    style: AppTextStyle.body1.copyWith(
                                        color: context.colorScheme.textPrimary),
                                  ),
                                );
                              }).toList(),
                              onChanged: (PlayerRole? newValue) {
                                if (newValue != null &&
                                    newValue != state.playerRole) {
                                  notifier.onPlayerRoleChange(newValue);
                                }
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DropdownButton(
                              value: state.battingStyle,
                              dropdownColor:
                                  context.colorScheme.containerLowOnSurface,
                              hint: Text(
                                  context.l10n
                                      .edit_profile_batting_style_placeholder,
                                  style: AppTextStyle.header4.copyWith(
                                      color: context.colorScheme.textDisabled)),
                              items:
                                  BattingStyle.values.map((BattingStyle items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items.getString(context),
                                    style: AppTextStyle.body1.copyWith(
                                        color: context.colorScheme.textPrimary),
                                  ),
                                );
                              }).toList(),
                              onChanged: (BattingStyle? newValue) {
                                if (newValue != null &&
                                    newValue != state.battingStyle) {
                                  notifier.onBattingStyleChange(newValue);
                                }
                              }),
                          DropdownButton(
                              value: state.bowlingStyle,
                              dropdownColor:
                                  context.colorScheme.containerLowOnSurface,
                              hint: Text(
                                  context.l10n
                                      .edit_profile_bowling_style_placeholder,
                                  style: AppTextStyle.header4.copyWith(
                                      color: context.colorScheme.textDisabled)),
                              items:
                                  BowlingStyle.values.map((BowlingStyle items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items.getString(context),
                                    style: AppTextStyle.body1.copyWith(
                                        color: context.colorScheme.textPrimary),
                                  ),
                                );
                              }).toList(),
                              onChanged: (BowlingStyle? newValue) {
                                if (newValue != null &&
                                    newValue != state.bowlingStyle) {
                                  notifier.onBowlingStyleChange(newValue);
                                }
                              })
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                  _stickyButton(context, notifier, state)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _profileImageView(BuildContext context,
      EditProfileViewNotifier notifier, EditProfileState state) {
    return Center(
      child: SizedBox(
        height: profileViewHeight,
        width: profileViewHeight,
        child: Stack(
          children: [
            Container(
              height: profileViewHeight,
              width: profileViewHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: state.imageUrl != null && !state.isImageUploading
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(state.imageUrl!),
                          fit: BoxFit.cover)
                      : null,
                  color: context.colorScheme.primary),
              child: state.imageUrl == null && !state.isImageUploading
                  ? Icon(
                      Icons.person,
                      size: profileViewHeight / 2,
                      color: context.colorScheme.textSecondary,
                    )
                  : state.isImageUploading
                      ? AppProgressIndicator(
                          color: context.colorScheme.surface,
                        )
                      : null,
            ),
            OnTapScale(
              onTap: () async {
                final imagePath =
                    await ImagePickerSheet.show<String>(context, true);
                if (imagePath != null) {
                  notifier.onImageChange(imagePath);
                }
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: profileViewHeight / 3,
                  width: profileViewHeight / 3,
                  decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      border:
                          Border.all(color: context.colorScheme.textSecondary),
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.edit,
                    size: profileViewHeight / 5,
                    color: context.colorScheme.textSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textInputField(BuildContext context, EditProfileViewNotifier notifier,
      EditProfileState state, String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      onChanged: (value) => notifier.onValueChange(),
      style:
          AppTextStyle.header4.copyWith(color: context.colorScheme.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyle.header4
            .copyWith(color: context.colorScheme.textDisabled),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          title,
          style: AppTextStyle.body2
              .copyWith(color: context.colorScheme.textSecondary),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context,
      EditProfileViewNotifier notifier, EditProfileState state) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        helpText: context.l10n.edit_profile_select_birth_date_placeholder,
        initialDate: state.dob,
        firstDate: DateTime(1920),
        lastDate: DateTime.now());
    if (picked != null && picked != state.dob) {
      notifier.onDateSelect(selectedDate: picked);
    }
  }

  Widget _genderOptionView(BuildContext context,
      EditProfileViewNotifier notifier, EditProfileState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _radioBtnCell(context, notifier, state, UserGender.male),
        _radioBtnCell(context, notifier, state, UserGender.female),
        _radioBtnCell(context, notifier, state, UserGender.other),
      ],
    );
  }

  Widget _radioBtnCell(BuildContext context, EditProfileViewNotifier notifier,
      EditProfileState state, UserGender gender) {
    return OnTapScale(
      onTap: () => notifier.onGenderSelect(gender: gender),
      child: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Radio(
              value: gender,
              groupValue: state.gender,
              activeColor: context.colorScheme.primary,
              onChanged: <UserGender>(value) {
                if (value != null) {
                  notifier.onGenderSelect(gender: value);
                }
              }),
          Text(
            gender.getString(context),
            style: AppTextStyle.button.copyWith(
                color: context.colorScheme.textSecondary, fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _showDeleteAlert(BuildContext context, Function() onDelete) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(context.l10n.common_delete_title),
          content: Text(context.l10n.alert_confirm_default_message(
              context.l10n.common_delete_title.toLowerCase())),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                context.l10n.common_cancel_title,
                style: TextStyle(color: context.colorScheme.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop();
                onDelete();
              },
              child: Text(
                context.l10n.common_delete_title,
                style: TextStyle(color: context.colorScheme.alert),
              ),
            ),
          ],
        );
      },
    );
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
