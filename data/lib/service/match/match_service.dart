import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../api/match/match_model.dart';
import '../../api/team/team_model.dart';
import '../../api/user/user_models.dart';
import '../../errors/app_error.dart';
import '../../extensions/list_extensions.dart';
import '../team/team_service.dart';
import '../user/user_service.dart';
import '../../utils/constant/firestore_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../storage/app_preferences.dart';

final matchServiceProvider = Provider((ref) {
  final service = MatchService(
    FirebaseFirestore.instance,
    ref.read(teamServiceProvider),
    ref.read(userServiceProvider),
    ref.read(currentUserPod)?.id,
  );

  ref.listen(currentUserPod, (_, next) => service._currentUserId = next?.id);
  return service;
});

class MatchService {
  final FirebaseFirestore _firestore;
  final TeamService _teamService;
  final UserService _userService;
  String? _currentUserId;
  final CollectionReference<AddEditMatchRequest> _matchCollection;

  MatchService(
    this._firestore,
    this._teamService,
    this._userService,
    this._currentUserId,
  ) : _matchCollection = _firestore
            .collection(FireStoreConst.matchesCollection)
            .withConverter(
              fromFirestore: AddEditMatchRequest.fromFireStore,
              toFirestore: (AddEditMatchRequest match, _) => match.toJson(),
            );

