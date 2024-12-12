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

Stream<(T1, T2, T3, T4)> combineLatest4<T1, T2, T3, T4>(
    Stream<T1> stream1,
    Stream<T2> stream2,
    Stream<T3> stream3,
    Stream<T4> stream4,
    ) {
  final firstThree = combineLatest3(stream1, stream2, stream3);
  return combineLatest2(firstThree, stream4)
      .map((tuple) => (tuple.$1.$1, tuple.$1.$2, tuple.$1.$3, tuple.$2));
}

Stream<(T1, T2, T3, T4, T5)> combineLatest5<T1, T2, T3, T4, T5>(
    Stream<T1> stream1,
    Stream<T2> stream2,
    Stream<T3> stream3,
    Stream<T4> stream4,
    Stream<T5> stream5,
    ) {
  final firstFour = combineLatest4(stream1, stream2, stream3, stream4);
  return combineLatest2(firstFour, stream5).map(
        (tuple) => (tuple.$1.$1, tuple.$1.$2, tuple.$1.$3, tuple.$1.$4, tuple.$2),
  );
}