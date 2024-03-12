import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import 'match_list_view_model.dart';

class MatchListScreen extends ConsumerWidget {
  const MatchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchListStateProvider);

    return Column(
      children: [
        _topStartMatchView(context),
        const SizedBox(
          height: 24,
        ),
        _matchList(context, state),
      ],
    );
  }

  Widget _topStartMatchView(BuildContext context) {
    return Container(
      color: context.colorScheme.containerLowOnSurface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.l10n.match_list_start_match_text,
            style: AppTextStyle.header4
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          PrimaryButton(
            context.l10n.match_list_start_title,
            expanded: false,
            onPressed: () => AppRoute.addMatch().push(context),
          ),
        ],
      ),
    );
  }

  Widget _matchList(BuildContext context, MatchListViewState state) {
    if (state.loading) {
      return const Expanded(
        child: Center(
          child: AppProgressIndicator(),
        ),
      );
    }

    if (state.matches != null && state.matches!.isNotEmpty) {
      return Expanded(
        child: ListView.separated(
          itemCount: state.matches!.length,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 16,
            );
          },
          itemBuilder: (context, index) {
            final match = state.matches![index];
            return _matchCell(context, match);
          },
        ),
      );
    } else {
      return Expanded(
        child: Center(
          child: Text(context.l10n.match_list_no_match_yet_title),
        ),
      );
    }
  }

  Widget _matchCell(BuildContext context, MatchModel match) {
    return Container(
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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      match.match_type.getString(context),
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textPrimary),
                    ),
                    Text(match.ground,
                        style: AppTextStyle.subtitle2
                            .copyWith(color: context.colorScheme.textPrimary)),
                    Text(
                        DateFormat(
                                'EEE, MMM dd yyyy ${context.is24HourFormat ? 'HH:mm' : 'hh:mm a'}')
                            .format(match.start_time),
                        style: AppTextStyle.subtitle2
                            .copyWith(color: context.colorScheme.textPrimary)),
                    Text(
                        context.l10n
                            .match_list_overs_title(match.number_of_over),
                        style: AppTextStyle.subtitle2
                            .copyWith(color: context.colorScheme.textPrimary)),
                    Divider(color: context.colorScheme.outline),
                  ],
                ),
              ),
              if (match.match_status != MatchStatus.finish) ...[
                IconButton(
                    onPressed: () {
                      if (match.match_status == MatchStatus.yetToStart) {
                        AppRoute.addMatch(matchId: match.id).push(context);
                      } else {
                        AppRoute.scoreBoard(matchId: match.id ?? "INVALID_ID")
                            .push(context);
                      }
                    },
                    icon: Icon(
                      match.match_status == MatchStatus.yetToStart
                          ? Icons.edit
                          : Icons.play_arrow_sharp,
                      size: 30,
                    )),
              ],
            ],
          ),
          Text(match.teams.first.team.name,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary)),
          Text(match.teams.last.team.name,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary)),
        ],
      ),
    );
  }
}
