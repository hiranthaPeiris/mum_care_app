import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<dynamic> uploadProfileImage(File _image, String uid,String folder) async {

    firebase_storage.Reference ref = storage.ref('$folder/').child(uid);

    try {
      firebase_storage.UploadTask task = ref.putFile(_image);
      firebase_storage.TaskSnapshot snapshot = await task;
      print('Uploaded ${snapshot.bytesTransferred} bytes.');
    } on FirebaseException catch (e) {
      print(e);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
      return e;
    }
  }

  Future<String> downloadProfileImage(String folder, String uid) async {
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // File downloadToFile = File('${appDocDir.path}/mum-profile.png');
    String url;
    try {
      url = await storage.ref('$folder/').child(uid).getDownloadURL();
      print(url);
      //firebase_storage.TaskSnapshot snapshot = await task;
      //print('Uploaded ${snapshot.bytesTransferred} bytes.');
      return url;
    } on FirebaseException catch (e) {
      print("error now:  $e");

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
      return null;
    }
  }
}
