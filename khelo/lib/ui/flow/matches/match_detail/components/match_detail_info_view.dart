import 'package:collection/collection.dart';
import 'package:data/api/match/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class MatchDetailInfoView extends ConsumerWidget {
  const MatchDetailInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchDetailTabStateProvider);
    final notifier = ref.watch(matchDetailTabStateProvider.notifier);
    return _body(context, notifier, state);
  }

  Widget _body(BuildContext context, MatchDetailTabViewNotifier notifier,
      MatchDetailTabState state) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onResume,
      );
    }

    return ListView(
      padding: context.mediaQueryPadding +
          const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _sectionTitle(context, context.l10n.match_detail_match_info_tab_title),
        _matchTitleView(context, state.match!),
        _dataRowView(context,
            title: context.l10n.match_info_date_and_time_title,
            subtitle: (state.match?.start_at ?? state.match?.start_time)
                ?.format(context, DateFormatType.shortDateTime)),
        _tossDetailView(context, state.match!),
        _dataRowView(context,
            title: context.l10n.match_info_venue_title,
            subtitle: state.match?.ground),
        _dataRowView(context,
            title: context.l10n.add_match_officials_umpires_title,
            subtitle: state.match?.umpires?.map((e) => e.name).join(", ")),
        _dataRowView(
          context,
          title: context.l10n.add_match_officials_referee_title,
          subtitle: state.match?.referee?.name,
        ),
        _dataRowView(context,
            title: context.l10n.add_match_officials_commentators_title,
            subtitle: state.match?.commentators?.map((e) => e.name).join(", ")),
        _dataRowView(context,
            title: context.l10n.add_match_officials_scorers_title,
            subtitle: state.match?.scorers?.map((e) => e.name).join(", ")),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Text(
        title,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary),
      ),
    );
  }

  Widget _dataRowView(
    BuildContext context, {
    required String title,
    String? subtitle,
  }) {
    if (subtitle == null || subtitle.isEmpty) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.body1
                .copyWith(color: context.colorScheme.textSecondary),
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Text(
            subtitle,
            textAlign: TextAlign.right,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          )),
        ],
      ),
    );
  }

  Widget _matchTitleView(BuildContext context, MatchModel match) {
    String title = match.teams
        .map((e) => e.team.name)
        .join(" ${context.l10n.common_versus_short_title} ");
    return _dataRowView(context,
        title: context.l10n.match_info_match_title, subtitle: title);
  }

  Widget _tossDetailView(BuildContext context, MatchModel match) {
    String? teamName = match.teams
        .firstWhereOrNull((element) => element.team.id == match.toss_winner_id)
        ?.team
        .name;
    String? decision = match.toss_decision?.getString(context);
    if (teamName != null &&
        teamName.isNotEmpty &&
        decision != null &&
        decision.isNotEmpty) {
      return _dataRowView(context,
          title: context.l10n.match_info_toss_title,
          subtitle:
              context.l10n.match_info_toss_detail_text(teamName, decision));
    } else {
      return const SizedBox();
    }
  }
}
