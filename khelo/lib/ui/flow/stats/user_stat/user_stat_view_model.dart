import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/service/ball_score/ball_score_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stat_view_model.freezed.dart';

final userStatViewStateProvider =
    StateNotifierProvider.autoDispose<UserStatViewNotifier, UserStatViewState>(
        (ref) {
  final notifier = UserStatViewNotifier(
    ref.read(ballScoreServiceProvider),
    ref.read(currentUserPod)?.id,
  );
  ref.listen(currentUserPod, (previous, next) {
    notifier.setUserId(next?.id);
  });
  return notifier;
});

class UserStatViewNotifier extends StateNotifier<UserStatViewState> {
  final BallScoreService _ballScoreService;

  UserStatViewNotifier(this._ballScoreService, String? userId)
      : super(UserStatViewState(currentUserId: userId)) {
    getUserRelatedBalls();
  }

  void setUserId(String? userId) {
    state = state.copyWith(currentUserId: userId);
  }

  Future<void> getUserRelatedBalls() async {
    state = state.copyWith(loading: true);
    try {
      final ballScores = await _ballScoreService.getCurrentUserRelatedBalls();
      state = state.copyWith(ballList: ballScores, loading: false);
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint(
          "UserStatViewNotifier: error while getting user related balls -> $e");
    }
  }
}

@freezed
class UserStatViewState with _$UserStatViewState {
  const factory UserStatViewState({
    Object? error,
    String? currentUserId,
    @Default([]) List<BallScoreModel> ballList,
    @Default(false) bool loading,
  }) = _UserStatViewState;
}
