import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageService {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadFile(String uid, String imagePath) async {
    StorageReference storageReference =
        _firebaseStorage.ref().child('reports/$uid/${basename(imagePath)}');
    StorageUploadTask uploadTask = storageReference.putFile(File(imagePath));
    uploadTask.events.listen((data) {
      print(data.snapshot.bytesTransferred);
    });
    return await storageReference.getPath();
  }

  Future<File> downloadImage(String imageRef) async {
    final filepath =
        join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
    final StorageReference storageReference =
        _firebaseStorage.ref().child(imageRef);
    StorageFileDownloadTask fileDownloadTask =
        storageReference.writeToFile(File(filepath));
    await fileDownloadTask.future;
    return File(filepath);
  }

  Future<String> uploadAvatar(String uid, String imagePath) async {
    StorageReference storageReference =
        _firebaseStorage.ref().child('avatars/$uid/avatar.png');
    StorageUploadTask uploadTask = storageReference.putFile(File(imagePath));
    uploadTask.events.listen((data) {
      print(data.snapshot.bytesTransferred);
    });
    return await storageReference.getPath();
  }

  Future<String> getDownloadURL(String imageRef) async {
    return await _firebaseStorage.ref().child(imageRef).getDownloadURL();
  }

  Future<void> deleteImage(String imageRef) async {
    return await _firebaseStorage.ref().child(imageRef).delete();
  }
}
