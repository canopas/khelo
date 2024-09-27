import '../../api/network/endpoint.dart';

class CreateUserEndpoint extends Endpoint {
  final String phone;
  final String name;

  CreateUserEndpoint({
    required this.phone,
    required this.name,
  });

  @override
  String get path => 'user/create';

  @override
  HttpMethod get method => HttpMethod.post;

  @override
  dynamic get data => {"phone": phone, "name": name};
}
