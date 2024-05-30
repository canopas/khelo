import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/innings/inning_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/service/ball_score/ball_score_service.dart';
import 'package:data/service/innings/inning_service.dart';
import 'package:data/service/match/match_service.dart';
import 'package:flutter/cupertino.dart';
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
  late StreamSubscription inningStreamSubscription;
  late StreamSubscription ballScoreStreamSubscription;

  MatchDetailTabViewNotifier(
    this._matchService,
    this._inningService,
    this._ballScoreService,
  ) : super(const MatchDetailTabState());

  void setData(String matchId) {
    _matchId = matchId;
    loadMatch();
  }

  void loadMatch() {
    state = state.copyWith(loading: true);
    matchStreamSubscription = _matchService.getMatchStreamById(_matchId).listen(
      (match) {
        state = state.copyWith(
            match: match,
            highlightTeamId: match.teams.first.team.id,
            error: null);
        if (!state.inningsQueryListenerSet) {
          final expandedTeam = state.match?.match_status == MatchStatus.finish
              ? state.match?.matchResult?.winType == WinnerByType.tie
                  ? state.match?.teams.first.team.id
                  : state.match?.matchResult?.teamId
              : state.match?.current_playing_team_id;
          state = state.copyWith(expandedTeamScorecard: [expandedTeam ?? ""]);
          _loadInnings();
        }
      },
      onError: (e, stack) {
        state = state.copyWith(
            error: state.match == null ? e : null, loading: false);
        debugPrint(
            "MatchDetailTabViewNotifier: error while load match -> $e. \n stack -> $stack");
      },
    );
  }

  void _loadInnings() {
    if (state.match == null) {
      return;
    }
    if (state.match?.match_status == MatchStatus.yetToStart) {
      state = state.copyWith(loading: false);
      return;
    }
    state = state.copyWith(inningsQueryListenerSet: true);
    inningStreamSubscription =
        _inningService.getInningsStreamByMatchId(matchId: _matchId).listen(
      (innings) {
        final firstInning = innings.firstWhere((element) =>
            (state.match?.toss_decision == TossDecision.bat &&
                element.team_id == state.match?.toss_winner_id) ||
            (state.match?.toss_decision == TossDecision.bowl &&
                element.team_id != state.match?.toss_winner_id));

        final secondInning = innings.firstWhere((element) =>
            (state.match?.toss_decision == TossDecision.bowl &&
                element.team_id == state.match?.toss_winner_id) ||
            (state.match?.toss_decision == TossDecision.bat &&
                element.team_id != state.match?.toss_winner_id));

        state = state.copyWith(
            firstInning: firstInning, secondInning: secondInning, error: null);
        if (!state.ballScoreQueryListenerSet) {
          _loadBallScores();
        }
      },
      onError: (e, stack) {
        state = state.copyWith(error: e, loading: false);
        debugPrint(
            "MatchDetailTabViewNotifier: error while load innings -> $e. \n stack -> $stack");
      },
    );
  }

  void _loadBallScores() {
    if (state.firstInning == null || state.secondInning == null) {
      return;
    }
    state = state.copyWith(ballScoreQueryListenerSet: true);

    ballScoreStreamSubscription = _ballScoreService
        .getBallScoresStreamByInningIds([
      state.firstInning?.id ?? "INVALID ID",
      state.secondInning?.id ?? "INVALID ID"
    ]).listen(
      (scores) {
        List<BallScoreModel> sortedList = state.ballScores.toList();
        for (final score in scores) {
          if (score.type == DocumentChangeType.added) {
            sortedList.add(score.ballScore);
          } else if (score.type == DocumentChangeType.removed) {
            sortedList
                .removeWhere((element) => element.id == score.ballScore.id);
          }
        }
        sortedList.sort(
          (a, b) => a.time.compareTo(b.time),
        );
        state =
            state.copyWith(ballScores: sortedList, loading: false, error: null);
      },
      onError: (e, stack) {
        state = state.copyWith(error: e, loading: false);
        debugPrint(
            "MatchDetailTabViewNotifier: error while load ball scores -> $e. \n stack -> $stack");
      },
    );
  }

  showHighlightTeamSelectionDialog() {
    state = state.copyWith(showTeamSelectionSheet: DateTime.now());
  }

  showHighlightFilterSelectionDialog() {
    state = state.copyWith(showHighlightOptionSelectionSheet: DateTime.now());
  }

  onHighlightFilterSelection(HighlightFilterOption selection) {
    state = state.copyWith(highlightFilterOption: selection);
  }

  onHighlightTeamSelection(String teamId) {
    state = state.copyWith(highlightTeamId: teamId);
  }

  cancelStreamSubscription() async {
    state = state.copyWith(
        inningsQueryListenerSet: false, ballScoreQueryListenerSet: false);
    await matchStreamSubscription.cancel();
    await inningStreamSubscription.cancel();
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
    @Default(0) int selectedTab,
    @Default([]) List<String> expandedTeamScorecard,
    @Default([]) List<BallScoreModel> ballScores,
    @Default(false) bool loading,
    @Default(false) bool inningsQueryListenerSet,
    @Default(false) bool ballScoreQueryListenerSet,
    @Default(HighlightFilterOption.all)
    HighlightFilterOption highlightFilterOption,
  }) = _MatchDetailTabState;
}

enum MatchDetailTab {
  commentary,
  scorecard,
  overs,
  squad,
  matchInfo,
  highlight;

  String getString(BuildContext context) {
    switch (this) {
      case MatchDetailTab.commentary:
        return context.l10n.match_detail_commentary_tab_title;
      case MatchDetailTab.scorecard:
        return context.l10n.match_detail_scorecard_tab_title;
      case MatchDetailTab.squad:
        return context.l10n.match_detail_squad_tab_title;
      case MatchDetailTab.matchInfo:
        return context.l10n.match_detail_match_info_tab_title;
      case MatchDetailTab.highlight:
        return context.l10n.match_detail_highlight_tab_title;
      case MatchDetailTab.overs:
        return context.l10n.match_detail_overs_tab_title;
    }
  }

  Widget getTabScreen() {
    switch (this) {
      case MatchDetailTab.commentary:
        return const MatchDetailCommentaryView();
      case MatchDetailTab.scorecard:
        return const MatchDetailScorecardView();
      case MatchDetailTab.squad:
        return const MatchDetailSquadView();
      case MatchDetailTab.matchInfo:
        return const MatchDetailInfoView();
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
        return context.l10n.match_highlight_filter_wickets_text;
    }
  }
}
