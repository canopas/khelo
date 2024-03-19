import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import 'match_list_view_model.dart';

class MatchListScreen extends ConsumerWidget {
  const MatchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchListStateProvider);

    return Column(
      children: [
        _topStartMatchView(context),
        const SizedBox(
          height: 24,
        ),
        _matchList(context, state),
      ],
    );
  }

  Widget _topStartMatchView(BuildContext context) {
    return Container(
      color: context.colorScheme.containerLowOnSurface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.l10n.match_list_start_match_text,
            style: AppTextStyle.header4
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          PrimaryButton(
            context.l10n.match_list_start_title,
            expanded: false,
            onPressed: () => AppRoute.addMatch().push(context),
          ),
        ],
      ),
    );
  }

  Widget _matchList(BuildContext context, MatchListViewState state) {
    if (state.loading) {
      return const Expanded(
        child: Center(
          child: AppProgressIndicator(),
        ),
      );
    }

    if (state.matches != null && state.matches!.isNotEmpty) {
      return Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.only(bottom: 40),
          itemCount: state.matches!.length,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 16,
            );
          },
          itemBuilder: (context, index) {
            final match = state.matches![index];
            return _matchCell(context, match);
          },
        ),
      );
    } else {
      return Expanded(
        child: Center(
          child: Text(context.l10n.match_list_no_match_yet_title),
        ),
      );
    }
  }

  Widget _matchCell(BuildContext context, MatchModel match) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.outline),
        borderRadius: BorderRadius.circular(20),
        color: context.colorScheme.containerLow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      match.match_type.getString(context),
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textPrimary),
                    ),
                    Text(match.ground,
                        style: AppTextStyle.subtitle2
                            .copyWith(color: context.colorScheme.textPrimary)),
                    Text(
                        DateFormat(
                                'EEE, MMM dd yyyy ${context.is24HourFormat ? 'HH:mm' : 'hh:mm a'}')
                            .format(match.start_time),
                        style: AppTextStyle.subtitle2
                            .copyWith(color: context.colorScheme.textPrimary)),
                    Text(
                        context.l10n
                            .match_list_overs_title(match.number_of_over),
                        style: AppTextStyle.subtitle2
                            .copyWith(color: context.colorScheme.textPrimary)),
                    Divider(color: context.colorScheme.outline),
                  ],
                ),
              ),
              if (match.match_status != MatchStatus.finish) ...[
                IconButton(
                    onPressed: () {
                      if (match.match_status == MatchStatus.yetToStart) {
                        AppRoute.addMatch(matchId: match.id).push(context);
                      } else {
                        AppRoute.scoreBoard(matchId: match.id ?? "INVALID_ID")
                            .push(context);
                      }
                    },
                    icon: Icon(
                      match.match_status == MatchStatus.yetToStart
                          ? Icons.edit
                          : Icons.play_arrow_sharp,
                      size: 30,
                    )),
              ],
            ],
          ),
          _teamNameView(
            context,
            team: match.teams.first,
            wicket: match.teams.last.wicket ?? 0,
            totalOvers: match.number_of_over,
            isRunning:
                match.current_playing_team_id == match.teams.first.team.id,
          ),
          _teamNameView(
            context,
            team: match.teams.last,
            wicket: match.teams.first.wicket ?? 0,
            totalOvers: match.number_of_over,
            isRunning:
                match.current_playing_team_id == match.teams.last.team.id,
          ),
          if (match.match_status == MatchStatus.finish) ...[
            _winnerMessageText(context, match)
          ]
        ],
      ),
    );
  }

  Widget _teamNameView(
    BuildContext context, {
    required MatchTeamModel team,
    required int wicket,
    required int totalOvers,
    required bool isRunning,
  }) {
    final over = (team.over ?? 0) - 1;

    return Text.rich(TextSpan(
        text: team.team.name,
        style: AppTextStyle.subtitle2.copyWith(
            color: isRunning
                ? context.colorScheme.primary
                : context.colorScheme.textPrimary),
        children: isRunning
            ? [
                TextSpan(
                  text: " - ",
                  style: AppTextStyle.subtitle1
                      .copyWith(color: context.colorScheme.textSecondary),
                ),
                TextSpan(
                  text: "${team.run}/$wicket",
                  style: AppTextStyle.header4
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
                TextSpan(
                  text: " (${over.toStringAsFixed(1)}/$totalOvers)",
                  style: AppTextStyle.body2
                      .copyWith(color: context.colorScheme.textSecondary),
                ),
              ]
            : List.empty()));
  }

  Widget _winnerMessageText(BuildContext context, MatchModel match) {
    final firstTeam = match.toss_decision == TossDecision.bat
        ? match.teams
            .firstWhere((element) => element.team.id == match.toss_winner_id)
        : match.teams
            .firstWhere((element) => element.team.id != match.toss_winner_id);
    final secondTeam = match.teams
        .firstWhere((element) => element.team.id != firstTeam.team.id);

    if (firstTeam.run! > secondTeam.run!) {
      // first batting team won
      final teamName = firstTeam.team.name;

      final runDifference = firstTeam.run! - secondTeam.run!;

      return _messageText(context, teamName, runDifference,
          context.l10n.score_board_runs_dot_title);
    } else {
      // second batting team won
      final teamName = secondTeam.team.name;

      final wicketDifference =
          secondTeam.squad.length - (firstTeam.wicket ?? 0);

      return _messageText(context, teamName, wicketDifference,
          context.l10n.score_board_wickets_dot_title);
    }
  }

  Widget _messageText(BuildContext context, String? teamName, int difference,
      String trailingText) {
    return Text.rich(TextSpan(
        text: "$teamName",
        style:
            AppTextStyle.subtitle2.copyWith(color: context.colorScheme.primary),
        children: [
          TextSpan(
              text: context.l10n.score_board_won_by_title,
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textSecondary)),
          TextSpan(
            text: "$difference",
          ),
          TextSpan(
            text: trailingText,
          ),
        ]));
  }
}
