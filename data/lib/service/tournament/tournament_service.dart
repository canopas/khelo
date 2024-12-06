import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/ball_score/ball_score_model.dart';
import '../../api/match/match_model.dart';
import '../../api/team/team_model.dart';
import '../../api/tournament/tournament_model.dart';
import '../../api/user/user_models.dart';
import '../../errors/app_error.dart';
import '../../utils/constant/firestore_constant.dart';
import '../match/match_service.dart';
import '../team/team_service.dart';
import '../user/user_service.dart';

final tournamentServiceProvider = Provider(
  (ref) => TournamentService(
    FirebaseFirestore.instance,
    ref.read(teamServiceProvider),
    ref.read(matchServiceProvider),
    ref.read(userServiceProvider),
  ),
);

class TournamentService {
  final FirebaseFirestore _firestore;
  final TeamService _teamService;
  final MatchService _matchService;
  final UserService _userService;

  TournamentService(
    this._firestore,
    this._teamService,
    this._matchService,
    this._userService,
  );

  CollectionReference<TournamentModel> get _tournamentCollection =>
      _firestore.collection(FireStoreConst.tournamentCollection).withConverter(
            fromFirestore: TournamentModel.fromFireStore,
            toFirestore: (TournamentModel tournament, _) => tournament.toJson(),
          );

  CollectionReference<TournamentTeamStat> _tournamentTeamStatCollection(
    String tournamentId,
  ) =>
      _tournamentCollection
          .doc(tournamentId)
          .collection(FireStoreConst.tournamentTeamStatsCollection)
          .withConverter(
            fromFirestore: TournamentTeamStat.fromFireStore,
            toFirestore: (tournamentTeamStat, _) => tournamentTeamStat.toJson(),
          );

