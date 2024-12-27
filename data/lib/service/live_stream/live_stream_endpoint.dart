import '../../api/network/endpoint.dart';

class CreateLiveStreamEndPoint extends Endpoint {
  final String matchId;
  final String name;
  final String description;

  CreateLiveStreamEndPoint({
    required this.matchId,
    required this.name,
    required this.description,
  });

  @override
  String get path => 'liveStream/createYouTubeStream';

  @override
  HttpMethod get method => HttpMethod.post;

  @override
  dynamic get data => {
    "matchId": matchId,
    "name": name,
    "description": description,
  };
}
