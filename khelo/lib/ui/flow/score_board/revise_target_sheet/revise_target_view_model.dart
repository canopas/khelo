import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'revise_target_view_model.freezed.dart';

final reviseTargetStateProvider = StateNotifierProvider.autoDispose<
    ReviseTargetViewNotifier, ReviseTargetViewState>((ref) {
  return ReviseTargetViewNotifier();
});

class ReviseTargetViewNotifier extends StateNotifier<ReviseTargetViewState> {
  ReviseTargetViewNotifier()
      : super(ReviseTargetViewState(
          manualOverTextController: TextEditingController(),
          manualRunsTextController: TextEditingController(),
        ));

  void setData(int runs, int overs) {
    state = state.copyWith(actualTarget: runs, totalOvers: overs);
  }

  void onConfirmTarget() {
    final runs = int.parse(state.manualRunsTextController.text);
    final overs = double.parse(state.manualOverTextController.text);

    if (!((overs.toInt() <= 0 && overs.toInt() >= state.totalOvers) ||
        runs >= state.actualTarget)) {
      state = state.copyWith(isPop: true);
    } else {
      state = state.copyWith(showErrorString: true);
    }
  }

  void onTextChange() {
    final isEnable = state.manualOverTextController.text.trim().isNotEmpty &&
        state.manualRunsTextController.text.trim().isNotEmpty;
    state = state.copyWith(showErrorString: null, isButtonEnabled: isEnable);
  }

  @override
  void dispose() {
    state.manualRunsTextController.dispose();
    state.manualOverTextController.dispose();
    super.dispose();
  }
}

@freezed
class ReviseTargetViewState with _$ReviseTargetViewState {
  const factory ReviseTargetViewState({
    bool? showErrorString,
    bool? isPop,
    @Default(false) bool isButtonEnabled,
    @Default(0) int actualTarget,
    @Default(0) int totalOvers,
    required TextEditingController manualOverTextController,
    required TextEditingController manualRunsTextController,
  }) = _ReviseTargetViewState;
}
