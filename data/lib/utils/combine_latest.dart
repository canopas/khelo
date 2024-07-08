import 'package:stream_transform/stream_transform.dart';

Stream<(T1, T2)> combineLatest2<T1, T2>(
  Stream<T1> stream1,
  Stream<T2> stream2,
) {
  return stream1.combineLatest(stream2, (t1, t2) => (t1, t2));
}