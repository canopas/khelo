import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/innings/inning_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/service/ball_score/ball_score_service.dart';
import 'package:data/service/innings/inning_service.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/utils/combine_latest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/match_detail_commentary_view.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/match_detail_highlight_view.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/match_detail_info_view.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/match_detail_overs_view.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/match_detail_scorecard_view.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/match_detail_squad_view.dart';

part 'match_detail_tab_view_model.freezed.dart';

final matchDetailTabStateProvider = StateNotifierProvider.autoDispose<
    MatchDetailTabViewNotifier, MatchDetailTabState>(
  (ref) => MatchDetailTabViewNotifier(
    ref.read(matchServiceProvider),
    ref.read(inningServiceProvider),
    ref.read(ballScoreServiceProvider),
  ),
);

class MatchDetailTabViewNotifier extends StateNotifier<MatchDetailTabState> {
  final MatchService _matchService;
  final InningsService _inningService;
  final BallScoreService _ballScoreService;
  late String _matchId;
  late StreamSubscription matchStreamSubscription;
  late StreamSubscription ballScoreStreamSubscription;

  MatchDetailTabViewNotifier(
    this._matchService,
    this._inningService,
    this._ballScoreService,
  ) : super(const MatchDetailTabState());

  void setData(String matchId) {
    _matchId = matchId;
    _loadMatchesAndInning();
  }

  void _loadMatchesAndInning() {
    try {
      state = state.copyWith(loading: true);
      final matchInningStream = combineLatest2(
        _matchService.getMatchStreamById(_matchId),
        _inningService.getInningsStreamByMatchId(matchId: _matchId),
      );
      matchStreamSubscription = matchInningStream.listen((data) {
        final match = data.$1;
        final innings = data.$2;
        state = state.copyWith(match: match);
        final firstInning = innings
            .where((element) =>
                (state.match?.toss_decision == TossDecision.bat &&
                    element.team_id == state.match?.toss_winner_id) ||
                (state.match?.toss_decision == TossDecision.bowl &&
                    element.team_id != state.match?.toss_winner_id))
            .firstOrNull;

        final secondInning = innings
            .where((element) =>
                (state.match?.toss_decision == TossDecision.bowl &&
                    element.team_id == state.match?.toss_winner_id) ||
                (state.match?.toss_decision == TossDecision.bat &&
                    element.team_id != state.match?.toss_winner_id))
            .firstOrNull;

        onScorecardExpansionChange(
          match.matchResult?.teamId ?? match.current_playing_team_id?? "",
          true,
        );
        state = state.copyWith(
            highlightTeamId: state.highlightTeamId ?? match.teams.first.team.id,
            firstInning: firstInning,
            secondInning: secondInning,
            error: null);

        if (!state.ballScoreQueryListenerSet) {
          _loadBallScores();
        }
      }, onError: (e) {
        debugPrint(
            "MatchDetailTabViewNotifier: error while loading match and inning -> $e");
        state = state.copyWith(error: AppError.fromError(e), loading: false);
      });
    } catch (e) {
      debugPrint(
          "MatchDetailTabViewNotifier: error while loading match and inning -> $e");
      state = state.copyWith(error: AppError.fromError(e), loading: false);
    }
  }

  void _loadBallScores() {
    if (state.firstInning == null || state.secondInning == null) {
      state = state.copyWith(loading: false);
      return;
    }
    state = state.copyWith(ballScoreQueryListenerSet: true);

    ballScoreStreamSubscription = _ballScoreService
        .getBallScoresStreamByInningIds([
      state.firstInning?.id ?? "INVALID ID",
      state.secondInning?.id ?? "INVALID ID"
    ]).listen(
      (scores) {
        final sortedList = scores.toList();
        sortedList.sort((a, b) => a.ballScore.time.compareTo(b.ballScore.time));

        final overList = state.overList.toList();
        for (final score in sortedList) {
          if (score.type == DocumentChangeType.added) {
            final overSummary =
                _configureOverSummary(overList, score.ballScore);
            overList.removeWhere((element) =>
                element.overNumber == overSummary?.overNumber &&
                element.inning_id == overSummary?.inning_id);
            if (overSummary != null) {
              overList.add(overSummary);
            }
          } else if (score.type == DocumentChangeType.removed) {
            final overSummary =
                _configureOverSummary(overList, score.ballScore, isUndo: true);
            overList.removeWhere((element) =>
                element.overNumber == score.ballScore.over_number &&
                element.inning_id == score.ballScore.inning_id);
            if (overSummary != null) {
              overList.add(overSummary);
            }
          }
        }

        overList.sort((a, b) => a.time.compareTo(b.time));
        state = state.copyWith(overList: overList, loading: false, error: null);
        changeHighlightFilter();
      },
      onError: (e, stack) {
        state = state.copyWith(error: e, loading: false);
        debugPrint(
            "MatchDetailTabViewNotifier: error while load ball scores -> $e");
      },
    );
  }

