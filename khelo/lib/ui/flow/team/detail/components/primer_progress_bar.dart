import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';

import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class PrimerProgressBar extends StatelessWidget {
  final TeamMatchStatus status;

  const PrimerProgressBar({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _progressBarSegment(
              color: context.colorScheme.positive,
              count: status.win,
              isStartRadius: status.win != 0,
              isEndRadius: status.tie == 0 && status.lost == 0,
            ),
            _progressBarSegment(
              color: context.colorScheme.secondary,
              count: status.tie,
              isStartRadius: status.win == 0,
              isEndRadius: status.lost == 0,
            ),
            _progressBarSegment(
              color: context.colorScheme.alert,
              count: status.lost,
              isEndRadius: status.lost != 0,
              isStartRadius: status.win == 0 && status.tie == 0,
            ),
          ],
        ),
        const SizedBox(height: 8),
        MediaQuery.withNoTextScaling(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _legendItem(
                context,
                color: context.colorScheme.positive,
                text: context.l10n.team_detail_won_title(status.win),
              ),
              _legendItem(
                context,
                color: context.colorScheme.secondary,
                text: context.l10n.team_detail_tie_title(status.tie),
              ),
              _legendItem(
                context,
                color: context.colorScheme.alert,
                text: context.l10n.team_detail_lost_title(status.lost),
              ),
            ],
          ),
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
              margin: const EdgeInsets.only(right: 4),
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
