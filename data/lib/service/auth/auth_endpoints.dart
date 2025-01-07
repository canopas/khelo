import '../../api/network/endpoint.dart';

class UpdateGoogleRefreshTokenEndPoint extends Endpoint {
  final String authCode;

  UpdateGoogleRefreshTokenEndPoint({required this.authCode});

  @override
  String get path => 'auth/storeGoogleRefreshToken';

  @override
  HttpMethod get method => HttpMethod.post;

  @override
  dynamic get data => {
        "authCode": authCode,
      };
}
