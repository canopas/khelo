import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_stats_tab_view_model.freezed.dart';

final myStatsTabStateProvider =
    StateNotifierProvider.autoDispose<MyStatsTabViewNotifier, MyStatsTabState>(
        (ref) => MyStatsTabViewNotifier());

class MyStatsTabViewNotifier extends StateNotifier<MyStatsTabState> {
  MyStatsTabViewNotifier() : super(const MyStatsTabState());

  void onTabChange(int tab) {
    if (state.selectedTab != tab) {
      state = state.copyWith(selectedTab: tab);
    }
  }
}

@freezed
class MyStatsTabState with _$MyStatsTabState {
  const factory MyStatsTabState({
    @Default(0) int selectedTab,
  }) = _MyStatsTabState;
}