  CollectionReference<PlayerKeyStat> _tournamentPlayerKeyStatCollection(
    String tournamentId,
  ) =>
      _tournamentCollection
          .doc(tournamentId)
          .collection(FireStoreConst.tournamentPlayerKeyStatsCollection)
          .withConverter(
            fromFirestore: PlayerKeyStat.fromFireStore,
            toFirestore: (tournamentKeyStat, _) => tournamentKeyStat.toJson(),
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

  Future<TournamentModel> getTournamentById(String id) async {
    try {
      final snapshot = await _tournamentCollection.doc(id).get();
      final tournament = snapshot.data();
      if (tournament != null) {
        return tournament;
      } else {
        return TournamentModel(
          id: '',
          name: '',
          type: TournamentType.knockOut,
          created_by: '',
          start_date: DateTime.now(),
          end_date: DateTime.now(),
        );
      }
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<TournamentModel>> getTournaments({
    String? lastMatchId,
    int limit = 10,
  }) async {
    final DateTime now = DateTime.now();
    final DateTime thirtyDaysAgo = now.subtract(Duration(days: 30));

    final Timestamp timestamp = Timestamp.fromDate(thirtyDaysAgo);

    var query = _tournamentCollection
        .where(Filter(FireStoreConst.startDate, isGreaterThan: timestamp))
        .orderBy(FireStoreConst.startDate);

    if (lastMatchId != null) {
      query = query.startAfter([lastMatchId]);
    }

    final snapshot = await query.limit(limit).get();

    return Future.wait(
      snapshot.docs.map(
        (e) async {
          var tournament = e.data();
          final matchIds = tournament.match_ids;
          if (matchIds.isNotEmpty) {
            final matches = await _matchService.getMatchesByIds(matchIds);
            tournament = tournament.copyWith(matches: matches);
          }
          final status = getTournamentStatus(tournament);
          return tournament.copyWith(status: status);
        },
      ),
    );
  }

  Future<List<TournamentTeamStat>> getTeamsStats(
    String tournamentId,
    List<TeamModel> teams,
  ) async {
    try {
      final snapshot = await _tournamentTeamStatCollection(tournamentId).get();
      return snapshot.docs
          .map(
            (e) => e.data().copyWith(
                  team: teams.firstWhere((element) => element.id == e.id),
                ),
          )
          .toList();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<TournamentTeamStat> getTeamStatByTeamId(
    String tournamentId,
    TeamModel team,
  ) async {
    try {
      final snapshot =
          await _tournamentTeamStatCollection(tournamentId).doc(team.id).get();
      return snapshot.data()?.copyWith(team: team) ??
          TournamentTeamStat(team_id: team.id, team: team);
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<PlayerKeyStat>> getPlayerKeyStats(
    String tournamentId,
    List<UserModel> players,
  ) async {
    try {
      final snapshot =
          await _tournamentPlayerKeyStatCollection(tournamentId).get();

      if (snapshot.docs.isEmpty && players.isEmpty) return [];

      return snapshot.docs.map((doc) {
        final data = doc.data();

        final player = players.firstWhereOrNull((p) => p.id == data.player_id);

        return player == null ? data : data.copyWith(player: player);
      }).toList();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<PlayerKeyStat> getPlayerKeyStatByPlayerId(
    String tournamentId,
    UserModel player,
  ) async {
    try {
      final snapshot = await _tournamentPlayerKeyStatCollection(tournamentId)
          .doc(player.id)
          .get();
      return snapshot.data()?.copyWith(player: player) ??
          PlayerKeyStat(player_id: player.id, teamName: '', player: player);
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<int> getUserOwnedTournamentsCount(String userId) {
    final currentPlayer = TournamentMember(
      id: userId,
      role: TournamentMemberRole.organizer,
    );

    final filter = Filter.or(
      Filter(FireStoreConst.createdBy, isEqualTo: userId),
      Filter(FireStoreConst.members, arrayContains: currentPlayer.toJson()),
    );
    return _tournamentCollection.where(filter).count().get().then((snapshot) {
      return snapshot.count ?? 0;
    }).catchError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<TournamentModel>> streamActiveTournaments() {
    final DateTime now = DateTime.now();
    final DateTime thirtyDaysAgo = now.subtract(Duration(days: 30));

    final Timestamp timestamp = Timestamp.fromDate(thirtyDaysAgo);

    return _tournamentCollection
        .where(Filter(FireStoreConst.startDate, isGreaterThan: timestamp))
        .snapshots()
        .asyncMap(
      (event) async {
        return await Future.wait(
          event.docs.map(
            (e) async {
              var tournament = e.data();
              final matchIds = tournament.match_ids;
              if (matchIds.isNotEmpty) {
                final matches = await _matchService.getMatchesByIds(matchIds);
                tournament = tournament.copyWith(matches: matches);
              }
              final status = getTournamentStatus(tournament);
              return tournament.copyWith(status: status);
            },
          ),
        );
      },
    ).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<TournamentModel>> streamCurrentUserRelatedMatches(String userId) {
    final currentMember = TournamentMember(id: userId);

    final memberContains = [
      currentMember.copyWith(role: TournamentMemberRole.organizer).toJson(),
      currentMember.copyWith(role: TournamentMemberRole.admin).toJson(),
    ];
    final filter = Filter.or(
      Filter(FireStoreConst.createdBy, isEqualTo: userId),
      Filter(FireStoreConst.members, arrayContainsAny: memberContains),
    );

    return _tournamentCollection
        .where(filter)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList())
        .handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<TournamentModel> streamTournamentById(String tournamentId) {
    return _tournamentCollection
        .doc(tournamentId)
        .snapshots()
        .asyncMap((snapshot) async {
      if (snapshot.data() == null) {
        return TournamentModel(
          id: tournamentId,
          name: '',
          created_by: '',
          type: TournamentType.knockOut,
          start_date: DateTime.now(),
          end_date: DateTime.now().add(const Duration(days: 1)),
        );
      } else {
        var tournament = snapshot.data()!;
        final teamIds = tournament.team_ids;
        final matchIds = tournament.match_ids;

        if (teamIds.isNotEmpty) {
          final teams = await _teamService.getTeamsByIds(teamIds);
          final teamStats = await getTeamsStats(tournamentId, teams);
          tournament = tournament.copyWith(teams: teams, teamStats: teamStats);
        }

        if (matchIds.isNotEmpty) {
          final matches = await _matchService.getMatchesByIds(matchIds);

          final players = matches
              .expand((match) => match.teams)
              .expand((team) => team.squad)
              .map((member) => member.player)
              .where((player) => player.isActive)
              .toSet()
              .toList();

          final keyStats =
              (await getPlayerKeyStats(tournamentId, players)).getTopKeyStats();

          tournament =
              tournament.copyWith(matches: matches, keyStats: keyStats);
        }

        if (tournament.members.isNotEmpty) {
          final memberIds = tournament.members.map((e) => e.id).toList();
          final users = await _userService.getUsersByIds(memberIds);

          final members = tournament.members.map((member) {
            final user = users.firstWhere((element) => element.id == member.id);
            return member.copyWith(user: user);
          }).toList();

          tournament = tournament.copyWith(members: members);
        }
        final status = getTournamentStatus(tournament);

        return tournament.copyWith(status: status);
      }
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Future<void> _updateTeamStats(
    String tournamentId,
    TournamentTeamStat teamStat,
  ) async {
    try {
      final teamStatRef =
          _tournamentTeamStatCollection(tournamentId).doc(teamStat.team_id);
      await teamStatRef.set(teamStat, SetOptions(merge: true));
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> _updatePlayerKeyStats(
    String tournamentId,
    PlayerKeyStat keyStat,
  ) async {
    try {
      final keyStatRef = _tournamentPlayerKeyStatCollection(tournamentId)
          .doc(keyStat.player_id);
      await keyStatRef.set(keyStat, SetOptions(merge: true));
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateTournamentStats({
    required String tournamentId,
    required MatchModel match,
    required List<BallScoreModel> ballScores,
  }) async {
    if (match.teams.isEmpty || ballScores.isEmpty) {
      return;
    }

    try {
      final userStatType = match.match_type == MatchType.testMatch
          ? UserStatType.test
          : UserStatType.other;

      for (final team in match.teams) {
        // Update team stats
        final currentTeamStat =
            await getTeamStatByTeamId(tournamentId, team.team);

        final newTeamStat = match.getTeamStat(
          team.team_id,
          currentTeamStat: currentTeamStat,
        );

        await _updateTeamStats(tournamentId, newTeamStat);

        // Update player stats
        for (final player in team.squad) {
          final currentKeyStat =
              await getPlayerKeyStatByPlayerId(tournamentId, player.player);

          final newStats = ballScores
              .where(
                (score) =>
                    score.batsman_id == player.id ||
                    score.bowler_id == player.id ||
                    score.wicket_taker_id == player.id,
              )
              .toList()
              .calculateUserStats(
                player.id,
                oldUserStats: currentKeyStat.stats,
                type: userStatType,
              );

          final updatedKeyStat = PlayerKeyStat(
            player_id: player.id,
            teamName: team.team.name,
            stats: newStats,
          );

          await _updatePlayerKeyStats(tournamentId, updatedKeyStat);
        }
      }
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateTeamIds(
    String tournamentId,
    List<String> teamIds,
  ) async {
    try {
      await _tournamentCollection
          .doc(tournamentId)
          .update({FireStoreConst.teamIds: teamIds});
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> removeMatchFromTournament(
    String tournamentId,
    String matchId,
  ) async {
    try {
      await _tournamentCollection.doc(tournamentId).update({
        FireStoreConst.matchIds: FieldValue.arrayRemove([matchId]),
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> addMatchInTournament(String tournamentId, String matchId) async {
    try {
      await _tournamentCollection.doc(tournamentId).update({
        FireStoreConst.matchIds: FieldValue.arrayUnion([matchId]),
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateTournamentMembers(
    String tournamentId,
    List<TournamentMember> members,
  ) async {
    try {
      await _tournamentCollection.doc(tournamentId).update({
        FireStoreConst.members: members.map((e) => e.toJson()).toList(),
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> removeTournamentMember(
    String tournamentId,
    TournamentMember member,
  ) async {
    try {
      await _tournamentCollection.doc(tournamentId).update({
        FireStoreConst.members: FieldValue.arrayRemove([member.toJson()]),
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> changeTournamentOwner(
    String tournamentId,
    String? newOwnerId,
    List<TournamentMember> members,
  ) async {
    try {
      await _tournamentCollection.doc(tournamentId).update({
        FireStoreConst.createdBy: newOwnerId,
        FireStoreConst.members: members.map((e) => e.toJson()).toList(),
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> deleteTournament(String tournamentId) async {
    try {
      await _tournamentCollection.doc(tournamentId).delete();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  // Helper
  TournamentStatus getTournamentStatus(TournamentModel tournament) {
    if (tournament.matches.isEmpty) return TournamentStatus.upcoming;

    final bool isUpcoming = (tournament.start_date.isAfter(DateTime.now()) &&
            tournament.end_date.isAfter(DateTime.now())) &&
        tournament.matches
            .every((match) => match.match_status == MatchStatus.yetToStart);

    final bool isRunning = tournament.start_date.isBefore(DateTime.now()) &&
        tournament.end_date.isAfter(DateTime.now()) &&
        tournament.matches
            .any((match) => match.match_status == MatchStatus.running);

    final bool isFinished = tournament.end_date.isBefore(DateTime.now()) &&
        tournament.matches.every(
          (match) =>
              match.match_status == MatchStatus.finish ||
              match.match_status == MatchStatus.abandoned,
        );

    final bool isInProgress = tournament.start_date.isBefore(DateTime.now()) &&
        tournament.end_date.isAfter(DateTime.now()) &&
        tournament.matches.any(
          (match) =>
              match.match_status == MatchStatus.running ||
              match.match_status == MatchStatus.yetToStart,
        );

    if (isUpcoming) return TournamentStatus.upcoming;
    if (isRunning || isInProgress) return TournamentStatus.running;
    if (isFinished) return TournamentStatus.finish;

    return TournamentStatus.finish;
  }
}
