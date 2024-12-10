import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/match_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/tournament/detail/components/filter_tab_view.dart';
import 'package:style/extensions/context_extensions.dart';

import '../../../../../components/action_bottom_sheet.dart';
import '../../../../../components/empty_screen.dart';
import '../tournament_detail_view_model.dart';

class TournamentDetailMatchesTab extends ConsumerWidget {
  final Function(String) onMatchFilter;
  final VoidCallback onAddMatchTap;

  const TournamentDetailMatchesTab({
    super.key,
    required this.onMatchFilter,
    required this.onAddMatchTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tournamentDetailStateProvider);

    if (state.filteredMatches.isEmpty && state.matches.isEmpty) {
      return EmptyScreen(
        title: context.l10n.tournament_detail_matches_empty_title,
        description: context.l10n.tournament_detail_matches_empty_description,
        buttonTitle: context.l10n.tournament_detail_matches_add_btn,
        isShowButton: state.tournament!.created_by == state.currentUserId ||
            state.tournament!.members
                .any((element) => element.id == state.currentUserId),
        onTap: onAddMatchTap,
      );
    }

    return ListView(
      padding: context.mediaQueryPadding.copyWith(top: 0) +
          EdgeInsets.all(16).copyWith(bottom: 24),
      children: [
        FilterTabView(
          title: context.l10n.tournament_detail_matches_filter_by_teams_title,
          onFilter: () => showFilterOptionSelectionSheet(
            context,
            matchFilter: state.matchFilter,
            teams: state.tournament!.teams,
            onTap: onMatchFilter,
          ),
          filterValue: state.matchFilter ??
              context.l10n.tournament_detail_matches_filter_all_teams_option,
        ),
        if (state.filteredMatches.isEmpty)
          SizedBox(
            height: context.mediaQuerySize.height / 2.5,
            child: EmptyScreen(
              title: context.l10n.tournament_detail_matches_filter_empty_title,
              description: context
                  .l10n.tournament_detail_matches_filter_empty_description,
              isShowButton: false,
            ),
          ),
        ...state.filteredMatches.map(
          (match) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: MatchDetailCell(
                showTournamentBadge: false,
                backgroundColor: context.colorScheme.surface,
                match: match,
                onTap: () =>
                    AppRoute.matchDetailTab(matchId: match.id).push(context),
              ),
            );
          },
        ),
      ],
    );
  }

  void showFilterOptionSelectionSheet(
    BuildContext context, {
    required Function(String) onTap,
    String? matchFilter,
    required List<TeamModel> teams,
  }) async {
    final filterOptions = [
      context.l10n.tournament_detail_matches_filter_all_teams_option,
      ...teams.map((e) => e.name)
    ];
    final matchFiltered = matchFilter ?? filterOptions.first;
    return await showActionBottomSheet(
        context: context,
        items: filterOptions
            .map((option) => BottomSheetAction(
                  title: option,
                  enabled: matchFiltered != option,
                  showCheck: matchFiltered == option,
                  onTap: () {
                    context.pop();
                    onTap(option);
                  },
                ))
            .toList());
  }
}
