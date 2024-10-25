import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/match_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../components/action_bottom_sheet.dart';
import '../../../../../components/empty_screen.dart';
import '../../../../../gen/assets.gen.dart';
import '../tournament_detail_view_model.dart';

class TournamentDetailMatchesTab extends ConsumerWidget {
  final List<TeamModel> teams;
  final List<MatchModel> filteredMatches;
  final Function(String) onMatchFilter;
  final Function(List<MatchModel>) onSelected;

  const TournamentDetailMatchesTab({
    super.key,
    required this.teams,
    required this.filteredMatches,
    required this.onMatchFilter,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tournamentDetailStateProvider);
    if (filteredMatches.isEmpty) {
      return Stack(
        children: [
          EmptyScreen(
            title: context.l10n.tournament_detail_matches_empty_title,
            description:
                context.l10n.tournament_detail_matches_empty_description,
            isShowButton: false,
          ),
          _stickyButton(context),
        ],
      );
    }

    return ListView(
      padding: context.mediaQueryPadding.copyWith(top: 0) +
          EdgeInsets.all(16).copyWith(bottom: 24),
      children: [
        _filterView(context, state),
        ...filteredMatches.map(
          (match) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: MatchDetailCell(
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

  Widget _filterView(BuildContext context, TournamentDetailState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.l10n.tournament_detail_matches_filter_by_teams_title,
          style: AppTextStyle.header4.copyWith(
            color: context.colorScheme.textPrimary,
          ),
        ),
        TextButton.icon(
          iconAlignment: IconAlignment.end,
          onPressed: () => showFilterOptionSelectionSheet(
            context,
            matchFilter: state.matchFilter,
            onTap: onMatchFilter,
          ),
          label: Text(
            state.matchFilter ??
                context.l10n.tournament_detail_matches_filter_all_teams_option,
            style: AppTextStyle.body2.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          icon: SvgPicture.asset(
            Assets.images.icArrowDown,
            height: 18,
            width: 18,
            colorFilter: ColorFilter.mode(
              context.colorScheme.primary,
              BlendMode.srcATop,
            ),
          ),
        ),
      ],
    );
  }

  void showFilterOptionSelectionSheet(
    BuildContext context, {
    required Function(String) onTap,
    String? matchFilter,
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
                  child: _checkWidget(
                    context,
                    isShowCheck: matchFiltered == option,
                  ),
                  onTap: () {
                    context.pop();
                    onTap(option);
                  },
                ))
            .toList());
  }

  Widget? _checkWidget(
    BuildContext context, {
    required bool isShowCheck,
  }) =>
      isShowCheck
          ? SvgPicture.asset(
              Assets.images.icCheck,
              colorFilter: ColorFilter.mode(
                context.colorScheme.primary,
                BlendMode.srcATop,
              ),
            )
          : null;

  Widget _stickyButton(BuildContext context) {
    return BottomStickyOverlay(
      child: PrimaryButton(
        context.l10n.tournament_detail_matches_add_btn,
        onPressed: () {
          onSelected.call([]);
        },
      ),
    );
  }
}
