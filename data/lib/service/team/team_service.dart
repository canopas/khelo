import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
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
  final CollectionReference<AddTeamRequestModel> _teamsCollection;

  TeamService(this._currentUserId, this.firestore, this._userService)
      : _teamsCollection = firestore
            .collection(FireStoreConst.teamsCollection)
            .withConverter(
                fromFirestore: AddTeamRequestModel.fromFireStore,
                toFirestore: (AddTeamRequestModel team, _) => team.toJson());

  Future<TeamModel> getTeamById(String teamId) async {
    try {
      final teamDoc = await _teamsCollection.doc(teamId).get();

      final teamRequestModel = teamDoc.data();

      if (teamRequestModel == null) {
        return deActiveDummyTeamModel(teamId);
      }

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

  Stream<TeamModel> getTeamStreamById(String teamId) {
    return _teamsCollection.doc(teamId).snapshots().asyncMap((teamDoc) async {
      final teamRequestModel = teamDoc.data();
      if (teamRequestModel == null) {
        return deActiveDummyTeamModel(teamId);
      }
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
    }).handleError((error, stack) => AppError.fromError(error, stack));
  }

  Stream<List<TeamModel>> getUserRelatedTeams() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }
    final filter = Filter.or(
      Filter(FireStoreConst.createdBy, isEqualTo: _currentUserId),
      Filter(FireStoreConst.players, arrayContains: _currentUserId),
    );
    return _teamsCollection
        .where(filter)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(snapshot.docs.map((mainDoc) async {
        AddTeamRequestModel teamRequestModel = mainDoc.data();

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
          players: member,
        );
        return team;
      }));
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<TeamModel>> getUserOwnedTeams() {
    return _teamsCollection
        .where(FireStoreConst.createdBy, isEqualTo: _currentUserId)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(snapshot.docs.map((mainDoc) async {
        AddTeamRequestModel teamRequestModel = mainDoc.data();

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
      }).toList());
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Future<String> updateTeam(AddTeamRequestModel team) async {
    try {
      final teamRef = _teamsCollection.doc(team.id);
      await teamRef.set(team.copyWith(id: teamRef.id), SetOptions(merge: true));
      return teamRef.id;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateProfileImageUrl(String teamId, String? imageUrl) async {
    try {
      final teamRef = _teamsCollection.doc(teamId);
      await teamRef.update({
        FireStoreConst.profileImageUrl: imageUrl,
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> addPlayersToTeam(String teamId, List<String> players) async {
    try {
      final teamRef = _teamsCollection.doc(teamId);
      await teamRef
          .update({FireStoreConst.players: FieldValue.arrayUnion(players)});
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> removePlayersFromTeam(
      String teamId, List<String> playerIds) async {
    try {
      final teamRef = _teamsCollection.doc(teamId);
      await teamRef
          .update({FireStoreConst.players: FieldValue.arrayRemove(playerIds)});
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<bool> isTeamNameAvailable(String teamName) async {
    try {
      QuerySnapshot teamSnap = await _teamsCollection
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
      final snapshot = await _teamsCollection
          .where(FireStoreConst.nameLowercase,
              isGreaterThanOrEqualTo: searchKey.caseAndSpaceInsensitive)
          .where(FireStoreConst.nameLowercase,
              isLessThan: '${searchKey.caseAndSpaceInsensitive}z')
          .get();

      List<TeamModel> teams = [];

      for (final mainDoc in snapshot.docs) {
        AddTeamRequestModel teamRequestModel = mainDoc.data();

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
      await _teamsCollection.doc(teamId).delete();
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
