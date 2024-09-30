import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/tournament/tournament_model.dart';
import '../../errors/app_error.dart';
import '../../utils/constant/firestore_constant.dart';

final tournamentServiceProvider = Provider(
  (ref) => TournamentService(FirebaseFirestore.instance),
);

class TournamentService {
  final FirebaseFirestore _firestore;

  TournamentService(this._firestore);

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
}
