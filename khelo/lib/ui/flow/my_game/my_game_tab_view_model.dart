import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_game_tab_view_model.freezed.dart';

final myGameTabViewStateProvider =
    StateNotifierProvider.autoDispose<MyGameTabViewNotifier, MyGameTabState>(
        (ref) => MyGameTabViewNotifier());

class MyGameTabViewNotifier extends StateNotifier<MyGameTabState> {
  MyGameTabViewNotifier() : super(const MyGameTabState());

  void onTabChange(int tab) {
    if (state.selectedTab != tab) {
      state = state.copyWith(selectedTab: tab);
    }
  }
}

@freezed
class MyGameTabState with _$MyGameTabState {
  const factory MyGameTabState({
    @Default(0) int selectedTab,
  }) = _MyGameTabState;
}
