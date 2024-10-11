import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../api/team/team_model.dart';
import '../../api/user/user_models.dart';
import '../../errors/app_error.dart';
import '../../extensions/string_extensions.dart';
import '../../utils/constant/firestore_constant.dart';
import '../../utils/dummy_deactivated_account.dart';
import '../user/user_service.dart';

final teamServiceProvider = Provider(
  (ref) => TeamService(
    FirebaseFirestore.instance,
    ref.read(userServiceProvider),
  ),
);

class TeamService {
  final FirebaseFirestore _firestore;
  final UserService _userService;

  TeamService(this._firestore, this._userService);

  CollectionReference<TeamModel> get _teamsCollection =>
      _firestore.collection(FireStoreConst.teamsCollection).withConverter(
            fromFirestore: TeamModel.fromFireStore,
            toFirestore: (TeamModel team, _) => team.toJson(),
          );

  String get generateTeamId => _teamsCollection.doc().id;

  Future<TeamModel> getTeamById(String teamId) async {
    try {
      final teamDoc = await _teamsCollection.doc(teamId).get();
      final team = teamDoc.data();
      final users = await getMemberListFromUserIds(
        team?.players.map((e) => e.id).toList() ?? [],
      );

      final players = team?.players.map((player) {
        final user = users.firstWhere((element) => element.id == player.id);
        return player.copyWith(user: user);
      }).toList();

      return team?.copyWith(players: players ?? []) ??
          deActiveDummyTeamModel(teamId);
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<TeamModel> streamTeamById(String teamId) {
    return _teamsCollection.doc(teamId).snapshots().asyncMap((teamDoc) async {
      final team = teamDoc.data();

      final users = await getMemberListFromUserIds(
        team?.players.map((e) => e.id).toList() ?? [],
      );

      final players = team?.players.map((player) {
        final user = users.firstWhere((element) => element.id == player.id);
        return player.copyWith(user: user);
      }).toList();

      return team?.copyWith(players: players ?? []) ??
          deActiveDummyTeamModel(teamId);
    }).handleError((error, stack) => AppError.fromError(error, stack));
  }

  Stream<List<TeamModel>> streamUserRelatedTeams(String userId) {
    final currentPlayer = TeamPlayer(id: userId);

    final playerContains = [
      currentPlayer.copyWith(role: TeamPlayerRole.admin).toJson(),
      currentPlayer.copyWith(role: TeamPlayerRole.player).toJson(),
    ];

    final filter = Filter.or(
      Filter(FireStoreConst.createdBy, isEqualTo: userId),
      Filter(FireStoreConst.teamPlayers, arrayContainsAny: playerContains),
    );
    return _teamsCollection
        .where(filter)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(
        snapshot.docs.map((mainDoc) async {
          final team = mainDoc.data();

          final users = await getMemberListFromUserIds(
            team.players.map((e) => e.id).toList(),
          );

          final players = team.players.map((player) {
            final user = users.firstWhere((element) => element.id == player.id);
            return player.copyWith(user: user);
          }).toList();

          return team.copyWith(players: players);
        }).toList(),
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<TeamModel>> streamUserOwnedTeams(String userId) {
    final currentPlayer = TeamPlayer(
      id: userId,
      role: TeamPlayerRole.admin,
    );

    final filter = Filter.or(
      Filter(FireStoreConst.createdBy, isEqualTo: userId),
      Filter(FireStoreConst.teamPlayers, arrayContains: currentPlayer.toJson()),
    );
    return _teamsCollection
        .where(filter)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(
        snapshot.docs.map((mainDoc) async {
          final team = mainDoc.data();

          final users = await getMemberListFromUserIds(
            team.players.map((e) => e.id).toList(),
          );

          final players = team.players.map((player) {
            final user = users.firstWhere((element) => element.id == player.id);
            return player.copyWith(user: user);
          }).toList();

          return team.copyWith(players: players);
        }).toList(),
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Future<String> updateTeam(TeamModel team) async {
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

  Future<void> addPlayersToTeam(String teamId, List<TeamPlayer> players) async {
    try {
      await _teamsCollection.doc(teamId).update({
        FireStoreConst.teamPlayers:
            FieldValue.arrayUnion(players.map((e) => e.toJson()).toList()),
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> editPlayersToTeam(
    String teamId,
    List<TeamPlayer> players,
  ) async {
    try {
      await _teamsCollection.doc(teamId).update(
        {FireStoreConst.teamPlayers: players.map((e) => e.toJson()).toList()},
      );
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> removePlayersFromTeam(
    String teamId,
    List<TeamPlayer> players,
  ) async {
    try {
      final teamRef = _teamsCollection.doc(teamId);
      await teamRef.update({
        FireStoreConst.teamPlayers:
            FieldValue.arrayRemove(players.map((e) => e.toJson()).toList()),
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<bool> isTeamNameAvailable(String teamName) async {
    try {
      final QuerySnapshot teamSnap = await _teamsCollection
          .where(
            FireStoreConst.nameLowercase,
            isEqualTo: teamName.caseAndSpaceInsensitive,
          )
          .get();

      return teamSnap.docs.isEmpty;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<TeamModel>> searchTeam(String searchKey) async {
    try {
      final snapshot = await _teamsCollection
          .where(
            FireStoreConst.nameLowercase,
            isGreaterThanOrEqualTo: searchKey.caseAndSpaceInsensitive,
          )
          .where(
            FireStoreConst.nameLowercase,
            isLessThan: '${searchKey.caseAndSpaceInsensitive}z',
          )
          .get();

      final List<TeamModel> teams = [];

      for (final mainDoc in snapshot.docs) {
        final team = mainDoc.data();

        final users = await getMemberListFromUserIds(
          team.players.map((e) => e.id).toList(),
        );

        final players = team.players.map((player) {
          final user = users.firstWhere((element) => element.id == player.id);
          return player.copyWith(user: user);
        }).toList();

        teams.add(team.copyWith(players: players));
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

  Future<List<TeamModel>> getTeamsByIds(List<String> teamIds) async {
    try {
      return await _teamsCollection
          .where(FieldPath.documentId, whereIn: teamIds)
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<List<TeamModel>> streamUserRelatedTeamsByUserId(String userId) {
    final currentPlayer = TeamPlayer(id: userId);

    final playerContains = [
      currentPlayer.copyWith(role: TeamPlayerRole.admin).toJson(),
      currentPlayer.copyWith(role: TeamPlayerRole.player).toJson(),
    ];

    return _teamsCollection
        .where(FireStoreConst.teamPlayers, arrayContainsAny: playerContains)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(
        snapshot.docs.map((mainDoc) async {
          final team = mainDoc.data();

          final users = await getMemberListFromUserIds(
            team.players.map((e) => e.id).toList(),
          );

          final players = team.players.map((player) {
            final user = users.firstWhere((element) => element.id == player.id);
            return player.copyWith(user: user);
          }).toList();

          return team.copyWith(players: players);
        }).toList(),
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }
}
