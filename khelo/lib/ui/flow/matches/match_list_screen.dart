import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/match_status_tag.dart';
import 'package:khelo/components/won_by_message_text.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/data_model_extensions/match_model_extension.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:style/animations/on_tap_scale.dart';
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
            return const SizedBox(height: 16);
          },
          itemBuilder: (context, index) {
            final match = state.matches![index];
            return _matchCell(context, match, state.currentUserId);
          },
        ),
      );
    } else {
      return Expanded(
        child: Center(
          child: Text(
            context.l10n.match_list_no_match_yet_title,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ),
      );
    }
  }

  Widget _matchCell(BuildContext context, MatchModel match, String? currentUserId,) {
    return OnTapScale(
      onTap: () => AppRoute.matchDetailTab(matchId: match.id ?? "INVALID ID").push(context),
      child: Container(
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
            _matchOtherDetail(context, match, currentUserId),
            _teamsAndStatusView(context, match),
            _winnerMessageText(context, match)
          ],
        ),
      ),
    );
  }

  Widget _matchOtherDetail(BuildContext context, MatchModel match, String? currentUserId,) {
    return Row(
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
              Text(match.start_time.format(context, DateFormatType.dateAndTime),
                  style: AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textPrimary)),
              Text(context.l10n.match_list_overs_title(match.number_of_over),
                  style: AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textPrimary)),
              Divider(color: context.colorScheme.outline),
            ],
          ),
        ),
        _matchEditOrResumeActionButton(context, match, currentUserId),
      ],
    );
  }

  Widget _matchEditOrResumeActionButton(
    BuildContext context,
    MatchModel match,
  String? currentUserId,
  ) {
    if (match.match_status != MatchStatus.finish && match.created_by == currentUserId) {
      return IconButton(
          onPressed: () {
            if (match.match_status == MatchStatus.yetToStart) {
              AppRoute.addMatch(matchId: match.id).push(context);
            } else {
              if (match.toss_decision == null || match.toss_winner_id == null) {
                AppRoute.addTossDetail(matchId: match.id ?? "INVALID_ID")
                    .push(context);
              } else {
                AppRoute.scoreBoard(matchId: match.id ?? "INVALID_ID")
                    .push(context);
              }
            }
          },
          icon: Icon(
            match.match_status == MatchStatus.yetToStart
                ? Icons.edit
                : Icons.play_arrow_sharp,
            size: 30,
          ));
    } else {
      return const SizedBox();
    }
  }

  Widget _teamsAndStatusView(BuildContext context, MatchModel match) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _teamNameView(
              context,
              team: match.teams.first,
              wicket: match.teams.last.wicket ?? 0,
              totalOvers: match.number_of_over,
              isRunning:
                  match.current_playing_team_id == match.teams.first.team.id &&
                      match.match_status == MatchStatus.running,
            ),
            _teamNameView(
              context,
              team: match.teams.last,
              wicket: match.teams.first.wicket ?? 0,
              totalOvers: match.number_of_over,
              isRunning:
                  match.current_playing_team_id == match.teams.last.team.id &&
                      match.match_status == MatchStatus.running,
            ),
          ],
        ),
        MatchStatusTag(status: match.match_status)
      ],
    );
  }

  Widget _teamNameView(
    BuildContext context, {
    required MatchTeamModel team,
    required int wicket,
    required int totalOvers,
    required bool isRunning,
  }) {
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
                  text: " (${team.over ?? 0}/$totalOvers)",
                  style: AppTextStyle.body2
                      .copyWith(color: context.colorScheme.textSecondary),
                ),
              ]
            : List.empty()));
  }

  Widget _winnerMessageText(BuildContext context, MatchModel match) {
    final winSummary = match.getWinnerSummary(context);
    if (match.match_status == MatchStatus.finish && winSummary != null) {
      return WonByMessageText(
        teamName: winSummary.teamName,
        difference: winSummary.difference,
        trailingText: winSummary.wonByText,
      );
    } else {
      return const SizedBox();
    }
  }
}
