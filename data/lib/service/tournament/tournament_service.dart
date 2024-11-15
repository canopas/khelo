import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/ball_score/ball_score_model.dart';
import '../../api/match/match_model.dart';
import '../../api/team/team_model.dart';
import '../../api/tournament/tournament_model.dart';
import '../../errors/app_error.dart';
import '../../utils/constant/firestore_constant.dart';
import '../ball_score/ball_score_service.dart';
import '../match/match_service.dart';
import '../team/team_service.dart';
import '../user/user_service.dart';

final tournamentServiceProvider = Provider(
  (ref) => TournamentService(
    FirebaseFirestore.instance,
    ref.read(teamServiceProvider),
    ref.read(matchServiceProvider),
    ref.read(userServiceProvider),
    ref.read(ballScoreServiceProvider),
  ),
);

class TournamentService {
  final FirebaseFirestore _firestore;
  final TeamService _teamService;
  final MatchService _matchService;
  final UserService _userService;
  final BallScoreService _ballScoreService;

  TournamentService(
    this._firestore,
    this._teamService,
    this._matchService,
    this._userService,
    this._ballScoreService,
  );

  CollectionReference<TournamentModel> get _tournamentCollection =>
      _firestore.collection(FireStoreConst.tournamentCollection).withConverter(
            fromFirestore: TournamentModel.fromFireStore,
            toFirestore: (TournamentModel tournament, _) => tournament.toJson(),
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
    var query = _tournamentCollection.orderBy(FireStoreConst.startDate);

    if (lastMatchId != null) {
      query = query.startAfter([lastMatchId]);
    }

    final snapshot = await query.limit(limit).get();

    return Future.wait(
      snapshot.docs.map(
        (e) async {
          final tournament = e.data();
          final matchIds = tournament.match_ids;
          if (matchIds.isNotEmpty) {
            final matches = await _matchService.getMatchesByIds(matchIds);
            final status = getTournamentStatus(matches);
            return tournament.copyWith(matches: matches, status: status);
          }
          return tournament;
        },
      ),
    );
  }

  Future<List<PlayerKeyStat>> getKeyStats(List<MatchModel> matches) async {
    final List<PlayerKeyStat> playerStatsList = [];
    final List<String> matchIds = matches.map((match) => match.id).toList();
    final scores = await _ballScoreService.getBallScoresByMatchIds(matchIds);

    for (final match in matches) {
      for (final team in match.teams) {
        for (final player in team.squad) {
          final stats = scores.calculateUserStats(player.id);

          playerStatsList.add(
            PlayerKeyStat(
              player: player.player,
              teamName: team.team.name,
              stats: stats,
            ),
          );
        }
      }
    }
    final keyStats = playerStatsList.getTopKeyStats();

    return keyStats.where((element) => element.player.isActive).toList();
  }

