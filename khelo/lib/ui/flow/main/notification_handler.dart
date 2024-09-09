import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_route.dart';

const _androidChannel = AndroidNotificationChannel(
  "notification_khelo_channel",
  "Khelo Notification",
  importance: Importance.max,
);

final notificationHandlerProvider =
    Provider.autoDispose((ref) => NotificationHandler());

class NotificationHandler {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationHandler() {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);
  }

  Future<void> init(BuildContext context) async {
    _initFcm(context);
    if (context.mounted) await _initLocalNotifications(context);
  }

  void _initFcm(BuildContext context) {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null && context.mounted) {
        _onTapNotification(context, message.data);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (context.mounted) _onTapNotification(context, event.data);
    });
    if (Platform.isAndroid) {
      FirebaseMessaging.onMessage.listen((event) {
        showLocalNotification(event);
      });
    }
  }

  Future<void> _initLocalNotifications(BuildContext context) async {
    _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings('khelo_logo'),
          iOS: DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
          )),
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          _onTapNotification(context, jsonDecode(response.payload!));
        }
      },
    );
  }

  void showLocalNotification(RemoteMessage event) {
    final notification = event.notification;
    final data = event.data;
    final title = notification?.title;
    final body = notification?.body;

    if (title != null && body != null) {
      _flutterLocalNotificationsPlugin.show(
          DateTime.now().microsecondsSinceEpoch ~/ 1000000,
          title,
          body,
          NotificationDetails(
              android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
          )),
          payload: jsonEncode(data));
    }
  }
}

extension on NotificationHandler {
  void _onTapNotification(BuildContext context, Map<String, dynamic> data) {
    final String? type = data['type'];
    final String? teamId = data['team_id'];
    final String? matchId = data['matchId'];

    if (type?.isEmpty ?? true) return;

    final notificationType = NotificationType.values
        .firstWhereOrNull((element) => element.value == type);
    if (notificationType == null) return;

    switch (notificationType) {
      case NotificationType.addedPlayer:
        _openTeamDetail(context, teamId);
        break;
      case NotificationType.matchStart:
        _openMatchDetail(context, matchId);
        break;
    }
  }

  void _openTeamDetail(BuildContext context, String? teamId) {
    if (teamId != null) {
      AppRoute.teamDetail(teamId: teamId).push(context);
    }
  }

  void _openMatchDetail(BuildContext context, String? matchId) {
    if (matchId != null) {
      AppRoute.matchDetailTab(matchId: matchId).push(context);
    }
  }
}

enum NotificationType {
  addedPlayer('added_to_team'),
  matchStart('match_start');

  final String value;

  const NotificationType(this.value);
}