  Stream<List<MatchModel>> getCurrentUserPlayedMatches() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }

    final filter = Filter.and(
      Filter(FireStoreConst.matchStatus, isEqualTo: MatchStatus.finish.value),
      Filter(FireStoreConst.players, arrayContains: _currentUserId),
    );

    return _matchCollection
        .where(filter)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(
        snapshot.docs.map((mainDoc) async {
          final match = mainDoc.data();
          final List<MatchTeamModel> teams = await getTeamsList(match.teams);
          return MatchModel(
            id: match.id,
            teams: teams,
            match_type: match.match_type,
            number_of_over: match.number_of_over,
            over_per_bowler: match.over_per_bowler,
            players: match.players,
            team_ids: match.team_ids,
            team_creator_ids: match.team_creator_ids,
            city: match.city,
            ground: match.ground,
            start_time: match.start_time,
            created_by: match.created_by,
            ball_type: match.ball_type,
            pitch_type: match.pitch_type,
            match_status: match.match_status,
            toss_winner_id: match.toss_winner_id,
            toss_decision: match.toss_decision,
            current_playing_team_id: match.current_playing_team_id,
          );
        }).toList(),
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<MatchModel>> getCurrentUserRelatedMatches() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }

    final filter = Filter.or(
      Filter(FireStoreConst.createdBy, isEqualTo: _currentUserId),
      Filter(FireStoreConst.players, arrayContains: _currentUserId),
      Filter(FireStoreConst.teamCreatorIds, arrayContains: _currentUserId),
    );

    return _matchCollection
        .where(filter)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(
        snapshot.docs.map((mainDoc) async {
          final match = mainDoc.data();
          final List<MatchTeamModel> teams = await getTeamsList(match.teams);
          return MatchModel(
            id: match.id,
            teams: teams,
            match_type: match.match_type,
            number_of_over: match.number_of_over,
            over_per_bowler: match.over_per_bowler,
            city: match.city,
            players: match.players,
            team_ids: match.team_ids,
            team_creator_ids: match.team_creator_ids,
            ground: match.ground,
            start_time: match.start_time,
            created_by: match.created_by,
            ball_type: match.ball_type,
            pitch_type: match.pitch_type,
            match_status: match.match_status,
            toss_winner_id: match.toss_winner_id,
            toss_decision: match.toss_decision,
            current_playing_team_id: match.current_playing_team_id,
          );
        }).toList(),
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<MatchModel>> getMatchesByTeamId(String teamId) {
    return _matchCollection
        .where(FireStoreConst.teamIds, arrayContains: teamId)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(
        snapshot.docs.map((mainDoc) async {
          final match = mainDoc.data();

          final List<MatchTeamModel> teams = await getTeamsList(match.teams);
          return MatchModel(
            id: match.id,
            teams: teams,
            match_type: match.match_type,
            number_of_over: match.number_of_over,
            over_per_bowler: match.over_per_bowler,
            city: match.city,
            players: match.players,
            team_ids: match.team_ids,
            team_creator_ids: match.team_creator_ids,
            ground: match.ground,
            start_time: match.start_time,
            created_by: match.created_by,
            ball_type: match.ball_type,
            pitch_type: match.pitch_type,
            match_status: match.match_status,
            toss_winner_id: match.toss_winner_id,
            toss_decision: match.toss_decision,
            current_playing_team_id: match.current_playing_team_id,
          );
        }).toList(),
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<MatchModel>> getRunningMatches() {
    return _matchCollection
        .where(FireStoreConst.matchStatus, isEqualTo: MatchStatus.running.value)
        .snapshots()
        .asyncMap((snapshot) async {
      final List<MatchModel> matches = [];
      for (final mainDoc in snapshot.docs) {
        if (mainDoc.data().match_status == MatchStatus.running) {
          final match = mainDoc.data();

          final List<MatchTeamModel> teams = await getTeamsList(match.teams);
          matches.add(
            MatchModel(
              id: match.id,
              teams: teams,
              match_type: match.match_type,
              number_of_over: match.number_of_over,
              over_per_bowler: match.over_per_bowler,
              players: match.players,
              team_ids: match.team_ids,
              team_creator_ids: match.team_creator_ids,
              city: match.city,
              ground: match.ground,
              start_time: match.start_time,
              created_by: match.created_by,
              ball_type: match.ball_type,
              pitch_type: match.pitch_type,
              match_status: match.match_status,
              toss_winner_id: match.toss_winner_id,
              toss_decision: match.toss_decision,
              current_playing_team_id: match.current_playing_team_id,
            ),
          );
        }
      }
      return matches;
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<MatchModel> getMatchStreamById(String id) {
    return _matchCollection.doc(id).snapshots().asyncMap((snapshot) async {
      final match = snapshot.data();
      if (match == null) {
        return MatchModel(
          teams: [],
          match_type: MatchType.limitedOvers,
          number_of_over: 0,
          over_per_bowler: 0,
          city: '',
          ground: '',
          start_time: DateTime.now(),
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
        referee = await _userService.getUserById(match.referee_id!);
      }

      return MatchModel(
        id: match.id,
        teams: teams,
        match_type: match.match_type,
        number_of_over: match.number_of_over,
        over_per_bowler: match.over_per_bowler,
        players: match.players,
        team_ids: match.team_ids,
        team_creator_ids: match.team_creator_ids,
        city: match.city,
        ground: match.ground,
        start_time: match.start_time,
        created_by: match.created_by,
        ball_type: match.ball_type,
        pitch_type: match.pitch_type,
        match_status: match.match_status,
        commentators: commentators,
        referee: referee,
        scorers: scorers,
        umpires: umpires,
        power_play_overs1: match.power_play_overs1 ?? [],
        power_play_overs2: match.power_play_overs2 ?? [],
        power_play_overs3: match.power_play_overs3 ?? [],
        toss_decision: match.toss_decision,
        toss_winner_id: match.toss_winner_id,
        current_playing_team_id: match.current_playing_team_id,
      );
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Future<MatchModel> getMatchById(String id) async {
    try {
      final snapshot = await _matchCollection.doc(id).get();

      final match = snapshot.data();
      if (match == null) {
        return MatchModel(
          teams: [],
          match_type: MatchType.limitedOvers,
          number_of_over: 0,
          over_per_bowler: 0,
          city: '',
          ground: '',
          start_time: DateTime.now(),
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
        referee = await _userService.getUserById(match.referee_id!);
      }

      final matchModel = MatchModel(
        id: match.id,
        teams: teams,
        match_type: match.match_type,
        number_of_over: match.number_of_over,
        over_per_bowler: match.over_per_bowler,
        players: match.players,
        team_ids: match.team_ids,
        team_creator_ids: match.team_creator_ids,
        city: match.city,
        ground: match.ground,
        start_time: match.start_time,
        created_by: match.created_by,
        ball_type: match.ball_type,
        pitch_type: match.pitch_type,
        match_status: match.match_status,
        commentators: commentators,
        referee: referee,
        scorers: scorers,
        umpires: umpires,
        power_play_overs1: match.power_play_overs1 ?? [],
        power_play_overs2: match.power_play_overs2 ?? [],
        power_play_overs3: match.power_play_overs3 ?? [],
        toss_decision: match.toss_decision,
        toss_winner_id: match.toss_winner_id,
        current_playing_team_id: match.current_playing_team_id,
      );

      return matchModel;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<String> updateMatch(AddEditMatchRequest match) async {
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
    List<MatchPlayerRequest>? updatedMatchPlayer,
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

      await matchRef.update({FireStoreConst.currentPlayingTeamId: teamId});
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateTeamsSquad(
    String matchId,
    AddMatchTeamRequest teamRequest,
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
          {FireStoreConst.teams: updatedTeams.map((e) => e.toJson())},
        );
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
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
    List<AddMatchTeamRequest> teamList,
  ) async {
    try {
      final List<MatchTeamModel> teams = [];

      await Future.forEach(teamList, (e) async {
        final TeamModel team = await _teamService.getTeamById(e.team_id);
        final List<MatchPlayer> squad =
            await getPlayerListFromPlayerIds(e.squad);
        teams.add(
          MatchTeamModel(
            team: team,
            squad: squad,
            over: e.over,
            run: e.run,
            wicket: e.wicket,
            captain_id: e.captain_id,
            admin_id: e.admin_id,
          ),
        );
      });

      return teams;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<MatchPlayer>> getPlayerListFromPlayerIds(
    List<MatchPlayerRequest> players,
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
        );
      }).toList();

      return squad;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