  OverSummary? _configureOverSummary(
    List<OverSummary> overList,
    BallScoreModel ball, {
    bool isUndo = false,
  }) {
    if (isUndo) {
      final overToUpdate = overList.firstWhere((element) =>
          element.overNumber == ball.over_number &&
          element.inning_id == ball.inning_id);
      return overToUpdate.removeBall(ball);
    }

    BatsmanSummary striker = _configureBatsman(
        overList: overList,
        playerId: ball.batsman_id,
        inningId: ball.inning_id);
    BatsmanSummary nonStriker = _configureBatsman(
        overList: overList,
        playerId: ball.non_striker_id,
        inningId: ball.inning_id);

    final lastPlayerSummary = overList
        .where(
          (element) =>
              element.inning_id == ball.inning_id &&
              element.bowler.player.id == ball.bowler_id,
        )
        .lastOrNull
        ?.bowler;
    BowlerSummary bowler = _configureBowler(
        inningId: ball.inning_id,
        playerId: ball.bowler_id,
        lastPlayerSummary: lastPlayerSummary);
    Player? catchBy;
    if (ball.wicket_taker_id != null) {
      final player = _getPlayerByInningId(
          inningId: ball.inning_id,
          playerId: ball.wicket_taker_id!,
          isFieldingTeam: true);
      catchBy = Player(id: player.id, name: player.name ?? '');
    }

    final currentOver = overList
        .where((element) =>
            element.overNumber == ball.over_number &&
            element.inning_id == ball.inning_id)
        .firstOrNull;

    if (currentOver != null) {
      return currentOver
          .copyWith(striker: striker, nonStriker: nonStriker, bowler: bowler)
          .addBall(ball, catchBy: catchBy);
    } else {
      final lastOver = overList
          .where((element) =>
              element.overNumber == ball.over_number - 1 &&
              element.inning_id == ball.inning_id)
          .firstOrNull;
      return OverSummary(
              inning_id: ball.inning_id,
              overNumber: ball.over_number,
              team_id: _getTeamIdByInningId(ball.inning_id),
              striker: striker,
              nonStriker: nonStriker,
              bowler: bowler,
              totalRuns: lastOver?.inning_id == ball.inning_id
                  ? lastOver?.totalRuns ?? 0
                  : 0,
              totalWickets: lastOver?.inning_id == ball.inning_id
                  ? lastOver?.totalWickets ?? 0
                  : 0)
          .addBall(ball, catchBy: catchBy);
    }
  }

  String _getTeamIdByInningId(String inningId) {
    final teamId = state.firstInning?.id == inningId
        ? state.firstInning?.team_id
        : state.secondInning?.team_id;
    return teamId ?? "";
  }

  BowlerSummary _configureBowler({
    BowlerSummary? lastPlayerSummary,
    required String inningId,
    required String playerId,
  }) {
    BowlerSummary? bowler = lastPlayerSummary;

    if (bowler == null) {
      final player = _getPlayerByInningId(
          inningId: inningId, playerId: playerId, isFieldingTeam: true);
      bowler = BowlerSummary(player: player);
    }

    return bowler;
  }

  int getFractionalPart(double value) {
    String valueString = value.toString();

    List<String> parts = valueString.split('.');

    if (parts.length > 1) {
      return int.parse(parts[1]);
    } else {
      return 0;
    }
  }

  BatsmanSummary _configureBatsman({
    required List<OverSummary> overList,
    required String playerId,
    required String inningId,
  }) {
    OverSummary? lastPlayerContainedOver = overList
        .where((element) =>
            element.inning_id == inningId &&
            (element.striker.player.id == playerId ||
                element.nonStriker.player.id == playerId))
        .lastOrNull;
    BatsmanSummary? lastBatsman;
    if (lastPlayerContainedOver != null) {
      lastBatsman = lastPlayerContainedOver.striker.player.id == playerId
          ? lastPlayerContainedOver.striker
          : lastPlayerContainedOver.nonStriker;
    }
    if (lastBatsman == null) {
      final overContainingOutPlayers = overList
          .where((element) =>
              element.inning_id == inningId &&
              element.outPlayers.any((e) => e.player.id == playerId))
          .lastOrNull;
      lastBatsman = overContainingOutPlayers?.outPlayers
          .firstWhere((element) => element.player.id == playerId);
    }
    if (lastBatsman == null) {
      UserModel player =
          _getPlayerByInningId(inningId: inningId, playerId: playerId);
      lastBatsman = BatsmanSummary(player: player);
    }

    return lastBatsman;
  }

  UserModel _getPlayerByInningId({
    required String inningId,
    required String playerId,
    bool isFieldingTeam = false,
  }) {
    final teamId = [state.firstInning, state.secondInning]
        .where((element) =>
            isFieldingTeam ? element?.id != inningId : element?.id == inningId)
        .firstOrNull
        ?.team_id;

    final player = state.match?.teams
        .where((element) => teamId == element.team.id)
        .firstOrNull
        ?.squad
        .where((element) => element.player.id == playerId)
        .firstOrNull
        ?.player;

    return player ?? const UserModel(id: '');
  }

  void showHighlightTeamSelectionDialog() {
    state = state.copyWith(showTeamSelectionSheet: DateTime.now());
  }

