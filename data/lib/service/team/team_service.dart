import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/extensions/string_extensions.dart';
import 'package:data/service/user/user_service.dart';
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
  final FirebaseFirestore _firestore;
  final UserService _userService;
  final String _collectionName = 'teams';

  TeamService(this._currentUserId, this._firestore, this._userService);

  Future<String> updateTeam(AddTeamRequestModel team) async {
    try {
      DocumentReference teamRef =
          _firestore.collection(_collectionName).doc(team.id);
      WriteBatch batch = _firestore.batch();

      batch.set(teamRef, team.toJson(), SetOptions(merge: true));
      String newTeamId = teamRef.id;

      if (team.id == null) {
        batch.update(teamRef, {'id': newTeamId});
      }
      await batch.commit();
      return newTeamId;
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  Future<TeamModel> getTeamById(String teamId) async {
    try {
      CollectionReference teamsCollection =
          _firestore.collection(_collectionName);

      DocumentSnapshot teamDoc = await teamsCollection.doc(teamId).get();

      AddTeamRequestModel teamRequestModel =
          AddTeamRequestModel.fromJson(teamDoc.data() as Map<String, dynamic>);

      final member = (teamRequestModel.players?.isNotEmpty ?? false)
          ? await getMemberListFromUserIds(teamRequestModel.players ?? [])
          : null;

      final team = TeamModel(
          name: teamRequestModel.name,
          name_lowercase: teamRequestModel.name_lowercase,
          id: teamRequestModel.id,
          city: teamRequestModel.city,
          created_at: teamRequestModel.created_at,
          created_by: teamRequestModel.created_by,
          profile_img_url: teamRequestModel.profile_img_url,
          players: member);

      return team;
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  Future<List<TeamModel>> getUserRelatedTeams({
    TeamFilterOption option = TeamFilterOption.all,
  }) async {
    try {
      QuerySnapshot mainCollectionSnapshot;

      switch (option) {
        case TeamFilterOption.all:
          mainCollectionSnapshot = await _firestore
              .collection(_collectionName)
              .where(
                Filter.or(
                  Filter('created_by', isEqualTo: _currentUserId),
                  Filter('players', arrayContains: _currentUserId),
                ),
              )
              .get();
        case TeamFilterOption.createdByMe:
          mainCollectionSnapshot = await _firestore
              .collection(_collectionName)
              .where('created_by', isEqualTo: _currentUserId)
              .get();
        case TeamFilterOption.memberMe:
          mainCollectionSnapshot = await _firestore
              .collection(_collectionName)
              .where('players', arrayContains: _currentUserId)
              .get();
      }

      List<TeamModel> teams = [];

      for (QueryDocumentSnapshot mainDoc in mainCollectionSnapshot.docs) {
        AddTeamRequestModel teamRequestModel = AddTeamRequestModel.fromJson(
            mainDoc.data() as Map<String, dynamic>);

        final member = (teamRequestModel.players?.isNotEmpty ?? false)
            ? await getMemberListFromUserIds(teamRequestModel.players ?? [])
            : null;

        final team = TeamModel(
            name: teamRequestModel.name,
            name_lowercase: teamRequestModel.name_lowercase,
            id: teamRequestModel.id,
            city: teamRequestModel.city,
            created_at: teamRequestModel.created_at,
            created_by: teamRequestModel.created_by,
            profile_img_url: teamRequestModel.profile_img_url,
            players: member);

        teams.add(team);
      }

      return teams;
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  Future<List<TeamModel>> getUserOwnedTeams() async {
    try {
      QuerySnapshot mainCollectionSnapshot = await _firestore
          .collection(_collectionName)
          .where('created_by', isEqualTo: _currentUserId)
          .get();

      List<TeamModel> teams = [];

      for (QueryDocumentSnapshot mainDoc in mainCollectionSnapshot.docs) {
        AddTeamRequestModel teamRequestModel = AddTeamRequestModel.fromJson(
            mainDoc.data() as Map<String, dynamic>);

        final member = (teamRequestModel.players?.isNotEmpty ?? false)
            ? await getMemberListFromUserIds(teamRequestModel.players ?? [])
            : null;

        final team = TeamModel(
            name: teamRequestModel.name,
            name_lowercase: teamRequestModel.name_lowercase,
            id: teamRequestModel.id,
            city: teamRequestModel.city,
            created_at: teamRequestModel.created_at,
            created_by: teamRequestModel.created_by,
            profile_img_url: teamRequestModel.profile_img_url,
            players: member);

        teams.add(team);
      }

      return teams;
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  Future<void> deleteTeam(String teamId) async {
    try {
      await _firestore.collection(_collectionName).doc(teamId).delete();
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  Future<void> addPlayersToTeam(String teamId, List<String> players) async {
    try {
      DocumentReference teamRef =
          _firestore.collection(_collectionName).doc(teamId);

      await teamRef.set(
          {'players': FieldValue.arrayUnion(players)}, SetOptions(merge: true));
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  Future<void> removePlayersFromTeam(
      String teamId, List<String> playerIds) async {
    try {
      DocumentReference teamRef =
          _firestore.collection(_collectionName).doc(teamId);

      await teamRef.update({'players': FieldValue.arrayRemove(playerIds)});
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  Future<bool> isTeamNameAvailable(String teamName) async {
    try {
      QuerySnapshot teamSnap = await _firestore
          .collection(_collectionName)
          .where('name_lowercase', isEqualTo: teamName.caseAndSpaceInsensitive)
          .get();

      return teamSnap.docs.isEmpty;
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  Future<List<TeamModel>> searchTeam(String searchKey) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection(_collectionName)
          .where('name_lowercase',
              isGreaterThanOrEqualTo: searchKey.caseAndSpaceInsensitive)
          .where('name_lowercase',
              isLessThan: '${searchKey.caseAndSpaceInsensitive}z')
          .get();

      List<TeamModel> teams = [];

      for (QueryDocumentSnapshot mainDoc in snapshot.docs) {
        AddTeamRequestModel teamRequestModel = AddTeamRequestModel.fromJson(
            mainDoc.data() as Map<String, dynamic>);

        final member = (teamRequestModel.players?.isNotEmpty ?? false)
            ? await getMemberListFromUserIds(teamRequestModel.players ?? [])
            : null;

        final team = TeamModel(
            name: teamRequestModel.name,
            name_lowercase: teamRequestModel.name_lowercase,
            id: teamRequestModel.id,
            city: teamRequestModel.city,
            created_at: teamRequestModel.created_at,
            created_by: teamRequestModel.created_by,
            profile_img_url: teamRequestModel.profile_img_url,
            players: member);

        teams.add(team);
      }

      return teams;
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  // Helper Method
  Future<List<UserModel>> getMemberListFromUserIds(List<String> users) async {
    try {
      final userList = await _userService.getUsersByIds(users);
      return userList;
    } catch (error) {
      throw AppError.fromError(error);
    }
  }
}

enum TeamFilterOption {
  all,
  createdByMe,
  memberMe;
}
