import 'package:data/api/match/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/components/match_status_tag.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/flow/team/detail/team_detail_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class TeamDetailMatchContent extends ConsumerWidget {
  const TeamDetailMatchContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamDetailStateProvider);

    if (state.matches?.isEmpty ?? true) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            context.l10n.team_detail_empty_match_title,
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary, fontSize: 20),
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const SizedBox(
          height: 24,
        ),
        for (final match in state.matches ?? []) ...[
          _matchCell(context, state, match),
          const SizedBox(
            height: 16,
          ),
        ],
        const SizedBox(
          height: 34,
        ),
      ],
    );
  }

  Widget _matchCell(
      BuildContext context, TeamDetailState state, MatchModel match) {
    final opponentTeam = match.teams
        .where((element) => element.team.id != state.team?.id)
        .firstOrNull
        ?.team;
    return Row(
      children: [
        ImageAvatar(
            initial: opponentTeam?.name[0].toUpperCase() ?? "?",
            imageUrl: opponentTeam?.profile_img_url,
            size: 50),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              opponentTeam?.name ?? "--",
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            Text(
              "${context.l10n.team_detail_overs_title} ${match.number_of_over.toString()}",
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textSecondary),
            ),
            Text(
              match.start_time.format(context, DateFormatType.dateAndTime),
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textSecondary),
            ),
            Text(
              match.ground,
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textSecondary),
            ),
            const SizedBox(
              height: 4,
            ),
            MatchStatusTag(status: match.match_status)
          ],
        ),
      ],
    );
  }
}
