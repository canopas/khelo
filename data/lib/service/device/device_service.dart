import 'dart:io';

import '../../api/network/client.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';

final deviceServiceProvider = Provider(
  (ref) => DeviceService(
    rawDio: ref.read(rawDioProvider),
    deviceId: ref.read(deviceIdPod),
  ),
);

class DeviceService {
  final Dio rawDio;
  final String deviceId;

  DeviceService({
    required this.rawDio,
    required this.deviceId,
  });

  Future<int> get appVersion async {
    final packageInfo = await PackageInfo.fromPlatform();
    return int.tryParse(packageInfo.buildNumber) ?? 0;
  }

  Future<String> get version async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<String> get packageName async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  Future<String> get deviceName async {
    final deviceInfo = await DeviceInfoPlugin().deviceInfo;
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      deviceInfo.version.sdkInt;
      return deviceInfo.data['product'];
    } else {
      return deviceInfo.data['name'];
    }
  }

  Future<String> get osVersion async {
    if (kIsWeb) {
      final deviceInfo = await DeviceInfoPlugin().webBrowserInfo;
      return deviceInfo.userAgent ??
          deviceInfo.productSub ??
          deviceInfo.browserName.name;
    } else if (!kIsWeb && Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      return deviceInfo.version.release;
    } else if (!kIsWeb && Platform.isIOS) {
      final deviceInfo = await DeviceInfoPlugin().iosInfo;
      return deviceInfo.systemVersion;
    } else {
      final deviceInfo = await DeviceInfoPlugin().deviceInfo;
      return deviceInfo.data['version'] ?? 'Unknown';
    }
  }

  Future<String> get timezone {
    return FlutterTimezone.getLocalTimezone();
  }

  Future<String> get countryCode async {
    final response = await rawDio.get('http://ip-api.com/json/');
    return response.data['countryCode'];
  }
}
