import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/components/match_status_tag.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
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
    children.add(Divider(color: context.colorScheme.outline));
    if (state.match!.match_status == MatchStatus.finish) {
      children.add(_winnerMessageText(context, state.match!));
    } else if (state.match?.match_status == MatchStatus.running) {
      children.add(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 24),
            child: StatusTag(
                matchStatus: state.match?.match_status ?? MatchStatus.running),
          ),
        ],
      ));
    }

    return children;
  }

  Widget _teamScore(BuildContext context, MatchTeamModel team, int wicket) {
    return Row(
      children: [
        ImageAvatar(
          initial: team.team.name_initial ?? team.team.name.initials(limit: 1),
          imageUrl: team.team.profile_img_url,
          size: 32,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(team.team.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.subtitle3
                  .copyWith(color: context.colorScheme.textSecondary)),
        ),
        Text.rich(TextSpan(
            text: "${team.run}-$wicket",
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
            children: [
              TextSpan(
                text: " ${team.over}",
                style: AppTextStyle.body2
                    .copyWith(color: context.colorScheme.textSecondary),
              )
            ]))
      ],
    );
  }

  Widget _winnerMessageText(BuildContext context, MatchModel match) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: WonByMessageText(
          matchResult: match.matchResult,
        ),
      ),
    );
  }
}
