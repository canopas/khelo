import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/service/user/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final matchServiceProvider = Provider((ref) {
  final service = MatchService(
    FirebaseFirestore.instance,
    ref.read(teamServiceProvider),
    ref.read(userServiceProvider),
  );
  return service;
});

class MatchService {
  final FirebaseFirestore _firestore;
  final TeamService _teamService;
  final UserService _userService;
  final String _collectionName = 'matches';

  MatchService(this._firestore, this._teamService, this._userService);

  Future<List<MatchModel>> getMatches() async {
    CollectionReference matchCollection =
        _firestore.collection(_collectionName);

    QuerySnapshot mainCollectionSnapshot = await matchCollection.get();
    List<MatchModel> matches = [];

    for (QueryDocumentSnapshot mainDoc in mainCollectionSnapshot.docs) {
      Map<String, dynamic> mainDocData = mainDoc.data() as Map<String, dynamic>;
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
        ball_type: match.ball_type,
        pitch_type: match.pitch_type,
        match_status: match.match_status,
        toss_winner_id: match.toss_winner_id,
        toss_decision: match.toss_decision,
      ));
    }

    return matches;
  }

  Future<MatchModel> getMatchById(String id) async {
    DocumentReference matchRef = _firestore.collection(_collectionName).doc(id);
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
    );

    return matchModel;
  }

  Future<String> updateMatch(AddEditMatchRequest match) async {
    DocumentReference matchRef =
        _firestore.collection(_collectionName).doc(match.id);
    WriteBatch batch = _firestore.batch();

    Map<String, dynamic> matchJson = match.toJson();

    final teamsJson = (matchJson['teams'] as List).map((team) {
      final teamRequest = (team as AddMatchTeamRequest).toJson();
      final squadJson =
          (team).squad.map((playerRequest) => playerRequest.toJson()).toList();
      teamRequest['squad'] = squadJson;

      return teamRequest;
    }).toList();

    matchJson['teams'] = teamsJson;

    batch.set(matchRef, matchJson, SetOptions(merge: true));
    String newMatchId = matchRef.id;

    if (match.id == null) {
      batch.update(matchRef, {'id': newMatchId});
    }

    await batch.commit();
    return newMatchId;
  }

  Future<void> updateTossDetails(
      String matchId, String tossWinnerId, TossDecision tossDecision) async {
    DocumentReference matchRef =
        _firestore.collection(_collectionName).doc(matchId);

    Map<String, dynamic> tossDetails = {
      'toss_winner_id': tossWinnerId,
      'toss_decision': tossDecision.value,
    };

    await matchRef.update(tossDetails);
  }

  Future<void> updateMatchStatus(String matchId, MatchStatus status) async {
    DocumentReference matchRef =
        _firestore.collection(_collectionName).doc(matchId);

    Map<String, dynamic> matchStatus = {
      'match_status': status.value,
    };

    await matchRef.update(matchStatus);
  }

  Future<void> updateTeamsSquad(
      String matchId, AddMatchTeamRequest teamRequest) async {
    DocumentReference matchRef =
        _firestore.collection(_collectionName).doc(matchId);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(matchRef);

      List<Map<String, dynamic>> existingTeams =
          List<Map<String, dynamic>>.from(snapshot.get('teams') ?? []);

      int teamIndex = existingTeams
          .indexWhere((team) => team['team_id'] == teamRequest.team_id);

      if (teamIndex != -1) {
        List<Map<String, dynamic>> updatedSquad =
            List<Map<String, dynamic>>.from(
                existingTeams[teamIndex]['squad'] ?? []);

        for (var updatedPlayer in teamRequest.squad) {
          int existingPlayerIndex = updatedSquad
              .indexWhere((player) => player['id'] == updatedPlayer.id);
          if (existingPlayerIndex != -1) {
            updatedSquad[existingPlayerIndex] = updatedPlayer.toJson();
          } else {
            updatedSquad.add(updatedPlayer.toJson());
          }
        }

        existingTeams[teamIndex]['squad'] = updatedSquad;
      }

      transaction.update(matchRef, {'teams': existingTeams});
    });
  }

  Future<void> deleteMatch(String matchId) async {
    await _firestore.collection(_collectionName).doc(matchId).delete();
  }

  // Helper Methods
  Future<List<UserModel>?> getUserListFromUserIds(List<String>? userIds) async {
    if (userIds == null) {
      return null;
    }
    List<UserModel> users = [];
    for (final id in userIds) {
      var userModel = await _userService.getUserById(id);
      users.add(userModel);
    }
    return users;
  }

  Future<List<MatchTeamModel>> getTeamsList(
      List<AddMatchTeamRequest> teamList) async {
    List<MatchTeamModel> teams = [];

    await Future.forEach(teamList, (e) async {
      TeamModel team = await _teamService.getTeamById(e.team_id);
      List<MatchPlayer> squad = await getPlayerListFromPlayerIds(e.squad);
      teams.add(MatchTeamModel(
          team: team,
          squad: squad,
          captain_id: e.captain_id,
          admin_id: e.admin_id));
    });

    return teams;
  }

  Future<List<MatchPlayer>> getPlayerListFromPlayerIds(
      List<MatchPlayerRequest> players) async {
    List<MatchPlayer> squad = [];
    for (final player in players) {
      var userModel = await _userService.getUserById(player.id);
      squad.add(MatchPlayer(
          player: userModel, status: player.status, index: player.index));
    }
    return squad;
  }
}
