import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataSevice{
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getCompData(String uID) async {
    return await _firestore
        .collection('ComDatabase')
        .doc(uID)
        .get()
        .then(((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        //print('Document data: ${documentSnapshot.data()}');
        return documentSnapshot;
      } else {
        print('Document does not exist on the database');
        return null;
      }
    }));
  }

  Future<DocumentSnapshot> getPregData(String uID) async {
    return await _firestore
        .collection('PreDatabase')
        .doc(uID)
        .get()
        .then(((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        //print('Document data: ${documentSnapshot.data()}');
        return documentSnapshot;
      } else {
        print('Document does not exist on the database');
        return null;
      }
    }));
  }


}