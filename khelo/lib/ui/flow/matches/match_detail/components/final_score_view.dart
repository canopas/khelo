import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/data_model_extensions/match_model_extension.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:khelo/components/won_by_message_text.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class FinalScoreView extends ConsumerWidget {
  const FinalScoreView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchDetailTabStateProvider);

    return Column(
      children: _buildScoreView(context, state),
    );
  }

  List<Widget> _buildScoreView(
      BuildContext context, MatchDetailTabState state) {
    List<Widget> children = [];
    if (state.match == null) {
      return children;
    }
    children.add(const SizedBox(height: 16));
    for (final team in state.match!.teams) {
      final wicketCount = state.match!.teams
              .firstWhere((element) => element.team.id != team.team.id)
              .wicket;

      children.add(_teamScore(context, team, wicketCount));
      children.add(const SizedBox(height: 8));
    }
    children.add(const SizedBox(height: 8));
    if (state.match!.match_status == MatchStatus.finish) {
      children.add(Divider(
        color: context.colorScheme.outline,
      ));
      children.add(_winnerMessageText(context, state.match!));
    }

    return children;
  }

  Widget _teamScore(BuildContext context, MatchTeamModel team, int wicket) {
    return Row(
      children: [
        ImageAvatar(
          initial: team.team.name[0].toUpperCase(),
          imageUrl: team.team.profile_img_url,
          size: 35,
        ),
        const SizedBox(width: 8),
        Text(team.team.name,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary)),
        const Spacer(),
        Text.rich(TextSpan(
            text: "${team.run}-$wicket",
            style: AppTextStyle.header3
                .copyWith(color: context.colorScheme.textPrimary),
            children: [
              TextSpan(
                text: " ${team.over}",
                style: AppTextStyle.subtitle2
                    .copyWith(color: context.colorScheme.textSecondary),
              )
            ]))
      ],
    );
  }

  Widget _winnerMessageText(BuildContext context, MatchModel match) {
    final winSummary = match.getWinnerSummary(context);
    if (match.match_status == MatchStatus.finish && winSummary != null) {
      if (winSummary.teamName.isEmpty) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              context.l10n.score_board_match_tied_text,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.primary),
            ),
          ),
        );
      }
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: WonByMessageText(
            teamName: winSummary.teamName,
            difference: winSummary.difference,
            trailingText: winSummary.wonByText,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
