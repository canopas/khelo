import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/extensions/string_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../storage/app_preferences.dart';

final teamServiceProvider = Provider((ref) {
  final service =
      TeamService(ref.read(currentUserPod)?.id, FirebaseFirestore.instance);

  ref.listen(currentUserPod, (_, next) => service._currentUserId = next?.id);
  return service;
});

class TeamService {
  String? _currentUserId;
  final FirebaseFirestore _firestore;
  final String _collectionName = 'teams';
  final String _subCollectionName = 'players';

  TeamService(this._currentUserId, this._firestore);

  Future<String> updateTeam(TeamModel team, List<UserModel> players) async {
    DocumentReference teamRef =
        _firestore.collection(_collectionName).doc(team.id);
    WriteBatch batch = _firestore.batch();

    batch.set(teamRef, team.toJson(), SetOptions(merge: true));
    String newTeamId = teamRef.id;

    for (var player in players) {
      DocumentReference playerRef =
          teamRef.collection(_subCollectionName).doc(player.id);
      batch.set(playerRef, player.toJson(), SetOptions(merge: true));
    }

    if (team.id == null) {
      batch.update(teamRef, {'id': newTeamId});
    }
    await batch.commit();
    return newTeamId;
  }

  Future<TeamModel> getTeamById(String teamId) async {
    CollectionReference teamsCollection =
        _firestore.collection(_collectionName);

    DocumentSnapshot teamDoc = await teamsCollection.doc(teamId).get();

    TeamModel team = TeamModel.fromJson(teamDoc.data() as Map<String, dynamic>);

    CollectionReference playersCollection =
        teamDoc.reference.collection(_subCollectionName);
    QuerySnapshot playersSnapshot = await playersCollection.get();

    final players = playersSnapshot.docs.map((playerDoc) {
      return UserModel.fromJson(playerDoc.data() as Map<String, dynamic>);
    }).toList();

    return team.copyWith(players: players);
  }

  Future<List<TeamModel>> getTeams() async {
    CollectionReference teamsCollection =
        _firestore.collection(_collectionName);

    QuerySnapshot mainCollectionSnapshot = await teamsCollection.get();

    List<TeamModel> teams = [];

    for (QueryDocumentSnapshot mainDoc in mainCollectionSnapshot.docs) {
      TeamModel team =
          TeamModel.fromJson(mainDoc.data() as Map<String, dynamic>);

      if (team.created_by == _currentUserId) {
        CollectionReference playersCollection =
            mainDoc.reference.collection(_subCollectionName);

        QuerySnapshot playersSnapshot = await playersCollection.get();

        final players = playersSnapshot.docs.map((playerDoc) {
          return UserModel.fromJson(playerDoc.data() as Map<String, dynamic>);
        }).toList();

        team = team.copyWith(players: players);
        teams.add(team);
      } else {
        CollectionReference playersCollection =
            mainDoc.reference.collection(_subCollectionName);
        QuerySnapshot playersSnapshot = await playersCollection
            .where('id', isEqualTo: _currentUserId)
            .get();

        if (playersSnapshot.docs.isNotEmpty) {
          final players = playersSnapshot.docs.map((playerDoc) {
            return UserModel.fromJson(playerDoc.data() as Map<String, dynamic>);
          }).toList();

          team = team.copyWith(players: players);
          teams.add(team);
        }
      }
    }

    return teams;
  }

  Future<void> deleteTeam(String teamId) async {
    await _firestore.runTransaction((transaction) async {
      CollectionReference teamCollection =
          _firestore.collection(_collectionName);
      DocumentReference teamDocRef = teamCollection.doc(teamId);

      CollectionReference subCollection =
          teamDocRef.collection(_subCollectionName);
      QuerySnapshot subCollectionSnapshot = await subCollection.get();
      for (QueryDocumentSnapshot docSnapshot in subCollectionSnapshot.docs) {
        transaction.delete(docSnapshot.reference);
      }

      transaction.delete(teamDocRef);
    });
  }

  Future<void> addPlayersToTeam(String teamId, List<UserModel> players) async {
    DocumentReference teamRef =
        _firestore.collection(_collectionName).doc(teamId);

    WriteBatch batch = _firestore.batch();

    for (var player in players) {
      DocumentReference playerRef =
          teamRef.collection(_subCollectionName).doc(player.id);
      batch.set(playerRef, player.toJson(), SetOptions(merge: true));
    }

    await batch.commit();
  }

  Future<void> removePlayersFromTeam(
      String teamId, List<String> playerIds) async {
    CollectionReference playersCollection = _firestore
        .collection(_collectionName)
        .doc(teamId)
        .collection(_subCollectionName);

    for (String playerId in playerIds) {
      playersCollection.doc(playerId).delete();
    }
  }

  Future<bool> isTeamNameAvailable(String teamName) async {
    QuerySnapshot teamSnap = await _firestore
        .collection(_collectionName)
        .where('name_lowercase', isEqualTo: teamName.caseAndSpaceInsensitive)
        .get();

    return teamSnap.docs.isEmpty;
  }

  Future<List<TeamModel>> searchTeam(String searchKey) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection(_collectionName)
        .where('name_lowercase',
            isGreaterThanOrEqualTo: searchKey.caseAndSpaceInsensitive)
        .where('name_lowercase',
            isLessThan: '${searchKey.caseAndSpaceInsensitive}z')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return TeamModel.fromJson(data).copyWith(id: doc.id);
    }).toList();
  }
}
