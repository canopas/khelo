import 'package:data/storage/provider/preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_game_tab_view_model.freezed.dart';

final myGameTabViewStateProvider =
    StateNotifierProvider.autoDispose<MyGameTabViewNotifier, MyGameTabState>(
        (ref) =>
            MyGameTabViewNotifier(ref.read(_myGameTabSelectionPod.notifier)));

final _myGameTabSelectionPod = createPrefProvider<int>(
  prefKey: "my_game_tab_selection",
  defaultValue: 0,
);

class MyGameTabViewNotifier extends StateNotifier<MyGameTabState> {
  final StateController<int> tabSelectionController;

  MyGameTabViewNotifier(this.tabSelectionController)
      : super(MyGameTabState(initialTab: tabSelectionController.state));

  void onTabChange(int tab) {
    tabSelectionController.state = tab;
  }
}

@freezed
class MyGameTabState with _$MyGameTabState {
  const factory MyGameTabState({
    required int initialTab,
  }) = _MyGameTabState;
}
