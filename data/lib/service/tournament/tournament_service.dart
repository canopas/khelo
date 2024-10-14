import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/tournament/tournament_model.dart';
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
          tournament = tournament.copyWith(matches: matches);
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
}
