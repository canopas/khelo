import 'package:collection/collection.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_toss_detail_view_model.freezed.dart';

final addTossDetailStateProvider = StateNotifierProvider.autoDispose<
    AddTossDetailViewNotifier, AddTossDetailState>((ref) {
  return AddTossDetailViewNotifier(ref.read(matchServiceProvider));
});

class AddTossDetailViewNotifier extends StateNotifier<AddTossDetailState> {
  final MatchService _matchService;
  String? matchId;

  AddTossDetailViewNotifier(this._matchService)
      : super(const AddTossDetailState());

  void setData(String id) {
    matchId = id;
    getMatchById();
  }

  Future<void> getMatchById() async {
    if (matchId == null) {
      return;
    }
    state = state.copyWith(loading: true);
    try {
      final match = await _matchService.getMatchById(matchId!);
      state = state.copyWith(match: match, loading: false, error: null);
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint(
          "AddTossDetailViewNotifier: error while get Match By id -> $e");
    }
  }

  void onTossWinnerSelect(String id) {
    state = state.copyWith(tossWinnerTeamId: id);
    _onValueChange();
  }

  void onOptionSelect(TossDecision selection) {
    state = state.copyWith(tossWinnerDecision: selection);
    _onValueChange();
  }

  void _onValueChange() {
    final isEnable =
        state.tossWinnerDecision != null && state.tossWinnerTeamId != null;
    state = state.copyWith(isButtonEnable: isEnable);
  }

  Future<void> onNextButtonTap() async {
    final currentPlayingTeamId = state.tossWinnerDecision == TossDecision.bat
        ? state.tossWinnerTeamId
        : state.match!.teams
            .firstWhereOrNull(
                (element) => element.team.id != state.tossWinnerTeamId)
            ?.team
            .id;
    if (state.match?.id == null ||
        state.tossWinnerTeamId == null ||
        state.tossWinnerDecision == null ||
        currentPlayingTeamId == null) {
      return;
    }
    state =
        state.copyWith(isTossDetailUpdateInProgress: true, actionError: null);
    try {
      await _matchService.updateTossDetails(
          state.match!.id,
          state.tossWinnerTeamId!,
          state.tossWinnerDecision!,
          currentPlayingTeamId);
      state = state.copyWith(
          isTossDetailUpdateInProgress: false, pushScoreBoard: true);
    } catch (e) {
      state =
          state.copyWith(isTossDetailUpdateInProgress: false, actionError: e);
      debugPrint(
          "AddTossDetailViewNotifier: error while update toss detail -> $e");
    }
  }
}

@freezed
class AddTossDetailState with _$AddTossDetailState {
  const factory AddTossDetailState({
    Object? error,
    Object? actionError,
    MatchModel? match,
    TossDecision? tossWinnerDecision,
    String? tossWinnerTeamId,
    bool? pushScoreBoard,
    @Default(false) bool loading,
    @Default(false) bool isButtonEnable,
    @Default(false) bool isTossDetailUpdateInProgress,
  }) = _AddTossDetailState;
}
