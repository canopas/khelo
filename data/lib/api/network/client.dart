import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rawDioProvider = Provider((ref) {
  return Dio()
    ..options.connectTimeout = const Duration(seconds: 30)
    ..options.sendTimeout = const Duration(seconds: 30)
    ..options.receiveTimeout = const Duration(seconds: 30);
});
