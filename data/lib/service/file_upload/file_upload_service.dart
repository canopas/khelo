import 'dart:io';
import '../../errors/app_error.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fileUploadServiceProvider = Provider(
  (ref) => FileUploadService(FirebaseStorage.instance),
);

class FileUploadService {
  final FirebaseStorage _firebaseStorage;

  FileUploadService(this._firebaseStorage);

  Future<String> uploadProfileImage({
    required String filePath,
    required String uploadPath,
  }) async {
    final file = File(filePath);
    if (await file.exists()) {
      try {
        final snapshot =
            await _firebaseStorage.ref().child(uploadPath).putFile(file);
        final downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } catch (error, stack) {
        throw AppError.fromError(error, stack);
      }
    } else {
      throw Exception("uploadProfileImage: file doesn't exist.");
    }
  }

  Future<void> deleteUploadedImage(String imgUrl) async {
    try {
      await _firebaseStorage.refFromURL(imgUrl).delete();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
