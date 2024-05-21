import 'package:data/storage/provider/preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_stats_tab_view_model.freezed.dart';

final myStatsTabStateProvider =
    StateNotifierProvider.autoDispose<MyStatsTabViewNotifier, MyStatsTabState>(
        (ref) =>
            MyStatsTabViewNotifier(ref.read(_myStatSelectionPod.notifier)));

final _myStatSelectionPod = createPrefProvider<int>(
  prefKey: "my_stat_tab_selection",
  defaultValue: 0,
);

class MyStatsTabViewNotifier extends StateNotifier<MyStatsTabState> {
  final StateController<int> tabSelectionController;

  MyStatsTabViewNotifier(this.tabSelectionController)
      : super(MyStatsTabState(initialTab: tabSelectionController.state));

  void onTabChange(int tab) {
    tabSelectionController.state = tab;
  }
}

@freezed
class MyStatsTabState with _$MyStatsTabState {
  const factory MyStatsTabState({
    required int initialTab,
  }) = _MyStatsTabState;
}
