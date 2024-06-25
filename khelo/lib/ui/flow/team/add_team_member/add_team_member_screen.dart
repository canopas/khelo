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
import 'package:khelo/ui/flow/team/add_team_member/components/verify_team_member_sheet.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/search_text_field.dart';
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
          padding: context.mediaQueryPadding +
              const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _searchField(context, state),
              if (state.selectedUsers.isNotEmpty) ...[
                _selectedPlayerList(context, state),
              ],
              _content(context, state),
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
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textDisabled),
              ),
            )
          : ListView.separated(
              itemCount: state.searchedUsers.length,
              itemBuilder: (context, index) {
                UserModel user = state.searchedUsers[index];
                return Column(
                  children: [
                    if (index == 0) ...[
                      Divider(
                        height: 32,
                        color: context.colorScheme.outline,
                      )
                    ],
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: UserDetailCell(
                        user: user,
                        onTap: () => UserDetailSheet.show(
                          context,
                          user,
                          actionButtonTitle:
                              widget.team.players?.contains(user) == true ||
                                      state.selectedUsers.contains(user)
                                  ? null
                                  : context.l10n.common_select_title,
                          onButtonTap: () async {
                            if (user.phone != null) {
                              final res = await VerifyTeamMemberSheet.show(
                                  context,
                                  phoneNumber: user.phone!);
                              if (res != null && res && context.mounted) {
                                notifier.selectUser(user);
                              }
                            }
                          },
                        ),
                        trailing: OnTapScale(
                          onTap: widget.team.players?.contains(user) != true &&
                                  !state.selectedUsers.contains(user)
                              ? () async {
                                  if (user.phone != null) {
                                    final res =
                                        await VerifyTeamMemberSheet.show(
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
                              style: AppTextStyle.body2.copyWith(
                                  color: context.colorScheme.textDisabled),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Divider(
                height: 32,
                color: context.colorScheme.outline,
              ),
            ),
    );
  }

  Widget _searchField(
    BuildContext context,
    AddTeamMemberState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SearchTextField(
        controller: state.searchController,
        onChange: notifier.onSearchChanged,
        hintText: context.l10n.add_team_member_search_placeholder_text,
      ),
    );
  }

  Widget _selectedPlayerList(
    BuildContext context,
    AddTeamMemberState state,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: state.selectedUsers
              .map((user) => Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    width: 58,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 8),
                          _selectedProfileView(context, user),
                          const SizedBox(height: 4),
                          Text(user.name ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.caption.copyWith(
                                  color: context.colorScheme.textPrimary))
                        ]),
                  )))
              .toList()),
    );
  }

  Widget _selectedProfileView(BuildContext context, UserModel user) {
    return SizedBox(
      height: 58,
      width: 58,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: ImageAvatar(
              initial: user.nameInitial,
              imageUrl: user.profile_img_url,
              size: 56,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: OnTapScale(
                onTap: () => notifier.unSelectUser(user),
                child: _crossIcon(context)),
          ),
        ],
      ),
    );
  }

  Widget _crossIcon(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.textInversePrimary,
          border: Border.all(color: context.colorScheme.outline)),
      child: Icon(
        Icons.close,
        size: 16,
        color: context.colorScheme.textPrimary,
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
