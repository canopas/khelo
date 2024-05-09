import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/service/user/user_service.dart';
import 'package:data/utils/constant/firestore_constant.dart';
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

  MatchService(
    this._firestore,
    this._teamService,
    this._userService,
    this._currentUserId,
  );

  Future<List<MatchModel>> getMatches() async {
    try {
      CollectionReference matchCollection =
          _firestore.collection(FireStoreConst.matchesCollection);

      QuerySnapshot mainCollectionSnapshot = await matchCollection.get();
      List<MatchModel> matches = [];

      for (QueryDocumentSnapshot mainDoc in mainCollectionSnapshot.docs) {
        Map<String, dynamic> mainDocData =
            mainDoc.data() as Map<String, dynamic>;
        AddEditMatchRequest match = AddEditMatchRequest.fromJson(mainDocData);

        List<MatchTeamModel> teams = await getTeamsList(match.teams);
        matches.add(MatchModel(
          id: match.id,
          teams: teams,
          match_type: match.match_type,
          number_of_over: match.number_of_over,
          over_per_bowler: match.over_per_bowler,
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
        ));
      }

      return matches;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<List<MatchModel>> getCurrentUserPlayedMatches() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }

    StreamController<List<MatchModel>> controller =
        StreamController<List<MatchModel>>();

    _firestore.collection(FireStoreConst.matchesCollection).snapshots().listen(
        (QuerySnapshot<Map<String, dynamic>> snapshot) async {
      List<MatchModel> matches = [];
      try {
        for (QueryDocumentSnapshot mainDoc in snapshot.docs) {
          Map<String, dynamic> mainDocData =
              mainDoc.data() as Map<String, dynamic>;
          AddEditMatchRequest match = AddEditMatchRequest.fromJson(mainDocData);
          if (match.teams
                  .map((e) => e.squad.map((e) => e.id).contains(_currentUserId))
                  .contains(true) &&
              match.match_status == MatchStatus.finish) {
            List<MatchTeamModel> teams = await getTeamsList(match.teams);
            matches.add(MatchModel(
              id: match.id,
              teams: teams,
              match_type: match.match_type,
              number_of_over: match.number_of_over,
              over_per_bowler: match.over_per_bowler,
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
            ));
          }
        }
        controller.add(matches);
      } catch (error, stack) {
        controller.addError(AppError.fromError(error, stack));
        controller.close();
      }
    }, onError: (error, stack) {
      controller.addError(AppError.fromError(error, stack));
      controller.close();
    });

    return controller.stream;
  }

  Stream<List<MatchModel>> getCurrentUserRelatedMatches() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }

    StreamController<List<MatchModel>> controller =
        StreamController<List<MatchModel>>();

    _firestore.collection(FireStoreConst.matchesCollection).snapshots().listen(
        (QuerySnapshot<Map<String, dynamic>> snapshot) async {
      List<MatchModel> matches = [];

      try {
        for (QueryDocumentSnapshot mainDoc in snapshot.docs) {
          Map<String, dynamic> mainDocData =
              mainDoc.data() as Map<String, dynamic>;
          AddEditMatchRequest match = AddEditMatchRequest.fromJson(mainDocData);
          List<MatchTeamModel> teams = await getTeamsList(match.teams);
          if (teams.any((team) =>
              team.team.players
                  ?.map((player) => player.id)
                  .contains(_currentUserId) ??
              false || team.team.created_by == _currentUserId)) {
            matches.add(MatchModel(
              id: match.id,
              teams: teams,
              match_type: match.match_type,
              number_of_over: match.number_of_over,
              over_per_bowler: match.over_per_bowler,
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
            ));
          }
        }
        controller.add(matches);
      } catch (error, stack) {
        controller.addError(AppError.fromError(error, stack));
        controller.close();
      }
    }, onError: (error, stack) {
      controller.addError(AppError.fromError(error, stack));
      controller.close();
    });

    return controller.stream;
  }

  Future<List<MatchModel>> getMatchesByTeamId(String teamId) async {
    try {
      CollectionReference matchCollection =
          _firestore.collection(FireStoreConst.matchesCollection);

      QuerySnapshot mainCollectionSnapshot = await matchCollection.get();

      List<MatchModel> matches = [];

      for (QueryDocumentSnapshot mainDoc in mainCollectionSnapshot.docs) {
        Map<String, dynamic> mainDocData =
            mainDoc.data() as Map<String, dynamic>;
        AddEditMatchRequest match = AddEditMatchRequest.fromJson(mainDocData);
        if (match.teams.map((e) => e.team_id).contains(teamId)) {
          List<MatchTeamModel> teams = await getTeamsList(match.teams);
          matches.add(MatchModel(
            id: match.id,
            teams: teams,
            match_type: match.match_type,
            number_of_over: match.number_of_over,
            over_per_bowler: match.over_per_bowler,
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
          ));
        }
      }

      return matches;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<List<MatchModel>> getRunningMatches() {
    StreamController<List<MatchModel>> controller =
        StreamController<List<MatchModel>>();

    _firestore
        .collection(FireStoreConst.matchesCollection)
        .where(FireStoreConst.matchStatus, isEqualTo: 2)
        .snapshots()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) async {
      List<MatchModel> matches = [];
      try {
        for (QueryDocumentSnapshot mainDoc in snapshot.docs) {
          Map<String, dynamic> mainDocData =
              mainDoc.data() as Map<String, dynamic>;
          if (mainDocData[FireStoreConst.matchStatus] == 2) {
            AddEditMatchRequest match =
                AddEditMatchRequest.fromJson(mainDocData);

            List<MatchTeamModel> teams = await getTeamsList(match.teams);
            matches.add(MatchModel(
              id: match.id,
              teams: teams,
              match_type: match.match_type,
              number_of_over: match.number_of_over,
              over_per_bowler: match.over_per_bowler,
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
            ));
          }
        }
        controller.add(matches);
      } catch (error, stack) {
        controller.addError(AppError.fromError(error, stack));
        controller.close();
      }
    }, onError: (error, stack) {
      controller.addError(AppError.fromError(error, stack));
      controller.close();
    });

    return controller.stream;
  }

  Stream<MatchModel> getMatchStreamById(String id) {
    StreamController<MatchModel> controller = StreamController<MatchModel>();
    StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? subscription;
    subscription = _firestore
        .collection(FireStoreConst.matchesCollection)
        .doc(id)
        .snapshots()
        .listen((DocumentSnapshot<Map<String, dynamic>> snapshot) async {
      if (snapshot.exists) {
        try {
          AddEditMatchRequest match = AddEditMatchRequest.fromJson(
              snapshot.data() as Map<String, dynamic>);

          List<MatchTeamModel> teams = await getTeamsList(match.teams);
          List<UserModel>? umpires =
              await getUserListFromUserIds(match.umpire_ids);
          List<UserModel>? commentators =
              await getUserListFromUserIds(match.commentator_ids);
          List<UserModel>? scorers =
              await getUserListFromUserIds(match.scorer_ids);

          UserModel? referee;
          if (match.referee_id != null) {
            referee = await _userService.getUserById(match.referee_id!);
          }

          var matchModel = MatchModel(
            id: match.id,
            teams: teams,
            match_type: match.match_type,
            number_of_over: match.number_of_over,
            over_per_bowler: match.over_per_bowler,
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

          controller.add(matchModel);
        } catch (error, stack) {
          controller.addError(AppError.fromError(error, stack));
          controller.close();
          subscription?.cancel();
        }
      } else {
        controller.close();
        subscription?.cancel();
      }
    }, onError: (error, stack) {
      controller.addError(AppError.fromError(error, stack));
      controller.close();
      subscription?.cancel();
    });

    return controller.stream;
  }

  Future<MatchModel> getMatchById(String id) async {
    try {
      DocumentReference matchRef =
          _firestore.collection(FireStoreConst.matchesCollection).doc(id);
      DocumentSnapshot snapshot = await matchRef.get();

      AddEditMatchRequest match =
          AddEditMatchRequest.fromJson(snapshot.data() as Map<String, dynamic>);

      List<MatchTeamModel> teams = await getTeamsList(match.teams);
      List<UserModel>? umpires = await getUserListFromUserIds(match.umpire_ids);
      List<UserModel>? commentators =
          await getUserListFromUserIds(match.commentator_ids);
      List<UserModel>? scorers = await getUserListFromUserIds(match.scorer_ids);

      UserModel? referee;
      if (match.referee_id != null) {
        referee = await _userService.getUserById(match.referee_id!);
      }

      var matchModel = MatchModel(
        id: match.id,
        teams: teams,
        match_type: match.match_type,
        number_of_over: match.number_of_over,
        over_per_bowler: match.over_per_bowler,
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
      DocumentReference matchRef =
          _firestore.collection(FireStoreConst.matchesCollection).doc(match.id);
      WriteBatch batch = _firestore.batch();

      Map<String, dynamic> matchJson = match.toJson();

      final teamsJson = (matchJson[FireStoreConst.teams] as List).map((team) {
        final teamRequest = (team as AddMatchTeamRequest).toJson();
        final squadJson = (team)
            .squad
            .map((playerRequest) => playerRequest.toJson())
            .toList();
        teamRequest[FireStoreConst.squad] = squadJson;

        return teamRequest;
      }).toList();

      matchJson[FireStoreConst.teams] = teamsJson;

      batch.set(matchRef, matchJson, SetOptions(merge: true));
      String newMatchId = matchRef.id;

      if (match.id == null) {
        batch.update(matchRef, {FireStoreConst.id: newMatchId});
      }

      await batch.commit();
      return newMatchId;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateTossDetails(String matchId, String tossWinnerId,
      TossDecision tossDecision, String currentPlayingTeam) async {
    try {
      DocumentReference matchRef =
          _firestore.collection(FireStoreConst.matchesCollection).doc(matchId);

      Map<String, dynamic> tossDetails = {
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
      DocumentReference matchRef =
          _firestore.collection(FireStoreConst.matchesCollection).doc(matchId);

      Map<String, dynamic> matchStatus = {
        FireStoreConst.matchStatus: status.value,
      };

      await matchRef.update(matchStatus);
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateTeamScore({
    required String matchId,
    required String battingTeamId,
    required int totalRun,
    required double over,
    required String bowlingTeamId,
    required int wicket,
    int? runs,
  }) async {
    try {
      DocumentReference matchRef =
          _firestore.collection(FireStoreConst.matchesCollection).doc(matchId);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(matchRef);

        List<Map<String, dynamic>> existingTeams =
            List<Map<String, dynamic>>.from(
                snapshot.get(FireStoreConst.teams) ?? []);

        int battingTeamIndex = existingTeams
            .indexWhere((team) => team[FireStoreConst.teamId] == battingTeamId);
        int bowlingTeamIndex = existingTeams
            .indexWhere((team) => team[FireStoreConst.teamId] == bowlingTeamId);

        if (battingTeamIndex != -1 && bowlingTeamIndex != -1) {
          existingTeams[battingTeamIndex][FireStoreConst.run] = totalRun;
          existingTeams[battingTeamIndex][FireStoreConst.over] = over;
          existingTeams[bowlingTeamIndex][FireStoreConst.wicket] = wicket;
          if (runs != null) {
            existingTeams[bowlingTeamIndex][FireStoreConst.run] = runs;
          }
        }

        transaction.update(matchRef, {FireStoreConst.teams: existingTeams});
      });
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
      DocumentReference matchRef =
          _firestore.collection(FireStoreConst.matchesCollection).doc(matchId);

      DocumentSnapshot snapshot = await transaction.get(matchRef);

      List<Map<String, dynamic>> existingTeams =
          List<Map<String, dynamic>>.from(
              snapshot.get(FireStoreConst.teams) ?? []);

      int battingTeamIndex = existingTeams
          .indexWhere((team) => team[FireStoreConst.teamId] == battingTeamId);
      int bowlingTeamIndex = existingTeams
          .indexWhere((team) => team[FireStoreConst.teamId] == bowlingTeamId);

      if (battingTeamIndex != -1 && bowlingTeamIndex != -1) {
        if (updatedMatchPlayer != null) {
          List<Map<String, dynamic>> updatedSquad =
              List<Map<String, dynamic>>.from(
                  existingTeams[battingTeamIndex][FireStoreConst.squad] ?? []);

          for (final matchPlayer in updatedMatchPlayer) {
            int existingPlayerIndex = updatedSquad.indexWhere(
                (player) => player[FireStoreConst.id] == matchPlayer.id);
            if (existingPlayerIndex != -1) {
              updatedSquad[existingPlayerIndex] = matchPlayer.toJson();
            } else {
              updatedSquad.add(matchPlayer.toJson());
            }
          }
          existingTeams[battingTeamIndex][FireStoreConst.squad] = updatedSquad;
        }

        existingTeams[battingTeamIndex][FireStoreConst.run] = totalRun;
        if (runs != null) {
          existingTeams[battingTeamIndex][FireStoreConst.over] = over;
        }
        existingTeams[bowlingTeamIndex][FireStoreConst.wicket] = wicket;
        if (runs != null) {
          existingTeams[bowlingTeamIndex][FireStoreConst.run] = runs;
        }
      }

      transaction.update(matchRef, {FireStoreConst.teams: existingTeams});
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateCurrentPlayingTeam(
      {required String matchId, required String teamId}) async {
    try {
      DocumentReference matchRef =
          _firestore.collection(FireStoreConst.matchesCollection).doc(matchId);

      await matchRef.update({FireStoreConst.currentPlayingTeamId: teamId});
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateTeamsSquad(
      String matchId, AddMatchTeamRequest teamRequest) async {
    try {
      DocumentReference matchRef =
          _firestore.collection(FireStoreConst.matchesCollection).doc(matchId);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(matchRef);

        List<Map<String, dynamic>> existingTeams =
            List<Map<String, dynamic>>.from(
                snapshot.get(FireStoreConst.teams) ?? []);

        int teamIndex = existingTeams.indexWhere(
            (team) => team[FireStoreConst.teamId] == teamRequest.team_id);

        if (teamIndex != -1) {
          List<Map<String, dynamic>> updatedSquad =
              List<Map<String, dynamic>>.from(
                  existingTeams[teamIndex][FireStoreConst.squad] ?? []);

          for (var updatedPlayer in teamRequest.squad) {
            int existingPlayerIndex = updatedSquad.indexWhere(
                (player) => player[FireStoreConst.id] == updatedPlayer.id);
            if (existingPlayerIndex != -1) {
              updatedSquad[existingPlayerIndex] = updatedPlayer.toJson();
            } else {
              updatedSquad.add(updatedPlayer.toJson());
            }
          }

          existingTeams[teamIndex][FireStoreConst.squad] = updatedSquad;
        }

        transaction.update(matchRef, {FireStoreConst.teams: existingTeams});
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> deleteMatch(String matchId) async {
    try {
      await _firestore
          .collection(FireStoreConst.matchesCollection)
          .doc(matchId)
          .delete();
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
      List<UserModel> users = await _userService.getUsersByIds(userIds);
      return users;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<MatchTeamModel>> getTeamsList(
      List<AddMatchTeamRequest> teamList) async {
    try {
      List<MatchTeamModel> teams = [];

      await Future.forEach(teamList, (e) async {
        TeamModel team = await _teamService.getTeamById(e.team_id);
        List<MatchPlayer> squad = await getPlayerListFromPlayerIds(e.squad);
        teams.add(MatchTeamModel(
          team: team,
          squad: squad,
          over: e.over,
          run: e.run,
          wicket: e.wicket,
          captain_id: e.captain_id,
          admin_id: e.admin_id,
        ));
      });

      return teams;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<MatchPlayer>> getPlayerListFromPlayerIds(
      List<MatchPlayerRequest> players) async {
    try {
      List<String> playerIds = players.map((player) => player.id).toList();

      List<UserModel> users = await _userService.getUsersByIds(playerIds);

      List<MatchPlayer> squad = users.map((user) {
        final matchPlayer =
            players.firstWhere((element) => element.id == user.id);

        return MatchPlayer(
          player: user,
          status: matchPlayer.status,
          index: matchPlayer.index,
        );
      }).toList();

      return squad;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
