import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/match_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/team/detail/team_detail_view_model.dart';
import 'package:style/callback/on_visible_callback.dart';
import 'package:style/indicator/progress_indicator.dart';

import '../../../../../domain/extensions/widget_extension.dart';

class TeamDetailMatchContent extends ConsumerWidget {
  const TeamDetailMatchContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamDetailStateProvider);
    final isAdminOrOwner =
        state.team?.isAdminOrOwner(state.currentUserId) ?? false;

    if (state.matches.isNotEmpty) {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: state.matches.length + 1,
        itemBuilder: (context, index) {
          if (index < state.matches.length) {
            final match = state.matches[index];
            return MatchDetailCell(
              match: match,
              showActionButtons: isAdminOrOwner,
              onTap: () =>
                  AppRoute.matchDetailTab(matchId: match.id).push(context),
              onActionTap: () {
                if (match.match_status == MatchStatus.yetToStart) {
                  AppRoute.addMatch(matchId: match.id).push(context);
                } else {
                  if (match.toss_decision == null ||
                      match.toss_winner_id == null) {
                    AppRoute.addTossDetail(matchId: match.id).push(context);
                  } else {
                    AppRoute.scoreBoard(matchId: match.id).push(context);
                  }
                }
              },
            );
          }
          return OnVisibleCallback(
            onVisible: () => runPostFrame(
                ref.read(teamDetailStateProvider.notifier).loadData),
            child: (state.loading && state.matches.isNotEmpty)
                ? const Center(child: AppProgressIndicator())
                : const SizedBox(),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      );
    } else {
      return EmptyScreen(
          title: context.l10n.team_detail_empty_matches_title,
          description: (state.team?.created_by == state.currentUserId)
              ? context.l10n.team_detail_empty_matches_description_text
              : context.l10n.team_detail_visitor_empty_matches_description_text,
          isShowButton: isAdminOrOwner,
          buttonTitle: context.l10n.add_match_screen_title,
          onTap: () async {
            AppRoute.addMatch(
                    defaultTeam: (state.team?.players.length ?? 0) >= 2
                        ? state.team
                        : null)
                .push(context);
            // if (isUpdated == true && context.mounted) {
            //   ref.read(teamDetailStateProvider.notifier).loadTeamById();
            // }
          });
    }
  }
}
