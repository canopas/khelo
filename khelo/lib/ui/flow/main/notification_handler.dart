import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      _onTapNotification(context, event.data);
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
  void _onTapNotification(BuildContext context, Map<String, dynamic> data) {}
}
