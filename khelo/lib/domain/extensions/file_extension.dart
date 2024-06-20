import 'dart:io';

extension FileExtension on File {
  Future<bool> isFileUnderMaxSize() async {
    try {
      const maxAllowedSizeInBytes = 25 * 1024 * 1024;
      final sizeInBytes = await length();
      return sizeInBytes <= maxAllowedSizeInBytes;
    } catch (e) {
      rethrow;
    }
  }
}
