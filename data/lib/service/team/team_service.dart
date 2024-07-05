import 'dart:async';
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

  Stream<TeamModel> getTeamStreamById(String teamId) {
    StreamController<TeamModel> controller = StreamController<TeamModel>();
    StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? subscription;
    removeResources() {
      controller.close();
      subscription?.cancel();
    }

    catchError(Object error, StackTrace stack) {
      controller.addError(AppError.fromError(error, stack));
      removeResources();
    }

    subscription = _firestore
        .collection(FireStoreConst.teamsCollection)
        .doc(teamId)
        .snapshots()
        .listen((teamDoc) async {
      if (teamDoc.exists) {
        try {
          AddTeamRequestModel teamRequestModel = AddTeamRequestModel.fromJson(
              teamDoc.data() as Map<String, dynamic>);

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

          controller.add(team);
        } catch (e, stack) {
          catchError(e, stack);
        }
      } else {
        removeResources();
      }
    }, onError: catchError);

    return controller.stream;
  }

  Stream<List<TeamModel>> getUserRelatedTeams() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection(FireStoreConst.teamsCollection)
        .where(
          Filter.or(
            Filter(FireStoreConst.createdBy, isEqualTo: _currentUserId),
            Filter(FireStoreConst.players, arrayContains: _currentUserId),
          ),
        )
        .snapshots()
        .asyncMap((snapshot) async {
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
          players: member,
        );

        teams.add(team);
      }
      return teams;
    }).handleError((error, stack) {
      throw AppError.fromError(error, stack);
    });
  }

  Stream<List<TeamModel>> getUserOwnedTeams() {
    StreamController<List<TeamModel>> controller =
        StreamController<List<TeamModel>>();
    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;

    catchError(Object error, StackTrace stack) {
      controller.addError(AppError.fromError(error, stack));
      controller.close();
      subscription?.cancel();
    }

    subscription = _firestore
        .collection(FireStoreConst.teamsCollection)
        .where(FireStoreConst.createdBy, isEqualTo: _currentUserId)
        .snapshots()
        .listen((snapshot) async {
      try {
        List<TeamModel> teams =
            await Future.wait(snapshot.docs.map((mainDoc) async {
          AddTeamRequestModel teamRequestModel =
              AddTeamRequestModel.fromJson(mainDoc.data());

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

        controller.add(teams);
      } catch (e, stack) {
        catchError(e, stack);
      }
    }, onError: catchError);

    return controller.stream;
  }

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

  Future<void> updateProfileImageUrl(String teamId, String? imageUrl) async {
    try {
      DocumentReference teamRef =
          _firestore.collection(FireStoreConst.teamsCollection).doc(teamId);

      await teamRef.set({
        FireStoreConst.profileImageUrl: imageUrl,
      }, SetOptions(merge: true));
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> addPlayersToTeam(String teamId, List<String> players) async {
    try {
      DocumentReference teamRef =
          _firestore.collection(FireStoreConst.teamsCollection).doc(teamId);

      await teamRef.set(
          {FireStoreConst.players: FieldValue.arrayUnion(players)},
          SetOptions(merge: true));
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> removePlayersFromTeam(
      String teamId, List<String> playerIds) async {
    try {
      DocumentReference teamRef =
          _firestore.collection(FireStoreConst.teamsCollection).doc(teamId);

      await teamRef
          .update({FireStoreConst.players: FieldValue.arrayRemove(playerIds)});
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<bool> isTeamNameAvailable(String teamName) async {
    try {
      QuerySnapshot teamSnap = await _firestore
          .collection(FireStoreConst.teamsCollection)
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

  Future<void> deleteTeam(String teamId) async {
    try {
      await _firestore
          .collection(FireStoreConst.teamsCollection)
          .doc(teamId)
          .delete();
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
