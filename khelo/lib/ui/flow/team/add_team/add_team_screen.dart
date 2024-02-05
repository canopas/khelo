import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/image_picker_sheet.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/team/add_team/add_team_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/bottom_sticky_overlay.dart';

class AddTeamScreen extends ConsumerStatefulWidget {
  final TeamModel? editTeam;

  const AddTeamScreen({super.key, required this.editTeam});

  @override
  ConsumerState createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends ConsumerState<AddTeamScreen> {
  final double profileViewHeight = 130;
  late AddTeamViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(addTeamStateProvider.notifier);
    runPostFrame(() => notifier.setData(editTeam: widget.editTeam));
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
    notifier = ref.watch(addTeamStateProvider.notifier);
    final state = ref.watch(addTeamStateProvider);

    _observeTeam(context, ref);
    _observePop(context, ref);

    return AppPage(
      title: context.l10n.add_team_screen_title,
      automaticallyImplyLeading: false,
      leading: actionButton(
        context,
        onPressed: () {
          notifier.onBackBtnPressed();
          context.pop();
        },
        icon: Icon(
          Icons.close,
          color: context.colorScheme.primary,
        ),
      ),
      actions: [
        if (state.editTeam != null) ...[
          actionButton(
            context,
            onPressed: () {
              _showDeleteAlert(context, () {
                notifier.onTeamDelete();
              });
            },
            icon: Icon(
              Icons.delete_outline,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ],
      body: Material(
        child: Stack(
          children: [
            ListView(
              padding: context.mediaQueryPadding +
                  const EdgeInsets.symmetric(horizontal: 16),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                _profileImageView(context, notifier, state),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  onChanged: (value) {
                    notifier.onNameTextChanged();
                  },
                  controller: state.nameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
                  ],
                  decoration: InputDecoration(
                    hintText:
                        context.l10n.add_team_enter_team_name_placeholder_text,
                    suffixIcon: state.checkingForAvailability
                        ? const AppProgressIndicator(
                            size: AppProgressIndicatorSize.small,
                          )
                        : state.isNameAvailable != null
                            ? state.isNameAvailable!
                                ? Icon(
                                    Icons.check,
                                    color: context.colorScheme.positive,
                                  )
                                : Icon(
                                    Icons.close,
                                    color: context.colorScheme.alert,
                                  )
                            : null,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  onChanged: (value) {
                    notifier.onValueChange();
                  },
                  controller: state.locationController,
                  decoration: InputDecoration(
                    hintText: context.l10n.add_team_location_text,
                    border: const OutlineInputBorder(),
                  ),
                ),
                if (state.editTeam == null) ...[
                  Row(
                    children: [
                      Checkbox(
                        value: state.isAddMeCheckBoxEnable,
                        onChanged: (value) => notifier.onAddMeCheckBoxTap(),
                      ),
                      GestureDetector(
                        onTap: () => notifier.onAddMeCheckBoxTap(),
                        child: Text(
                          context.l10n.add_team_add_as_member_description_text,
                          style: AppTextStyle.button.copyWith(
                              color: context.colorScheme.textSecondary,
                              fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ] else ...[
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Text(
                        "PLAYERS",
                        style: AppTextStyle.header3
                            .copyWith(color: context.colorScheme.textPrimary),
                      ),
                      IconButton(
                          onPressed: () async {
                            final players = await AppRoute.addTeamMember(
                                    team: state.editTeam!)
                                .push<List<UserModel>>(context);
                            if (players != null) {
                              notifier.updatePlayersList(players);
                            }
                          },
                          icon: const Icon(Icons.add))
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  for (final UserModel player
                      in state.editTeam!.players ?? []) ...[
                    _userProfileCell(context, notifier, state, player),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                  if ((state.editTeam!.players ?? []).isEmpty) ...[
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Added user will be shown here, tap on '+' button to add team member",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.subtitle1
                          .copyWith(color: context.colorScheme.textPrimary),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(),
                  ],
                ],
              ],
            ),
            _stickyButton(context, state)
          ],
        ),
      ),
    );
  }

  Widget _profileImageView(
      BuildContext context, AddTeamViewNotifier notifier, AddTeamState state) {
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

  Widget _userProfileCell(BuildContext context, AddTeamViewNotifier notifier,
      AddTeamState state, UserModel user) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colorScheme.containerHigh,
              image: user.profile_img_url != null
                  ? DecorationImage(
                      image: CachedNetworkImageProvider(user.profile_img_url!),
                      fit: BoxFit.cover)
                  : null),
          child: user.profile_img_url == null
              ? Text(
                  user.nameInitial,
                  style: AppTextStyle.header2.copyWith(
                    color: context.colorScheme.secondary,
                  ),
                )
              : null,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name ?? context.l10n.common_anonymous_title,
                style: AppTextStyle.header4
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              Text(
                  user.player_role != null
                      ? _getPlayerRoleString(context, user.player_role!)
                      : "Not Specified",
                  style: AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textSecondary)),
              if (user.phone != null) ...[
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "***** ***${user.phone!.substring(user.phone!.length - 2)}",
                  style: AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textSecondary),
                ),
              ],
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              notifier.onRemoveUserFromTeam(user);
            },
            icon: const Icon(Icons.close)),
      ],
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
        onPressed: () {
          notifier.onAddBtnTap();
        },
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
}
