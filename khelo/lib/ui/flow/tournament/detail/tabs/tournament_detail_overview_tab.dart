import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/won_by_message_text.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/tournament/detail/components/match_group_tag.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../components/image_avatar.dart';
import '../tournament_detail_view_model.dart';

class TournamentDetailOverviewTab extends ConsumerWidget {
  final PageController controller;

  const TournamentDetailOverviewTab({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tournamentDetailStateProvider);
    return ListView(
      padding: context.mediaQueryPadding.copyWith(top: 0) +
          EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 40),
      children: [
        _featuredMatchesView(context, state.matches),
        _keyStatsView(context, state.keyStats),
        _teamsSquadsView(context, state.tournament!.teams),
        _infoView(context, state.tournament!),
      ],
    );
  }

  Widget _featuredMatchesView(BuildContext context, List<MatchModel> matches) {
    if (matches.isEmpty) return SizedBox();

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          _header(
            context,
            title:
                context.l10n.tournament_detail_overview_featured_matches_title,
            showViewAll: matches.length > 3,
            onViewAll: () => controller.jumpToPage(2),
          ),
          ...List.generate(
            matches.take(3).length,
            (index) => _matchCellView(context, matches[index]),
          )
        ],
      ),
    );
  }

  Widget _matchCellView(BuildContext context, MatchModel match) {
    final showMatchGroup =
        match.match_group != null && match.match_group != MatchGroup.round;
    return OnTapScale(
      onTap: () => AppRoute.matchDetailTab(matchId: match.id).push(context),
      child: Container(
        padding: showMatchGroup
            ? EdgeInsets.only(top: 8, bottom: 8, right: 16)
            : EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            if (showMatchGroup) MatchGroupTag(tag: match.match_group!),
            _buildTeamInfo(context, team: match.teams.first.team),
            if (match.matchResult != null) ...[
              Expanded(
                child: WonByMessageText(
                  isTournament: true,
                  matchResult: match.matchResult,
                ),
              ),
            ] else ...[
              Expanded(
                child: Column(
                  children: [
                    Text(
                      match.start_at?.format(context, DateFormatType.time) ??
                          DateTime.now().format(context, DateFormatType.time),
                      textAlign: TextAlign.center,
                      style: AppTextStyle.caption
                          .copyWith(color: context.colorScheme.textDisabled),
                    ),
                    Text(
                      match.start_at?.relativeTime(context) ??
                          DateTime.now().relativeTime(context),
                      textAlign: TextAlign.center,
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textPrimary),
                    ),
                  ],
                ),
              ),
            ],
            _buildTeamInfo(
              context,
              team: match.teams.last.team,
              isSecond: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamInfo(
    BuildContext context, {
    required TeamModel team,
    bool isSecond = false,
  }) {
    final initials = team.name_initial ?? team.name.initials(limit: 2);
    return MediaQuery.withNoTextScaling(
      child: Row(
        children: [
          if (isSecond) ...[
            Text(
              initials,
              style: AppTextStyle.subtitle1.copyWith(
                color: context.colorScheme.textPrimary,
              ),
            ),
            const SizedBox(width: 16),
            ImageAvatar(
              initial: initials,
              imageUrl: team.profile_img_url,
              size: 40,
            ),
          ] else ...[
            ImageAvatar(
              initial: initials,
              imageUrl: team.profile_img_url,
              size: 40,
            ),
            const SizedBox(width: 16),
            Text(
              initials,
              style: AppTextStyle.subtitle1.copyWith(
                color: context.colorScheme.textPrimary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _keyStatsView(BuildContext context, List<PlayerKeyStat> keyStats) {
    if (keyStats.isEmpty) return SizedBox();

    final keyStatsList = List.of(keyStats)
      ..sort((a, b) => b.value?.compareTo(a.value ?? 0) ?? 0);

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(
            context,
            showViewAll: keyStatsList.length > 4,
            title: context.l10n.tournament_detail_overview_key_stats_title,
            onViewAll: () => controller.jumpToPage(4),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: keyStatsList.take(4).length,
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 115,
            ),
            itemBuilder: (context, index) =>
                _keyStatsCellView(context, keyStatsList[index]),
          )
        ],
      ),
    );
  }

  Widget _keyStatsCellView(BuildContext context, PlayerKeyStat keyStat) {
    if (keyStat.tag == null && keyStat.value == null) return SizedBox();

    return MediaQuery.withNoTextScaling(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  keyStat.tag!.getString(context),
                  style: AppTextStyle.body2
                      .copyWith(color: context.colorScheme.positive),
                ),
                Text(
                  keyStat.value.toString(),
                  style: AppTextStyle.subtitle1.copyWith(
                    color: context.colorScheme.textPrimary,
                  ),
                )
              ],
            ),
            Divider(color: context.colorScheme.outline),
            Row(
              children: [
                ImageAvatar(
                  initial: keyStat.player.nameInitial,
                  imageUrl: keyStat.player.profile_img_url,
                  size: 40,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        keyStat.player.name ?? '',
                        style: AppTextStyle.subtitle2.copyWith(
                          color: context.colorScheme.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        keyStat.teamName,
                        style: AppTextStyle.caption.copyWith(
                          color: context.colorScheme.textDisabled,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _teamsSquadsView(BuildContext context, List<TeamModel> teams) {
    if (teams.isEmpty) return SizedBox();

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(
            context,
            showViewAll: teams.length > 3,
            title: context.l10n.tournament_detail_overview_teams_squads_title,
            onViewAll: () => controller.jumpToPage(1),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 136,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    teams.map((team) => _teamCellView(context, team)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _teamCellView(BuildContext context, TeamModel team) {
    return OnTapScale(
      onTap: () => AppRoute.teamDetail(teamId: team.id).push(context),
      child: Container(
        width: 120,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ImageAvatar(
              initial: team.name_initial ?? team.name.initials(limit: 1),
              imageUrl: team.profile_img_url,
              size: 40,
            ),
            const SizedBox(height: 16),
            Flexible(
              child: Text(
                team.name,
                style: AppTextStyle.subtitle2.copyWith(
                  color: context.colorScheme.textPrimary,
                ),
                textAlign: TextAlign.center,
                textScaler: TextScaler.noScaling,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoView(BuildContext context, TournamentModel tournament) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context,
              title: context.l10n.tournament_detail_overview_info_title),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _infoCellView(
                  context,
                  context.l10n.tournament_detail_overview_name_title,
                  tournament.name,
                ),
                Divider(color: context.colorScheme.outline, height: 1),
                _infoCellView(
                  context,
                  context.l10n.tournament_detail_overview_duration_title,
                  DateFormatter.formatDateRange(
                    context,
                    startDate: tournament.start_date,
                    endDate: tournament.end_date,
                    formatType: DateFormatType.dayMonth,
                  ),
                ),
                Divider(color: context.colorScheme.outline, height: 1),
                _infoCellView(
                  context,
                  context.l10n.tournament_detail_overview_type_title,
                  tournament.type.getString(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCellView(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.subtitle3
                  .copyWith(color: context.colorScheme.textSecondary),
              textScaler: TextScaler.noScaling,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textPrimary),
              textAlign: TextAlign.end,
              textScaler: TextScaler.noScaling,
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(
    BuildContext context, {
    required String title,
    bool showViewAll = false,
    Function()? onViewAll,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.header4
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ),
        Visibility(
          visible: showViewAll,
          child: TextButton(
            onPressed: onViewAll,
            child: Text(
              context.l10n.common_view_all,
              style: AppTextStyle.subtitle3
                  .copyWith(color: context.colorScheme.primary),
            ),
          ),
        )
      ],
    );
  }
}
