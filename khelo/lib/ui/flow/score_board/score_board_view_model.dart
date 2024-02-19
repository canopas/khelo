import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'score_board_view_model.freezed.dart';

final scoreBoardStateProvider = StateNotifierProvider.autoDispose<
    ScoreBoardViewNotifier, ScoreBoardViewState>((ref) {
  return ScoreBoardViewNotifier();
});

class ScoreBoardViewNotifier extends StateNotifier<ScoreBoardViewState> {
  ScoreBoardViewNotifier() : super(const ScoreBoardViewState());

  void onScoreButtonTap(ScoreButton btn) {
    switch (btn) {
      case ScoreButton.zero:
      // TODO: Handle this case.
      case ScoreButton.one:
      // TODO: Handle this case.
      case ScoreButton.two:
      // TODO: Handle this case.
      case ScoreButton.three:
      // TODO: Handle this case.
      case ScoreButton.four:
      // TODO: Handle this case.
      case ScoreButton.six:
      // TODO: Handle this case.
      case ScoreButton.fiveOrSeven:
      // TODO: Handle this case.
      case ScoreButton.undo:
      // TODO: Handle this case.
      case ScoreButton.out:
      // TODO: Handle this case.
      case ScoreButton.noBall:
      // TODO: Handle this case.
      case ScoreButton.wideBall:
      // TODO: Handle this case.
      case ScoreButton.bye:
      // TODO: Handle this case.
      case ScoreButton.legBye:
      // TODO: Handle this case.
    }
  }
}

@freezed
class ScoreBoardViewState with _$ScoreBoardViewState {
  const factory ScoreBoardViewState({
    Object? error,
  }) = _ScoreBoardViewState;
}

enum ScoreButton {
  zero,
  one,
  two,
  three,
  four,
  six,
  fiveOrSeven,
  undo,
  out,
  noBall,
  wideBall,
  bye,
  legBye;

  String getTitle(BuildContext context) {
    switch (this) {
      case ScoreButton.zero:
        return "0";
      case ScoreButton.one:
        return "1";
      case ScoreButton.two:
        return "2";
      case ScoreButton.three:
        return "3";
      case ScoreButton.four:
        return "4";
      case ScoreButton.six:
        return "6";
      case ScoreButton.fiveOrSeven:
        return "5, 7";
      case ScoreButton.undo:
        return "UNDO";
      case ScoreButton.out:
        return "OUT";
      case ScoreButton.noBall:
        return "NB";
      case ScoreButton.wideBall:
        return "WB";
      case ScoreButton.bye:
        return "BYE";
      case ScoreButton.legBye:
        return "LB";
    }
  }
}
