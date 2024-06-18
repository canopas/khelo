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

  // String URL extensions
  String get attachmentName => split('/').last;

  String get attachmentExtension => split('.').last;

  AttachmentsType get attachmentType {
    final ext = attachmentExtension.toLowerCase();
    if (ext == 'jpg' || ext == 'jpeg' || ext == 'png') {
      return AttachmentsType.image;
    } else if (ext == 'txt') {
      return AttachmentsType.text;
    } else if (ext == 'pdf') {
      return AttachmentsType.pdf;
    } else if (ext == 'gif') {
      return AttachmentsType.gif;
    } else if (ext == 'mp3' || ext == 'aac' || ext == 'wav' || ext == 'm4a') {
      return AttachmentsType.audio;
    } else if (ext == 'mp4' || ext == 'mov' || ext == 'webm' || ext == 'mkv') {
      return AttachmentsType.video;
    }
    return AttachmentsType.other;
  }
}

enum AttachmentsType {
  image,
  video,
  gif,
  audio,
  pdf,
  text,
  other;

  bool get isImage => this == image;

  bool get isVideo => this == video;

  bool get isGif => this == gif;

  bool get isAudio => this == audio;

  bool get isPdf => this == pdf;

  bool get isText => this == text;

  bool get isOther => this == other;
}
