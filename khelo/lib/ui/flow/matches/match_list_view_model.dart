import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_list_view_model.freezed.dart';

final matchListStateProvider = StateNotifierProvider.autoDispose<
    MatchListViewNotifier, MatchListViewState>((ref) {
  return MatchListViewNotifier();
});

class MatchListViewNotifier extends StateNotifier {
  MatchListViewNotifier() : super(const MatchListViewState());
}

@freezed
class MatchListViewState with _$MatchListViewState {
  const factory MatchListViewState({
    Object? error,
  }) = _MatchListViewState;
}
