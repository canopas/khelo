import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/components/user_detail_sheet.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class MatchDetailSquadView extends ConsumerWidget {
  const MatchDetailSquadView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchDetailTabStateProvider);
    final notifier = ref.watch(matchDetailTabStateProvider.notifier);
    return _body(context, notifier, state);
  }

  _body(BuildContext context, MatchDetailTabViewNotifier notifier,
      MatchDetailTabState state) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onResume,
      );
    }

    return _listView(context, state);
  }

  Widget _listView(BuildContext context, MatchDetailTabState state) {
    final firstTeam = state.match!.teams.firstOrNull;
    final secondTeam = state.match!.teams.elementAtOrNull(1);
    final firstTeamSquad = firstTeam?.squad
            .where((element) => element.player.isActive)
            .map((e) => e.player)
            .toList() ??
        [];
    final secondTeamSquad = secondTeam?.squad
            .where((element) => element.player.isActive)
            .map((e) => e.player)
            .toList() ??
        [];

    final firstTeamBench = firstTeam?.team.players
            ?.where((element) =>
                !firstTeamSquad.map((e) => e.id).contains(element.id) &&
                element.isActive)
            .toList() ??
        [];

    final secondTeamBench = secondTeam?.team.players
            ?.where((element) =>
                !secondTeamSquad.map((e) => e.id).contains(element.id) &&
                element.isActive)
            .toList() ??
        [];

    return ListView(
      padding: context.mediaQueryPadding,
      children: [
        _teamNameView(context,
            firstTeamName: firstTeam?.team.name ?? "",
            secondTeamName: secondTeam?.team.name ?? ""),
        ..._buildTeamList(context,
            title: context.l10n.match_squad_playing_title,
            firstTeamPlayers: firstTeamSquad,
            secondPlayers: secondTeamSquad,
            firstTeamCaptainId: state.match!.teams.firstOrNull?.captain_id,
            secondTeamCaptainId:
                state.match!.teams.elementAtOrNull(1)?.captain_id),
        ..._buildTeamList(context,
            title: context.l10n.match_squad_bench_title,
            firstTeamPlayers: firstTeamBench,
            secondPlayers: secondTeamBench)
      ],
    );
  }

  Widget _teamNameView(
    BuildContext context, {
    required String firstTeamName,
    required String secondTeamName,
  }) {
    return Container(
      color: context.colorScheme.containerLow,
      child: Row(
        children: [
          Expanded(
              child: _titleView(
            context,
            title: firstTeamName,
            textAlign: TextAlign.left,
            verticalPadding: 8,
            textStyle: AppTextStyle.header4,
          )),
          _titleView(context,
              title: context.l10n.common_versus_short_title,
              verticalPadding: 8),
          Expanded(
              child: _titleView(
            context,
            title: secondTeamName,
            textAlign: TextAlign.right,
            verticalPadding: 8,
            textStyle: AppTextStyle.header4,
          )),
        ],
      ),
    );
  }

  List<Widget> _buildTeamList(
    BuildContext context, {
    required String title,
    required List<UserModel> firstTeamPlayers,
    required List<UserModel> secondPlayers,
    String? firstTeamCaptainId,
    String? secondTeamCaptainId,
  }) {
    List<Widget> children = [];

    final listLength = firstTeamPlayers.length > firstTeamPlayers.length
        ? firstTeamPlayers.length
        : firstTeamPlayers.length;
    if (listLength > 0) {
      children.add(const SizedBox(height: 16));
      children.add(_titleView(context, title: title));
    }

    for (int index = 0; index < listLength; index++) {
      final firstTeamPlayer = firstTeamPlayers.elementAtOrNull(index);
      final secondTeamPlayer = secondPlayers.elementAtOrNull(index);
      children.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: index == 0 ? 0 : 16),
        child: Divider(
          height: 0,
          color: context.colorScheme.outline,
        ),
      ));
      children.add(Row(
        children: [
          Expanded(
              child: _playerProfileView(context,
                  user: firstTeamPlayer, captainId: firstTeamCaptainId)),
          Expanded(
              child: _playerProfileView(context,
                  user: secondTeamPlayer,
                  isFirstCell: false,
                  captainId: secondTeamCaptainId))
        ],
      ));
    }
    return children;
  }

  Widget _titleView(
    BuildContext context, {
    required String title,
    TextAlign textAlign = TextAlign.center,
    TextStyle textStyle = AppTextStyle.subtitle1,
    double verticalPadding = 12,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 16),
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: textStyle.copyWith(color: context.colorScheme.textPrimary),
      ),
    );
  }

  Widget _playerProfileView(
    BuildContext context, {
    UserModel? user,
    bool isFirstCell = true,
    String? captainId,
  }) {
    if (user == null) {
      return const SizedBox(
        height: 0,
      );
    }
    bool isCaptain = user.id == captainId;
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        decoration: BoxDecoration(
            border: BorderDirectional(
                end: BorderSide(
                    color: isFirstCell
                        ? context.colorScheme.outline
                        : Colors.transparent))),
        child: OnTapScale(
          onTap: () => UserDetailSheet.show(context, user),
          child: Row(
            children: [
              ImageAvatar(
                initial: user.nameInitial,
                imageUrl: user.profile_img_url,
                size: 40,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name == null
                            ? context.l10n.common_anonymous_title
                            : "${user.name}${isCaptain ? context.l10n.match_info_captain_short_title : ""}",
                        style: AppTextStyle.subtitle2
                            .copyWith(color: context.colorScheme.textPrimary),
                      ),
                      Text(
                          user.player_role != null
                              ? user.player_role!.getString(context)
                              : context.l10n.common_not_specified_title,
                          style: AppTextStyle.caption.copyWith(
                              color: context.colorScheme.textDisabled)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
