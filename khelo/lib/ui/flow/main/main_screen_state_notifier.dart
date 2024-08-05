import 'dart:async';

import 'package:data/api/user/user_models.dart';
import 'package:data/service/auth/auth_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_screen_state_notifier.freezed.dart';

final mainScreenStateNotifierProvider =
    StateNotifierProvider<MainScreenStateNotifier, MainScreenState>((ref) {
  return MainScreenStateNotifier(
    ref.read(lastNotificationPermissionPromptDatePod.notifier),
    ref.read(currentUserPod),
    ref.read(authServiceProvider),
  );
});

class MainScreenStateNotifier extends StateNotifier<MainScreenState> {
  final StateController<String?> lastNotificationPermissionPromptDate;
  final UserModel? currentUser;

  final AuthService authService;

  StreamSubscription? _tokenSub;

  MainScreenStateNotifier(
    this.lastNotificationPermissionPromptDate,
    this.currentUser,
    this.authService,
  ) : super(const MainScreenState()) {
    _showNotificationPermissionPromptIfRequired();
    _refreshFcmToken();
  }

  void _showNotificationPermissionPromptIfRequired() async {
    if (currentUser == null) return;
    await Future.delayed(const Duration(seconds: 4));
    final date = lastNotificationPermissionPromptDate.state;

    if (date == null ||
        DateTime.now().difference(DateTime.parse(date)).inDays >= 0) {
      state = state.copyWith(showNotificationPermissionPrompt: DateTime.now());
    }
  }

  void notificationPermissionPromptShown() {
    lastNotificationPermissionPromptDate.state = DateTime.now().toString();
  }

  void _refreshFcmToken() {
    _tokenSub?.cancel();
    _tokenSub = FirebaseMessaging.instance.onTokenRefresh.listen(
      (fcmToken) {
        authService.registerDevice(fcmToken);
      },
      onError: (error, stackTrace) {
        debugPrint(
            'MainScreenStateNotifier: Error refreshing FCM token $error');
      },
    );
  }

  @override
  void dispose() {
    _tokenSub?.cancel();
    super.dispose();
  }
}

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState({
    DateTime? showNotificationPermissionPrompt,
  }) = _MainScreenState;
}
