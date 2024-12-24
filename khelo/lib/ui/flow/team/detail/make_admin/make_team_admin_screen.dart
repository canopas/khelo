import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/action_bottom_sheet.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/team/detail/make_admin/make_team_admin_view_model.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/widgets/rounded_check_box.dart';

import '../../../../../components/error_snackbar.dart';
import '../../../../../components/user_detail_cell.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../matches/add_match/match_officials/search_user/search_user_screen.dart';
import '../../../matches/add_match/select_squad/components/user_detail_sheet.dart';

class MakeTeamAdminScreen extends ConsumerStatefulWidget {
  final TeamModel team;

  const MakeTeamAdminScreen({
    super.key,
    required this.team,
  });

  @override
  ConsumerState<MakeTeamAdminScreen> createState() => _MakeAdminScreenState();
}

class _MakeAdminScreenState extends ConsumerState<MakeTeamAdminScreen> {
  late MakeTeamAdminViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(makeTeamAdminStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.team));
  }

  @override
  Widget build(BuildContext context) {
    _observePop();
    _observeShowSelectionError();
    _observeActionError();
    final state = ref.watch(makeTeamAdminStateProvider);
    return AppPage(
      title: context.l10n.common_make_admin,
      actions: [
        actionButton(context,
            onPressed: state.isButtonEnabled ? notifier.onSave : null,
            icon: SvgPicture.asset(
              Assets.images.icCheck,
              height: 24,
              width: 24,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                state.isButtonEnabled
                    ? context.colorScheme.primary
                    : context.colorScheme.textDisabled,
                BlendMode.srcIn,
              ),
            ))
      ],
      body: Builder(builder: (context) => _body(context, state)),
    );
  }

  void _observePop() {
    ref.listen(
      makeTeamAdminStateProvider.select((value) => value.pop),
      (previous, next) {
        if (next) context.pop();
      },
    );
  }

  void _observeShowSelectionError() {
    ref.listen(
        makeTeamAdminStateProvider.select((value) => value.showSelectionError),
        (previous, next) {
      if (next) {
        showErrorSnackBar(
            context: context, error: context.l10n.make_admin_selection_error);
      }
    });
  }

  void _observeActionError() {
    ref.listen(makeTeamAdminStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  Widget _body(BuildContext context, MakeTeamAdminState state) {
    return Padding(
      padding: context.mediaQueryPadding,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: state.players.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return (state.owner.id.isNotEmpty)
                ? UserDetailCell(
                    user: state.owner,
                    showPhoneNumber: false,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onTap: () {
                      if (state.currentUserId ==
                          notifier.team.created_by_user.id) {
                        showActionBottomSheet(context: context, items: [
                          BottomSheetAction(
                            title: (notifier.team.created_by_user.id !=
                                    state.owner.id)
                                ? context
                                    .l10n.team_detail_remove_ownership_title
                                : context.l10n.common_transfer_ownership,
                            onTap: () async {
                              context.pop();
                              if (notifier.team.created_by_user.id !=
                                  state.owner.id) {
                                notifier.changeTeamOwner(
                                    notifier.team.created_by_user);
                                return;
                              }
                              final newOwner =
                                  await SearchUserBottomSheet.show<UserModel>(
                                context,
                                emptyScreenTitle:
                                    context.l10n.common_transfer_ownership,
                                emptyScreenDescription: context.l10n
                                    .team_detail_transfer_ownership_description,
                              );
                              if (context.mounted && newOwner != null) {
                                notifier.changeTeamOwner(newOwner);
                              }
                            },
                          ),
                          if (notifier.team.players
                              .map((e) => e.id)
                              .contains(state.owner.id)) // is part player
                            BottomSheetAction(
                              title: state.selectedPlayerIds
                                      .contains(state.owner.id)
                                  ? context.l10n.common_remove_admin
                                  : context.l10n.common_make_admin,
                              onTap: () {
                                context.pop();
                                notifier.selectAdmin(state.owner);
                              },
                            )
                        ]);
                      } else {
                        UserDetailSheet.show(context, state.owner);
                      }
                    },
                    trailing: Text(context.l10n.common_owner,
                        style: AppTextStyle.body2
                            .copyWith(color: context.colorScheme.primary)),
                  )
                : const SizedBox();
          }

          final player = state.players[index - 1];
          return UserDetailCell(
              user: player,
              showPhoneNumber: false,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              onTap: () => UserDetailSheet.show(context, player),
              trailing: RoundedCheckBox(
                isSelected: state.selectedPlayerIds.contains(player.id),
                onTap: (_) => notifier.selectAdmin(player),
              ));
        },
        separatorBuilder: (context, index) =>
            (index == 0 && state.owner.id.isNotEmpty)
                ? Divider(
                    height: 24,
                    thickness: 1,
                    color: context.colorScheme.outline,
                  )
                : const SizedBox(height: 16),
      ),
    );
  }
}
