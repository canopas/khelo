import 'package:data/api/match/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class MatchDetailInfoView extends ConsumerWidget {
  const MatchDetailInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchDetailTabStateProvider);
    return _body(context, state);
  }

  Widget _body(BuildContext context, MatchDetailTabState state) {
    if (state.loading) {
      return const AppProgressIndicator();
    }
    return ListView(
      padding:
          context.mediaQueryPadding + const EdgeInsets.symmetric(horizontal: 8),
      children: [
        _sectionTitle(context, context.l10n.match_detail_match_info_tab_title),
        _matchTitleView(context, state.match!),
        _matchDateTimeView(context, state.match?.start_time ?? DateTime.now()),
        _tossDetailView(context, state.match!),
        _matchOfficialView(context, state.match!),
        for (final team in state.match?.teams ?? []) ...[
          _teamPlayerView(context, team: team)
        ],
        _sectionTitle(context, context.l10n.match_info_venue_title),
        _dataRowView(context,
            title: context.l10n.match_info_ground_title,
            subtitle: state.match?.ground ?? "-"),
        _dataRowView(context,
            title: context.l10n.match_info_city_title,
            subtitle: state.match?.city ?? "-"),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Container(
      color: context.colorScheme.containerNormalOnSurface,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(top: 8),
      child: Text(
        title,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary),
      ),
    );
  }

  Widget _dataRowView(
    BuildContext context, {
    required String title,
    String? subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Text(
                title,
                style: AppTextStyle.header4
                    .copyWith(color: context.colorScheme.textPrimary),
              )),
          if (subtitle != null) ...[
            Expanded(
                flex: 3,
                child: Text(
                  subtitle,
                  style: AppTextStyle.subtitle1
                      .copyWith(color: context.colorScheme.textPrimary),
                )),
          ],
        ],
      ),
    );
  }

  Widget _matchTitleView(BuildContext context, MatchModel match) {
    String title = match.teams
        .map((e) => e.team.name)
        .join(" ${context.l10n.add_match_versus_short_title} ");
    return _dataRowView(context,
        title: context.l10n.match_info_match_title, subtitle: title);
  }

  Widget _matchDateTimeView(BuildContext context, DateTime matchTime) {
    return Column(
      children: [
        _dataRowView(context,
            title: context.l10n.match_info_date_title,
            subtitle: matchTime.format(context, DateFormatType.date)),
        _dataRowView(context,
            title: context.l10n.match_info_time_title,
            subtitle: matchTime.format(context, DateFormatType.time)),
      ],
    );
  }

  Widget _tossDetailView(BuildContext context, MatchModel match) {
    String? teamName = match.teams
        .where((element) => element.team.id == match.toss_winner_id)
        .firstOrNull
        ?.team
        .name;
    String? decision = match.toss_decision?.getString(context);
    if (teamName != null &&
        teamName.isNotEmpty &&
        decision != null &&
        decision.isNotEmpty) {
      return _dataRowView(context,
          title: context.l10n.match_info_toss_title,
          subtitle:
              context.l10n.match_info_toss_detail_text(teamName, decision));
    } else {
      return const SizedBox();
    }
  }

  Widget _teamPlayerView(
    BuildContext context, {
    required MatchTeamModel team,
  }) {
    String playing = team.squad
        .map((e) =>
            "${e.player.name}${team.captain_id == e.player.id ? context.l10n.match_info_captain_short_title : ""}")
        .join(", ");
    String? bench = team.team.players
        ?.where((element) =>
            !team.squad.map((e) => e.player.id).contains(element.id))
        .join(", ");
    return Column(
      children: [
        _dataRowView(context,
            title: context.l10n.match_info_squad_title(team.team.name)),
        _dataRowView(context,
            title: context.l10n.match_info_playing_title, subtitle: playing),
        if (bench != null && (bench).isNotEmpty) ...[
          _dataRowView(context,
              title: context.l10n.match_info_bench_title, subtitle: bench),
        ],
      ],
    );
  }

  Widget _matchOfficialView(BuildContext context, MatchModel match) {
    String? umpires = match.umpires?.map((e) => e.name).join(", ");
    return Column(
      children: [
        if (umpires != null && umpires.isNotEmpty) ...[
          _dataRowView(context,
              title: context.l10n.match_info_umpire_title, subtitle: umpires),
        ],
        if (match.referee?.name != null &&
            (match.referee?.name ?? "").isNotEmpty) ...[
          _dataRowView(context,
              title: context.l10n.match_info_referee_title,
              subtitle: match.referee?.name),
        ],
      ],
    );
  }
}