  Stream<List<TournamentModel>> streamActiveTournaments() {
    final currentDate = DateTime.now();
    final past30DaysDate = currentDate.subtract(Duration(days: 30));

    final filter = Filter.or(
      Filter(FireStoreConst.startDate, isGreaterThan: currentDate),
      Filter(FireStoreConst.endDate, isGreaterThanOrEqualTo: past30DaysDate),
    );

    return _tournamentCollection.where(filter).snapshots().asyncMap(
      (event) async {
        return await Future.wait(
          event.docs.map(
            (e) async {
              final tournament = e.data();
              final matchIds = tournament.match_ids;
              if (matchIds.isNotEmpty) {
                final matches = await _matchService.getMatchesByIds(matchIds);
                final status = getTournamentStatus(matches);
                return tournament.copyWith(matches: matches, status: status);
              }
              return tournament;
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
          tournament = tournament.copyWith(teams: DataClass().teams);
        }

        if (matchIds.isNotEmpty) {
          final matches = await _matchService.getMatchesByIds(matchIds);
          final keyStats = await getKeyStats(DataClass().matches);
          tournament =
              tournament.copyWith(matches: DataClass().matches, keyStats: keyStats);
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

        return tournament;
      }
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
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
  TournamentStatus getTournamentStatus(List<MatchModel> matches) {
    final bool anyRunning =
        matches.any((match) => match.match_status == MatchStatus.running);
    final bool allYetToStart =
        matches.every((match) => match.match_status == MatchStatus.yetToStart);
    final bool allFinishedOrAbandoned = matches.every(
      (match) =>
          match.match_status == MatchStatus.abandoned ||
          match.match_status == MatchStatus.finish,
    );

    if (anyRunning) return TournamentStatus.running;
    if (allYetToStart) return TournamentStatus.upcoming;
    if (allFinishedOrAbandoned) return TournamentStatus.finish;

    return TournamentStatus.finish;
  }
}

class DataClass {
  final List<TeamModel> teams = [
    TeamModel(id: "1", name: "A", name_lowercase: "a"),
    TeamModel(id: "2", name: "B", name_lowercase: "b"),
    TeamModel(id: "3", name: "C", name_lowercase: "c"),
    TeamModel(id: "4", name: "D", name_lowercase: "d"),
    // TeamModel(id: "5", name: "E", name_lowercase: "e"),
    // TeamModel(id: "6", name: "F", name_lowercase: "f"),
    // TeamModel(id: "7", name: "G", name_lowercase: "g"),
    // TeamModel(id: "8", name: "H", name_lowercase: "h"),
    // TeamModel(id: "9", name: "I", name_lowercase: "i"),
    // TeamModel(id: "10", name: "J", name_lowercase: "j"),
    // TeamModel(id: "11", name: "K", name_lowercase: "k"),
    // TeamModel(id: "12", name: "L", name_lowercase: "l"),
    // TeamModel(id: "13", name: "M", name_lowercase: "m"),
    // TeamModel(id: "14", name: "N", name_lowercase: "n"),
    // TeamModel(id: "15", name: "O", name_lowercase: "o"),
    // TeamModel(id: "16", name: "P", name_lowercase: "p"),
    // TeamModel(id: "17", name: "Q", name_lowercase: "q"),
    // TeamModel(id: "18", name: "R", name_lowercase: "r"),
    // TeamModel(id: "19", name: "S", name_lowercase: "s"),
    // TeamModel(id: "20", name: "T", name_lowercase: "t"),
    // TeamModel(id: "21", name: "U", name_lowercase: "u"),
    // TeamModel(id: "22", name: "V", name_lowercase: "v"),
    // TeamModel(id: "23", name: "W", name_lowercase: "w"),
    // TeamModel(id: "24", name: "X", name_lowercase: "x"),
    // TeamModel(id: "25", name: "Y", name_lowercase: "y"),
    // TeamModel(id: "26", name: "Z", name_lowercase: "z"),
  ];

  final MatchModel defaultMatchModel = MatchModel(
    id: "",
    teams: [],
    match_type: MatchType.limitedOvers,
    number_of_over: 4,
    over_per_bowler: 2,
    city: "Surat",
    ground: "Surat",
    ball_type: BallType.leather,
    pitch_type: PitchType.cement,
    created_by: "",
    match_status: MatchStatus.yetToStart,
    match_group: MatchGroup.round,
    match_group_number: 1,
  );
  late List<MatchModel> matches;

  DataClass() {
    matches = [
      defaultMatchModel.copyWith(
        match_group: MatchGroup.round,
        match_group_number: 1,
        teams: [
          MatchTeamModel(
              team_id: teams[0].id,
              team: teams[0],
              over: 2,
              run: 20,
              wicket: 2),
          MatchTeamModel(
              team_id: teams[1].id,
              team: teams[1],
              over: 1.4,
              run: 22,
              wicket: 3)
        ],
        match_status: MatchStatus.finish,
        toss_winner_id: teams[0].id,
        toss_decision: TossDecision.bat,
      ),
      defaultMatchModel.copyWith(
        match_group: MatchGroup.round,
        match_group_number: 1,
        teams: [
          MatchTeamModel(
              team_id: teams[2].id,
              team: teams[2],
              over: 2,
              run: 20,
              wicket: 2),
          MatchTeamModel(
              team_id: teams[3].id,
              team: teams[3],
              over: 1.4,
              run: 22,
              wicket: 3)
        ],
        match_status: MatchStatus.finish,
        toss_winner_id: teams[3].id,
        toss_decision: TossDecision.bat,
      ),
      // defaultMatchModel.copyWith(
      //   match_group: MatchGroup.round,
      //   match_group_number: 1,
      //   teams: [
      //     MatchTeamModel(
      //         team_id: teams[4].id,
      //         team: teams[4],
      //         over: 2,
      //         run: 20,
      //         wicket: 2),
      //     MatchTeamModel(
      //         team_id: teams[5].id,
      //         team: teams[5],
      //         over: 1.4,
      //         run: 22,
      //         wicket: 3)
      //   ],
      //   match_status: MatchStatus.finish,
      //   toss_winner_id: teams[4].id,
      //   toss_decision: TossDecision.bat,
      // ),
    ];
  }
}
