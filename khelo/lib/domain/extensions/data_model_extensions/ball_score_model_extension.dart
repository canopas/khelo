import 'package:data/api/ball_score/ball_score_model.dart';

extension BallScoreModelBoolean on BallScoreModel? {
  bool? isLegalDelivery() {
    if (this == null) {
      return null;
    }
    return this!.extras_type != ExtrasType.penaltyRun &&
        this!.extras_type != ExtrasType.noBall &&
        this!.extras_type != ExtrasType.wide &&
        this!.wicket_type != WicketType.timedOut &&
        this!.wicket_type != WicketType.retired &&
        this!.wicket_type != WicketType.retiredHurt;
  }
}

extension BallScoreModelList on List<BallScoreModel> {
  List<List<BallScoreModel>> chunkArrayByOver() {
    var groupedMap = groupBy(this, (BallScoreModel bs) => bs.over_number);

    var myChunkedList = groupedMap.values.map((list) {
      list.sort((a, b) {
        if (a.ball_number != b.ball_number) {
          return a.ball_number.compareTo(b.ball_number);
        } else {
          return a.time.compareTo(b.time);
        }
      });
      return list;
    }).toList();

    myChunkedList
        .sort((a, b) => a.first.over_number.compareTo(b.first.over_number));

    return myChunkedList;
  }

  Map<K, List<V>> groupBy<K, V>(List<V> list, K Function(V) getKey) {
    Map<K, List<V>> map = {};
    for (var element in list) {
      K key = getKey(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map;
  }
}