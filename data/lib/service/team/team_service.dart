import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../storage/app_preferences.dart';

final teamServiceProvider = Provider((ref) {
  final service = TeamService(FirebaseFirestore.instance);
  ref.listen(currentUserPod, (_, next) => service.currentUserId = next?.id);
  return service;
});

class TeamService {
  String? currentUserId;
  final FirebaseFirestore _firestore;
  final String collectionName = 'teams';
  final String subCollectionName = 'players';

  TeamService(this._firestore);

  Future<TeamModel> getTeamById(String teamId) async {
    CollectionReference teamsCollection = _firestore.collection(collectionName);

    DocumentSnapshot teamDoc = await teamsCollection.doc(teamId).get();

    TeamModel team = TeamModel.fromJson(teamDoc.data() as Map<String, dynamic>);

    CollectionReference playersCollection =
        teamDoc.reference.collection(subCollectionName);
    QuerySnapshot playersSnapshot = await playersCollection.get();

    final players = playersSnapshot.docs.map((playerDoc) {
      return UserModel.fromJson(playerDoc.data() as Map<String, dynamic>);
    }).toList();

    return team.copyWith(players: players);
  }

  // get Team with Players
  Future<List<TeamModel>> getTeamsWithPlayers() async {
    CollectionReference teamsCollection = _firestore.collection(collectionName);

    QuerySnapshot mainCollectionSnapshot = await teamsCollection.get();

    List<TeamModel> teams = [];

    for (QueryDocumentSnapshot mainDoc in mainCollectionSnapshot.docs) {
      TeamModel team =
          TeamModel.fromJson(mainDoc.data() as Map<String, dynamic>);

      CollectionReference playersCollection =
          mainDoc.reference.collection(subCollectionName);

      QuerySnapshot playersSnapshot = await playersCollection.get();

      final players = playersSnapshot.docs.map((playerDoc) {
        return UserModel.fromJson(playerDoc.data() as Map<String, dynamic>);
      }).toList();

      team = team.copyWith(players: players);
      teams.add(team);
    }

    return teams;
  }

  // update team
  Future<void> updateTeam(TeamModel team, List<UserModel> players) async {
    DocumentReference teamRef =
        _firestore.collection(collectionName).doc(team.id);

    WriteBatch batch = _firestore.batch();

    batch.set(teamRef, team.toJson(), SetOptions(merge: true));

    for (var player in players) {
      DocumentReference playerRef =
          teamRef.collection(subCollectionName).doc(player.id);
      batch.set(playerRef, player.toJson(), SetOptions(merge: true));
    }

    await batch.commit();
  }

  // delete team
  Future<void> deleteTeam(String teamId) async {
    await _firestore.collection(collectionName).doc(teamId).delete();
  }

  Future<void> deleteTeamWithCollection(String teamId) async {
    await _firestore.runTransaction((transaction) async {
      CollectionReference teamCollection =
          _firestore.collection(collectionName);
      DocumentReference teamDocRef = teamCollection.doc(teamId);

      // Delete sub-collection
      CollectionReference subCollection =
          teamDocRef.collection(subCollectionName);
      QuerySnapshot subCollectionSnapshot = await subCollection.get();
      for (QueryDocumentSnapshot docSnapshot in subCollectionSnapshot.docs) {
        transaction.delete(docSnapshot.reference);
      }

      // Delete team document
      transaction.delete(teamDocRef);
    });
  }

// add players plural
  Future<void> addPlayersToTeam(String teamId, List<UserModel> players) async {
    DocumentReference teamRef =
        _firestore.collection(collectionName).doc(teamId);

    WriteBatch batch = _firestore.batch();

    for (var player in players) {
      DocumentReference playerRef =
          teamRef.collection(subCollectionName).doc(player.id);
      batch.set(playerRef, player.toJson(), SetOptions(merge: true));
    }

    await batch.commit();
  }

// remove players plural
  Future<void> removePlayersFromTeam(
      String teamId, List<String> playerIds) async {
    CollectionReference playersCollection = _firestore
        .collection(collectionName)
        .doc(teamId)
        .collection(subCollectionName);

    for (String playerId in playerIds) {
      playersCollection.doc(playerId).delete();
    }
  }

// add player singular
  Future<void> addPlayerToTeam(String teamId, UserModel player) async {
    CollectionReference playersCollection = _firestore
        .collection(collectionName)
        .doc(teamId)
        .collection(subCollectionName);

    await playersCollection.add(player.toJson());
  }

// update player singular
  Future<void> updatePlayerInTeam(
      String teamId, String playerId, UserModel updatedPlayer) async {
    CollectionReference playersCollection = _firestore
        .collection(collectionName)
        .doc(teamId)
        .collection(subCollectionName);

    await playersCollection.doc(playerId).update(updatedPlayer.toJson());
  }

// delete player singular
  Future<void> deletePlayerFromTeam(String teamId, String playerId) async {
    CollectionReference playersCollection = _firestore
        .collection(collectionName)
        .doc(teamId)
        .collection(subCollectionName);

    await playersCollection.doc(playerId).delete();
  }

// is Team name available
  Future<bool> isTeamNameAvailable(String teamName) async {
    QuerySnapshot teamSnap = await _firestore
        .collection(collectionName)
        .where('name_lowercase', isEqualTo: teamName.toLowerCase())
        .get();

    return teamSnap.docs.isEmpty;
  }
}
