import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/won_by_message_text.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/data_model_extensions/match_model_extension.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class MatchDetailScorecardView extends ConsumerWidget {
  const MatchDetailScorecardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchDetailTabStateProvider);
    final notifier = ref.watch(matchDetailTabStateProvider.notifier);
    return _body(context, notifier,state);
  }

  Widget _body(BuildContext context, MatchDetailTabViewNotifier notifier, MatchDetailTabState state) {
    if (state.loading) {
      return const AppProgressIndicator();
    }

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: () async {
          await notifier.cancelStreamSubscription();
          notifier.loadMatch();
        },
      );
    }

    if (state.ballScores.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            context.l10n.match_scorecard_empty_scorecard_text,
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ),
      );
    }
    return _scorecardView(context, state);
  }

  Widget _scorecardView(BuildContext context, MatchDetailTabState state) {
    if (state.match == null) {
      return const SizedBox();
    }

    return ListView(
      padding: context.mediaQueryPadding,
      children: [
        _winnerMessageText(context, state.match!),
        for (final team in state.match!.teams) ...[
          _teamTitleView(
              context,
              team,
              state.match!.teams
                      .where((element) => element.team.id != team.team.id)
                      .firstOrNull
                      ?.wicket ??
                  0),
          _dataTable(context, state, team, isForBatting: true),
          const SizedBox(
            height: 16,
          ),
          _fallOfWicketView(
              context,
              state,
              state.firstInning?.team_id == team.team.id
                  ? state.firstInning?.id ?? 'INVALID ID'
                  : state.secondInning?.id ?? 'INVALID ID'),
          const SizedBox(
            height: 16,
          ),
          _dataTable(context, state, team, isForBatting: false),
          const SizedBox(
            height: 16,
          ),
          _powerPlayView(
              context,
              state,
              state.firstInning?.team_id == team.team.id
                  ? state.firstInning?.id ?? 'INVALID ID'
                  : state.secondInning?.id ?? 'INVALID ID'),
          const SizedBox(
            height: 20,
          )
        ]
      ],
    );
  }

  Widget _fallOfWicketView(
    BuildContext context,
    MatchDetailTabState state,
    String inningId,
  ) {
    final wickets = _getFallOfTheWicketDetail(state, inningId)
        .map((e) => "${e.$1} (${e.$2}, ${e.$3})")
        .join(", ");
    if (wickets.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tableRow(context,
            data: [],
            highlightRow: true,
            header: Text(
              context.l10n.match_scorecard_fall_of_wicket_text,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            )),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            wickets,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ),
      ],
    );
  }

  List<(int, String, String)> _getFallOfTheWicketDetail(
    MatchDetailTabState state,
    String inningId,
  ) {
    List<(int, String, String)> wickets = [];
    final scores = state.ballScores.where((element) =>
        element.inning_id == inningId &&
        element.wicket_type != null &&
        element.wicket_type != WicketType.retiredHurt);
    for (final ball in scores) {
      final teamId = state.firstInning?.id == inningId
          ? state.firstInning?.team_id
          : state.secondInning?.team_id;
      final playerName = state.match?.teams
          .firstWhere((element) => element.team.id == teamId)
          .squad
          .firstWhere((element) => element.player.id == ball.player_out_id)
          .player
          .name;
      final over = "${ball.over_number - 1}.${ball.ball_number}";
      final runs = _getTotalRunsBetweenOvers(state, inningId,
          endOver: ball.over_number, endBall: ball.ball_number);
      wickets.add((runs, playerName ?? "--", over));
    }

    return wickets;
  }

  Widget _powerPlayView(
    BuildContext context,
    MatchDetailTabState state,
    String inningId,
  ) {
    final List<(String overs, int run)> powerPlays =
        _getPowerPlayDetails(state, inningId);
    if (powerPlays.isEmpty) {
      return const SizedBox();
    } else {
      List<Widget> children = [];
      children.add(_tableRow(context,
          data: [
            context.l10n.match_scorecard_over_text,
            context.l10n.match_scorecard_run_text
          ],
          highlightRow: true,
          header: Text(
            context.l10n.match_scorecard_power_play_text,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          )));
      children.add(
        const SizedBox(
          height: 4,
        ),
      );
      int index = 0;
      for (var element in powerPlays) {
        index++;
        children.add(_tableRow(context,
            data: [(element.$1), "${element.$2}"],
            header: Text(
              context.l10n.power_play_text(index),
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            )));
      }
      return Column(
        children: children,
      );
    }
  }

  List<(String, int)> _getPowerPlayDetails(
      MatchDetailTabState state, String inningId) {
    List<(String, int)> powerPlays = [];

    void addPowerPlayDetails(List<int>? powerPlayOvers) {
      if (powerPlayOvers != null) {
        final start = powerPlayOvers.firstOrNull;
        final end = powerPlayOvers.lastOrNull;
        if (start != null && end != null) {
          powerPlays.add((
            start == end ? "$start" : "$start - $end",
            _getTotalRunsBetweenOvers(state, inningId,
                startOver: start, endOver: end)
          ));
        }
      }
    }

    addPowerPlayDetails(state.match?.power_play_overs1);
    addPowerPlayDetails(state.match?.power_play_overs2);
    addPowerPlayDetails(state.match?.power_play_overs3);

    return powerPlays;
  }

  int _getTotalRunsBetweenOvers(
    MatchDetailTabState state,
    String inningId, {
    int startOver = 0,
    required int endOver,
    int endBall = 6,
  }) {
    final runs = state.ballScores
        .where((element) =>
            element.inning_id == inningId &&
            element.over_number >= startOver &&
            (element.over_number < endOver ||
                (element.over_number == endOver &&
                    element.ball_number <= endBall)))
        .fold(
            0,
            (previousValue, element) =>
                previousValue +
                element.runs_scored +
                (element.extras_awarded ?? 0));
    return runs;
  }

  Widget _dataTable(
    BuildContext context,
    MatchDetailTabState state,
    MatchTeamModel team, {
    required bool isForBatting,
  }) {
    final teamInningId = state.firstInning?.team_id == team.team.id
        ? state.firstInning?.id
        : state.secondInning?.id;

    final bowlingSquad = state.match?.teams
        .firstWhere((element) => element.team.id != team.team.id)
        .squad;

    return Column(
      children: [
        _tableRow(context,
            highlightRow: true,
            data: isForBatting
                ? [
                    context.l10n.match_scorecard_run_short_text,
                    context.l10n.match_scorecard_ball_short_text,
                    context.l10n.match_scorecard_fours_short_text,
                    context.l10n.match_scorecard_sixes_short_text,
                    context.l10n.match_scorecard_strike_rate_short_text
                  ]
                : [
                    context.l10n.match_scorecard_over_short_text,
                    context.l10n.match_scorecard_maiden_short_text,
                    context.l10n.match_scorecard_run_short_text,
                    context.l10n.match_scorecard_wicket_short_text,
                    context.l10n.match_scorecard_no_ball_short_text,
                    context.l10n.match_scorecard_wide_ball_short_text,
                    context.l10n.match_scorecard_economy_short_text
                  ],
            header: Text(isForBatting
                ? context.l10n.match_scorecard_batter_text
                : context.l10n.match_scorecard_bowler_text)),
        const SizedBox(
          height: 4,
        ),
        if (isForBatting)
          ..._buildBatsmanList(
            context,
            state,
            bowlingSquad: bowlingSquad ?? [],
            inningId: teamInningId ?? "INVALID ID",
            players: team.squad,
          )
        else
          ..._buildBowlerList(
            context,
            state,
            inningId: teamInningId ?? "INVALID ID",
            players: bowlingSquad ?? [],
          ),
      ],
    );
  }

  Widget _tableRow(
    BuildContext context, {
    Widget? header,
    bool highlightRow = false,
    int? highlightColumnNumber,
    required List<String> data,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 16.0, vertical: highlightRow ? 2 : 0),
      decoration: BoxDecoration(
        color: highlightRow
            ? context.colorScheme.containerNormalOnSurface
            : Colors.transparent,
      ),
      child: Row(
        children: [
          if (header != null) ...[
            Expanded(flex: (data.length + 1) ~/ 1.5, child: header),
          ],
          for (int i = 0; i < data.length; i++) ...[
            Expanded(
                child: Text(
              data[i],
              style: i == highlightColumnNumber
                  ? AppTextStyle.header3
                      .copyWith(color: context.colorScheme.textPrimary)
                  : AppTextStyle.subtitle1
                      .copyWith(color: context.colorScheme.textPrimary),
              textAlign: TextAlign.center,
            )),
          ]
        ],
      ),
    );
  }

  List<Widget> _buildBatsmanList(
    BuildContext context,
    MatchDetailTabState state, {
    required String inningId,
    required List<MatchPlayer> players,
    required List<MatchPlayer> bowlingSquad,
  }) {
    List<MatchPlayer> filteredPlayer =
        players.where((element) => element.index != null).toList();
    filteredPlayer.sort((a, b) => a.index?.compareTo(b.index ?? 0) ?? 0);
    List<Widget> children = [];
    for (final player in filteredPlayer) {
      final (run, ball, four, six, strikeRate) =
          _getBattingPerformance(state, inningId, player.player.id);

      final (bowler, fielder, wicketType) =
          _getWicketDetail(state, bowlingSquad, inningId, player.player.id);

      String wicketString = "";
      if (wicketType == null) {
        wicketString = context.l10n.match_scorecard_not_out_text;
      } else {
        if (fielder == null) {
          wicketString = wicketType.getString(context);

          if (wicketType != WicketType.timedOut &&
              wicketType != WicketType.retired &&
              wicketType != WicketType.retiredHurt) {
            wicketString += " ($bowler)";
          }
        } else {
          wicketString = context.l10n
              .match_scorecard_bowler_catcher_short_text(bowler ?? "", fielder);
        }
      }
      children.add(_tableRow(context,
          highlightColumnNumber: 0,
          data: [
            run.toString(),
            ball.toString(),
            four.toString(),
            six.toString(),
            strikeRate.toStringAsFixed(1)
          ],
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${player.player.name}",
                style: AppTextStyle.subtitle1.copyWith(
                    color: context.colorScheme.textPrimary, fontSize: 20),
              ),
              Text(
                wicketString,
                style: AppTextStyle.body1
                    .copyWith(color: context.colorScheme.textSecondary),
              ),
            ],
          )));
    }
    final (bye, legBye, wide, noBall, penalty) =
        _getExtraCounts(state, inningId);
    children.add(_matchTotalView(context,
        title: context.l10n.match_scorecard_extra_text,
        count: (bye + legBye + wide + noBall + penalty),
        countDescription: context.l10n.match_scorecard_extras_short_text(
            bye, legBye, wide, noBall, penalty)));

    final inning = state.firstInning?.id == inningId
        ? state.firstInning
        : state.secondInning;
    final bowlingInning = state.firstInning?.id == inningId
        ? state.secondInning
        : state.firstInning;
    children.add(_matchTotalView(context,
        title: context.l10n.match_scorecard_total_text,
        count: inning?.total_runs ?? 0,
        countDescription: context.l10n.match_scorecard_wicket_over_text(
            bowlingInning?.total_wickets ?? 0, inning?.overs ?? 0)));

    String yetToPlayPlayers = players
        .where((element) => element.index == null)
        .map((e) => e.player.name)
        .join(", ");
    if (yetToPlayPlayers.isNotEmpty) {
      children.add(_didNotBatView(context, yetToPlayPlayers));
    }

    return children;
  }

  Widget _didNotBatView(BuildContext context, String players) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
              child: Text(
            context.l10n.match_scorecard_did_not_bat_text,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          )),
          Expanded(
              child: Text(players,
                  style: AppTextStyle.subtitle1
                      .copyWith(color: context.colorScheme.textPrimary))),
        ],
      ),
    );
  }

  (int, int, int, int, int) _getExtraCounts(
      MatchDetailTabState state, String inningId) {
    int wide = 0;
    int noBall = 0;
    int penalty = 0;
    int legBye = 0;
    int bye = 0;
    final extrasScore = state.ballScores.where((element) =>
        element.inning_id == inningId && element.extras_type != null);

    for (var element in extrasScore) {
      switch (element.extras_type) {
        case ExtrasType.wide:
          wide = wide + (element.extras_awarded ?? 0);
        case ExtrasType.noBall:
          noBall = noBall + (element.extras_awarded ?? 0);
        case ExtrasType.bye:
          penalty = penalty + (element.extras_awarded ?? 0);
        case ExtrasType.legBye:
          legBye = legBye + (element.extras_awarded ?? 0);
        case ExtrasType.penaltyRun:
          bye = bye + (element.extras_awarded ?? 0);
        default:
          break;
      }
    }
    return (bye, legBye, wide, noBall, penalty);
  }

  Widget _matchTotalView(
    BuildContext context, {
    required String title,
    required int count,
    required String countDescription,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          )),
          Expanded(
              child: Text.rich(
                  style: AppTextStyle.header3
                      .copyWith(color: context.colorScheme.textPrimary),
                  TextSpan(text: "$count", children: [
                    TextSpan(
                        text: " ($countDescription)",
                        style: AppTextStyle.subtitle1
                            .copyWith(color: context.colorScheme.textPrimary))
                  ]))),
        ],
      ),
    );
  }

  (int, int, int, int, double) _getBattingPerformance(
    MatchDetailTabState state,
    String inningId,
    String batsManId,
  ) {
    final batScore = state.ballScores.where(
      (element) =>
          element.inning_id == inningId &&
          element.batsman_id == batsManId &&
          element.extras_type != ExtrasType.penaltyRun &&
          element.wicket_type != WicketType.timedOut &&
          element.wicket_type != WicketType.retiredHurt &&
          element.wicket_type != WicketType.retired,
    );
    int run = 0;
    int ball = 0;
    int fours = 0;
    int sixes = 0;

    for (var element in batScore) {
      if (element.extras_type != ExtrasType.wide) {
        ball = ball + 1;
      }

      if (element.extras_type == ExtrasType.noBall) {
        final extra = (element.extras_awarded ?? 0) > 1
            ? (element.extras_awarded ?? 1) - 1
            : 0;
        run = run + extra;
      }
      run = run + element.runs_scored;
      if (element.is_six && element.runs_scored == 6) {
        sixes = sixes + 1;
      } else if (element.is_four && element.runs_scored == 4) {
        fours = fours + 1;
      }
    }

    final strikeRate = (run / ball) * 100;
    return (run, ball, fours, sixes, strikeRate.isNaN ? 0 : strikeRate);
  }

  (String?, String?, WicketType?) _getWicketDetail(
    MatchDetailTabState state,
    List<MatchPlayer> bowlingSquad,
    String inningId,
    String batsManId,
  ) {
    final batScore = state.ballScores
        .where(
          (element) =>
              element.inning_id == inningId &&
              element.player_out_id == batsManId,
        )
        .firstOrNull;
    if (batScore == null) {
      return (null, null, null);
    }

    final bowlerName = bowlingSquad
        .where((element) => element.player.id == batScore.bowler_id)
        .firstOrNull
        ?.player
        .name;
    final fielderName = bowlingSquad
        .where((element) => element.player.id == batScore.wicket_taker_id)
        .firstOrNull
        ?.player
        .name;

    return (bowlerName, fielderName, batScore.wicket_type);
  }

  List<Widget> _buildBowlerList(
    BuildContext context,
    MatchDetailTabState state, {
    required String inningId,
    required List<MatchPlayer> players,
  }) {
    List<Widget> children = [];
    for (final player in players) {
      final (over, maiden, runsConceded, wicket, noBall, wideBall, economy) =
          _getBowlingPerformance(state, inningId, player.player.id);
      if (over != null) {
        children.add(_tableRow(context,
            highlightColumnNumber: 3,
            data: [
              over.toStringAsFixed(1),
              maiden.toString(),
              runsConceded.toString(),
              wicket.toString(),
              noBall.toString(),
              wideBall.toString(),
              economy.toStringAsFixed(1)
            ],
            header: Text("${player.player.name}")));
      }
    }
    return children;
  }

  (double?, int, int, int, int, int, double) _getBowlingPerformance(
    MatchDetailTabState state,
    String inningId,
    String bowlerId,
  ) {
    final batScore = state.ballScores.where(
      (element) =>
          element.inning_id == inningId &&
          element.bowler_id == bowlerId &&
          element.extras_type != ExtrasType.penaltyRun &&
          element.wicket_type != WicketType.timedOut &&
          element.wicket_type != WicketType.retiredHurt &&
          element.wicket_type != WicketType.retired,
    );
    if (batScore.isEmpty) {
      return (null, 0, 0, 0, 0, 0, 0);
    }
    int ball = 0;
    int maiden = 0;
    int run = 0;
    int wicket = 0;
    int noBall = 0;
    int wide = 0;

    for (var element in batScore) {
      if (element.extras_type == ExtrasType.noBall) {
        final extra = (element.extras_awarded ?? 0) > 1
            ? (element.extras_awarded ?? 1) - 1
            : 0;
        run = run + element.runs_scored + extra;
        noBall = noBall + 1;
      } else if (element.extras_type == ExtrasType.wide) {
        wide = wide + 1;
      } else {
        run = run + element.runs_scored + (element.extras_awarded ?? 0);
        ball = ball + 1;
        if (element.wicket_type != null) {
          wicket = wicket + 1;
        }
      }
    }
    final over = ball / 6;
    final economy = run / over;
    return (
      over,
      maiden,
      run,
      wicket,
      noBall,
      wide,
      economy.isNaN ? 0 : economy
    );
  }

  Widget _winnerMessageText(BuildContext context, MatchModel match) {
    final winSummary = match.getWinnerSummary(context);
    if (match.match_status == MatchStatus.finish && winSummary != null) {
      if (winSummary.teamName.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            context.l10n.score_board_match_tied_text,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.primary),
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.all(16),
        child: WonByMessageText(
          teamName: winSummary.teamName,
          difference: winSummary.difference,
          trailingText: winSummary.wonByText,
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _teamTitleView(BuildContext context, MatchTeamModel team, int wicket) {
    return Container(
      color: context.colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            team.team.name,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary, fontSize: 20),
          ),
          Text(
            "${team.run} - $wicket ${context.l10n.match_commentary_trailing_over_short_text(team.over)}",
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary, fontSize: 20),
          )
        ],
      ),
    );
  }
}
