import 'dart:io';

import 'package:data/api/network/client.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';

final deviceServiceProvider = Provider(
  (ref) => DeviceService(
    rawDio: ref.read(rawDioProvider),
  ),
);

class DeviceService {
  final Dio rawDio;

  DeviceService({required this.rawDio});

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

  Future<String> get timezone {
    return FlutterTimezone.getLocalTimezone();
  }

  Future<String> get countryCode async {
    final response = await rawDio.get('http://ip-api.com/json/');
    return response.data['countryCode'];
  }
}
