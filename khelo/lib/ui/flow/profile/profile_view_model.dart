import 'package:data/api/user/user_models.dart';
import 'package:data/service/auth/auth_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

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
    state = state.copyWith(actionError: null);
    try {
      _authService.signOut();
    } catch (e) {
      state = state.copyWith(actionError: e);
      debugPrint("ProfileViewNotifier: error while sign Out -> $e");
    }
  }

  void onPrivacyPolicy(String path) async {
    try {
      final targetUrl = Uri.parse(path);
      await launchUrl(targetUrl, mode: LaunchMode.externalApplication);
    } catch (error) {
      state = state.copyWith(actionError: error);
    }
  }
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    Object? actionError,
    UserModel? currentUser,
  }) = _ProfileState;
}
