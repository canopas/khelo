import 'package:collection/collection.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/won_by_message_text.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../components/empty_screen.dart';

class MatchDetailScorecardView extends ConsumerWidget {
  const MatchDetailScorecardView({super.key});

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

    return (state.overList.isNotEmpty)
        ? _content(context, notifier, state)
        : EmptyScreen(
            title: context.l10n.match_detail_match_not_started_error_title,
            description: context.l10n.match_detail_error_description_text,
            isShowButton: false,
          );
  }

  Widget _content(
    BuildContext context,
    MatchDetailTabViewNotifier notifier,
    MatchDetailTabState state,
  ) {
    List<List<int>> powerPlays = [
      if (state.match?.power_play_overs1.isNotEmpty ?? false)
        state.match!.power_play_overs1,
      if (state.match?.power_play_overs2.isNotEmpty ?? false)
        state.match!.power_play_overs2,
      if (state.match?.power_play_overs3.isNotEmpty ?? false)
        state.match!.power_play_overs3,
    ];
    final groupOversByInnings = groupOversByInning(state.overList);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.match?.matchResult != null) ...[
          _winnerMessageText(context, state.match!.matchResult!),
        ],
        Expanded(
          child: ListView.separated(
            padding: context.mediaQueryPadding +
                EdgeInsets.only(
                    top: state.match?.matchResult == null ? 16 : 0, bottom: 16),
            itemCount: groupOversByInnings.length,
            itemBuilder: (context, index) {
              final inningOvers = groupOversByInnings[index];
              final overs = inningOvers.lastOrNull;
              final batsmen = _getBatsmen(inningOvers);
              final bowler = _getBowlers(inningOvers);

              final teamSquad = state.match?.teams
                  .firstWhereOrNull(
                      (element) => element.team.id == overs?.team_id)
                  ?.squad;

              final yetToPlayPlayers = teamSquad
                  ?.where((element) => element.performance
                      .where((element) =>
                          element.inning_id == overs?.inning_id &&
                          element.status == PlayerStatus.yetToPlay)
                      .isNotEmpty)
                  .toList();

              return _teamTitleView(context,
                  teamName: _getTeamNameByTeamId(state, overs?.team_id ?? ""),
                  inningString: _getInningStringByInningId(
                      context, state, overs?.inning_id ?? ""),
                  over: overs ?? const OverSummary(),
                  initiallyExpanded: state.expandedInningsScorecard
                      .contains(inningOvers.first.inning_id),
                  children: [
                    _dataTable(context, batsmen: batsmen),
                    ..._buildMatchTotalView(context,
                        inningLastOver: overs ?? const OverSummary(),
                        didNotBatPlayers: yetToPlayPlayers ?? []),
                    _fallOfWicketView(context, inningOvers),
                    _dataTable(context, bowler: bowler),
                    _powerPlayView(context, powerPlays, inningOvers),
                  ],
                  onExpansionChanged: (isExpanded) =>
                      notifier.onScorecardExpansionChange(
                          overs?.inning_id ?? "", isExpanded));
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          ),
        ),
      ],
    );
  }

  Widget _winnerMessageText(BuildContext context, MatchResult matchResult) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: WonByMessageText(
        textStyle: AppTextStyle.body1
            .copyWith(color: context.colorScheme.textDisabled),
        matchResult: matchResult,
      ),
    );
  }

  Widget _teamTitleView(
    BuildContext context, {
    required String teamName,
    String? inningString,
    required OverSummary over,
    required bool initiallyExpanded,
    required List<Widget> children,
    required Function(bool) onExpansionChanged,
  }) {
    return Material(
      type: MaterialType.transparency,
      child: ExpansionTile(
        backgroundColor: context.colorScheme.primary,
        collapsedBackgroundColor: context.colorScheme.primary,
        collapsedIconColor: context.colorScheme.onPrimary,
        controlAffinity: ListTileControlAffinity.platform,
        iconColor: context.colorScheme.onPrimary,
        initiallyExpanded: initiallyExpanded,
        onExpansionChanged: onExpansionChanged,
        trailing: AnimatedRotation(
          turns: initiallyExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 300),
          child: Icon(
            CupertinoIcons.chevron_down,
            size: 24,
            color: context.colorScheme.onPrimary,
          ),
        ),
        collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teamName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.subtitle1
                        .copyWith(color: context.colorScheme.onPrimary),
                  ),
                  if (inningString != null)
                    Text(
                      inningString,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.caption
                          .copyWith(color: context.colorScheme.onPrimary),
                    ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                  text: "${over.totalRuns}-${over.totalWickets} ",
                  children: [
                    TextSpan(
                        text: "(${over.overCount})",
                        style: AppTextStyle.body2
                            .copyWith(color: context.colorScheme.onPrimary))
                  ]),
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.onPrimary),
            ),
          ],
        ),
        children: children,
      ),
    );
  }

  Widget _dataTable(
    BuildContext context, {
    List<BatsmanSummary>? batsmen,
    List<BowlerSummary>? bowler,
  }) {
    return Column(
      children: [
        _tableRow(context,
            highlightRow: true,
            data: batsmen != null
                ? [
                    context.l10n.match_scorecard_run_short_text,
                    context.l10n.match_scorecard_ball_short_text,
                    context.l10n.match_scorecard_fours_short_text,
                    context.l10n.match_scorecard_sixes_short_text,
                    context.l10n.match_scorecard_strike_rate_short_text
                  ]
                : [
                    context.l10n.match_scorecard_over_short_text,
                    context.l10n.match_scorecard_maiden_short_text,
                    context.l10n.match_scorecard_run_short_text,
                    context.l10n.match_scorecard_wicket_short_text,
                    context.l10n.match_scorecard_no_ball_short_text,
                    context.l10n.match_scorecard_wide_ball_short_text,
                    context.l10n.match_scorecard_economy_short_text
                  ],
            header: Text(
              batsmen != null
                  ? context.l10n.match_scorecard_batter_text
                  : context.l10n.match_scorecard_bowler_text,
              style: AppTextStyle.body1
                  .copyWith(color: context.colorScheme.textDisabled),
            )),
        if (batsmen != null)
          ..._buildBatsmanList(context, batsmen: batsmen)
        else
          ..._buildBowlerList(context, bowlers: bowler ?? []),
      ],
    );
  }

  Widget _tableRow(
    BuildContext context, {
    Widget? header,
    bool highlightRow = false,
    int? highlightColumnNumber,
    required List<String> data,
    VoidCallback? onTap,
  }) {
    return Container(
      color: context.colorScheme.surface,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: highlightRow
              ? context.colorScheme.containerLowOnSurface
              : context.colorScheme.surface,
        ),
        child: Row(
          children: [
            if (header != null) ...[
              Expanded(
                  flex: (data.length + 1) ~/ 1.5,
                  child: OnTapScale(
                      enabled: onTap != null, onTap: onTap, child: header)),
            ],
            for (int i = 0; i < data.length; i++) ...[
              Expanded(
                  child: Text(
                data[i],
                style: i == highlightColumnNumber
                    ? AppTextStyle.caption
                        .copyWith(color: context.colorScheme.textPrimary)
                    : AppTextStyle.caption
                        .copyWith(color: context.colorScheme.textDisabled),
                textAlign: TextAlign.center,
              )),
            ]
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBatsmanList(
    BuildContext context, {
    required List<BatsmanSummary> batsmen,
  }) {
    List<Widget> children = [];
    for (final player in batsmen) {
      String wicketString = "";
      if (player.wicketType == null) {
        wicketString = context.l10n.match_scorecard_not_out_text;
      } else {
        if (player.catchBy == null) {
          wicketString = player.wicketType?.getString(context) ?? "";

          if (player.wicketType != WicketType.timedOut &&
              player.wicketType != WicketType.retired &&
              player.wicketType != WicketType.retiredHurt) {
            wicketString += " (${player.ballBy?.name})";
          }
        } else {
          wicketString = context.l10n.match_scorecard_bowler_catcher_short_text(
              player.ballBy?.name ?? "", player.catchBy?.name ?? "");
        }
      }
      children.add(_tableRow(context,
          highlightColumnNumber: 0,
          data: [
            player.runs.toString(),
            player.ballFaced.toString(),
            player.fours.toString(),
            player.sixes.toString(),
            player.strikeRate.toString(),
          ],
          onTap: player.player.isActive
              ? () =>
                  AppRoute.userDetail(userId: player.player.id).push(context)
              : null,
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                player.player.name ?? '',
                style: AppTextStyle.subtitle2
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              Text(
                wicketString,
                style: AppTextStyle.caption
                    .copyWith(color: context.colorScheme.textDisabled),
              ),
            ],
          )));

      children.add(Divider(
        height: 0,
        color: context.colorScheme.outline,
      ));
    }
    return children;
  }

  List<Widget> _buildBowlerList(
    BuildContext context, {
    required List<BowlerSummary> bowlers,
  }) {
    List<Widget> children = [];
    for (int index = 0; index < bowlers.length; index++) {
      final bowler = bowlers[index];

      if (index != 0) {
        children.add(Divider(
          height: 0,
          color: context.colorScheme.outline,
        ));
      }

      children.add(_tableRow(context,
          highlightColumnNumber: 3,
          data: [
            bowler.overDelivered.toString(),
            bowler.maiden.toString(),
            bowler.runsConceded.toString(),
            bowler.wicket.toString(),
            bowler.noBalls.toString(),
            bowler.wideBalls.toString(),
            bowler.economy.toString(),
          ],
          onTap: bowler.player.isActive
              ? () =>
                  AppRoute.userDetail(userId: bowler.player.id).push(context)
              : null,
          header: Text(
            bowler.player.name ?? '',
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
          )));
    }
    return children;
  }

  List<Widget> _buildMatchTotalView(
    BuildContext context, {
    required OverSummary inningLastOver,
    required List<MatchPlayer> didNotBatPlayers,
  }) {
    List<Widget> children = [];
    // Extra Summary
    children.add(_matchTotalView(context,
        title: context.l10n.match_scorecard_extra_text,
        count: inningLastOver.extrasSummary.total,
        countDescription: context.l10n.match_scorecard_extras_short_text(
            inningLastOver.extrasSummary.bye,
            inningLastOver.extrasSummary.legBye,
            inningLastOver.extrasSummary.wideBall,
            inningLastOver.extrasSummary.noBall,
            inningLastOver.extrasSummary.penalty)));
    children.add(Divider(
      height: 0,
      color: context.colorScheme.outline,
    ));

    // total summary
    children.add(_matchTotalView(context,
        title: context.l10n.match_scorecard_total_text,
        count: inningLastOver.totalRuns,
        countDescription: context.l10n.match_scorecard_wicket_over_text(
            inningLastOver.totalWickets, inningLastOver.overCount)));
    children.add(Divider(
      height: 0,
      color: context.colorScheme.outline,
    ));

    // did not bat summary
    if (didNotBatPlayers.isNotEmpty) {
      children.add(_didNotBatView(context, didNotBatPlayers));
    }
    return children;
  }

  Widget _matchTotalView(
    BuildContext context, {
    required String title,
    required int count,
    required String countDescription,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      color: context.colorScheme.surface,
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
          )),
          Expanded(
              child: Text.rich(
                  style: AppTextStyle.caption
                      .copyWith(color: context.colorScheme.textPrimary),
                  TextSpan(text: "$count", children: [
                    TextSpan(
                        text: " ($countDescription)",
                        style: AppTextStyle.caption
                            .copyWith(color: context.colorScheme.textDisabled))
                  ]))),
        ],
      ),
    );
  }

  Widget _didNotBatView(BuildContext context, List<MatchPlayer> players) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      color: context.colorScheme.surface,
      child: Row(
        children: [
          Expanded(
              child: Text(
            context.l10n.match_scorecard_did_not_bat_text,
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
          )),
          Expanded(
              child: Text.rich(TextSpan(
                  children: players.map((player) {
            bool isLastName = players.last.player.id == player.player.id;
            String name = player.player.name ?? '';
            if (!isLastName) name += ", ";
            return WidgetSpan(
                child: OnTapScale(
              onTap: player.player.isActive
                  ? () => AppRoute.userDetail(userId: player.player.id)
                      .push(context)
                  : null,
              child: Text(name,
                  style: AppTextStyle.caption
                      .copyWith(color: context.colorScheme.textPrimary)),
            ));
          }).toList()))),
        ],
      ),
    );
  }

  Widget _fallOfWicketView(
      BuildContext context, List<OverSummary> inningOvers) {
    final oversWithWicket =
        inningOvers.expand((over) => over.outPlayers).toList();

    if (oversWithWicket.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tableRow(context,
            data: [],
            highlightRow: true,
            header: Text(
              context.l10n.match_scorecard_fall_of_wicket_text,
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textPrimary),
            )),
        Container(
          width: double.infinity,
          color: context.colorScheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text.rich(
            TextSpan(
                children: _buildFallOfWicketText(context, oversWithWicket)),
            style: AppTextStyle.caption
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ),
      ],
    );
  }

  List<InlineSpan> _buildFallOfWicketText(
    BuildContext context,
    List<BatsmanSummary> oversWithWicket,
  ) {
    List<InlineSpan> children = [];

    for (int index = 0; index < oversWithWicket.length; index++) {
      final batsmen = oversWithWicket[index];
      children.add(TextSpan(text: "${batsmen.runs} ("));
      children.add(WidgetSpan(
          child: OnTapScale(
              onTap: batsmen.player.isActive
                  ? () => AppRoute.userDetail(userId: batsmen.player.id)
                      .push(context)
                  : null,
              child: Text(batsmen.player.name ?? '',
                  style: AppTextStyle.caption
                      .copyWith(color: context.colorScheme.secondary)))));
      children.add(TextSpan(
          text:
              ", ${batsmen.outAtOver})${index == oversWithWicket.length - 1 ? "" : ", "}"));
    }
    return children;
  }

  Widget _powerPlayView(
    BuildContext context,
    List<List<int>> powerPlays,
    List<OverSummary> inningOvers,
  ) {
    if (powerPlays.isEmpty) {
      return const SizedBox();
    } else {
      List<Widget> children = [];
      children.add(_tableRow(context,
          data: [
            context.l10n.match_scorecard_over_text,
            context.l10n.match_scorecard_run_text
          ],
          highlightRow: true,
          header: Text(
            context.l10n.match_scorecard_power_play_text,
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
          )));
      int index = 0;
      for (var powerPlay in powerPlays) {
        final start = powerPlay.first;
        final end = powerPlay.last;
        index++;
        children.add(_tableRow(context,
            data: [
              "$start-$end",
              "${_getTotalRunsBetweenOvers(inningOvers, start, end)}"
            ],
            header: Text(
              context.l10n.power_play_text(index),
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textPrimary),
            )));
        if (index != powerPlays.length) {
          children.add(Divider(height: 0, color: context.colorScheme.outline));
        }
      }
      return Column(
        children: children,
      );
    }
  }

  List<List<OverSummary>> groupOversByInning(List<OverSummary> overs) {
    Map<String, List<OverSummary>> groupedOvers = {};

    for (var over in overs) {
      if (groupedOvers.containsKey(over.inning_id)) {
        groupedOvers[over.inning_id]!.add(over);
      } else {
        groupedOvers[over.inning_id] = [over];
      }
    }

    return groupedOvers.values.toList();
  }

  String _getTeamNameByTeamId(MatchDetailTabState state, String teamId) {
    return state.match?.teams
            .firstWhereOrNull((element) => element.team.id == teamId)
            ?.team
            .name ??
        "";
  }

  String? _getInningStringByInningId(
      BuildContext context, MatchDetailTabState state, String inningId) {
    if (state.match?.match_type != MatchType.testMatch) {
      return null;
    }

    final inningIndex = state.allInnings
        .firstWhereOrNull((element) => element.id == inningId)
        ?.index;

    if (inningIndex == 1 || inningIndex == 2) {
      return context.l10n.common_first_inning_title;
    } else {
      return context.l10n.common_second_inning_title;
    }
  }

  List<BatsmanSummary> _getBatsmen(List<OverSummary> inningOvers) {
    final lastOver = inningOvers.lastOrNull;
    List<BatsmanSummary> batsmen =
        inningOvers.expand((over) => over.outPlayers).toList();
    if (!batsmen
            .map((e) => e.player.id)
            .contains(lastOver?.striker.player.id) &&
        lastOver != null) {
      batsmen.add(lastOver.striker);
    }
    if (!batsmen
            .map((e) => e.player.id)
            .contains(lastOver?.nonStriker.player.id) &&
        lastOver != null) {
      batsmen.add(lastOver.nonStriker);
    }

    // remove duplicate
    Map<String, BatsmanSummary> batsManMap = {};
    for (final batsman in batsmen) {
      batsManMap[batsman.player.id] = batsman;
    }

    return batsManMap.values.toList();
  }

  List<BowlerSummary> _getBowlers(List<OverSummary> inningOvers) {
    Map<String, BowlerSummary> bowlerMap = {};

    // remove duplicate
    for (OverSummary over in inningOvers) {
      bowlerMap[over.bowler.player.id] = over.bowler;
    }
    List<BowlerSummary> bowlers = bowlerMap.values.toList();

    return bowlers;
  }

  int _getTotalRunsBetweenOvers(
    List<OverSummary> inningOvers,
    int startOver,
    int endOver,
  ) {
    if (startOver > endOver) return 0;
    final runsBeforeStartOver =
        (startOver - 1).isNegative || (startOver - 1) == 0
            ? 0
            : inningOvers
                    .firstWhereOrNull(
                        (element) => element.overNumber == startOver - 1)
                    ?.totalRuns ??
                0;

    final runsAfterEndOver = inningOvers
            .firstWhereOrNull((element) => element.overNumber == endOver)
            ?.totalRuns ??
        0;

    return runsAfterEndOver - runsBeforeStartOver;
  }
}
