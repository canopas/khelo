import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/components/image_picker_sheet.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/domain/formatter/string_formatter.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/team/add_team/add_team_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/bottom_sticky_overlay.dart';

import '../../../../components/image_avatar.dart';
import '../../../../gen/assets.gen.dart';

class AddTeamScreen extends ConsumerStatefulWidget {
  final TeamModel? editTeam;

  const AddTeamScreen({super.key, required this.editTeam});

  @override
  ConsumerState createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends ConsumerState<AddTeamScreen> {
  final double profileViewHeight = 128;
  late AddTeamViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(addTeamStateProvider.notifier);
    runPostFrame(() => notifier.setData(editTeam: widget.editTeam));
  }

  void _observeActionError(BuildContext context, WidgetRef ref) {
    ref.listen(addTeamStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  void _observeTeam(BuildContext context, WidgetRef ref) {
    ref.listen(
      addTeamStateProvider.select((value) => value.team),
      (previous, current) async {
        if (current != null) {
          AppRoute.addTeamMember(team: current).pushReplacement(context);
        }
      },
    );
  }

  void _observePop(BuildContext context, WidgetRef ref) {
    ref.listen(
      addTeamStateProvider.select((value) => value.isPop),
      (previous, current) async {
        if (current && context.mounted) {
          context.pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addTeamStateProvider);

    _observeActionError(context, ref);
    _observeTeam(context, ref);
    _observePop(context, ref);

    return AppPage(
      title: widget.editTeam != null
          ? context.l10n.edit_team_screen_title
          : context.l10n.add_team_screen_title,
      automaticallyImplyLeading: false,
      leading: actionButton(
        context,
        onPressed: () {
          notifier.onBackBtnPressed();
          context.pop();
        },
        icon: Icon(
          Icons.arrow_back,
          color: context.colorScheme.textPrimary,
        ),
      ),
      actions: [
        if (state.editTeam != null) ...[
          actionButton(
            context,
            onPressed: () {
              _showDeleteAlert(context, onDelete: notifier.onTeamDelete);
            },
            icon: SvgPicture.asset(
              Assets.images.icBin,
              height: 24,
              width: 24,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                  context.colorScheme.alert, BlendMode.srcATop),
            ),
          ),
        ],
      ],
      body: _body(context, state),
    );
  }

  Widget _body(BuildContext context, AddTeamState state) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16) + BottomStickyOverlay.padding,
            children: [
              _profileImageView(context, state),
              const SizedBox(height: 40),
              Consumer(builder: (context, ref, child) {
                final nameState = ref.watch(addTeamStateProvider);
                return _textInputField(
                    onChanged: (value) {
                      notifier.onNameTextChanged();
                    },
                    controller: nameState.nameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]'))
                    ],
                    suffixIcon: nameState.checkingForAvailability
                        ? const AppProgressIndicator(
                            size: AppProgressIndicatorSize.small,
                          )
                        : nameState.isNameAvailable != null
                            ? nameState.isNameAvailable!
                                ? Icon(
                                    Icons.check,
                                    color: context.colorScheme.positive,
                                  )
                                : Icon(
                                    Icons.close,
                                    color: context.colorScheme.alert,
                                  )
                            : null,
                    hintText:
                        context.l10n.add_team_enter_team_name_placeholder_text);
              }),
              const SizedBox(height: 8),
              _textInputField(
                controller: state.locationController,
                onChanged: (p0) => notifier.onValueChange(),
                hintText: context.l10n.add_team_location_text,
              ),
              if (widget.editTeam == null) ...[
                ListTileTheme(
                  horizontalTitleGap: 8.0,
                  child: CheckboxListTile(
                    value: state.isAddMeCheckBoxEnable,
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                        context.l10n.add_team_add_as_member_description_text),
                    onChanged: (value) {
                      if (value != null) {
                        notifier.onAddMeCheckBoxTap(value);
                      }
                    },
                  ),
                ),
              ] else ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(context.l10n.add_team_players_text,
                        style: AppTextStyle.header4
                            .copyWith(color: context.colorScheme.textPrimary)),
                    actionButton(
                      context,
                      onPressed: () =>
                          AppRoute.addTeamMember(team: widget.editTeam!)
                              .push(context),
                      icon: Icon(
                        CupertinoIcons.add,
                        color: context.colorScheme.textPrimary,
                        size: 20,
                      ),
                    )
                  ],
                ),
                if (state.teamMembers.isEmpty) ...[
                  AspectRatio(
                    aspectRatio: 1.2,
                    child: Center(
                      child: Text(
                        context.l10n.add_team_add_hint_text,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.subtitle1
                            .copyWith(color: context.colorScheme.textPrimary),
                      ),
                    ),
                  ),
                ],
                ...state.teamMembers.map(
                  (player) => _playerProfileCell(context, player: player),
                ),
              ],
            ],
          ),
          _stickyButton(context, state)
        ],
      ),
    );
  }

  Widget _textInputField({
    required TextEditingController controller,
    required String hintText,
    required Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
  }) {
    return AppTextField(
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      suffixIcon: suffixIcon,
      style: AppTextStyle.subtitle3
          .copyWith(color: context.colorScheme.textPrimary),
      borderRadius: BorderRadius.circular(12),
      borderType: AppTextFieldBorderType.outline,
      backgroundColor: context.colorScheme.containerLow,
      borderColor: BorderColor(Colors.transparent, Colors.transparent),
    );
  }

  Widget _profileImageView(
    BuildContext context,
    AddTeamState state,
  ) {
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
                      Icons.sports_cricket,
                      size: profileViewHeight / 2,
                      color: context.colorScheme.textSecondary,
                    )
                  : state.isImageUploading
                      ? AppProgressIndicator(
                          color: context.colorScheme.surface,
                        )
                      : null,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: OnTapScale(
                onTap: () async {
                  final imagePath =
                      await ImagePickerSheet.show<String>(context, true);
                  if (imagePath != null) {
                    notifier.onImageSelect(imagePath);
                  }
                },
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

  Widget _playerProfileCell(BuildContext context, {required UserModel player}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ImageAvatar(
            initial: player.name ?? '',
            imageUrl: player.profile_img_url,
            size: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name ?? '',
                  style: AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
                Text(
                    player.player_role != null
                        ? player.player_role!.getString(context)
                        : context.l10n.common_not_specified_title,
                    style: AppTextStyle.caption
                        .copyWith(color: context.colorScheme.textSecondary)),
                if (player.phone != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    player.phone
                        .format(context, StringFormats.obscurePhoneNumber),
                    style: AppTextStyle.caption
                        .copyWith(color: context.colorScheme.textSecondary),
                  ),
                ],
              ],
            ),
          ),
          actionButton(context,
              onPressed: () => notifier.onRemoveUserFromTeam(player),
              icon: const Icon(Icons.close))
        ],
      ),
    );
  }

  // Widget _userProfileCell(
  //   BuildContext context,
  //   AddTeamViewNotifier notifier,
  //   AddTeamState state,
  //   UserModel user,
  // ) {
  //   return Row(
  //     children: [
  //       ImageAvatar(
  //         initial: user.nameInitial,
  //         imageUrl: user.profile_img_url,
  //         size: 50,
  //       ),
  //       const SizedBox(
  //         width: 8,
  //       ),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               user.name ?? context.l10n.common_anonymous_title,
  //               style: AppTextStyle.header4
  //                   .copyWith(color: context.colorScheme.textPrimary),
  //             ),
  //             Text(
  //                 user.player_role != null
  //                     ? user.player_role!.getString(context)
  //                     : context.l10n.common_not_specified_title,
  //                 style: AppTextStyle.subtitle2
  //                     .copyWith(color: context.colorScheme.textSecondary)),
  //             if (user.phone != null) ...[
  //               const SizedBox(
  //                 height: 2,
  //               ),
  //               Text(
  //                 user.phone.format(context, StringFormats.obscurePhoneNumber),
  //                 style: AppTextStyle.subtitle2
  //                     .copyWith(color: context.colorScheme.textSecondary),
  //               ),
  //             ],
  //           ],
  //         ),
  //       ),
  //       IconButton(
  //           onPressed: () => notifier.onRemoveUserFromTeam(user),
  //           icon: const Icon(Icons.close)),
  //     ],
  //   );
  // }

  Widget _stickyButton(BuildContext context, AddTeamState state) {
    return BottomStickyOverlay(
      child: PrimaryButton(
        state.editTeam != null
            ? context.l10n.common_save_title
            : context.l10n.common_add_title,
        enabled: state.isAddBtnEnable &&
            !state.isImageUploading &&
            !state.checkingForAvailability,
        progress: state.isAddInProgress,
        onPressed: () => notifier.onAddBtnTap(),
      ),
    );
  }

  void _showDeleteAlert(
    BuildContext context, {
    required Function() onDelete,
  }) {
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
}
