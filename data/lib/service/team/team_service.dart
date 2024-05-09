import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/extensions/string_extensions.dart';
import 'package:data/service/user/user_service.dart';
import 'package:data/utils/constant/firestore_constant.dart';
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

  TeamService(this._currentUserId, this._firestore, this._userService);

  Future<String> updateTeam(AddTeamRequestModel team) async {
    try {
      DocumentReference teamRef =
          _firestore.collection(FireStoreConst.teamsCollection).doc(team.id);
      WriteBatch batch = _firestore.batch();

      batch.set(teamRef, team.toJson(), SetOptions(merge: true));
      String newTeamId = teamRef.id;

      if (team.id == null) {
        batch.update(teamRef, {FireStoreConst.id: newTeamId});
      }
      await batch.commit();
      return newTeamId;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<TeamModel> getTeamById(String teamId) async {
    try {
      CollectionReference teamsCollection =
          _firestore.collection(FireStoreConst.teamsCollection);

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
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
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
              .collection(FireStoreConst.teamsCollection)
              .where(
                Filter.or(
                  Filter(FireStoreConst.createdBy, isEqualTo: _currentUserId),
                  Filter(FireStoreConst.players, arrayContains: _currentUserId),
                ),
              )
              .get();
        case TeamFilterOption.createdByMe:
          mainCollectionSnapshot = await _firestore
              .collection(FireStoreConst.teamsCollection)
              .where(FireStoreConst.createdBy, isEqualTo: _currentUserId)
              .get();
        case TeamFilterOption.memberMe:
          mainCollectionSnapshot = await _firestore
              .collection(FireStoreConst.teamsCollection)
              .where(FireStoreConst.players, arrayContains: _currentUserId)
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
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<TeamModel>> getUserOwnedTeams() async {
    try {
      QuerySnapshot mainCollectionSnapshot = await _firestore
          .collection(FireStoreConst.teamsCollection)
          .where(FireStoreConst.createdBy, isEqualTo: _currentUserId)
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
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> deleteTeam(String teamId) async {
    try {
      await _firestore.collection(FireStoreConst.teamsCollection).doc(teamId).delete();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> addPlayersToTeam(String teamId, List<String> players) async {
    try {
      DocumentReference teamRef =
          _firestore.collection(FireStoreConst.teamsCollection).doc(teamId);

      await teamRef.set(
          {FireStoreConst.players: FieldValue.arrayUnion(players)}, SetOptions(merge: true));
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> removePlayersFromTeam(
      String teamId, List<String> playerIds) async {
    try {
      DocumentReference teamRef =
          _firestore.collection(FireStoreConst.teamsCollection).doc(teamId);

      await teamRef.update({FireStoreConst.players: FieldValue.arrayRemove(playerIds)});
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<bool> isTeamNameAvailable(String teamName) async {
    try {
      QuerySnapshot teamSnap = await _firestore
          .collection(FireStoreConst.teamsCollection)
          .where(FireStoreConst.nameLowercase, isEqualTo: teamName.caseAndSpaceInsensitive)
          .get();

      return teamSnap.docs.isEmpty;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<TeamModel>> searchTeam(String searchKey) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection(FireStoreConst.teamsCollection)
          .where(FireStoreConst.nameLowercase,
              isGreaterThanOrEqualTo: searchKey.caseAndSpaceInsensitive)
          .where(FireStoreConst.nameLowercase,
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
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  // Helper Method
  Future<List<UserModel>> getMemberListFromUserIds(List<String> users) async {
    try {
      final userList = await _userService.getUsersByIds(users);
      return userList;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}

enum TeamFilterOption {
  all,
  createdByMe,
  memberMe;
}
