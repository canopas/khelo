import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/action_bottom_sheet.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/commentary_ball_summary.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class MatchDetailHighlightView extends ConsumerWidget {
  const MatchDetailHighlightView({super.key});

  _observeShowTeamSelectionSheet(
    BuildContext context,
    WidgetRef ref,
    List<MatchTeamModel>? teams,
    Function(String) onTap,
  ) {
    ref.listen(
        matchDetailTabStateProvider
            .select((value) => value.showTeamSelectionSheet), (previous, next) {
      if (next != null) {
        showTeamSelectionSheet(context, teams, onTap);
      }
    });
  }

  _observeShowHighlightOptionSelectionSheet(BuildContext context, WidgetRef ref,
      Function(HighlightFilterOption) onSelection) {
    ref.listen(
        matchDetailTabStateProvider
            .select((value) => value.showHighlightOptionSelectionSheet),
        (previous, next) {
      if (next != null) {
        showFilterOptionSelectionSheet(context, onSelection);
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchDetailTabStateProvider);
    final notifier = ref.watch(matchDetailTabStateProvider.notifier);

    _observeShowTeamSelectionSheet(
        context, ref, state.match?.teams, notifier.onHighlightTeamSelection);
    _observeShowHighlightOptionSelectionSheet(
        context, ref, notifier.onHighlightFilterSelection);

    return _body(context, notifier, state);
  }

  Widget _body(
    BuildContext context,
    MatchDetailTabViewNotifier notifier,
    MatchDetailTabState state,
  ) {
    if (state.loading) {
      return const AppProgressIndicator();
    }

    final teamName = _getTeamNameByInningId(state);

    return Padding(
      padding: context.mediaQueryPadding,
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _highlightFilterButton(context, teamName,
                      notifier.showHighlightTeamSelectionDialog),
                ),
                const VerticalDivider(
                  width: 1,
                ),
                Expanded(
                  child: _highlightFilterButton(
                      context,
                      state.highlightFilterOption.getString(context),
                      notifier.showHighlightFilterSelectionDialog),
                ),
              ],
            ),
          ),
          Expanded(child: _highlightList(context, notifier, state)),
        ],
      ),
    );
  }

  Widget _highlightList(BuildContext context,
      MatchDetailTabViewNotifier notifier, MatchDetailTabState state) {
    final highlight = _getHighlightsScore(state);

    if (highlight.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            context.l10n.match_highlight_empty_highlight_text,
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: highlight.length,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return CommentaryBallSummary(state: state, ball: highlight[index]);
      },
    );
  }

  String _getTeamNameByInningId(MatchDetailTabState state) {
    final teamName = state.match?.teams
        .where((element) => element.team.id == state.highlightTeamId)
        .firstOrNull
        ?.team
        .name;
    return teamName ?? "--";
  }

  Widget _highlightFilterButton(
      BuildContext context, String title, Function() onTap) {
    return OnTapScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        color: context.colorScheme.containerNormalOnSurface,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.subtitle1.copyWith(
                    color: context.colorScheme.textPrimary,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            Icon(
              Icons.expand_more_sharp,
              color: context.colorScheme.textPrimary,
            )
          ],
        ),
      ),
    );
  }

  List<BallScoreModel> _getHighlightsScore(MatchDetailTabState state) {
    final inningId = state.firstInning?.team_id == state.highlightTeamId
        ? state.firstInning?.id
        : state.secondInning?.id;
    switch (state.highlightFilterOption) {
      case HighlightFilterOption.all:
        return state.ballScores
            .where((element) =>
                element.inning_id == inningId &&
                (element.wicket_type != null ||
                    element.is_four ||
                    element.is_six))
            .toList();
      case HighlightFilterOption.fours:
        return state.ballScores
            .where(
                (element) => element.inning_id == inningId && element.is_four)
            .toList();
      case HighlightFilterOption.sixes:
        return state.ballScores
            .where((element) => element.inning_id == inningId && element.is_six)
            .toList();
      case HighlightFilterOption.wickets:
        return state.ballScores
            .where((element) =>
                element.inning_id == inningId && element.wicket_type != null)
            .toList();
    }
  }

  void showFilterOptionSelectionSheet(
      BuildContext context, Function(HighlightFilterOption) onTap) {
    showActionBottomSheet(
        context: context,
        items: HighlightFilterOption.values
            .map((e) => BottomSheetAction(
                  title: e.getString(context),
                  onTap: () {
                    context.pop();
                    onTap(e);
                  },
                ))
            .toList());
  }

  void showTeamSelectionSheet(BuildContext context, List<MatchTeamModel>? teams,
      Function(String) onTap) {
    showActionBottomSheet(
      context: context,
      items: teams
              ?.map((e) => BottomSheetAction(
                    title: e.team.name,
                    onTap: () {
                      context.pop();
                      onTap(e.team.id ?? "INVALID ID");
                    },
                  ))
              .toList() ??
          [],
    );
  }
}
