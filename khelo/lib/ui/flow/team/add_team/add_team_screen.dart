import 'package:data/api/team/team_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/confirmation_dialog.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/components/image_picker_sheet.dart';
import 'package:khelo/components/profile_image_avatar.dart';
import 'package:khelo/components/user_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/team/add_team/add_team_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/text/text_input_formatter.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/back_button.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/widgets/rounded_check_box.dart';

import '../../../../gen/assets.gen.dart';
import '../../matches/add_match/select_squad/components/user_detail_sheet.dart';

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

  @override
  Widget build(BuildContext context) {
    _observeActionError(context, ref);
    _observeTeam(context, ref);
    _observePop(context, ref);

    return AppPage(
      title: widget.editTeam != null
          ? context.l10n.add_team_edit_team_screen_title
          : context.l10n.add_team_screen_title,
      automaticallyImplyLeading: false,
      leading: backButton(
        context,
        onPressed: context.pop,
      ),
      actions: [
        if (widget.editTeam != null) ...[
          actionButton(
            context,
            onPressed: () => showConfirmationDialog(
              context,
              title: context.l10n.common_delete_title,
              message: context.l10n.alert_confirm_default_message(
                  context.l10n.common_delete_title.toLowerCase()),
              confirmBtnText: context.l10n.common_delete_title,
              onConfirm: notifier.onTeamDelete,
            ),
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
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final state = ref.watch(addTeamStateProvider);
    return Stack(
      children: [
        ListView(
          padding: context.mediaQueryPadding +
              const EdgeInsets.all(16) +
              BottomStickyOverlay.padding,
          children: [
            ProfileImageAvatar(
              size: profileViewHeight,
              placeHolderImage: Assets.images.icGroup,
              isLoading: state.isImageUploading,
              imageUrl: state.editTeam?.profile_img_url,
              filePath: state.filePath,
              onEditButtonTap: () async {
                final imagePath = await ImagePickerSheet.show<String>(
                  context,
                  allowCrop: true,
                );
                if (imagePath != null) {
                  notifier.onImageSelect(imagePath);
                }
              },
            ),
            const SizedBox(height: 40),
            _textInputField(
                onChanged: (value) => notifier.onNameTextChanged(),
                controller: state.nameController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]'))
                ],
                suffixIcon: state.checkingForAvailability
                    ? const UnconstrainedBox(
                        child: AppProgressIndicator(
                            size: AppProgressIndicatorSize.small))
                    : state.isNameAvailable != null
                        ? state.isNameAvailable!
                            ? Icon(Icons.check,
                                color: context.colorScheme.positive)
                            : Icon(Icons.close,
                                color: context.colorScheme.alert)
                        : null,
                hintText:
                    context.l10n.add_team_enter_team_name_placeholder_text),
            const SizedBox(height: 16),
            _textInputField(
              controller: state.locationController,
              onChanged: (p0) => notifier.onValueChange(),
              hintText: context.l10n.common_location_title,
            ),
            const SizedBox(height: 16),
            _textInputField(
              controller: state.nameInitialsController,
              textCapitalization: TextCapitalization.characters,
              maxLength: 4,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                CustomTextFormatter((text) => text.toUpperCase()),
              ],
              onChanged: (p0) => notifier.onValueChange(),
              hintText: context.l10n.add_team_team_initial_placeholder_text,
            ),
            if (widget.editTeam == null) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RoundedCheckBoxTile(
                  title: context.l10n.add_team_add_as_member_description_text,
                  style: AppTextStyle.caption
                      .copyWith(color: context.colorScheme.textSecondary),
                  isSelected: state.isAddMeCheckBoxEnable,
                  onTap: notifier.onAddMeCheckBoxTap,
                ),
              ),
            ] else ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(context.l10n.add_team_players_text,
                      style: AppTextStyle.header4
                          .copyWith(color: context.colorScheme.textPrimary)),
                  const SizedBox(width: 16),
                  actionButton(
                    context,
                    onPressed: () async {
                      final players = await AppRoute.addTeamMember(
                              team: widget.editTeam!
                                  .copyWith(players: state.teamMembers))
                          .push<List<TeamPlayer>>(context);
                      if (context.mounted && (players ?? []).isNotEmpty) {
                        notifier.updatePlayersList(players!);
                      }
                    },
                    icon: Icon(
                      CupertinoIcons.add,
                      color: context.colorScheme.textPrimary,
                      size: 24,
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
              ...state.teamMembers.map((player) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: UserDetailCell(
                    user: player.user,
                    onTap: () => UserDetailSheet.show(context, player.user),
                    trailing: actionButton(context,
                        onPressed: () =>
                            notifier.onRemoveUserFromTeam(player.user),
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10),
                        icon: Icon(
                          Icons.close,
                          size: 16,
                          color: context.colorScheme.textDisabled,
                        )),
                  ),
                );
              }),
              const SizedBox(height: 24),
            ],
          ],
        ),
        _stickyButton(context, state)
      ],
    );
  }

  Widget _textInputField({
    required TextEditingController controller,
    required String hintText,
    required Function(String)? onChanged,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
    int? maxLength,
  }) {
    return AppTextField(
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      suffixIcon: suffixIcon,
      style: AppTextStyle.subtitle3
          .copyWith(color: context.colorScheme.textPrimary),
      hintStyle: AppTextStyle.subtitle3
          .copyWith(color: context.colorScheme.textDisabled),
      borderRadius: BorderRadius.circular(12),
      textCapitalization: textCapitalization,
      borderType: AppTextFieldBorderType.outline,
      maxLength: maxLength,
      backgroundColor: context.colorScheme.containerLow,
      borderColor: BorderColor(
          focusColor: Colors.transparent, unFocusColor: Colors.transparent),
    );
  }

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
        onPressed: notifier.onAddBtnTap,
      ),
    );
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
          context.pop(current);
        }
      },
    );
  }
}
