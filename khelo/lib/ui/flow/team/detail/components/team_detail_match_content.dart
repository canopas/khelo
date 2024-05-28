import 'package:data/api/match/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/match_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/team/detail/team_detail_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class TeamDetailMatchContent extends ConsumerWidget {
  const TeamDetailMatchContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamDetailStateProvider);

    if (state.matches != null && state.matches!.isNotEmpty) {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16) +
            context.mediaQueryPadding,
        itemCount: state.matches?.length ?? 0,
        itemBuilder: (context, index) {
          final match = state.matches![index];
          return MatchDetailCell(
            match: match,
            showActionButtons: match.created_by == state.currentUserId,
            onTap: () =>
                AppRoute.matchDetailTab(matchId: match.id ?? "").push(context),
            onActionTap: () {
              if (match.match_status == MatchStatus.yetToStart) {
                AppRoute.addMatch(matchId: match.id).push(context);
              } else {
                if (match.toss_decision == null ||
                    match.toss_winner_id == null) {
                  AppRoute.addTossDetail(matchId: match.id ?? "INVALID_ID")
                      .push(context);
                } else {
                  AppRoute.scoreBoard(matchId: match.id ?? "INVALID_ID")
                      .push(context);
                }
              }
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      );
    } else {
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
  }
}
