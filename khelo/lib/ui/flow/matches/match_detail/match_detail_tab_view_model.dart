import 'dart:async';

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
          loadInnings();
        }
      },
      onError: (e, stack) {
        state = state.copyWith(error: state.match == null ? e : null, loading: false);
        debugPrint(
            "MatchDetailTabViewNotifier: error while load match -> $e. \n stack -> $stack");
      },
    );
  }

  void loadInnings() {
    if (state.match == null) {
      return;
    }
    if (state.match?.match_status == MatchStatus.yetToStart) {
      state = state.copyWith(loading: false);
      return;
    }
    state = state.copyWith(inningsQueryListenerSet: true);
    inningStreamSubscription = _inningService.getInningsStreamByMatchId(matchId: _matchId).listen(
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
          loadBallScores();
        }
      },
      onError: (e, stack) {
        state = state.copyWith(error: e, loading: false);
        debugPrint(
            "MatchDetailTabViewNotifier: error while load innings -> $e. \n stack -> $stack");
      },
    );
  }

  void loadBallScores() {
    if (state.firstInning == null || state.secondInning == null) {
      return;
    }
    state = state.copyWith(ballScoreQueryListenerSet: true);

    ballScoreStreamSubscription = _ballScoreService.getBallScoresStreamByInningIds([
      state.firstInning?.id ?? "INVALID ID",
      state.secondInning?.id ?? "INVALID ID"
    ]).listen(
      (scores) {
        final sortedList = scores;
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

  _cancelStreamSubscription() async {
    await matchStreamSubscription.cancel();
    await inningStreamSubscription.cancel();
    await ballScoreStreamSubscription.cancel();
  }

  @override
  void dispose() {
    _cancelStreamSubscription();
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
