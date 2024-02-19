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
      AddEditMatchRequest match =
          AddEditMatchRequest.fromJson(mainDoc.data() as Map<String, dynamic>);
      List<TeamModel> teams = await getTeamListFromTeamIds(match.team_ids);
      List<MatchPlayer> playersA =
          await getPlayerListFromPlayerIds(match.team_a_players);
      List<MatchPlayer> playersB =
          await getPlayerListFromPlayerIds(match.team_b_players);

      // required data has been provided
      matches.add(MatchModel(
        id: match.id,
        teams: teams,
        team_a_players: playersA,
        team_b_players: playersB,
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

    List<MatchPlayer> playersA =
        await getPlayerListFromPlayerIds(match.team_a_players);
    List<MatchPlayer> playersB =
        await getPlayerListFromPlayerIds(match.team_b_players);

    List<TeamModel> teams = await getTeamListFromTeamIds(match.team_ids);
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
      team_a_players: playersA,
      team_b_players: playersB,
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
      power_play_overs1: match.power_play_overs1,
      power_play_overs2: match.power_play_overs2,
      power_play_overs3: match.power_play_overs3,
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

    final teamAPlayersJson = (matchJson['team_a_players'] as List)
        .map((player) => (player as MatchPlayerRequest).toJson())
        .toList();

    final teamBPlayersJson = (matchJson['team_b_players'] as List)
        .map((player) => (player as MatchPlayerRequest).toJson())
        .toList();

    matchJson['team_a_players'] = teamAPlayersJson;
    matchJson['team_b_players'] = teamBPlayersJson;

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
      'toss_result': tossDecision.value,
    };

    await matchRef.update(tossDetails);
  }

  Future<void> deleteMatch(String matchId) async {
    await _firestore.collection(_collectionName).doc(matchId).delete();
  }

  // Helper Methods
  Future<List<TeamModel>> getTeamListFromTeamIds(List<String> teamIds) async {
    List<TeamModel> teams = [];

    for (final id in teamIds) {
      var teamModel = await _teamService.getTeamById(id);
      teams.add(teamModel);
    }

    return teams;
  }

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

  Future<List<MatchPlayer>> getPlayerListFromPlayerIds(
      List<MatchPlayerRequest> players) async {
    List<MatchPlayer> squad = [];
    for (final player in players) {
      var userModel = await _userService.getUserById(player.id);
      squad.add(MatchPlayer(
          player: userModel,
          status: player.status,
          role: player.role ?? [],
          index: player.index));
    }
    return squad;
  }
}
