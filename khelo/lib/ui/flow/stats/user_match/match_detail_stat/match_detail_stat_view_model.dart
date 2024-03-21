import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/innings/inning_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/service/ball_score/ball_score_service.dart';
import 'package:data/service/innings/inning_service.dart';
import 'package:data/service/match/match_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_detail_stat_view_model.freezed.dart';

final matchDetailStatViewStateProvider = StateNotifierProvider.autoDispose<
        MatchDetailStatViewNotifier, MatchDetailStatViewState>(
    (ref) => MatchDetailStatViewNotifier(
          ref.read(matchServiceProvider),
          ref.read(inningServiceProvider),
          ref.read(ballScoreServiceProvider),
        ));

class MatchDetailStatViewNotifier
    extends StateNotifier<MatchDetailStatViewState> {
  final MatchService _matchService;
  final InningsService _inningService;
  final BallScoreService _ballScoreService;

  MatchDetailStatViewNotifier(
      this._matchService, this._inningService, this._ballScoreService)
      : super(const MatchDetailStatViewState());

  void setData(String matchId) {
    state = state.copyWith(matchId: matchId);
    loadMatch();
  }

  Future<void> loadMatch() async {
    if (state.matchId == null) {
      return;
    }

    state = state.copyWith(loading: state.match == null);
    try {
      final match = await _matchService.getMatchById(state.matchId!);
      final innings = await _inningService.getInningsByMatchId(
          matchId: match.id ?? "INVALID ID");
      final firstInning = match.toss_decision == TossDecision.bat
          ? innings
              .where((element) => element.team_id == match.toss_winner_id)
              .first
          : innings
              .where((element) => element.team_id != match.toss_winner_id)
              .first;

      final secondInning = innings
          .where((element) => element.team_id != firstInning.team_id)
          .first;

      final firstScore = await _ballScoreService
          .getBallScoreListByInningId(firstInning.id ?? "INVALID ID");
      final secondScore = await _ballScoreService
          .getBallScoreListByInningId(secondInning.id ?? "INVALID ID");

      state = state.copyWith(
          match: match,
          firstInning: firstInning,
          secondInning: secondInning,
          firstScore: firstScore,
          secondScore: secondScore,
          loading: false);
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint(
          "MatchDetailStatViewNotifier: error while loading match -> $e");
    }
  }
}

@freezed
class MatchDetailStatViewState with _$MatchDetailStatViewState {
  const factory MatchDetailStatViewState({
    Object? error,
    @Default(false) bool loading,
    String? matchId,
    MatchModel? match,
    InningModel? firstInning,
    InningModel? secondInning,
    List<BallScoreModel>? firstScore,
    List<BallScoreModel>? secondScore,
  }) = _MatchDetailStatViewState;
}
