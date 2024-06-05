import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/action_bottom_sheet.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/commentary_ball_summary.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';
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
      return const Center(child: AppProgressIndicator());
    }

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: () => notifier.onResume(),
      );
    }

    final teamName = _getTeamNameByInningId(state);

    return Padding(
      padding: context.mediaQueryPadding,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
          Expanded(child: _highlightList(context, notifier, state)),
        ],
      ),
    );
  }

  Widget _highlightList(BuildContext context,
      MatchDetailTabViewNotifier notifier, MatchDetailTabState state) {
    final highlight = state.highlightFiltered;

    if (highlight.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            context.l10n.match_highlight_empty_highlight_text,
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle3
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: highlight.length,
      padding: const EdgeInsets.only(top: 24),
      separatorBuilder: (context, index) =>
          Divider(color: context.colorScheme.outline, height: 32),
      itemBuilder: (context, index) {
        final overSummary = highlight[index];
        final filterBall = overSummary.balls.where(
          (element) =>
              element.is_four ||
              element.is_six ||
              element.extras_type != null ||
              element.wicket_type != null,
        );
        return Column(
          children: [
            for (final ball in filterBall) ...[
              CommentaryBallSummary(ball: ball, overSummary: overSummary),
            ]
          ],
        );
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

  void showTeamSelectionSheet(
    BuildContext context,
    List<MatchTeamModel>? teams,
    Function(String) onTap,
  ) {
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
