import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ballScoreServiceProvider = Provider((ref) {
  final service = BallScoreService(
    FirebaseFirestore.instance,
    ref.read(currentUserPod)?.id,
  );

  ref.listen(currentUserPod, (_, next) => service._currentUserId = next?.id);
  return service;
});

class BallScoreService {
  final FirebaseFirestore _firestore;
  String? _currentUserId;

  final String _collectionName = 'ball_scores';

  BallScoreService(this._firestore, this._currentUserId);

  Future<String> updateBallScore(BallScoreModel score) async {
    DocumentReference scoreRef =
        _firestore.collection(_collectionName).doc(score.id);
    WriteBatch batch = _firestore.batch();

    batch.set(scoreRef, score.toJson(), SetOptions(merge: true));
    String newScoreId = scoreRef.id;

    if (score.id == null) {
      batch.update(scoreRef, {'id': newScoreId});
    }

    await batch.commit();
    return newScoreId;
  }

  Future<List<BallScoreModel>> getBallScoreListByInningId(
      String inningId) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection(_collectionName)
        .where('inning_id', isEqualTo: inningId)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return BallScoreModel.fromJson(data).copyWith(id: doc.id);
    }).toList();
  }

  Future<List<BallScoreModel>> getCurrentUserRelatedBalls() async {
    if (_currentUserId == null) {
      return [];
    }
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection(_collectionName)
        .where(Filter.or(
            Filter("bowler_id", isEqualTo: _currentUserId),
            Filter("batsman_id", isEqualTo: _currentUserId),
            Filter("wicket_taker_id", isEqualTo: _currentUserId),
            Filter("player_out_id", isEqualTo: _currentUserId)))
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return BallScoreModel.fromJson(data).copyWith(id: doc.id);
    }).toList();
  }

  Future<void> deleteBall(String ballId) async {
    await _firestore.collection(_collectionName).doc(ballId).delete();
  }
}
