import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/user_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/components/select_admin_and_captain_dialog.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/components/user_detail_sheet.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/select_squad_view_model.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class SelectSquadScreen extends ConsumerStatefulWidget {
  final TeamModel team;
  final List<MatchPlayer>? squad;
  final String? captainId;
  final String? adminId;

  const SelectSquadScreen({
    super.key,
    required this.team,
    this.squad,
    this.captainId,
    this.adminId,
  });

  @override
  ConsumerState createState() => _SelectSquadScreenState();
}

class _SelectSquadScreenState extends ConsumerState<SelectSquadScreen> {
  late SelectSquadViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(selectSquadStateProvider.notifier);
    runPostFrame(() => notifier.setData(
        widget.team, widget.squad ?? [], widget.captainId, widget.adminId));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(selectSquadStateProvider);

    return AppPage(
      title: context.l10n.common_select_squad_title,
      actions: [
        actionButton(context,
            onPressed: state.isDoneBtnEnable
                ? () async {
                    var result = await SelectAdminAndCaptainDialog.show<
                        Map<String, dynamic>>(context);
                    if (result != null && context.mounted) {
                      Map<String, dynamic> updatedResult = Map.from(result);
                      updatedResult["squad"] = state.squad;
                      context.pop(updatedResult);
                    }
                  }
                : null,
            icon: SvgPicture.asset(
              Assets.images.icCheck,
              colorFilter: ColorFilter.mode(
                  state.isDoneBtnEnable
                      ? context.colorScheme.textPrimary
                      : context.colorScheme.textDisabled,
                  BlendMode.srcIn),
            )),
      ],
      body: Builder(builder: (context) {
        return Padding(
          padding: context.mediaQueryPadding,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _playingSquadList(context, notifier, state),
              _teamMemberList(context, notifier, state)
            ],
          ),
        );
      }),
    );
  }

  Widget _playingSquadList(
    BuildContext context,
    SelectSquadViewNotifier notifier,
    SelectSquadViewState state,
  ) {
    return Wrap(
      children: [
        _sectionTitle(
          context,
          context.l10n.select_squad_playing_squad_title,
          subtitle: !state.isDoneBtnEnable
              ? context.l10n.select_squad_least_require_text
              : null,
        ),
        if (state.squad.isEmpty) ...[
          _emptyList(context.l10n.select_squad_empty_squad_text)
        ] else ...[
          for (final member in state.squad) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: UserDetailCell(
                user: member.player,
                trailing: _trailingButton(
                  context,
                  notifier,
                  member: member,
                  isRemove: true,
                ),
                onTap: () => UserDetailSheet.show(
                  context,
                  member.player,
                  actionButtonTitle: context.l10n.common_remove_title,
                  onButtonTap: () => notifier.removeFromSquad(member.player),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ],
    );
  }

  Widget _teamMemberList(
    BuildContext context,
    SelectSquadViewNotifier notifier,
    SelectSquadViewState state,
  ) {
    final memberList = getFilteredList(state);

    return Wrap(
      children: [
        if (memberList.isNotEmpty || (state.team?.players.isEmpty ?? true)) ...[
          _sectionTitle(context, context.l10n.select_squad_rest_of_team_title),
        ],
        if (state.team?.players.isEmpty ?? true) ...[
          _emptyList(context.l10n.select_squad_empty_team_member_text)
        ] else ...[
          for (final member in memberList) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: UserDetailCell(
                user: member,
                trailing: _trailingButton(
                  context,
                  notifier,
                  member: MatchPlayer(id: member.id, player: member),
                  isRemove: false,
                ),
                onTap: () => UserDetailSheet.show(
                  context,
                  member,
                  actionButtonTitle: context.l10n.common_add_title,
                  onButtonTap: () => notifier
                      .addToSquad(MatchPlayer(id: member.id, player: member)),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ],
    );
  }

  Widget _emptyList(String text) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style:
            AppTextStyle.body1.copyWith(color: context.colorScheme.textPrimary),
      ),
    );
  }

  List<UserModel> getFilteredList(SelectSquadViewState state) {
    return state.team?.players
            .where((element) =>
                !state.squad.map((e) => e.player.id).contains(element.id) &&
                element.user.isActive)
            .map((e) => e.user)
            .toList() ??
        [];
  }

  Widget _sectionTitle(BuildContext context, String title, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: AppTextStyle.subtitle1
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        if (subtitle != null) ...[
          const SizedBox(
            height: 2,
          ),
          Text(
            subtitle,
            style: AppTextStyle.body2
                .copyWith(color: context.colorScheme.textDisabled),
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _trailingButton(
    BuildContext context,
    SelectSquadViewNotifier notifier, {
    required MatchPlayer member,
    required bool isRemove,
  }) {
    return actionButton(
      context,
      onPressed: () => isRemove
          ? notifier.removeFromSquad(member.player)
          : notifier.addToSquad(member),
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      icon: Icon(
        isRemove ? Icons.close : Icons.add,
        size: 16,
        color: context.colorScheme.textDisabled,
      ),
    );
  }
}
