import 'dart:io';

import 'package:data/api/user/user_models.dart';
import 'package:data/service/auth/auth_service.dart';
import 'package:data/service/device/device_service.dart';
import 'package:data/service/user/user_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

part 'profile_view_model.freezed.dart';

final profileStateProvider =
    StateNotifierProvider.autoDispose<ProfileViewNotifier, ProfileState>((ref) {
  final notifier = ProfileViewNotifier(
    ref.read(authServiceProvider),
    ref.read(deviceServiceProvider),
    ref.read(userServiceProvider),
    ref.read(currentUserPod),
  );

  ref.listen(currentUserPod, (_, next) => notifier._updateUser(next));
  return notifier;
});

class ProfileViewNotifier extends StateNotifier<ProfileState> {
  static const String webFallbackUrl = 'https://github.com/canopas/khelo';

  final AuthService _authService;
  final DeviceService _deviceService;
  final UserService _userService;

  ProfileViewNotifier(
    this._authService,
    this._deviceService,
    this._userService,
    UserModel? user,
  ) : super(ProfileState(currentUser: user)) {
    _updateStat();
    refreshNotificationPermissionStatus();
    _getAppVersion();
  }

  void _updateUser(UserModel? user) {
    state = state.copyWith(currentUser: user);
    _updateStat();
  }

  void _updateStat() {
    state = state.copyWith(
      enableUserNotification: state.currentUser?.notifications ?? true,
    );
  }

  void _getAppVersion() async {
    final appVersion = await _deviceService.version;
    state = state.copyWith(appVersion: appVersion);
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

  void openUrl(String path) async {
    try {
      final targetUrl = Uri.parse(path);
      await launchUrl(targetUrl, mode: LaunchMode.externalApplication);
    } catch (error) {
      state = state.copyWith(actionError: error);
    }
  }

  void onToggleUserNotificationChange() async {
    try {
      final userId = state.currentUser?.id;
      if (userId == null) return;
      state = state.copyWith(actionError: null);

      await _userService.updateUserNotificationSettings(
        userId,
        !state.enableUserNotification,
      );
      state = state.copyWith(
        enableUserNotification: !state.enableUserNotification,
        actionError: null,
      );
    } catch (error) {
      state = state.copyWith(actionError: error);
      debugPrint(
          "ProfileViewNotifier: error while update user notifications -> $error");
    }
  }

  void refreshNotificationPermissionStatus() async {
    final isNotificationPermissionRequired =
        await DeviceService.isNotificationPermissionRequired();
    if (isNotificationPermissionRequired) {
      final isGranted = await Permission.notification.isGranted;
      state = state.copyWith(shouldShowNotificationBanner: !isGranted);
    } else {
      state = state.copyWith(shouldShowNotificationBanner: false);
    }
  }

  Future<void> onRateUs() async {
    try {
      final packageName = await _deviceService.packageName;
      final targetUrl = (!kIsWeb && Platform.isAndroid)
          ? "market://details?id=$packageName"
          : (!kIsWeb && Platform.isIOS)
              ? "itms-apps://itunes.apple.com/app/6480175424"
              : webFallbackUrl;
      await launchUrl(Uri.parse(targetUrl));
    } catch (e) {
      state = state.copyWith(actionError: e);
      debugPrint("ProfileViewNotifier: error while rate us -> $e");
    }
  }

  Future<void> onShareApp(String shareString) async {
    try {
      await Share.share(shareString);
    } catch (e) {
      state = state.copyWith(actionError: e);
      debugPrint("ProfileViewNotifier: error while share app -> $e");
    }
  }
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    Object? actionError,
    UserModel? currentUser,
    String? appVersion,
    @Default(true) bool enableUserNotification,
    @Default(false) bool shouldShowNotificationBanner,
  }) = _ProfileState;
}
