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
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../components/image_avatar.dart';

class TournamentDetailOverviewTab extends ConsumerStatefulWidget {
  final TournamentModel tournament;

  const TournamentDetailOverviewTab({
    super.key,
    required this.tournament,
  });

  @override
  ConsumerState<TournamentDetailOverviewTab> createState() =>
      _TournamentDetailOverviewTabState();
}

class _TournamentDetailOverviewTabState
    extends ConsumerState<TournamentDetailOverviewTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.containerLow,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16)
            .copyWith(bottom: context.mediaQueryPadding.bottom + 40),
        children: [
          _featuredMatchesView(context, widget.tournament.matches),
          _keyStatsView(context, widget.tournament.keyStats),
          _teamsSquadsView(context, widget.tournament.teams),
          _infoView(context, widget.tournament),
        ],
      ),
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
            onViewAll: () {},
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildTeamInfo(team: match.teams.first.team),
          const Spacer(),
          if (match.matchResult != null) ...[
            WonByMessageText(
              isTournament: true,
              matchResult: match.matchResult,
            ),
          ] else ...[
            Column(
              children: [
                Text(
                  match.start_at?.format(context, DateFormatType.time) ??
                      DateTime.now().format(context, DateFormatType.time),
                  style: AppTextStyle.caption
                      .copyWith(color: context.colorScheme.textDisabled),
                ),
                Text(
                  match.start_at?.relativeTime(context) ??
                      DateTime.now().relativeTime(context),
                  style: AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
              ],
            ),
          ],
          const Spacer(),
          _buildTeamInfo(team: match.teams.last.team, isSecond: true),
        ],
      ),
    );
  }

  Widget _buildTeamInfo({
    required TeamModel team,
    bool isSecond = false,
  }) {
    final initials = team.name_initial ?? team.name.initials(limit: 2);
    return Row(
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
    );
  }

  Widget _keyStatsView(BuildContext context, List<PlayerKeyStat> keyStats) {
    if (keyStats.isEmpty) return SizedBox();

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(
            context,
            showViewAll: keyStats.length > 4,
            title: context.l10n.tournament_detail_overview_key_stats_title,
            onViewAll: () {},
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: keyStats.take(4).length,
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 115,
            ),
            itemBuilder: (context, index) =>
                _keyStatsCellView(context, keyStats[index]),
          )
        ],
      ),
    );
  }

  Widget _keyStatsCellView(BuildContext context, PlayerKeyStat keyStat) {
    if (keyStat.tag == null && keyStat.value == null) return SizedBox();

    return Container(
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
                    )
                  ],
                ),
              )
            ],
          ),
        ],
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
            showViewAll: teams.length >= 3,
            title: context.l10n.tournament_detail_overview_teams_squads_title,
            onViewAll: () {},
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 130,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => _teamCellView(
                context,
                teams[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemCount: teams.length,
            ),
          )
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
          Text(
            title,
            style: AppTextStyle.subtitle3
                .copyWith(color: context.colorScheme.textSecondary),
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
        Text(
          title,
          style: AppTextStyle.header4
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const Spacer(),
        Opacity(
          opacity: showViewAll ? 1 : 0,
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
