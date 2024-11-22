import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:khelo/components/tournament_badge.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../components/image_avatar.dart';
import '../../../../domain/formatter/date_formatter.dart';
import '../../../app_route.dart';

class MatchItem extends StatelessWidget {
  final MatchModel match;

  const MatchItem({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return OnTapScale(
      onTap: () => AppRoute.matchDetailTab(matchId: match.id).push(context),
      child: MediaQuery.withNoTextScaling(
        child: Container(
          width: 360,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.colorScheme.containerLow,
            border: Border.all(color: context.colorScheme.outline),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _matchDetailView(context, match),
              const SizedBox(height: 24),
              _teamScore(
                context,
                match.teams.first,
                match.teams.elementAt(1).wicket,
              ),
              const SizedBox(height: 22),
              _teamScore(
                context,
                match.teams.elementAt(1),
                match.teams.first.wicket,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _teamScore(
    BuildContext context,
    MatchTeamModel matchTeam,
    int wicket,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageAvatar(
          initial: matchTeam.team.name_initial ??
              matchTeam.team.name.initials(limit: 1),
          imageUrl: matchTeam.team.profile_img_url,
          size: 32,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(matchTeam.team.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppTextStyle.subtitle3
                  .copyWith(color: context.colorScheme.textPrimary)),
        ),
        if (matchTeam.over != 0) ...[
          Text.rich(TextSpan(
              text: "${matchTeam.run}-$wicket",
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textPrimary),
              children: [
                TextSpan(
                  text: " ${matchTeam.over}",
                  style: AppTextStyle.body2
                      .copyWith(color: context.colorScheme.textSecondary),
                )
              ])),
        ],
      ],
    );
  }

  Widget _matchDetailView(
    BuildContext context,
    MatchModel match,
  ) {
    return Row(
      children: [
        if (match.tournament_id != null) TournamentBadge(),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
              overflow: TextOverflow.ellipsis,
              TextSpan(
                  text: (match.start_at ?? match.start_time)
                      ?.format(context, DateFormatType.dateAndTime),
                  style: AppTextStyle.caption
                      .copyWith(color: context.colorScheme.textSecondary),
                  children: [
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Container(
                          height: 5,
                          width: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.colorScheme.textSecondary,
                          ),
                        )),
                    TextSpan(text: match.ground)
                  ])),
        ),
      ],
    );
  }
}
