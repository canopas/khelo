import 'package:collection/collection.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/action_bottom_sheet.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/commentary_ball_summary.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/widgets/adaptive_outlined_tile.dart';

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
        final highlightTeamId = ref.watch(matchDetailTabStateProvider.select(
          (value) => value.highlightTeamId,
        ));
        showTeamSelectionSheet(context, teams, onTap, highlightTeamId);
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
        final highlightFilterOption =
            ref.watch(matchDetailTabStateProvider.select(
          (value) => value.highlightFilterOption,
        ));
        showFilterOptionSelectionSheet(
          context,
          onTap: onSelection,
          highlightFilterOption: highlightFilterOption,
        );
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
      return const Center(child: AppProgressIndicator());
    }

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onResume,
      );
    }

    final teamName = _getTeamNameByInningId(state);

    return Padding(
      padding: context.mediaQueryPadding,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              children: [
                Expanded(
                    child: AdaptiveOutlinedTile(
                  placeholder: teamName,
                  title: teamName,
                  maxLines: 1,
                  onTap: notifier.showHighlightTeamSelectionDialog,
                  showTrailingIcon: true,
                )),
                const SizedBox(width: 8),
                Expanded(
                    child: AdaptiveOutlinedTile(
                  placeholder: state.highlightFilterOption.getString(context),
                  title: state.highlightFilterOption.getString(context),
                  maxLines: 1,
                  onTap: notifier.showHighlightFilterSelectionDialog,
                  showTrailingIcon: true,
                )),
              ],
            ),
          ),
          Expanded(child: _highlightList(context, state)),
        ],
      ),
    );
  }

  Widget _highlightList(BuildContext context, MatchDetailTabState state) {
    final highlight = state.filteredHighlight;

    if (highlight.isEmpty) {
      return EmptyScreen(
        title: context.l10n.match_detail_highlight_empty_title,
        description: context.l10n.match_detail_highlight_empty_description_text,
        isShowButton: false,
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.only(bottom: 24),
        itemCount: highlight.length,
        separatorBuilder: (context, index) =>
            Divider(color: context.colorScheme.outline, height: 32),
        itemBuilder: (context, index) {
          final overSummary = highlight[index];
          return Column(children: _buildHighlightList(context, overSummary));
        },
      );
    }
  }

  List<Widget> _buildHighlightList(
      BuildContext context, OverSummary overSummary) {
    List<Widget> children = [];
    for (int index = 0; index < overSummary.balls.length; index++) {
      children.add(CommentaryBallSummary(
          ball: overSummary.balls[index], overSummary: overSummary));
      if (index != overSummary.balls.length - 1) {
        children.add(Divider(
          color: context.colorScheme.outline,
          height: 32,
        ));
      }
    }
    return children;
  }

  String _getTeamNameByInningId(MatchDetailTabState state) {
    final teamName = state.match?.teams
        .firstWhereOrNull((element) => element.team.id == state.highlightTeamId)
        ?.team
        .name;
    return teamName ?? "--";
  }

  void showFilterOptionSelectionSheet(
    BuildContext context, {
    required Function(HighlightFilterOption) onTap,
    required HighlightFilterOption highlightFilterOption,
  }) async {
    return await showActionBottomSheet(
        context: context,
        items: HighlightFilterOption.values
            .map((option) => BottomSheetAction(
                  title: option.getString(context),
                  enabled: highlightFilterOption != option,
                  showCheck: highlightFilterOption == option,
                  onTap: () {
                    context.pop();
                    onTap(option);
                  },
                ))
            .toList());
  }

  void showTeamSelectionSheet(
    BuildContext context,
    List<MatchTeamModel>? teams,
    Function(String) onTap,
    String? highlightTeamId,
  ) async {
    return await showActionBottomSheet(
      context: context,
      items: teams
              ?.map((match) => BottomSheetAction(
                    title: match.team.name,
                    enabled: highlightTeamId != match.team.id,
                    showCheck: highlightTeamId == match.team.id,
                    onTap: () {
                      context.pop();
                      onTap(match.team.id);
                    },
                  ))
              .toList() ??
          [],
    );
  }
}
