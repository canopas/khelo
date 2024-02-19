import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

part 'power_play_view_model.freezed.dart';

final powerPlayStateProvider = StateNotifierProvider.autoDispose<
    PowerPlayViewNotifier, PowerPlayViewState>((ref) {
  return PowerPlayViewNotifier();
});

class PowerPlayViewNotifier extends StateNotifier<PowerPlayViewState> {
  PowerPlayViewNotifier() : super(const PowerPlayViewState());

  void setData(
    List<int>? firstPowerPlay,
    List<int>? secondPowerPlay,
    List<int>? thirdPowerPlay,
  ) {
    state = state.copyWith(
        firstPowerPlay: firstPowerPlay ?? [],
        secondPowerPlay: secondPowerPlay ?? [],
        thirdPowerPlay: thirdPowerPlay ?? []);
  }

  void onResetButtonTap(PowerPlayType powerPlay) {
    if (powerPlay == PowerPlayType.one) {
      state = state.copyWith(firstPowerPlay: []);
    } else if (powerPlay == PowerPlayType.two) {
      state = state.copyWith(secondPowerPlay: []);
    } else if (powerPlay == PowerPlayType.three) {
      state = state.copyWith(thirdPowerPlay: []);
    }
  }

  void onOverTap(int over, PowerPlayType powerPlay) {
    final list = powerPlay == PowerPlayType.one
        ? state.firstPowerPlay.toList()
        : powerPlay == PowerPlayType.two
            ? state.secondPowerPlay.toList()
            : state.thirdPowerPlay.toList();

    list.sort();

    final lastElement = list.lastOrNull;
    final firstElement = list.firstOrNull;

    if (_isForUndo(over, powerPlay)) {
      if (!_canUndo(over, firstElement, lastElement)) {
        return;
      }

      list.removeWhere((element) => element == over);

      state = state.copyWith(
          firstPowerPlay:
              powerPlay == PowerPlayType.one ? list : state.firstPowerPlay,
          secondPowerPlay:
              powerPlay == PowerPlayType.two ? list : state.secondPowerPlay,
          thirdPowerPlay:
              powerPlay == PowerPlayType.three ? list : state.thirdPowerPlay);
    } else {
      if (!_isSelectable(over, firstElement, lastElement) ||
          !_isGreaterThanPriorList(over, powerPlay)) {
        return;
      }

      state = state.copyWith(
          firstPowerPlay: powerPlay == PowerPlayType.one
              ? [...state.firstPowerPlay, over]
              : state.firstPowerPlay,
          secondPowerPlay: powerPlay == PowerPlayType.two
              ? [...state.secondPowerPlay, over]
              : state.secondPowerPlay,
          thirdPowerPlay: powerPlay == PowerPlayType.three
              ? [...state.thirdPowerPlay, over]
              : state.thirdPowerPlay);
    }
  }

  bool _isSelectable(int over, int? firstElement, int? lastElement) {
    return (lastElement == null && firstElement == null) ||
        lastElement! + 1 == over ||
        firstElement! - 1 == over;
  }

  bool _isGreaterThanPriorList(int over, PowerPlayType type) {
    final priorList = type == PowerPlayType.two
        ? state.firstPowerPlay.toList()
        : state.secondPowerPlay.toList();
    priorList.sort();
    final priorListEnd = priorList.lastOrNull;
    return !(type != PowerPlayType.one &&
        priorListEnd != null &&
        over < priorListEnd);
  }

  bool _canUndo(int over, int? firstElement, int? lastElement) {
    return over == firstElement || over == lastElement;
  }

  bool _isForUndo(int over, PowerPlayType powerPlay) {
    return powerPlay == PowerPlayType.one
        ? state.firstPowerPlay.contains(over)
        : powerPlay == PowerPlayType.two
            ? state.secondPowerPlay.contains(over)
            : state.thirdPowerPlay.contains(over);
  }
}

@freezed
class PowerPlayViewState with _$PowerPlayViewState {
  const factory PowerPlayViewState({
    @Default([]) List<int> firstPowerPlay,
    @Default([]) List<int> secondPowerPlay,
    @Default([]) List<int> thirdPowerPlay,
  }) = _PowerPlayViewState;
}

enum PowerPlayType {
  one,
  two,
  three;

  String getTitle(BuildContext context) {
    switch (this) {
      case PowerPlayType.one:
        return context.l10n.power_play_text(1);
      case PowerPlayType.two:
        return context.l10n.power_play_text(2);
      case PowerPlayType.three:
        return context.l10n.power_play_text(3);
    }
  }
}
