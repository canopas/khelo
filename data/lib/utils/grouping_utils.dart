import 'package:collection/collection.dart';

/// Generic function to group a list by two fields.
Map<K1, Map<K2, List<T>>> groupByTwoFields<T, K1, K2>(
  List<T> items, {
  required K1 Function(T item) primaryGroupByKey,
  required K2 Function(T item) secondaryGroupByKey,
}) {
  // Group items by the primary key
  final primaryGroupedItems = groupBy(items, primaryGroupByKey);

  // For each primary group, further group by the secondary key
  final result = <K1, Map<K2, List<T>>>{};
  primaryGroupedItems.forEach((primaryKey, primaryGroup) {
    result[primaryKey] = groupBy(primaryGroup, secondaryGroupByKey);
  });

  return result;
}
