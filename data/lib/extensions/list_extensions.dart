extension ListExtension<E> on List<E> {
  ///Update the element at any position; it will return the same list if the element is not found.
  List<E> updateWhere({
    required bool Function(E element) where,
    required E Function(E oldElement) updated,
  }) {
    final newList = toList();
    final int index = newList.indexWhere(where);
    if (index >= 0) {
      newList[index] = updated(newList[index]);
    }
    return newList;
  }
}