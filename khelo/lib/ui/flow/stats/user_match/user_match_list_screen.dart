import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/components/won_by_message_text.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/data_model_extensions/match_model_extension.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/stats/user_match/user_match_list_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class UserMatchListScreen extends ConsumerWidget {
  const UserMatchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userMatchListStateProvider);
    if (state.loading) {
      return const AppProgressIndicator();
    }

    return _body(context, state);
  }

  Widget _body(BuildContext context, UserMatchListState state) {
    return ListView.separated(
        padding: const EdgeInsets.only(bottom: 50, top: 24),
        itemBuilder: (context, index) {
          return _matchListCell(context, state.matches.elementAt(index));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16,
          );
        },
        itemCount: state.matches.length);
  }

  Widget _matchListCell(BuildContext context, MatchModel match) {
    return OnTapScale(
      onTap: () {
        AppRoute.matchDetailStat(matchId: match.id ?? "INVALID ID")
            .push(context);
      },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: _teamNameView(context, match.teams.first.team)),
                Text(
                  context.l10n.add_match_versus_short_title,
                  style: AppTextStyle.header4
                      .copyWith(color: context.colorScheme.primary),
                ),
                Expanded(child: _teamNameView(context, match.teams.last.team)),
              ],
            ),
            Divider(color: context.colorScheme.outline),
            Text(
              "${match.match_type.getString(context)} - ${context.l10n.match_list_overs_title(match.number_of_over)}",
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            Text(match.ground,
                style: AppTextStyle.subtitle2
                    .copyWith(color: context.colorScheme.textPrimary)),
            Text(match.start_time.format(context, DateFormatType.dateAndTime),
                style: AppTextStyle.subtitle2
                    .copyWith(color: context.colorScheme.textPrimary)),
            Divider(color: context.colorScheme.outline),
            _winnerMessageText(context, match)
          ],
        ),
      ),
    );
  }

  Widget _teamNameView(BuildContext context, TeamModel team) {
    return Column(
      children: [
        ImageAvatar(
          initial: team.name[0].toUpperCase(),
          imageUrl: team.profile_img_url,
          size: 50,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          team.name,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
      ],
    );
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
