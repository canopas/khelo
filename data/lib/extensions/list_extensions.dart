extension ListExtension<E> on List<E> {
  // Update the element at any position; it will return the same list if the element is not found.
  List<E> updateWhere({
    required bool Function(E element) where,
    required E Function(E oldElement) updated,
    E Function()? onNotFound,
  }) {
    final newList = toList();
    final int index = newList.indexWhere(where);
    if (index >= 0) {
      newList[index] = updated(newList[index]);
    } else {
      if (onNotFound != null) {
        newList.add(onNotFound());
      }
    }
    return newList;
  }

  // This converts a list into a list of lists, using the specified size.
  // For example:
  // List<int> numbers = List.generate(100, (index) => index + 1);
  // List<List<int>> result = numbers.chunked(5);
  List<List<E>> chunked(int size) {
    return List.generate((length / size).ceil(), (index) {
      final int start = index * size;
      return sublist(start, start + size < length ? start + size : length);
    });
  }
}
