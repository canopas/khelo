import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/formatter/string_formatter.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/components/user_detail_sheet.dart';
import 'package:khelo/ui/flow/team/add_team_member/add_team_member_view_model.dart';
import 'package:khelo/ui/flow/team/add_team_member/components/verify_add_team_member_dialog.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class AddTeamMemberScreen extends ConsumerWidget {
  final TeamModel team;

  const AddTeamMemberScreen({super.key, required this.team});

  void _observeActionError(BuildContext context, WidgetRef ref) {
    ref.listen(addTeamMemberStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  void _observeIsAdded(
      BuildContext context, WidgetRef ref, AddTeamMemberState state) {
    ref.listen(addTeamMemberStateProvider.select((value) => value.isAdded),
        (previous, next) {
      if (next && context.mounted) {
        context.pop(state.selectedUsers);
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(addTeamMemberStateProvider.notifier);
    final state = ref.watch(addTeamMemberStateProvider);

    _observeActionError(context, ref);
    _observeIsAdded(context, ref, state);
    return AppPage(
      title: context.l10n.add_team_member_screen_title,
      actions: [
        Visibility(
          visible: state.selectedUsers.isNotEmpty,
          child: state.isAddInProgress
              ? const AppProgressIndicator(
                  size: AppProgressIndicatorSize.small,
                )
              : IconButton(
                  onPressed: () {
                    notifier.addPlayersToTeam(team.id);
                  },
                  icon: Icon(
                    Icons.check,
                    color: context.colorScheme.primary,
                  )),
        )
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SafeArea(
          child: Column(
            children: [
              _searchTextField(context, notifier, state),
              _body(context, notifier, state),
              _selectedPlayerList(context, notifier, state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(
    BuildContext context,
    AddTeamMemberViewNotifier notifier,
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
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              },
              itemCount: state.searchedUsers.length,
              itemBuilder: (context, index) {
                UserModel user = state.searchedUsers[index];
                return _userProfileCell(context, notifier, state, user);
              },
            ),
    );
  }

  Widget _searchTextField(
    BuildContext context,
    AddTeamMemberViewNotifier notifier,
    AddTeamMemberState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Material(
        type: MaterialType.transparency,
        child: TextField(
          controller: state.searchController,
          onChanged: (value) => notifier.onSearchChanged(),
          decoration: InputDecoration(
            hintText: context.l10n.add_team_member_search_placeholder_text,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: context.colorScheme.containerLowOnSurface,
            hintStyle: TextStyle(color: context.colorScheme.textDisabled),
            prefixIcon: Icon(
              Icons.search,
              color: context.colorScheme.textDisabled,
              size: 24,
            ),
          ),
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style: AppTextStyle.body2.copyWith(
            color: context.colorScheme.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _userProfileCell(
    BuildContext context,
    AddTeamMemberViewNotifier notifier,
    AddTeamMemberState state,
    UserModel user,
  ) {
    return GestureDetector(
        onTap: () => UserDetailSheet.show(context, user),
        child: Row(
          children: [
            ImageAvatar(
              initial: user.nameInitial,
              imageUrl: user.profile_img_url,
              size: 50,
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
                          ? user.player_role!.getString(context)
                          : context.l10n.common_not_specified_title,
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textSecondary)),
                  if (user.phone != null) ...[
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      user.phone
                          .format(context, StringFormats.obscurePhoneNumber),
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textSecondary),
                    ),
                  ],
                ],
              ),
            ),
            OnTapScale(
              onTap: team.players?.contains(user) != true &&
                      !state.selectedUsers.contains(user)
                  ? () async {
                      if (user.phone != null) {
                        final res = await VerifyAddTeamMemberDialog.show(
                            context,
                            phoneNumber:
                                user.phone!.substring(user.phone!.length - 5));
                        if (res != null && res && context.mounted) {
                          notifier.selectUser(user);
                        }
                      }
                    }
                  : null,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                    color: context.colorScheme.containerLow,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(team.players?.contains(user) == true ||
                        state.selectedUsers.contains(user)
                    ? context.l10n.add_team_member_added_text
                    : context.l10n.common_add_title.toUpperCase()),
              ),
            ),
          ],
        ));
  }

  Widget _selectedPlayerList(
    BuildContext context,
    AddTeamMemberViewNotifier notifier,
    AddTeamMemberState state,
  ) {
    return SizedBox(
      height: 60,
      child: Stack(
        children: [
          ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: 100),
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
                            onTap: () {
                              notifier.unSelectUser(user);
                            },
                            child: Icon(
                              Icons.cancel_rounded,
                              color: context.colorScheme.textPrimary,
                            )),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 20,
                );
              },
              itemCount: state.selectedUsers.length),
        ],
      ),
    );
  }
}
