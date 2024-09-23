import 'package:flutter/material.dart';

enum HttpMethod { get, post, put, delete, patch }

@immutable
abstract class Endpoint {
  HttpMethod get method => HttpMethod.get;

  String get path;

  Map<String, String>? get queryParameters => null;

  Map<String, String> get headers => const {};

  dynamic get data => null;

  bool get needsAuth => true;

  String? get baseUrl => null;

  String? get contentType => null;
}
