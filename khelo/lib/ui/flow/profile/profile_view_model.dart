import 'package:data/api/user/user_models.dart';
import 'package:data/service/user/user_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_view_model.freezed.dart';

final profileStateProvider =
    StateNotifierProvider.autoDispose<ProfileViewNotifier, ProfileState>((ref) {
  final notifier = ProfileViewNotifier(
    FirebaseAuth.instance,
    ref.read(userServiceProvider),
    ref.read(currentUserPod),
  );
  ref.listen(currentUserPod, (_, next) => notifier._updateUser(next));
  return notifier;
});

class ProfileViewNotifier extends StateNotifier<ProfileState> {
  final FirebaseAuth _auth;
  final UserService _userService;

  ProfileViewNotifier(this._auth, this._userService, UserModel? user)
      : super(ProfileState(currentUser: user));

  void _updateUser(UserModel? user) {
    state = state.copyWith(currentUser: user);
  }

  void onSignOutTap() {
    // signOut from firebase auth
    try {
      _auth.signOut();
      _userService.signOutUser();
      // clear preference and show intro
    } catch (e) {
      debugPrint("ProfileViewNotifier: error while sign Out -> $e");
    }
  }
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({UserModel? currentUser}) = _ProfileState;
}
