import 'package:stream_transform/stream_transform.dart';

Stream<(T1, T2)> combineLatest2<T1, T2>(
  Stream<T1> stream1,
  Stream<T2> stream2,
) {
  return stream1.combineLatest(stream2, (t1, t2) => (t1, t2));
}

Stream<(T1, T2, T3)> combineLatest3<T1, T2, T3>(
  Stream<T1> stream1,
  Stream<T2> stream2,
  Stream<T3> stream3,
) {
  final firstTwo = combineLatest2(stream1, stream2);
  return combineLatest2(firstTwo, stream3)
      .map((tuple) => (tuple.$1.$1, tuple.$1.$2, tuple.$2));
}