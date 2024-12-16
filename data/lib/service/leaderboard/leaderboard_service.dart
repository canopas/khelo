import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/leaderboard/leaderboard_model.dart';
import '../../errors/app_error.dart';
import '../../extensions/date_extension.dart';
import '../../utils/combine_latest.dart';
import '../../utils/constant/firestore_constant.dart';
import '../user/user_service.dart';

final leaderboardServiceProvider = Provider(
  (ref) => LeaderboardService(
    FirebaseFirestore.instance,
    ref.read(userServiceProvider),
  ),
);

class LeaderboardService {
  final FirebaseFirestore _firestore;
  final UserService _userService;

  LeaderboardService(
    this._firestore,
    this._userService,
  );

  CollectionReference<LeaderboardPlayer> _leaderboardCollection(
    LeaderboardType type,
  ) =>
      _firestore
          .collection(FireStoreConst.leaderboardCollection)
          .doc(type.getDatabaseConst())
          .collection(FireStoreConst.dataCollection)
          .withConverter(
            fromFirestore: LeaderboardPlayer.fromFireStore,
            toFirestore: (LeaderboardPlayer leaderboard, _) =>
                leaderboard.toJson(),
          );

  Stream<List<LeaderboardPlayer>> streamLeaderboardByField({
    LeaderboardType type = LeaderboardType.allTime,
    int limit = 20,
    LeaderboardField field = LeaderboardField.batting,
  }) {
    var query = _leaderboardCollection(type)
        .orderBy(field.getDatabaseConst(), descending: true)
        .where(field.getDatabaseConst(), isGreaterThan: 0);

    if (type == LeaderboardType.weekly || type == LeaderboardType.monthly) {
      final now = DateTime.now();
      final startTime = type == LeaderboardType.weekly
          ? now.getStartOfWeek
          : now.getStartOfMonth;
      final endTime =
          type == LeaderboardType.weekly ? now.getEndOfWeek : now.getEndOfMonth;

      final timeFilter = Filter.and(
        Filter(FireStoreConst.date, isGreaterThanOrEqualTo: startTime),
        Filter(FireStoreConst.date, isLessThanOrEqualTo: endTime),
      );

      query = query.where(timeFilter);
    }

    query = query.limit(limit);
    return query.snapshots().asyncMap((snapshot) async {
      final docs = snapshot.docs.map((e) => e.data()).toList();
      final players =
          await _userService.getUsersByIds(docs.map((e) => e.id).toList());
      return docs.map((e) {
        final player = players.firstWhere((element) => element.id == e.id);
        return e.copyWith(user: player);
      }).toList();
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<LeaderboardModel>> streamLeaderboard({
    LeaderboardType type = LeaderboardType.allTime,
    int limit = 20,
  }) {
    return combineLatest3(
      streamLeaderboardByField(
        type: type,
        limit: limit,
        field: LeaderboardField.batting,
      ),
      streamLeaderboardByField(
        type: type,
        limit: limit,
        field: LeaderboardField.bowling,
      ),
      streamLeaderboardByField(
        type: type,
        limit: limit,
        field: LeaderboardField.fielding,
      ),
    ).map(
      (event) {
        final List<LeaderboardModel> leaderboard = [];
        if (event.$1.isNotEmpty) {
          leaderboard.add(
            LeaderboardModel(
              type: LeaderboardField.batting,
              players: event.$1,
            ),
          );
        }
        if (event.$2.isNotEmpty) {
          leaderboard.add(
            LeaderboardModel(
              type: LeaderboardField.bowling,
              players: event.$2,
            ),
          );
        }
        if (event.$3.isNotEmpty) {
          leaderboard.add(
            LeaderboardModel(
              type: LeaderboardField.fielding,
              players: event.$3,
            ),
          );
        }
        return leaderboard;
      },
    ).handleError((error, stack) => throw AppError.fromError(error, stack));
  }
}
