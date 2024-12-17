import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/matches/add_match/add_match_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class TeamSelectionView extends StatelessWidget {
  final AddMatchViewNotifier notifier;
  final AddMatchViewState state;

  const TeamSelectionView({
    super.key,
    required this.notifier,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
              color: context.colorScheme.containerLow,
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _selectTeamCell(context, notifier, state, TeamType.a),
              Center(
                child: Text(
                  context.l10n.common_versus_short_title,
                  style: AppTextStyle.subtitle1
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
              ),
              _selectTeamCell(context, notifier, state, TeamType.b),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectTeamCell(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
    TeamType type,
  ) {
    final TeamModel? team = type == TeamType.a ? state.teamA : state.teamB;
    final validSquad = team == null
        ? true
        : type == TeamType.a
            ? (state.squadA?.length ?? 0) >= 2 &&
                state.teamAAdminId != null &&
                state.teamACaptainId != null
            : (state.squadB?.length ?? 0) >= 2 &&
                state.teamBAdminId != null &&
                state.teamBCaptainId != null;
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OnTapScale(
            onTap: () async {
              final team = await AppRoute.searchTeam(
                excludedIds: [
                  state.teamA?.id ?? "INVALID ID",
                  state.teamB?.id ?? "INVALID ID"
                ],
                onlyUserTeams: type == TeamType.a,
              ).push<TeamModel>(context);
              if (team != null && context.mounted) {
                notifier.onTeamSelect(team, type);
              }
            },
            child: Container(
              height: 80,
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2,
                    color: validSquad
                        ? Colors.transparent
                        : context.colorScheme.alert),
                color: validSquad
                    ? context.colorScheme.containerHigh
                    : context.colorScheme.alert.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                image: (team != null && team.profile_img_url != null)
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(
                          team.profile_img_url!,
                        ),
                        fit: BoxFit.cover)
                    : null,
              ),
              child: (team == null)
                  ? Text(
                      type.getString(context),
                      style: AppTextStyle.subtitle1
                          .copyWith(color: context.colorScheme.textDisabled),
                    )
                  : (team.profile_img_url == null)
                      ? Text(
                          team.name_initial ?? team.name.initials(limit: 1),
                          style: AppTextStyle.subtitle1.copyWith(
                              color: context.colorScheme.textDisabled),
                        )
                      : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            team?.name ?? context.l10n.add_match_team_name_placeholder,
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle3
                .copyWith(color: context.colorScheme.textDisabled),
            maxLines: 2,
          ),
          if (team != null) ...[
            const SizedBox(height: 4),
            _selectSquadButton(
                context, notifier, state, team, type, validSquad),
          ],
        ],
      ),
    );
  }

  Widget _selectSquadButton(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
    TeamModel team,
    TeamType type,
    bool isValidSquad,
  ) {
    return OnTapScale(
        onTap: () async {
          final squad = await AppRoute.selectSquad(
            team: team,
            squad: type == TeamType.a
                ? state.squadA
                    ?.where(
                      (element) => element.player.isActive,
                    )
                    .toList()
                : state.squadB
                    ?.where((element) => element.player.isActive)
                    .toList(),
            captainId: type == TeamType.a
                ? state.teamACaptainId
                : state.teamBCaptainId,
            adminId:
                type == TeamType.a ? state.teamAAdminId : state.teamBAdminId,
          ).push<Map<String, dynamic>>(context);
          if (squad != null && context.mounted) {
            notifier.onSquadSelect(type, squad);
          }
        },
        child: Text(
          context.l10n.common_select_squad_title,
          style: AppTextStyle.button.copyWith(
              color: isValidSquad
                  ? context.colorScheme.primary
                  : context.colorScheme.alert),
        ));
  }
}
