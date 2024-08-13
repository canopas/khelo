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
import 'package:style/widgets/rounded_check_box.dart';

import '../../../../../components/error_snackbar.dart';
import '../../../../../components/user_detail_cell.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../matches/add_match/select_squad/components/user_detail_sheet.dart';

class MakeTeamAdminScreen extends ConsumerStatefulWidget {
  final String teamId;
  final List<TeamPlayer> players;

  const MakeTeamAdminScreen({
    super.key,
    required this.teamId,
    required this.players,
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
    runPostFrame(() => notifier.setData(
          teamId: widget.teamId,
          players: widget.players,
        ));
  }

  @override
  Widget build(BuildContext context) {
    _observePop();
    _observeActionError();
    final state = ref.watch(makeTeamAdminStateProvider);
    return AppPage(
      title: context.l10n.team_detail_make_admin,
      actions: (state.isButtonEnabled)
          ? [
              actionButton(context,
                  onPressed: notifier.onSave,
                  icon: SvgPicture.asset(
                    Assets.images.icCheck,
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      context.colorScheme.textPrimary,
                      BlendMode.srcIn,
                    ),
                  ))
            ]
          : null,
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

  void _observeActionError() {
    ref.listen(makeTeamAdminStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  Widget _body(BuildContext context, MakeTeamAdminState state) {
    return ListView.separated(
      padding: const EdgeInsets.all(16) + context.mediaQueryPadding,
      itemCount: widget.players.length,
      itemBuilder: (context, index) {
        final player = widget.players[index];
        return (player.user != null)
            ? UserDetailCell(
                user: player.user!,
                onTap: () => UserDetailSheet.show(context, player.user!),
                showPhoneNumber: false,
                trailing: RoundedCheckBox(
                  isSelected: state.selectedPlayers
                      .any((element) => element.user == player.user),
                  onTap: (_) => notifier.selectAdmin(player),
                ),
              )
            : SizedBox();
      },
      separatorBuilder: (context, index) => SizedBox(height: 16),
    );
  }
}
