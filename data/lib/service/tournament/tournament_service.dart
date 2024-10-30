import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/ball_score/ball_score_model.dart';
import '../../api/match/match_model.dart';
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
          type: TournamentType.other,
          start_date: DateTime.now(),
          end_date: DateTime.now().add(const Duration(days: 1)),
        );
      } else {
        var tournament = snapshot.data()!;
        final teamIds = tournament.team_ids;
        final matchIds = tournament.match_ids;

        if (teamIds.isNotEmpty) {
          final teams = await _teamService.getTeamsByIds(teamIds);
          tournament = tournament.copyWith(teams: teams);
        }

        if (matchIds.isNotEmpty) {
          final matches = await _matchService.getMatchesByIds(matchIds);
          final keyStats = await getKeyStats(matches);
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

        return tournament;
      }
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
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
    final keyStats = playerStatsList.getTopKeyStats()
      ..sort((a, b) => b.value?.compareTo(a.value ?? 0) ?? 0);

    return keyStats.where((element) => element.player.isActive).toList();
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

  Future<void> updateMatchIds(
    String tournamentId,
    List<String> matchIds,
  ) async {
    try {
      await _tournamentCollection
          .doc(tournamentId)
          .update({FireStoreConst.matchIds: matchIds});
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
}
