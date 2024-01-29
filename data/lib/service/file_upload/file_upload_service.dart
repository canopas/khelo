import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

final fileUploadServiceProvider = Provider(
  (ref) => FileUploadService(FirebaseStorage.instance),
);

class FileUploadService {
  final FirebaseStorage _firebaseStorage;

  FileUploadService(this._firebaseStorage);

  Future<String> uploadProfileImage(String imagePath) async {
    var file = File(imagePath);
    if (await file.exists()) {
      String fileExtension = path.extension(file.path);
      DateTime currentDate = DateTime.now();
      String imgName =
          "IMG_${currentDate.year}${currentDate.month}${currentDate.day}${currentDate.hour}${currentDate.minute}${currentDate.second}${currentDate.millisecond}$fileExtension";
      var snapshot = await _firebaseStorage
          .ref()
          .child('UserProfileImages/$imgName')
          .putFile(file); // TODO: resolve rules of firebase storage and fireStore
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      throw Exception("UploadProfileImage: file doesn't exist");
    }
  }

  Future<void> deleteUploadedProfileImage(String imgUrl) async {
    await _firebaseStorage.refFromURL(imgUrl).delete();
  }
}
