import 'dart:io';
import 'package:data/errors/app_error.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

final fileUploadServiceProvider = Provider(
  (ref) => FileUploadService(FirebaseStorage.instance),
);

class FileUploadService {
  final FirebaseStorage _firebaseStorage;

  FileUploadService(this._firebaseStorage);

  Future<String> uploadProfileImage(
    String imagePath,
    ImageUploadType type,
  ) async {
    var file = File(imagePath);
    if (await file.exists()) {
      try {
        String fileExtension = path.extension(file.path);
        DateTime currentDate = DateTime.now();
        String imgName =
            "IMG_${currentDate.year}${currentDate.month}${currentDate.day}${currentDate.hour}${currentDate.minute}${currentDate.second}${currentDate.millisecond}$fileExtension";
        var snapshot = await _firebaseStorage
            .ref()
            .child('${type.value}/$imgName')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } catch (error) {
        throw AppError.fromError(error);
      }
    } else {
      throw Exception("uploadProfileImage: file doesn't exist.");
    }
  }

  Future<void> deleteUploadedImage(String imgUrl) async {
    try {
      await _firebaseStorage.refFromURL(imgUrl).delete();
    } catch (error) {
      throw AppError.fromError(error);
    }
  }
}

enum ImageUploadType {
  user('UserProfileImages'),
  team('TeamProfileImages');

  const ImageUploadType(this.value);

  final String value;
}
