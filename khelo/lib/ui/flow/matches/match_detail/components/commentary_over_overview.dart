import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/data_model_extensions/ball_score_model_extension.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/over_score_view.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class CommentaryOverOverview extends ConsumerWidget {
  final int index;

  const CommentaryOverOverview({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchDetailTabStateProvider);

    final over = _getOverBallScores(state, index);
    final overLastBall = over.lastOrNull;
    final overNumber = overLastBall?.over_number ?? 0;
    final inningId = overLastBall?.inning_id ?? "INVALID ID";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: context.colorScheme.containerNormalOnSurface,
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Text(
                  "$overNumber",
                  style: AppTextStyle.header1
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
                const SizedBox(
                  width: 12,
                ),
                _divider(context, axis: Axis.vertical),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BowlerSummary(
                          state: state,
                          index: index + 1,
                          inningId: inningId,
                          bowlerId: overLastBall?.bowler_id ?? "INVALID ID"),
                      const SizedBox(
                        height: 4,
                      ),
                      OverScoreView(
                        over: over,
                        size: 30,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          _divider(context),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: _batsMenView(
                      context,
                      state,
                      inningId,
                      index,
                      overLastBall?.batsman_id ?? "INVALID ID",
                      overLastBall?.non_striker_id ?? "INVALID ID"),
                ),
                _divider(context, axis: Axis.vertical),
                Expanded(
                  flex: 3,
                  child: _teamTotalView(context, state, inningId),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<BallScoreModel> _getOverBallScores(
    MatchDetailTabState state,
    int index,
  ) {
    final currentOverNumber = state.ballScores[index].over_number;
    final currentInningId = state.ballScores[index].inning_id;
    return state.ballScores
        .where((element) =>
            element.over_number == currentOverNumber &&
            element.inning_id == currentInningId)
        .toList();
  }

  Widget _divider(BuildContext context, {Axis axis = Axis.horizontal}) {
    if (axis == Axis.horizontal) {
      return Divider(
        color: context.colorScheme.outline,
      );
    } else {
      return VerticalDivider(
        color: context.colorScheme.outline,
      );
    }
  }

  Widget _batsMenView(BuildContext context, MatchDetailTabState state,
      String inningId, int index, String batsmanId, String nonStrikerId) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _batsManScoreView(context, state, index, batsmanId, inningId),
        _batsManScoreView(context, state, index, nonStrikerId, inningId)
      ],
    );
  }

  Widget _batsManScoreView(BuildContext context, MatchDetailTabState state,
      int index, String batsManId, String inningId) {
    final (batsManName, runs, ball) =
        _getBatsManSummaryTillIndex(state, index, batsManId, inningId);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Text(
          batsManName,
          style: AppTextStyle.subtitle1
              .copyWith(color: context.colorScheme.textPrimary),
        )),
        Text.rich(TextSpan(
            text: "$runs",
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
            children: [
              TextSpan(
                text: "($ball)",
                style: AppTextStyle.body1
                    .copyWith(color: context.colorScheme.textPrimary),
              )
            ])),
      ],
    );
  }

  (String, int, int) _getBatsManSummaryTillIndex(
    MatchDetailTabState state,
    int index,
    String batsManId,
    String inningId,
  ) {
    final battingTeamId = inningId == state.firstInning?.id
        ? state.firstInning?.team_id
        : state.secondInning?.team_id;

    final batterName = state.match?.teams
        .firstWhere((element) => battingTeamId == element.team.id)
        .team
        .players
        ?.firstWhere((element) => element.id == batsManId)
        .name;

    final score = state.ballScores.getRange(0, index + 1).where((element) =>
        element.inning_id == inningId &&
        element.batsman_id == batsManId &&
        element.extras_type != ExtrasType.penaltyRun &&
        element.wicket_type != WicketType.retired &&
        element.wicket_type != WicketType.retiredHurt &&
        element.wicket_type != WicketType.timedOut);

    int ballCount = 0;
    int run = 0;
    for (var element in score) {
      if (element.extras_type != ExtrasType.wide) {
        ballCount = ballCount + 1;
      }

      if (element.extras_type == ExtrasType.noBall) {
        final extra = (element.extras_awarded ?? 0) > 1
            ? (element.extras_awarded ?? 1) - 1
            : 0;
        run = run + extra;
      }
      run = run + element.runs_scored;
    }

    return (batterName ?? "--", run, ballCount);
  }

  Widget _teamTotalView(
      BuildContext context, MatchDetailTabState state, String inningId) {
    final team = _getTeamByInningId(state, inningId);
    final (run, wicket) = _getTeamScoreTillIndex(state, inningId);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageAvatar(
          initial: team?.name[0].toUpperCase() ?? "?",
          imageUrl: team?.profile_img_url,
          size: 35,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Column(
            children: [
              Text(
                team?.name ?? "",
                textAlign: TextAlign.center,
                style: AppTextStyle.subtitle2
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              Text.rich(TextSpan(
                  text: "$run",
                  style: AppTextStyle.subtitle1
                      .copyWith(color: context.colorScheme.textPrimary),
                  children: [
                    TextSpan(
                        text: "($wicket)",
                        style: AppTextStyle.body1
                            .copyWith(color: context.colorScheme.textPrimary))
                  ])),
            ],
          ),
        ),
      ],
    );
  }

  TeamModel? _getTeamByInningId(MatchDetailTabState state, String inningId) {
    final teamId = state.firstInning?.id == inningId
        ? state.firstInning?.team_id
        : state.secondInning?.team_id;

    final team = state.match?.teams
        .where((element) => element.team.id == teamId)
        .firstOrNull
        ?.team;
    return team;
  }

  (int, int) _getTeamScoreTillIndex(
      MatchDetailTabState state, String inningId) {
    final ballScore = state.ballScores
        .getRange(0, index + 1)
        .where((element) => element.inning_id == inningId);
    final runs = ballScore.fold(
        0,
        (lastTotal, element) =>
            lastTotal + element.runs_scored + (element.extras_awarded ?? 0));
    final wicket = ballScore
        .where((element) =>
            element.wicket_type != null &&
            element.wicket_type != WicketType.retiredHurt)
        .length;

    return (runs, wicket);
  }
}

