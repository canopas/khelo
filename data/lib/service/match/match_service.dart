import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/match/match_model.dart';
import '../../api/team/team_model.dart';
import '../../api/user/user_models.dart';
import '../../errors/app_error.dart';
import '../../extensions/list_extensions.dart';
import '../../utils/constant/firestore_constant.dart';
import '../team/team_service.dart';
import '../user/user_service.dart';

final matchServiceProvider = Provider(
  (ref) => MatchService(
    FirebaseFirestore.instance,
    ref.read(teamServiceProvider),
    ref.read(userServiceProvider),
  ),
);

class MatchService {
  final FirebaseFirestore _firestore;
  final TeamService _teamService;
  final UserService _userService;

  MatchService(
    this._firestore,
    this._teamService,
    this._userService,
  );

  CollectionReference<MatchModel> get _matchCollection =>
      _firestore.collection(FireStoreConst.matchesCollection).withConverter(
            fromFirestore: MatchModel.fromFireStore,
            toFirestore: (MatchModel match, _) => match.toJson(),
          );

  String get generateMatchId => _matchCollection.doc().id;

  Future<MatchModel> getMatchById(String id) async {
    try {
      final snapshot = await _matchCollection.doc(id).get();

      final match = snapshot.data();
      if (match == null) {
        return MatchModel(
          id: '',
          teams: [],
          match_type: MatchType.limitedOvers,
          number_of_over: 0,
          over_per_bowler: 0,
          city: '',
          ground: '',
          start_time: DateTime.now(),
          start_at: DateTime.now(),
          ball_type: BallType.leather,
          pitch_type: PitchType.turf,
          created_by: '',
          match_status: MatchStatus.running,
          updated_at: DateTime.now(),
        );
      }

      final List<MatchTeamModel> teams = await getTeamsList(match.teams);
      final List<UserModel>? umpires =
          await getUserListFromUserIds(match.umpire_ids);
      final List<UserModel>? commentators =
          await getUserListFromUserIds(match.commentator_ids);
      final List<UserModel>? scorers =
          await getUserListFromUserIds(match.scorer_ids);

      UserModel? referee;
      if (match.referee_id != null) {
        referee = await _userService.getUser(match.referee_id!);
      }

      return match.copyWith(
        teams: teams,
        commentators: commentators,
        referee: referee,
        scorers: scorers,
        umpires: umpires,
      );
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<List<MatchModel>> streamUserRelatedMatches(String userId) {
    final filter = Filter.or(
      Filter(FireStoreConst.createdBy, isEqualTo: userId),
      Filter(FireStoreConst.players, arrayContains: userId),
      Filter(FireStoreConst.teamCreatorIds, arrayContains: userId),
    );

    return _matchCollection
        .where(filter)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(
        snapshot.docs.map((mainDoc) async {
          final match = mainDoc.data();
          final List<MatchTeamModel> teams = await getTeamsList(match.teams);
          return match.copyWith(teams: teams);
        }).toList(),
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<MatchModel>> streamUserMatches(String userId) {
    return _matchCollection
        .where(FireStoreConst.players, arrayContains: userId)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(
        snapshot.docs.map((mainDoc) async {
          final match = mainDoc.data();
          final List<MatchTeamModel> teams = await getTeamsList(match.teams);
          return match.copyWith(teams: teams);
        }).toList(),
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<MatchModel>> streamMatchesByTeamId(String teamId) {
    return _matchCollection
        .where(FireStoreConst.teamIds, arrayContains: teamId)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(
        snapshot.docs.map((mainDoc) async {
          final match = mainDoc.data();

          final List<MatchTeamModel> teams = await getTeamsList(match.teams);
          return match.copyWith(teams: teams);
        }).toList(),
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<MatchModel>> streamActiveRunningMatches() {
    final DateTime now = DateTime.now();
    final DateTime oneAndHalfHoursAgo =
        now.subtract(Duration(hours: 1, minutes: 30));

    final Timestamp timestamp = Timestamp.fromDate(oneAndHalfHoursAgo);

    final filter = Filter.and(
      Filter(FireStoreConst.matchStatus, isEqualTo: MatchStatus.running.value),
      Filter(FireStoreConst.updatedAt, isGreaterThan: timestamp),
    );
    return _matchCollection
        .where(filter)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(
        snapshot.docs.map((mainDoc) async {
          final match = mainDoc.data();

          final List<MatchTeamModel> teams = await getTeamsList(match.teams);
          return match.copyWith(teams: teams);
        }).toList(),
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<MatchModel>> streamUpcomingMatches() {
    final DateTime now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final DateTime aMonthAfter = startOfDay.add(Duration(days: 30));

    final Timestamp timestampAfterMonth = Timestamp.fromDate(aMonthAfter);
    final Timestamp timestampNow = Timestamp.fromDate(startOfDay);

    final filter = Filter.and(
      Filter(
        FireStoreConst.matchStatus,
        isEqualTo: MatchStatus.yetToStart.value,
      ),
      Filter(FireStoreConst.startAt, isGreaterThanOrEqualTo: timestampNow),
      Filter(
        FireStoreConst.startAt,
        isLessThanOrEqualTo: timestampAfterMonth,
      ),
    );
    return _matchCollection
        .where(filter)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(
        snapshot.docs.map((mainDoc) async {
          final match = mainDoc.data();

          final List<MatchTeamModel> teams = await getTeamsList(match.teams);
          return match.copyWith(teams: teams);
        }).toList(),
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<MatchModel>> streamFinishedMatches() {
    final DateTime now = DateTime.now();
    final DateTime fifteenDaysAgo =
        DateTime(now.year, now.month, now.day).subtract(Duration(days: 15));

    final Timestamp timestamp = Timestamp.fromDate(fifteenDaysAgo);

    final filter = Filter.and(
      Filter(FireStoreConst.matchStatus, isEqualTo: MatchStatus.finish.value),
      Filter(FireStoreConst.updatedAt, isGreaterThan: timestamp),
    );
    return _matchCollection
        .where(filter)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(
        snapshot.docs.map((mainDoc) async {
          final match = mainDoc.data();

          final List<MatchTeamModel> teams = await getTeamsList(match.teams);
          return match.copyWith(teams: teams);
        }).toList(),
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Future<List<MatchModel>> getMatchesByStatus({
    required List<MatchStatus> status,
    String? lastMatchId,
    int limit = 10,
  }) async {
    final filter = status.map((e) => e.value).toList();
    if (filter.isEmpty) return [];
    var query = _matchCollection
        .where(FireStoreConst.matchStatus, whereIn: filter)
        .orderBy(FieldPath.documentId);

    if (lastMatchId != null) {
      query = query.startAfter([lastMatchId]);
    }

    final snapshot = await query.limit(limit).get();

    return Future.wait(
      snapshot.docs.map((doc) async {
        final match = doc.data();
        final teams = await getTeamsList(match.teams);
        return match.copyWith(teams: teams);
      }).toList(),
    );
  }

  Stream<MatchModel> streamMatchById(String id) {
    return _matchCollection.doc(id).snapshots().asyncMap((snapshot) async {
      final match = snapshot.data();
      if (match == null) {
        return MatchModel(
          id: '',
          teams: [],
          match_type: MatchType.limitedOvers,
          number_of_over: 0,
          over_per_bowler: 0,
          city: '',
          ground: '',
          start_time: DateTime.now(),
          start_at: DateTime.now(),
          ball_type: BallType.leather,
          pitch_type: PitchType.turf,
          created_by: '',
          match_status: MatchStatus.running,
        );
      }

      final List<MatchTeamModel> teams = await getTeamsList(match.teams);
      final List<UserModel>? umpires =
          await getUserListFromUserIds(match.umpire_ids);
      final List<UserModel>? commentators =
          await getUserListFromUserIds(match.commentator_ids);
      final List<UserModel>? scorers =
          await getUserListFromUserIds(match.scorer_ids);

      UserModel? referee;
      if (match.referee_id != null) {
        referee = await _userService.getUser(match.referee_id!);
      }

      return match.copyWith(
        teams: teams,
        commentators: commentators,
        referee: referee,
        scorers: scorers,
        umpires: umpires,
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Future<String> updateMatch(MatchModel match) async {
    try {
      final matchRef = _matchCollection.doc(match.id);
      await matchRef.set(
        match.copyWith(id: matchRef.id),
        SetOptions(merge: true),
      );
      return matchRef.id;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateTossDetails(
    String matchId,
    String tossWinnerId,
    TossDecision tossDecision,
    String currentPlayingTeam,
  ) async {
    try {
      final matchRef = _matchCollection.doc(matchId);

      final Map<String, dynamic> tossDetails = {
        FireStoreConst.tossWinnerId: tossWinnerId,
        FireStoreConst.tossDecision: tossDecision.value,
        FireStoreConst.currentPlayingTeamId: currentPlayingTeam,
        FireStoreConst.updatedAt: DateTime.now(),
      };

      await matchRef.update(tossDetails);
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateMatchStatus(String matchId, MatchStatus status) async {
    try {
      final matchRef = _matchCollection.doc(matchId);

      final Map<String, dynamic> matchStatus = {
        FireStoreConst.matchStatus: status.value,
        FireStoreConst.updatedAt: DateTime.now(),
      };

      await matchRef.update(matchStatus);
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateTeamScoreAndSquadViaTransaction(
    Transaction transaction, {
    required String matchId,
    required String battingTeamId,
    required int totalRun,
    required String bowlingTeamId,
    required int wicket,
    double? over,
    int? runs,
    List<MatchPlayer>? updatedMatchPlayer,
  }) async {
    try {
      final matchRef = _matchCollection.doc(matchId);

      final snapshot = await transaction.get(matchRef);

      final existingTeams = snapshot.data()?.teams ?? [];

      final int battingTeamIndex =
          existingTeams.indexWhere((team) => team.team_id == battingTeamId);
      final int bowlingTeamIndex =
          existingTeams.indexWhere((team) => team.team_id == bowlingTeamId);

      var battingTeam = existingTeams[battingTeamIndex];
      var bowlingTeam = existingTeams[bowlingTeamIndex];
      if (battingTeamIndex != -1 && bowlingTeamIndex != -1) {
        if (updatedMatchPlayer != null) {
          final updatedSquad = existingTeams[battingTeamIndex].squad.toList();

          for (final matchPlayer in updatedMatchPlayer) {
            final int existingPlayerIndex = updatedSquad
                .indexWhere((player) => player.id == matchPlayer.id);
            if (existingPlayerIndex != -1) {
              updatedSquad[existingPlayerIndex] = matchPlayer;
            } else {
              updatedSquad.add(matchPlayer);
            }
          }
          battingTeam = battingTeam.copyWith(squad: updatedSquad);
        }

        battingTeam = battingTeam.copyWith(run: totalRun);
        if (over != null) {
          battingTeam = battingTeam.copyWith(over: over);
        }
        bowlingTeam = bowlingTeam.copyWith(wicket: wicket);
        if (runs != null) {
          bowlingTeam = bowlingTeam.copyWith(run: runs);
        }
      }

      transaction.update(matchRef, {
        FireStoreConst.teams: [battingTeam.toJson(), bowlingTeam.toJson()],
        FireStoreConst.updatedAt: DateTime.now(),
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateCurrentPlayingTeam({
    required String matchId,
    required String teamId,
  }) async {
    try {
      final matchRef = _matchCollection.doc(matchId);

      await matchRef.update({
        FireStoreConst.currentPlayingTeamId: teamId,
        FireStoreConst.updatedAt: DateTime.now(),
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateTeamsSquad(
    String matchId,
    MatchTeamModel teamRequest,
  ) async {
    try {
      final matchRef = _matchCollection.doc(matchId);

      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(matchRef);

        final existingTeams = snapshot.data()?.teams ?? [];
        var updatedTeams = existingTeams;
        final int teamIndex = existingTeams
            .indexWhere((team) => team.team_id == teamRequest.team_id);

        if (teamIndex != -1) {
          var team = existingTeams[teamIndex];
          final updatedSquad = existingTeams[teamIndex].squad.toList();

          for (var updatedPlayer in teamRequest.squad) {
            final int existingPlayerIndex = updatedSquad
                .indexWhere((player) => player.id == updatedPlayer.id);
            if (existingPlayerIndex != -1) {
              updatedSquad[existingPlayerIndex] = updatedPlayer;
            } else {
              updatedSquad.add(updatedPlayer);
            }
          }

          team = team.copyWith(squad: updatedSquad);
          updatedTeams = updatedTeams.updateWhere(
            where: (element) => element.team_id == team.team_id,
            updated: (oldElement) => team,
          );
        }

        transaction.update(
          matchRef,
          {
            FireStoreConst.teams: updatedTeams.map((e) => e.toJson()).toList(),
            FireStoreConst.updatedAt: DateTime.now(),
          },
        );
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> setRevisedTarget({
    required String matchId,
    required RevisedTarget revisedTarget,
  }) async {
    await _matchCollection.doc(matchId).update(
      {
        FireStoreConst.revisedTarget: revisedTarget.toJson(),
        FireStoreConst.updatedAt: DateTime.now(),
      },
    );
  }

  Future<void> deleteMatch(String matchId) async {
    try {
      await _matchCollection.doc(matchId).delete();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  // Helper Methods
  Future<List<UserModel>?> getUserListFromUserIds(List<String>? userIds) async {
    if (userIds == null) {
      return null;
    }
    try {
      final List<UserModel> users = await _userService.getUsersByIds(userIds);
      return users;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<MatchTeamModel>> getTeamsList(
    List<MatchTeamModel> teamList,
  ) async {
    try {
      final List<MatchTeamModel> teams = [];

      await Future.forEach(teamList, (e) async {
        final TeamModel team = await _teamService.getTeamById(e.team_id);
        final List<MatchPlayer> squad =
            await getPlayerListFromPlayerIds(e.squad);
        teams.add(
          e.copyWith(team: team, squad: squad),
        );
      });

      return teams;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<MatchPlayer>> getPlayerListFromPlayerIds(
    List<MatchPlayer> players,
  ) async {
    try {
      final List<String> playerIds =
          players.map((player) => player.id).toList();

      final List<UserModel> users = await _userService.getUsersByIds(playerIds);

      final List<MatchPlayer> squad = users.map((user) {
        final matchPlayer =
            players.firstWhere((element) => element.id == user.id);

        return MatchPlayer(
          player: user,
          performance: matchPlayer.performance,
          id: user.id,
        );
      }).toList();

      return squad;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
