extension EmailValidator on String {
  bool isValidEmail() {
    // TODO: wrong result in case of 'special!chars@email.com'
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  String initials({int? limit}) {
    List<String> words = trim().split(RegExp(r'\s+'));
    String result = words.map((word) => word.isNotEmpty ? word[0] : '').join();
    result = result.toUpperCase();

    // If limit is not null, apply the limit; otherwise, return all initials
    if (limit != null) {
      return result.substring(0, limit.clamp(0, result.length));
    } else {
      return result;
    }
  }
}
