import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AuthHttpClient extends http.BaseClient {
  final http.Client inner;
  final FirebaseAuth firebaseAuth;

  AuthHttpClient(this.inner, this.firebaseAuth);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final user = firebaseAuth.currentUser;

    if (user != null) {
      final idToken = await user.getIdToken();
      request.headers['Authorization'] = 'Bearer $idToken';
    }

    return inner.send(request);
  }
}
