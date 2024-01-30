import 'package:data/api/user/user_models.dart';
import 'package:data/service/auth/auth_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_view_model.freezed.dart';

final profileStateProvider =
    StateNotifierProvider.autoDispose<ProfileViewNotifier, ProfileState>((ref) {
  final notifier = ProfileViewNotifier(
    ref.read(authServiceProvider),
    ref.read(currentUserPod),
  );
  ref.listen(currentUserPod, (_, next) => notifier._updateUser(next));
  return notifier;
});

class ProfileViewNotifier extends StateNotifier<ProfileState> {
  final AuthService _authService;

  ProfileViewNotifier(this._authService, UserModel? user)
      : super(ProfileState(currentUser: user));

  void _updateUser(UserModel? user) {
    state = state.copyWith(currentUser: user);
  }

  void onSignOutTap() {
    try {
      _authService.signOut();
    } catch (e) {
      debugPrint("ProfileViewNotifier: error while sign Out -> $e");
    }
  }
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({UserModel? currentUser}) = _ProfileState;
}
