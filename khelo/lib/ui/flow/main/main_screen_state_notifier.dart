import 'dart:async';

import 'package:data/api/user/user_models.dart';
import 'package:data/service/auth/auth_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:data/storage/provider/preferences_provider.dart';
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
  final PreferenceNotifier<String?> _lastNotificationPermissionPromptDate;
  final UserModel? _currentUser;

  final AuthService _authService;

  StreamSubscription? _tokenSub;

  MainScreenStateNotifier(
    this._lastNotificationPermissionPromptDate,
    this._currentUser,
    this._authService,
  ) : super(const MainScreenState()) {
    _showNotificationPermissionPromptIfRequired();
    _refreshFcmToken();
  }

  void _showNotificationPermissionPromptIfRequired() async {
    if (_currentUser == null) return;
    await Future.delayed(const Duration(seconds: 4));
    final date = _lastNotificationPermissionPromptDate.state;

    if (date == null ||
        DateTime.now().difference(DateTime.parse(date)).inDays >= 21) {
      state = state.copyWith(showNotificationPermissionPrompt: DateTime.now());
    }
  }

  void notificationPermissionPromptShown() {
    _lastNotificationPermissionPromptDate.state = DateTime.now().toString();
  }

  void _refreshFcmToken() {
    _tokenSub?.cancel();
    _tokenSub = FirebaseMessaging.instance.onTokenRefresh.listen(
      _authService.registerDevice,
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
