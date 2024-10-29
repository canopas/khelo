import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../components/empty_screen.dart';
import '../../../../../components/image_avatar.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../app_route.dart';
import '../tournament_detail_view_model.dart';

class TournamentDetailTeamsTab extends ConsumerWidget {
  final Function(List<TeamModel>) onSelected;

  const TournamentDetailTeamsTab({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tournamentDetailStateProvider);
    if (state.tournament!.teams.isEmpty) {
      return EmptyScreen(
        title: context.l10n.tournament_detail_teams_empty_title,
        description: context.l10n.tournament_detail_teams_empty_description,
        isShowButton: state.tournament!.created_by == state.currentUserId ||
            state.tournament!.members
                .any((element) => element.id == state.currentUserId),
        buttonTitle: context.l10n.tournament_detail_teams_select_btn,
        onTap: () async {
          final selectedTeams = await AppRoute.teamSelection(
                  selectedTeams: state.tournament!.teams)
              .push<List<TeamModel>>(context);
          if (context.mounted && selectedTeams != null) {
            onSelected.call(selectedTeams);
          }
        },
      );
    }

    return ListView.separated(
      itemCount: state.tournament!.teams.length,
      padding: context.mediaQueryPadding.copyWith(top: 0) +
          EdgeInsets.all(16).copyWith(bottom: 24),
      itemBuilder: (context, index) {
        return _teamCellView(context, state.tournament!.teams[index]);
      },
      separatorBuilder: (context, index) => SizedBox(height: 16),
    );
  }

  Widget _teamCellView(BuildContext context, TeamModel team) {
    return OnTapScale(
      onTap: () => AppRoute.teamDetail(teamId: team.id).push(context),
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          tileColor: context.colorScheme.surface,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          leading: ImageAvatar(
            initial: team.name_initial ?? team.name.initials(limit: 1),
            imageUrl: team.profile_img_url,
            size: 40,
          ),
          title: Text(
            team.name,
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          subtitle: team.players.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                      '${team.players.length} ${context.l10n.add_team_players_text}',
                      style: AppTextStyle.body2
                          .copyWith(color: context.colorScheme.textDisabled)),
                )
              : null,
          trailing: SvgPicture.asset(
            Assets.images.icArrowForward,
            colorFilter: ColorFilter.mode(
              context.colorScheme.textDisabled,
              BlendMode.srcATop,
            ),
          ),
        ),
      ),
    );
  }
}
