import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/settings/profile/edit_profile_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class EditProfileScreen extends ConsumerWidget {
  final bool isToCreateAccount;

  EditProfileScreen({super.key, required this.isToCreateAccount});

  final double profileViewHeight = 130;
  final ImagePicker _picker = ImagePicker();

  _observeIsSaved(BuildContext context, WidgetRef ref) {
    ref.listen(editProfileStateProfile.select((state) => state.isSaved),
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
    final notifier = ref.watch(editProfileStateProfile.notifier);
    final state = ref.watch(editProfileStateProfile);

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
          child: Builder(
            builder: (context) {
              return ListView(
                padding: context.mediaQueryPadding +
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                        child: Icon(Icons.calendar_today,
                            color: context.colorScheme.textPrimary),
                      )),
                      TextSpan(
                          text: DateFormat.yMMMMd().format(state.dob),
                          style: AppTextStyle.subtitle1.copyWith(
                              color: context.colorScheme.textSecondary)),
                    ])),
                  ),
                  _sectionTitle(
                      context, context.l10n.edit_profile_gender_placeholder),
                  _genderOptionView(context, notifier, state),
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownButton(
                      alignment: Alignment.center,
                      value: state.playerRole,
                      hint: Text(
                          context.l10n.edit_profile_player_role_placeholder),
                      items: PlayerRole.values.map((PlayerRole items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(_getPlayerRoleString(context, items)),
                        );
                      }).toList(),
                      onChanged: (PlayerRole? newValue) {
                        if (newValue != null && newValue != state.playerRole) {
                          notifier.onPlayerRoleChange(newValue);
                        }
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton(
                          value: state.battingStyle,
                          hint: Text(context
                              .l10n.edit_profile_batting_style_placeholder),
                          items: BattingStyle.values.map((BattingStyle items) {
                            return DropdownMenuItem(
                              value: items,
                              child:
                                  Text(_getBattingStyleString(context, items)),
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
                          hint: Text(context
                              .l10n.edit_profile_bowling_style_placeholder),
                          items: BowlingStyle.values.map((BowlingStyle items) {
                            return DropdownMenuItem(
                              value: items,
                              child:
                                  Text(_getBowlingStyleString(context, items)),
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
                  PrimaryButton(
                    context.l10n.edit_profile_save_title,
                    expanded: false,
                    progress: state.isSaveInProgress,
                    enabled: state.isButtonEnable,
                    onPressed: () => notifier.onSubmitTap(),
                  )
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
                  image: state.imageUrl != null
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(state.imageUrl!),
                          fit: BoxFit.cover)
                      : null,
                  color: context.colorScheme.primary),
              child: state.imageUrl == null
                  ? Icon(
                      Icons.person,
                      size: profileViewHeight / 2,
                      color: context.colorScheme.textSecondary,
                    )
                  : null,
            ),
            OnTapScale(
              onTap: () {
                _onEditProfileButtonTap(context, notifier);
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

  void _onEditProfileButtonTap(
      BuildContext context, EditProfileViewNotifier notifier) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: context.colorScheme.surface,
      builder: (sheetContext) {
        return Container(
          padding: sheetContext.mediaQueryPadding +
              const EdgeInsets.only(left: 16, right: 16, bottom: 24),
          child: Wrap(
            children: [
              Text(
                context.l10n.edit_profile_choose_option_title,
                style: AppTextStyle.header2
                    .copyWith(color: context.colorScheme.textSecondary),
              ),
              const SizedBox(
                height: 34,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //<a href="https://lovepik.com/images/png-light-line.html">Light Line Png vectors by Lovepik.com</a> GRAPHIC IMAGE LINK : camera
                  _sheetOptionCell(
                    context,
                    notifier,
                    "assets/images/ic_camera.png",
                    () async {
                      sheetContext.pop();
                      final image = await _picker.pickImage(
                        source: ImageSource.camera,
                        requestFullMetadata: false,
                      );
                      if (context.mounted && image != null) {
                        _openCropImage(context, notifier, image);
                      }
                    },
                  ),

                  _sheetOptionCell(
                    context,
                    notifier,
                    "assets/images/ic_gallery.png",
                    () async {
                      sheetContext.pop();
                      final image = await _picker.pickImage(
                        source: ImageSource.gallery,
                        requestFullMetadata: false,
                      );
                      if (context.mounted && image != null) {
                        _openCropImage(context, notifier, image);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _sheetOptionCell(BuildContext context,
      EditProfileViewNotifier notifier, String imagePath, VoidCallback onTap) {
    return OnTapScale(
      onTap: () => onTap(),
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(imagePath)),
            shape: BoxShape.circle,
            border: Border.all(color: context.colorScheme.containerHigh),
            color: context.colorScheme.containerLow),
      ),
    );
  }

  void _openCropImage(BuildContext context, EditProfileViewNotifier notifier,
      XFile image) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: context.l10n.edit_profile_crop_image_title,
          toolbarColor: context.colorScheme.primary,
          toolbarWidgetColor: context.colorScheme.onPrimary,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: context.l10n.edit_profile_crop_image_title,
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    if (croppedImage != null) notifier.onImageChange(croppedImage.path);
  }

  Widget _textInputField(BuildContext context, EditProfileViewNotifier notifier,
      EditProfileState state, String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      onChanged: (value) => notifier.onValueChange(),
      decoration: InputDecoration(
        labelText: label,
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
            _getGenderString(context, gender),
            style: AppTextStyle.button.copyWith(
                color: context.colorScheme.textSecondary, fontSize: 16),
          ),
        ],
      ),
    );
  }

  String _getGenderString(BuildContext context, UserGender gender) {
    switch (gender) {
      case UserGender.male:
        return context.l10n.edit_profile_gender_male_title;
      case UserGender.female:
        return context.l10n.edit_profile_gender_female_title;
      case UserGender.other:
        return context.l10n.edit_profile_gender_other_title;
      default:
        return "";
    }
  }

  String _getBattingStyleString(BuildContext context, BattingStyle style) {
    switch (style) {
      case BattingStyle.rightHandBat:
        return context.l10n.batting_style_right_hand_bat_title;
      case BattingStyle.leftHandBat:
        return context.l10n.batting_style_left_hand_bat_title;
    }
  }

  String _getBowlingStyleString(BuildContext context, BowlingStyle style) {
    switch (style) {
      case BowlingStyle.rightArmFast:
        return context.l10n.bowling_style_right_arm_fast_title;
      case BowlingStyle.rightArmMedium:
        return context.l10n.bowling_style_right_arm_medium_title;
      case BowlingStyle.leftArmFast:
        return context.l10n.bowling_style_left_arm_fast_title;
      case BowlingStyle.leftArmMedium:
        return context.l10n.bowling_style_left_arm_medium_title;
      case BowlingStyle.slowLeftArmOrthodox:
        return context.l10n.bowling_style_slow_left_arm_orthodox_title;
      case BowlingStyle.slowLeftArmChinaMan:
        return context.l10n.bowling_style_slow_left_arm_chinaman_title;
      case BowlingStyle.rightArmOffBreak:
        return context.l10n.bowling_style_right_arm_off_break_title;
      case BowlingStyle.rightArmLegBreak:
        return context.l10n.bowling_style_right_arm_leg_break_title;
      case BowlingStyle.none:
        return context.l10n.common_none_title;
    }
  }

  String _getPlayerRoleString(BuildContext context, PlayerRole role) {
    switch (role) {
      case PlayerRole.topOrderBatter:
        return context.l10n.player_role_top_order_batter_title;
      case PlayerRole.middleOrderBatter:
        return context.l10n.player_role_middle_order_batter_title;
      case PlayerRole.wickerKeeperBatter:
        return context.l10n.player_role_wicket_keeper_batter_title;
      case PlayerRole.wicketKeeper:
        return context.l10n.player_role_wicket_keeper_title;
      case PlayerRole.bowler:
        return context.l10n.player_role_bowler_title;
      case PlayerRole.allRounder:
        return context.l10n.player_role_all_rounder_title;
      case PlayerRole.lowerOrderBatter:
        return context.l10n.player_role_lower_order_batter_title;
      case PlayerRole.openingBatter:
        return context.l10n.player_role_opening_batter_title;
      case PlayerRole.none:
        return context.l10n.common_none_title;
    }
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
              onPressed: () {
                context.pop();
              },
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
}
