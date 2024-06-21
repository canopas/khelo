import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/components/user_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/components/user_detail_sheet.dart';
import 'package:khelo/ui/flow/team/add_team_member/add_team_member_view_model.dart';
import 'package:khelo/ui/flow/team/add_team_member/components/verify_add_team_member_dialog.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../gen/assets.gen.dart';

class AddTeamMemberScreen extends ConsumerStatefulWidget {
  final TeamModel team;

  const AddTeamMemberScreen({super.key, required this.team});

  @override
  ConsumerState<AddTeamMemberScreen> createState() =>
      _AddTeamMemberScreenState();
}

class _AddTeamMemberScreenState extends ConsumerState<AddTeamMemberScreen> {
  late AddTeamMemberViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(addTeamMemberStateProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addTeamMemberStateProvider);

    _observeActionError();
    _observeIsAdded(state);
    return AppPage(
      title: context.l10n.add_team_member_screen_title,
      actions: [
        Visibility(
          visible: state.selectedUsers.isNotEmpty,
          child: state.isAddInProgress
              ? const AppProgressIndicator(size: AppProgressIndicatorSize.small)
              : actionButton(
                  context,
                  onPressed: () => notifier.addPlayersToTeam(widget.team.id),
                  icon: SvgPicture.asset(
                    Assets.images.icCheck,
                    colorFilter: ColorFilter.mode(
                      context.colorScheme.primary,
                      BlendMode.srcATop,
                    ),
                  ),
                ),
        ),
      ],
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              _searchField(context, state),
              _content(context, state),
              _selectedPlayerList(context, state),
            ],
          ),
        );
      }),
    );
  }

  Widget _content(
    BuildContext context,
    AddTeamMemberState state,
  ) {
    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onSearchChanged,
      );
    }
    return Expanded(
      child: state.searchedUsers.isEmpty
          ? Center(
              child: Text(
                context.l10n.add_team_member_search_hint_text,
                textAlign: TextAlign.center,
                style: AppTextStyle.subtitle1.copyWith(
                    color: context.colorScheme.textDisabled, fontSize: 20),
              ),
            )
          : ListView.separated(
              padding: context.mediaQueryPadding +
                  const EdgeInsets.symmetric(vertical: 16),
              itemCount: state.searchedUsers.length,
              itemBuilder: (context, index) {
                UserModel user = state.searchedUsers[index];
                return UserDetailCell(
                  user: user,
                  onTap: () => UserDetailSheet.show(context, user),
                  trailing: OnTapScale(
                    onTap: widget.team.players?.contains(user) != true &&
                            !state.selectedUsers.contains(user)
                        ? () async {
                            if (user.phone != null) {
                              final res = await VerifyAddTeamMemberDialog.show(
                                  context,
                                  phoneNumber: user.phone!);
                              if (res != null && res && context.mounted) {
                                notifier.selectUser(user);
                              }
                            }
                          }
                        : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: context.colorScheme.containerLow,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        widget.team.players?.contains(user) == true ||
                                state.selectedUsers.contains(user)
                            ? context.l10n.add_team_member_added_text
                            : context.l10n.common_add_title.toUpperCase(),
                        style: AppTextStyle.body2
                            .copyWith(color: context.colorScheme.textDisabled),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
    );
  }

  Widget _searchField(
    BuildContext context,
    AddTeamMemberState state,
  ) {
    return AppTextField(
      controller: state.searchController,
      borderRadius: BorderRadius.circular(30),
      contentPadding: const EdgeInsets.all(16),
      borderType: AppTextFieldBorderType.outline,
      onChanged: (value) => notifier.onSearchChanged(),
      backgroundColor: context.colorScheme.containerLowOnSurface,
      hintText: context.l10n.add_team_member_search_placeholder_text,
      style: AppTextStyle.body2.copyWith(
        color: context.colorScheme.textPrimary,
      ),
      hintStyle: AppTextStyle.subtitle2.copyWith(
        color: context.colorScheme.textDisabled,
      ),
      borderColor: BorderColor(
        focusColor: Colors.transparent,
        unFocusColor: Colors.transparent,
      ),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      prefixIcon: Icon(
        Icons.search,
        color: context.colorScheme.textDisabled,
        size: 24,
      ),
    );
  }

  Widget _selectedPlayerList(
    BuildContext context,
    AddTeamMemberState state,
  ) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: state.selectedUsers.length,
        itemBuilder: (context, index) {
          final user = state.selectedUsers[index];
          return SizedBox(
            height: 60,
            width: 65,
            child: Stack(
              children: [
                ImageAvatar(
                  initial: user.nameInitial,
                  imageUrl: user.profile_img_url,
                  size: 60,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: OnTapScale(
                      onTap: () => notifier.unSelectUser(user),
                      child: Icon(
                        Icons.cancel_rounded,
                        color: context.colorScheme.textPrimary,
                      )),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 20),
      ),
    );
  }

  void _observeActionError() {
    ref.listen(addTeamMemberStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  void _observeIsAdded(AddTeamMemberState state) {
    ref.listen(addTeamMemberStateProvider.select((value) => value.isAdded),
        (previous, next) {
      if (next && context.mounted) {
        context.pop(state.selectedUsers);
      }
    });
  }
}
