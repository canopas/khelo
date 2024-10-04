import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/tournament/tournament_model.dart';
import '../../errors/app_error.dart';
import '../../storage/app_preferences.dart';
import '../../utils/constant/firestore_constant.dart';

final tournamentServiceProvider = Provider((ref) {
  final service = TournamentService(
    FirebaseFirestore.instance,
    ref.read(currentUserPod)?.id,
  );
  ref.listen(currentUserPod, (_, next) => service._currentUserId = next?.id);
  return service;
});

class TournamentService {
  String? _currentUserId;
  final FirebaseFirestore _firestore;

  TournamentService(this._firestore, this._currentUserId);

  CollectionReference<TournamentModel> get _tournamentCollection =>
      _firestore.collection(FireStoreConst.tournamentCollection).withConverter(
            fromFirestore: TournamentModel.fromFireStore,
            toFirestore: (TournamentModel tournament, _) => tournament.toJson(),
          );

  String get generateTournamentId => _tournamentCollection.doc().id;

  Future<void> createTournament(TournamentModel tournament) async {
    try {
      await _tournamentCollection
          .doc(tournament.id)
          .set(tournament, SetOptions(merge: true));
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<List<TournamentModel>> streamCurrentUserRelatedMatches() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }
    final currantMember = TournamentMember(id: _currentUserId ?? 'INVALID ID');

    final memberContains = [
      currantMember.copyWith(role: TournamentMemberRole.organizer).toJson(),
      currantMember.copyWith(role: TournamentMemberRole.admin).toJson(),
    ];
    final filter = Filter.or(
      Filter(FireStoreConst.createdBy, isEqualTo: _currentUserId),
      Filter(FireStoreConst.members, arrayContainsAny: memberContains),
    );

    return _tournamentCollection
        .where(filter)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(
        snapshot.docs.map((mainDoc) async {
          return mainDoc.data();
        }).toList(),
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }
}
