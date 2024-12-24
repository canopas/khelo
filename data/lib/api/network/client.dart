import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../errors/app_error.dart';
import '../../service/auth/auth_service.dart';
import '../../utils/constant/firestore_constant.dart';

import 'package:http/http.dart' as http;

import 'endpoint.dart';
import 'interceptor/auth_client.dart';

final httpProvider = Provider((ref) {
  final client = http.Client();
  return AuthHttpClient(client, ref.read(firebaseAuthProvider));
});

final rawDioProvider = Provider((ref) {
  return Dio()
    ..options.connectTimeout = const Duration(seconds: 30)
    ..options.sendTimeout = const Duration(seconds: 30)
    ..options.receiveTimeout = const Duration(seconds: 30);
});

extension HttpExtensions on http.Client {
  Future<http.Response> req(Endpoint endpoint) async {
    final request = http.Request(
      endpoint.method.name,
      Uri.parse('${DataConfig.instance.apiBaseUrl}${endpoint.path}'),
    )..headers.addAll(endpoint.headers);

    if (endpoint.data != null) {
      request.headers['content-type'] = 'application/json';
      request.body = jsonEncode(endpoint.data);
    }

    http.Response response;

    try {
      response = await http.Response.fromStream(await send(request));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      }
    } catch (error) {
      if (error is SocketException) {
        throw const NoConnectionError();
      } else if (error is TimeoutException) {
        throw const NoConnectionError();
      } else {
        rethrow;
      }
    }

    throw SomethingWentWrongError(
      statusCode: response.statusCode.toString(),
      message: response.body,
    );
  }
}

extension HttpResponseExtensions on http.Response {
  Map<String, dynamic> get data {
    return body.isNotEmpty ? jsonDecode(utf8.decode(bodyBytes)) : {};
  }
}
