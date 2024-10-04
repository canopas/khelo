import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/over_score_view.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class CommentaryOverOverview extends StatelessWidget {
  final OverSummary overSummary;
  final TeamModel? team;

  const CommentaryOverOverview({
    super.key,
    required this.overSummary,
    required this.team,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 16),
      color: context.colorScheme.containerLow,
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                _overCount(context),
                const SizedBox(width: 16),
                _divider(context, axis: Axis.vertical),
                const SizedBox(width: 16),
                _bowlerAndOverSummary(context)
              ],
            ),
          ),
          const SizedBox(height: 16),
          _divider(context),
          const SizedBox(height: 16),
          _teamTotalView(context),
          const SizedBox(height: 16),
          _batsManScoreView(context, overSummary.striker),
          const SizedBox(height: 4),
          _batsManScoreView(context, overSummary.nonStriker),
        ],
      ),
    );
  }

  Widget _overCount(BuildContext context) {
    return Column(
      children: [
        Text(
          context.l10n.match_scorecard_over_text,
          style: AppTextStyle.caption
              .copyWith(color: context.colorScheme.textDisabled),
        ),
        Text(
          "${overSummary.overNumber}",
          style: AppTextStyle.header1
              .copyWith(color: context.colorScheme.textPrimary),
        ),
      ],
    );
  }

  Widget _bowlerAndOverSummary(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BowlerSummaryView(bowlerSummary: overSummary.bowler),
          const SizedBox(height: 8),
          OverScoreView(over: overSummary.balls, size: 32)
        ],
      ),
    );
  }

  Widget _divider(BuildContext context, {Axis axis = Axis.horizontal}) {
    if (axis == Axis.horizontal) {
      return Divider(height: 0, color: context.colorScheme.outline);
    } else {
      return VerticalDivider(width: 0, color: context.colorScheme.outline);
    }
  }

  Widget _teamTotalView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ImageAvatar(
          initial: team?.name_initial ?? team?.name.initials(limit: 1) ?? "?",
          imageUrl: team?.profile_img_url,
          size: 35,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            team?.name ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.subtitle3
                .copyWith(color: context.colorScheme.textSecondary),
          ),
        ),
        const SizedBox(width: 6),
        Text("${overSummary.totalRuns}-${overSummary.totalWickets}",
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary)),
      ],
    );
  }

  Widget _batsManScoreView(
    BuildContext context,
    BatsmanSummary batsmanSummary,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: OnTapScale(
          enabled: batsmanSummary.player.isActive,
          onTap: () => AppRoute.userDetail(userId: batsmanSummary.player.id)
              .push(context),
          child: Text(
            batsmanSummary.player.name ?? '',
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        )),
        Text.rich(TextSpan(
            text: batsmanSummary.runs.toString(),
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
            children: [
              TextSpan(
                text: "(${batsmanSummary.ballFaced})",
                style: AppTextStyle.body2
                    .copyWith(color: context.colorScheme.textSecondary),
              )
            ])),
      ],
    );
  }
}

class BowlerSummaryView extends StatelessWidget {
  final BowlerSummary bowlerSummary;
  final bool isForBowlerIntro;

  const BowlerSummaryView({
    super.key,
    required this.bowlerSummary,
    this.isForBowlerIntro = false,
  });

  @override
  Widget build(BuildContext context) {
    if (bowlerSummary.overDelivered == 0) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnTapScale(
          enabled: bowlerSummary.player.isActive && !isForBowlerIntro,
          onTap: () => AppRoute.userDetail(userId: bowlerSummary.player.id)
              .push(context),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: isForBowlerIntro ? 16 : 0),
            child: Text.rich(TextSpan(
                text: bowlerSummary.player.name,
                style: AppTextStyle.subtitle2
                    .copyWith(color: context.colorScheme.textPrimary),
                children: [
                  TextSpan(
                    text:
                        " [${bowlerSummary.overDelivered} - ${bowlerSummary.maiden} - ${bowlerSummary.runsConceded} - ${bowlerSummary.wicket}]",
                    style: AppTextStyle.subtitle3
                        .copyWith(color: context.colorScheme.textPrimary),
                  ),
                  if (isForBowlerIntro) ...[
                    TextSpan(
                      text: context.l10n.match_commentary_back_to_attack_text,
                    ),
                  ]
                ])),
          ),
        ),
      ],
    );
  }
}
