import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/stats/user_match/match_detail_stat/match_detail_stat_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class MatchDetailStatScreen extends ConsumerStatefulWidget {
  final String matchId;

  const MatchDetailStatScreen({super.key, required this.matchId});

  @override
  ConsumerState createState() => _MatchDetailStatScreenState();
}

class _MatchDetailStatScreenState extends ConsumerState<MatchDetailStatScreen> {
  late MatchDetailStatViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(matchDetailStatViewStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.matchId));
  }

  @override
  Widget build(BuildContext context) {
    notifier = ref.watch(matchDetailStatViewStateProvider.notifier);
    final state = ref.watch(matchDetailStatViewStateProvider);
    return AppPage(
      title: context.l10n.match_stat_screen_title,
      body: _body(context, state),
    );
  }

  Widget _body(BuildContext context, MatchDetailStatViewState state) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    } else if (state.match != null) {
      return ListView.separated(
          padding: context.mediaQueryPadding +
              const EdgeInsets.only(left: 16, right: 16, bottom: 50),
          itemBuilder: (context, index) {
            return _teamDetailView(context, state, state.match!.teams[index]);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
          itemCount: state.match?.teams.length ?? 0);
    }
    return const SizedBox();
  }

  Widget _teamDetailView(
    BuildContext context,
    MatchDetailStatViewState state,
    MatchTeamModel team,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Column(
        children: [
          _teamProfileView(context, team.team),
          _teamScoreView(context, state, team),
        ],
      ),
    );
  }

  Widget _teamProfileView(BuildContext context, TeamModel team) {
    return Column(
      children: [
        Row(
          children: [
            ImageAvatar(
              initial: team.name[0].toUpperCase(),
              imageUrl: team.profile_img_url,
              size: 70,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(team.name,
                    style: AppTextStyle.header4
                        .copyWith(color: context.colorScheme.textPrimary)),
                Text(team.city ?? "",
                    style: AppTextStyle.subtitle2
                        .copyWith(color: context.colorScheme.textPrimary)),
                Text(
                    DateFormat.yMMMd()
                        .format(team.created_at ?? DateTime.now()),
                    style: AppTextStyle.subtitle2
                        .copyWith(color: context.colorScheme.textPrimary)),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Divider(color: context.colorScheme.outline),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _teamScoreView(
    BuildContext context,
    MatchDetailStatViewState state,
    MatchTeamModel team,
  ) {
    return Column(
      children: [
        _runScoredText(context, team.run ?? 0, team.over ?? 0),
        const SizedBox(
          height: 16,
        ),
        _wicketTaken(context, team.wicket.toString()),
        const SizedBox(
          height: 16,
        ),
        _extraAwarded(context, state, team.team.id ?? "INVALID ID"),
        const SizedBox(
          height: 16,
        ),
        _sixesAndFourView(context, state, team.team.id ?? "INVALID ID"),
        const SizedBox(
          height: 16,
        ),
        _squadExpansionView(context, state, team),
      ],
    );
  }

  Widget _wicketTaken(BuildContext context, String wicket) {
    return Row(
      children: [
        Expanded(
          child: _boundaryCountCell(
            context,
            context.l10n.common_wicket_taken_title,
            wicket,
          ),
        )
      ],
    );
  }

  Widget _runScoredText(BuildContext context, int run, double over) {
    return Text.rich(TextSpan(
        text: run.toString(),
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary, fontSize: 22),
        children: [
          TextSpan(
            text: context.l10n.match_stat_in_over_text(over.toString()),
            style: AppTextStyle.body1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ]));
  }

  Widget _sixesAndFourView(
    BuildContext context,
    MatchDetailStatViewState state,
    String teamId,
  ) {
    final (sixCount, fourCount) = _getBoundaryCount(state, teamId);

    return Row(
      children: [
        Expanded(
            child: _boundaryCountCell(context,
                context.l10n.match_stat_fours_title, fourCount.toString())),
        const SizedBox(width: 16),
        Expanded(
            child: _boundaryCountCell(context,
                context.l10n.match_stat_sixes_title, sixCount.toString())),
      ],
    );
  }

  (int, int) _getBoundaryCount(MatchDetailStatViewState state, String teamId) {
    final scoreList = state.firstInning?.team_id == teamId
        ? state.firstScore
        : state.secondScore;

    final sixCount = scoreList?.where((element) => element.is_six).length ?? 0;
    final fourCount =
        scoreList?.where((element) => element.is_four).length ?? 0;

    return (sixCount, fourCount);
  }

  Widget _boundaryCountCell(BuildContext context, String title, String count) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.containerLowOnSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
            text: count,
            style: AppTextStyle.header1
                .copyWith(color: context.colorScheme.textPrimary),
            children: [
              TextSpan(
                text: title,
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textSecondary),
              )
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _squadExpansionView(
    BuildContext context,
    MatchDetailStatViewState state,
    MatchTeamModel team,
  ) {
    return Material(
      color: Colors.transparent,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: ExpansionTile(
          collapsedBackgroundColor: context.colorScheme.containerLowOnSurface,
          backgroundColor: context.colorScheme.surface,
          iconColor: context.colorScheme.primary,
          collapsedIconColor: context.colorScheme.textPrimary,
          collapsedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: context.colorScheme.outline, width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
          title: _playedSquadText(context, team.squad.length),
          children: team.squad
              .map((e) =>
                  _playerCell(context, state, team.team.id ?? "INVALID ID", e))
              .toList(),
        ),
      ),
    );
  }

  Widget _playedSquadText(BuildContext context, int memberCount) {
    return Text.rich(TextSpan(
        text: context.l10n.match_stat_played_squad_title,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary, fontSize: 20),
        children: [
          TextSpan(
            text: context.l10n.match_stat_count_player_text(memberCount),
            style: AppTextStyle.body1
                .copyWith(color: context.colorScheme.textPrimary),
          )
        ]));
  }

  Widget _playerCell(
    BuildContext context,
    MatchDetailStatViewState state,
    String teamId,
    MatchPlayer player,
  ) {
    final (runs, over, wicket, batAvg) =
        _calculatePlayerDetails(state, teamId, player.player.id);
    return ListTile(
      title: Text(player.player.name ?? ""),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(
              text: "$runs",
              style: AppTextStyle.subtitle1.copyWith(
                  color: context.colorScheme.textPrimary, fontSize: 20),
              children: [
                TextSpan(
                    text: " ($over)",
                    style: AppTextStyle.body2
                        .copyWith(color: context.colorScheme.textSecondary))
              ])), // Text.rich
          Text(
            context.l10n.match_stat_count_wickets_text(wicket),
            style: AppTextStyle.body1
                .copyWith(color: context.colorScheme.textSecondary),
          ),
        ],
      ),
      trailing: Text(
        batAvg.toStringAsFixed(2) + context.l10n.match_stat_bat_avg_title,
        style: AppTextStyle.body2
            .copyWith(color: context.colorScheme.textSecondary),
        textAlign: TextAlign.center,
      ),
    );
  }

  (int, int, int, double) _calculatePlayerDetails(
    MatchDetailStatViewState state,
    String teamId,
    String playerId,
  ) {
    double batAvg = 0.0;

    final battingScoreList = state.firstInning?.team_id == teamId
        ? state.firstScore
        : state.secondScore;

    final bowlingScoreList = state.firstInning?.team_id == teamId
        ? state.secondScore
        : state.firstScore;

    final facedBalls = battingScoreList?.where((element) =>
        element.batsman_id == playerId &&
        element.extras_type != ExtrasType.penaltyRun &&
        element.wicket_type != WicketType.timedOut &&
        element.wicket_type != WicketType.retiredHurt &&
        element.wicket_type != WicketType.retired);

    final runs = facedBalls?.fold(
            0, (sum, element) => sum + (element.runs_scored ?? 0)) ??
        0;
    final ballCount = facedBalls?.length ?? 0;

    final wicket = bowlingScoreList
            ?.where((element) =>
                element.player_out_id == playerId &&
                element.wicket_type != null &&
                element.wicket_type != WicketType.timedOut &&
                element.wicket_type != WicketType.retiredHurt &&
                element.wicket_type != WicketType.retired)
            .length ??
        0;

    final dismissalCount = battingScoreList
            ?.where((element) => element.player_out_id == playerId)
            .length ??
        0;

    if (dismissalCount == 0) {
      batAvg = runs.toDouble();
    } else {
      batAvg = runs / dismissalCount;
    }

    return (runs, ballCount, wicket, batAvg);
  }

  Widget _extraAwarded(
    BuildContext context,
    MatchDetailStatViewState state,
    String teamId,
  ) {
    final extra = _calculateExtras(state, teamId);
    return Row(
      children: [
        Expanded(
            child: _boundaryCountCell(context,
                context.l10n.match_stat_extra_awarded_title, extra.toString()))
      ],
    );
  }

  int _calculateExtras(MatchDetailStatViewState state, String teamId) {
    final scoreList = state.firstInning?.team_id == teamId
        ? state.firstScore
        : state.secondScore;

    return scoreList?.fold(
            0, (sum, element) => (sum ?? 0) + (element.extras_awarded ?? 0)) ??
        0;
  }
}