  void showHighlightFilterSelectionDialog() {
    state = state.copyWith(showHighlightOptionSelectionSheet: DateTime.now());
  }

  void onHighlightFilterSelection(HighlightFilterOption selection) {
    if (state.highlightFilterOption == selection) return;

    state = state.copyWith(highlightFilterOption: selection);
    changeHighlightFilter();
  }

  void onHighlightTeamSelection(String teamId) {
    if (state.highlightTeamId == teamId) return;

    state = state.copyWith(highlightTeamId: teamId);
    changeHighlightFilter();
  }

  void changeHighlightFilter() {
    final highlightList = state.overList.where((element) {
      return element.team_id == state.highlightTeamId &&
          element.balls.any(shouldIncludeInHighlight);
    }).map((over) {
      final filteredBalls = over.balls.where(shouldIncludeInHighlight).toList();
      return over.copyWith(balls: filteredBalls);
    }).toList();

    state = state.copyWith(filteredHighlight: highlightList);
  }

  bool shouldIncludeInHighlight(BallScoreModel ball) {
    switch (state.highlightFilterOption) {
      case HighlightFilterOption.all:
        return ball.extras_type != null ||
            ball.wicket_type != null ||
            ball.is_six ||
            ball.is_four;
      case HighlightFilterOption.fours:
        return ball.is_four;
      case HighlightFilterOption.sixes:
        return ball.is_six;
      case HighlightFilterOption.wickets:
        return ball.wicket_type != null &&
            ball.wicket_type != WicketType.retiredHurt;
    }
  }

  Future<void> cancelStreamSubscription() async {
    state = state.copyWith(ballScoreQueryListenerSet: false);
    await matchStreamSubscription.cancel();
    await ballScoreStreamSubscription.cancel();
  }

  void onTabChange(int tab) {
    if (state.selectedTab != tab) {
      state = state.copyWith(selectedTab: tab);
    }
  }

  void onScorecardExpansionChange(String teamId, bool isExpanded) {
    List<String> expandedList = state.expandedTeamScorecard.toList();
    if (isExpanded) {
      expandedList.add(teamId);
    } else {
      expandedList.remove(teamId);
    }
    state =
        state.copyWith(expandedTeamScorecard: expandedList.toSet().toList());
  }

  Future<void> onResume() async {
    await cancelStreamSubscription();
    _loadMatchesAndInning();
  }

  @override
  void dispose() {
    cancelStreamSubscription();
    super.dispose();
  }
}

@freezed
class MatchDetailTabState with _$MatchDetailTabState {
  const factory MatchDetailTabState({
    Object? error,
    MatchModel? match,
    InningModel? firstInning,
    InningModel? secondInning,
    String? highlightTeamId,
    DateTime? showTeamSelectionSheet,
    DateTime? showHighlightOptionSelectionSheet,
    @Default(1) int selectedTab,
    @Default([]) List<OverSummary> overList,
    @Default([]) List<OverSummary> filteredHighlight,
    @Default([]) List<String> expandedTeamScorecard,
    @Default(false) bool loading,
    @Default(false) bool ballScoreQueryListenerSet,
    @Default(HighlightFilterOption.all)
    HighlightFilterOption highlightFilterOption,
  }) = _MatchDetailTabState;
}

enum MatchDetailTab {
  matchInfo,
  commentary,
  scorecard,
  overs,
  squad,
  highlight;

  String getString(BuildContext context) {
    switch (this) {
      case MatchDetailTab.matchInfo:
        return context.l10n.match_detail_match_info_tab_title;
      case MatchDetailTab.commentary:
        return context.l10n.match_detail_commentary_tab_title;
      case MatchDetailTab.scorecard:
        return context.l10n.match_detail_scorecard_tab_title;
      case MatchDetailTab.squad:
        return context.l10n.match_detail_squad_tab_title;
      case MatchDetailTab.highlight:
        return context.l10n.match_detail_highlight_tab_title;
      case MatchDetailTab.overs:
        return context.l10n.common_overs_title;
    }
  }

  Widget getTabScreen() {
    switch (this) {
      case MatchDetailTab.matchInfo:
        return const MatchDetailInfoView();
      case MatchDetailTab.commentary:
        return const MatchDetailCommentaryView();
      case MatchDetailTab.scorecard:
        return const MatchDetailScorecardView();
      case MatchDetailTab.squad:
        return const MatchDetailSquadView();
      case MatchDetailTab.highlight:
        return const MatchDetailHighlightView();
      case MatchDetailTab.overs:
        return const MatchDetailOversView();
    }
  }
}

enum HighlightFilterOption {
  all,
  fours,
  sixes,
  wickets;

  String getString(BuildContext context) {
    switch (this) {
      case HighlightFilterOption.all:
        return context.l10n.match_highlight_filter_all_text;
      case HighlightFilterOption.fours:
        return context.l10n.match_highlight_filter_fours_text;
      case HighlightFilterOption.sixes:
        return context.l10n.match_highlight_filter_sixes_text;
      case HighlightFilterOption.wickets:
        return context.l10n.common_wickets_text;
    }
  }
}
