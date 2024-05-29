import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';

import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class PrimerProgressBar extends StatelessWidget {
  final MatchResult matchResult;

  const PrimerProgressBar({
    super.key,
    required this.matchResult,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _progressBarSegment(
              color: context.colorScheme.positive,
              count: matchResult.win,
              isStartRadius: true,
            ),
            _progressBarSegment(
              color: context.colorScheme.secondary,
              count: matchResult.tie,
            ),
            _progressBarSegment(
              color: context.colorScheme.alert,
              count: matchResult.lost,
              isEndRadius: true,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _legendItem(
              context,
              color: context.colorScheme.positive,
              text: context.l10n.team_detail_won_title(matchResult.win),
            ),
            _legendItem(
              context,
              color: context.colorScheme.secondary,
              text: context.l10n.team_detail_tie_title(matchResult.tie),
            ),
            _legendItem(
              context,
              color: context.colorScheme.alert,
              text: context.l10n.team_detail_lost_title(matchResult.lost),
            ),
          ],
        )
      ],
    );
  }

  Widget _progressBarSegment({
    required Color color,
    required int count,
    bool isStartRadius = false,
    bool isEndRadius = false,
  }) {
    return Expanded(
      flex: count,
      child: Container(
        height: 8.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.horizontal(
            left: isStartRadius ? const Radius.circular(30) : Radius.zero,
            right: isEndRadius ? const Radius.circular(30) : Radius.zero,
          ),
        ),
      ),
    );
  }

  Widget _legendItem(
    BuildContext context, {
    required Color color,
    required String text,
  }) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              constraints: const BoxConstraints(minHeight: 8, minWidth: 8),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
          TextSpan(
            text: text,
            style: AppTextStyle.caption
                .copyWith(color: context.colorScheme.textSecondary),
          ),
        ],
      ),
    );
  }
}