class BowlerSummary extends StatelessWidget {
  final MatchDetailTabState state;
  final int index;
  final String inningId;
  final String bowlerId;
  final bool isForBowlerIntro;

  const BowlerSummary({
    super.key,
    required this.state,
    required this.index,
    required this.inningId,
    required this.bowlerId,
    this.isForBowlerIntro = false,
  });

  @override
  Widget build(BuildContext context) {
    final (bowlerName, over, maidenOversCount, runsConceded, wicketCount) =
        _getBowlerSummaryTillIndex(state,
            index: index, inningId: inningId, bowlerId: bowlerId);
    if (over == 0) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isForBowlerIntro ? 16 : 0),
          child: Text.rich(TextSpan(
              text: "$bowlerName",
              style: isForBowlerIntro
                  ? AppTextStyle.subtitle1
                      .copyWith(color: context.colorScheme.textPrimary)
                  : AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textPrimary),
              children: [
                TextSpan(
                  text:
                      " [$over - $maidenOversCount - $runsConceded - $wicketCount]",
                  style: AppTextStyle.body1
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
                if (isForBowlerIntro) ...[
                  const TextSpan(
                    text: " is back to attack.",
                  ),
                ]
              ])),
        ),
      ],
    );
  }

  (String?, double, int, int, int) _getBowlerSummaryTillIndex(
    MatchDetailTabState state, {
    required int index,
    required String inningId,
    required String bowlerId,
  }) {
    final bowlingTeamId = inningId == state.firstInning?.id
        ? state.secondInning?.team_id
        : state.firstInning?.team_id;

    final bowlerName = state.match?.teams
        .firstWhere((element) => bowlingTeamId == element.team.id)
        .team
        .players
        ?.firstWhere((element) => element.id == bowlerId)
        .name;

    final scoreList = state.ballScores
        .getRange(0, index)
        .where((element) =>
            element.bowler_id == bowlerId && element.inning_id == inningId)
        .toList();
    // over
    final legalDeliveryCount =
        scoreList.where((element) => element.isLegalDelivery() ?? false).length;
    final over = legalDeliveryCount / 6;
    // maiden
    final emptyBalls = scoreList.where((element) =>
        element.extras_type == null &&
        element.wicket_type == null &&
        element.runs_scored == 0);

    int maidenOversCount = 0;
    int overNumber = 0;
    int ballNumber = 0;
    for (final ball in emptyBalls) {
      if (overNumber != ball.over_number) {
        if (ballNumber == 6) {
          maidenOversCount++;
        }
        overNumber = ball.over_number;
        ballNumber = 0;
      } else {
        ballNumber++;
      }
    }
    // runs conceded
    final runsConceded = scoreList
        .where((element) => element.extras_type != ExtrasType.penaltyRun)
        .fold(
            0,
            (sum, element) =>
                sum + element.runs_scored + (element.extras_awarded ?? 0));
    // wickets
    final wicketCount = scoreList
        .where((element) =>
            element.wicket_type != null &&
            element.wicket_type != WicketType.retired &&
            element.wicket_type != WicketType.retiredHurt &&
            element.wicket_type != WicketType.timedOut)
        .length;

    return (bowlerName, over, maidenOversCount, runsConceded, wicketCount);
  }
}
