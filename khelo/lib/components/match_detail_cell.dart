import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/components/match_status_tag.dart';
import 'package:khelo/components/tournament_badge.dart';
import 'package:khelo/components/won_by_message_text.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class MatchDetailCell extends StatelessWidget {
  final MatchModel match;
  final VoidCallback onTap;
  final bool showStatusTag;
  final bool showTournamentBadge;
  final bool showActionButtons;
  final VoidCallback? onActionTap;
  final Color? backgroundColor;

  const MatchDetailCell({
    super.key,
    required this.match,
    required this.onTap,
    this.showStatusTag = true,
    this.showActionButtons = false,
    this.showTournamentBadge = true,
    this.backgroundColor,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return OnTapScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? context.colorScheme.containerLow,
          border: Border.all(color: context.colorScheme.outline),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _matchTimeAndGroundView(context),
            const SizedBox(height: 16),
            ...match.teams.map(
              (team) => _teamView(context, team),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(
                color: context.colorScheme.outline,
                height: 1,
              ),
            ),
            Row(
              children: [
                Expanded(child: _winnerMessageText(context)),
                if (showStatusTag) ...[
                  StatusTag(
                    matchStatus: match.match_status,
                    onTap: showActionButtons &&
                            match.match_status != MatchStatus.finish &&
                            match.match_status != MatchStatus.abandoned
                        ? onActionTap
                        : null,
                  )
                ],
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _matchTimeAndGroundView(BuildContext context) {
    return Row(children: [
      if (showTournamentBadge && match.tournament_id != null) ...[
        TournamentBadge(),
        const SizedBox(width: 8),
      ],
      Expanded(
        flex: 2,
        child: Text(
            (match.start_at ?? match.start_time ?? DateTime.now())
                .format(context, DateFormatType.dateAndTime),
            style: AppTextStyle.caption
                .copyWith(color: context.colorScheme.textDisabled)),
      ),
      Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              Assets.images.icLocation,
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                context.colorScheme.textSecondary,
                BlendMode.srcATop,
              ),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                match.ground,
                style: AppTextStyle.caption
                    .copyWith(color: context.colorScheme.textDisabled),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _teamView(BuildContext context, MatchTeamModel matchTeam) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          ImageAvatar(
            initial: matchTeam.team.name.characters.first.toUpperCase(),
            imageUrl: matchTeam.team.profile_img_url,
            size: 32,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(matchTeam.team.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: AppTextStyle.subtitle3
                    .copyWith(color: context.colorScheme.textPrimary)),
          ),
          if (!(matchTeam.run == 0 &&
              matchTeam.wicket == 0 &&
              matchTeam.over == 0)) ...[
            Text.rich(TextSpan(
                text: "${matchTeam.run}-${matchTeam.wicket}",
                style: AppTextStyle.subtitle2
                    .copyWith(color: context.colorScheme.textPrimary),
                children: [
                  TextSpan(
                    text: " ${matchTeam.over}",
                    style: AppTextStyle.body2
                        .copyWith(color: context.colorScheme.textSecondary),
                  )
                ]))
          ],
        ],
      ),
    );
  }

  Widget _winnerMessageText(BuildContext context) {
    if (match.match_status == MatchStatus.finish) {
      return WonByMessageText(
        matchResult: match.matchResult,
      );
    } else {
      return Text(
        "${match.match_type.getString(context)} ${context.l10n.match_list_overs_title(match.number_of_over)}",
        style: AppTextStyle.body2
            .copyWith(color: context.colorScheme.textDisabled),
      );
    }
  }
}
