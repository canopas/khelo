import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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
      title: context.l10n.team_detail_make_admin_screen_title,
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
    final members = widget.team.players
        .where((element) => element.id != widget.team.created_by)
        .toList();

    final TeamPlayer owner = widget.team.players.firstWhere(
        (element) => element.id == widget.team.created_by,
        orElse: () => const TeamPlayer(id: ''));

    return Padding(
      padding: context.mediaQueryPadding,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: members.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return (owner.id.isNotEmpty)
                ? UserDetailCell(
                    user: owner.user,
                    showPhoneNumber: false,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onTap: () => UserDetailSheet.show(context, owner.user),
                    trailing: Text(
                        context.l10n.team_detail_make_admin_owner_title,
                        style: AppTextStyle.body2
                            .copyWith(color: context.colorScheme.primary)),
                  )
                : const SizedBox();
          }

          final player = members[index - 1];
          return UserDetailCell(
              user: player.user,
              showPhoneNumber: false,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              onTap: () => UserDetailSheet.show(context, player.user),
              trailing: RoundedCheckBox(
                isSelected: state.selectedPlayers
                    .any((element) => element.user == player.user),
                onTap: (_) => notifier.selectAdmin(player),
              ));
        },
        separatorBuilder: (context, index) =>
            (index == 0 && owner.id.isNotEmpty)
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
