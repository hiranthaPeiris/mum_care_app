import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataSevice {
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

  Future<List<QueryDocumentSnapshot>> getMyPregMums(String midwifeID) async {
    return await _firestore
        .collection('users')
        .where("midwifeID", isEqualTo: midwifeID)
        .where("PregnanctFam", isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length > 0) {
        return querySnapshot.docs;
      }
    }).catchError((err) {
      print(err);
      return null;
    });
  }

  Future<List<QueryDocumentSnapshot>> getMyCompFams(String midwifeID) async {
    return await _firestore
        .collection('users')
        .where("midwifeID", isEqualTo: midwifeID)
        .where("competencyFam", isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length > 0) {
        return querySnapshot.docs;
      }
    }).catchError((err) {
      print(err);
      return null;
    });
  }

  Future<String> getMyMidwife(String mohArea) async {
    return await _firestore
        .collection('users')
        .where('mohArea', isEqualTo: mohArea)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length > 0) {
        return querySnapshot.docs[0].id;
      }
    }).catchError((err) {
      print(err);
      return null;
    });
  }
}
