import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/extensions/string_extensions.dart';
import 'package:data/service/user/user_service.dart';
import 'package:data/utils/constant/firestore_constant.dart';
import 'package:data/utils/dummy_deactivated_account.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../storage/app_preferences.dart';

final teamServiceProvider = Provider((ref) {
  final service = TeamService(
    ref.read(currentUserPod)?.id,
    FirebaseFirestore.instance,
    ref.read(userServiceProvider),
  );

  ref.listen(currentUserPod, (_, next) => service._currentUserId = next?.id);
  return service;
});

class TeamService {
  String? _currentUserId;

  final FirebaseFirestore firestore;
  final UserService _userService;

  TeamService(this._currentUserId, this.firestore, this._userService);

  CollectionReference<TeamModel> get _teamCollection =>
      firestore.collection(FireStoreConst.teamsCollection).withConverter(
          fromFirestore: TeamModel.fromFireStore,
          toFirestore: (TeamModel team, _) => team.toJson());

  CollectionReference<TeamPlayer> _playersCollection(String teamId) =>
      _teamCollection
          .doc(teamId)
          .collection(FireStoreConst.playersCollection)
          .withConverter<TeamPlayer>(
              fromFirestore: TeamPlayer.fromFireStore,
              toFirestore: (value, options) => value.toJson());

  Future<TeamModel> getTeamById(String teamId) async {
    try {
      final team = await _teamCollection.doc(teamId).get();
      final players = await getTeamPlayers(teamId);
      return team.data()?.copyWith(players: players) ??
          deActiveDummyTeamModel(teamId);
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<TeamModel> streamTeam(String teamId) {
    return _teamCollection.doc(teamId).snapshots().asyncMap((event) async {
      final players = await getTeamPlayers(teamId);
      return event.data()?.copyWith(players: players) ??
          deActiveDummyTeamModel(teamId);
    }).handleError((error, stack) => AppError.fromError(error, stack));
  }

  Future<List<TeamPlayer>> getTeamPlayers(String teamId) async {
    final data = await _playersCollection(teamId).get();

    final futures = data.docs.map((player) async {
      final detail = await _userService.getUserById(player.id);
      return player.data().copyWith(detail: detail);
    }).toList();

    return Future.wait(futures);
  }

  Stream<List<TeamModel>> streamUserRelatedTeams() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }

    return _teamCollection.snapshots().asyncMap((snapshot) async {
      final futures = snapshot.docs.map((doc) async {
        final teamId = doc.id;
        final playersSnapshot = await _playersCollection(teamId)
            .where('id', isEqualTo: _currentUserId)
            .get();
        final players = playersSnapshot.docs.map((e) => e.data()).toList();
        return (players.isNotEmpty)
            ? doc.data().copyWith(players: players)
            : null;
      }).toList();

      final results = await Future.wait(futures);
      return results.whereType<TeamModel>().toList();
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<TeamModel>> getUserOwnedTeams() {
    return _teamCollection
        .where(FireStoreConst.createdBy, isEqualTo: _currentUserId)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList())
        .handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Future<String> updateTeam(TeamModel team) async {
    try {
      final teamRef = _teamCollection.doc(team.id);
      await teamRef.set(team.copyWith(id: teamRef.id), SetOptions(merge: true));
      return teamRef.id;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateProfileImageUrl(String teamId, String? imageUrl) async {
    try {
      final teamRef = _teamCollection.doc(teamId);
      await teamRef.update({
        FireStoreConst.profileImageUrl: imageUrl,
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> addPlayersToTeam(String teamId, List<TeamPlayer> players) async {
    try {
      WriteBatch batch = firestore.batch();
      for (final player in players) {
        batch.set(_playersCollection(teamId).doc(player.id), player,
            SetOptions(merge: true));
      }
      await batch.commit();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> removePlayersFromTeam(
      String teamId, List<String> playerIds) async {
    try {
      WriteBatch batch = firestore.batch();
      final playerRef = _playersCollection(teamId);
      for (final id in playerIds) {
        batch.delete(playerRef.doc(id));
      }
      batch.commit();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<bool> isTeamNameAvailable(String teamName) async {
    try {
      QuerySnapshot teamSnap = await _teamCollection
          .where(FireStoreConst.nameLowercase,
              isEqualTo: teamName.caseAndSpaceInsensitive)
          .get();

      return teamSnap.docs.isEmpty;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<TeamModel>> searchTeam(String searchKey) async {
    try {
      final snapshot = await _teamCollection
          .where(FireStoreConst.nameLowercase,
              isGreaterThanOrEqualTo: searchKey.caseAndSpaceInsensitive)
          .where(FireStoreConst.nameLowercase,
              isLessThan: '${searchKey.caseAndSpaceInsensitive}z')
          .get();

      return snapshot.docs.map((e) => e.data()).toList();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> deleteTeam(String teamId) async {
    try {
      await _teamCollection.doc(teamId).delete();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
