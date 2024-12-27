import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../api/live_stream/live_stream_model.dart';
import '../../api/network/client.dart';
import '../../errors/app_error.dart';
import '../../utils/constant/firestore_constant.dart';
import 'live_stream_endpoint.dart';

final liveStreamServiceProvider = Provider(
  (ref) => LiveStreamService(
    FirebaseFirestore.instance,
    ref.read(httpProvider),
  ),
);

class LiveStreamService {
  final FirebaseFirestore _firestore;
  final http.Client client;

  LiveStreamService(
    this._firestore,
    this.client,
  );

  CollectionReference<LiveStreamModel> _liveStreamCollection() =>
      _firestore.collection(FireStoreConst.liveStreamsCollection).withConverter(
            fromFirestore: LiveStreamModel.fromFireStore,
            toFirestore: (LiveStreamModel liveStream, _) => liveStream.toJson(),
          );

  String get generateStreamId => _liveStreamCollection().doc().id;

  Future<LiveStreamModel> createLiveStream(
    CreateLiveStreamEndPoint streamInfo,
  ) async {
    try {
      final response = await client.req(streamInfo);
      return LiveStreamModel.fromJson(response.data);
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<LiveStreamModel?> getLiveStreamByMatchId(String matchId) async {
    try {
      final stream = await _liveStreamCollection()
          .where(FireStoreConst.matchId, isEqualTo: matchId)
          .limit(1)
          .get();

      return stream.docs.firstOrNull?.data();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
