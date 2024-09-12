import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/user/user_models.dart';
import '../../storage/app_preferences.dart';
import '../device/device_service.dart';

final supportServiceProvider = Provider(
  (ref) => SupportService(
    ref.read(currentUserPod),
    ref.read(deviceServiceProvider),
  ),
);

class SupportService {
  final UserModel? _currentUser;
  final DeviceService _device;

  SupportService(this._currentUser, this._device);

  Future<void> submitSupportRequest(
    String title,
    String description,
    List<String> attachments,
  ) async {
    try {
      final data = {
        "title": title,
        "description": description,
        "device_name": await _device.deviceName,
        "app_version": await _device.appVersion,
        "device_os": Platform.operatingSystemVersion,
        "user_id": _currentUser?.id,
        "attachments": attachments,
      };
      final callable = FirebaseFunctions.instanceFor(region: 'asia-south1')
          .httpsCallable('sendSupportRequest');
      await callable.call(data);
    } catch (error) {
      debugPrint("error while sending support request ->$error");
    }
  }
}
