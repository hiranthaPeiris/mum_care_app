import 'package:cloud_firestore/cloud_firestore.dart';

enum HOMEVISITSTATE { pending, done, rescheduled }
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class HomeVisitService {
  Future<void> addHomeVisit(
      String desc, String dateTime, String uid, String midwifeID) async {
    // HomeShedule she1 = HomeShedule(
    //     description: description.text,
    //     dateTime: _
    //     mothername: montherval);
    try {
      var homeVisit = _firestore
          .collection("Bookings")
          .doc(uid)
          .collection('HomeVisits');

      var midwifeVisit = _firestore
          .collection('Bookings')
          .doc(midwifeID)
          .collection('HomeVisits');
          
      var userDocRef = _firestore.collection('users').doc(uid);
      //data for user's home visit collection
      await homeVisit.add({
        'description': desc,
        'dateTime': dateTime,
        'status': "pending",
        'confirmation':'pending'
      });
      //data for midwife's home visit collection
      await midwifeVisit.add({
        'description': desc,
        'dateTime': dateTime,
        'status': "pending",
        'confirmation': 'pending',
        'userDocRef': userDocRef
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> chageStatus(
      HOMEVISITSTATE state, String uid, String docID) async {
    var userDocRef = _firestore
        .collection('bookings')
        .doc(uid)
        .collection('HomeVisit')
        .doc(docID);
    //var midwifeDocRef = _firestore.collection(collectionPath)
    WriteBatch batch = _firestore.batch();

    switch (state) {
      case HOMEVISITSTATE.pending:
        batch.set(userDocRef, {'status': 'pending'});
        //await userDocRef.set();
        break;
      case HOMEVISITSTATE.done:
        await userDocRef.set({'status': 'done'});
        break;
      case HOMEVISITSTATE.rescheduled:
        await userDocRef.set({'status': 'done'});
        break;
      default:
        print("switch default");
    }
  }

  Future<void> changeConfirmation() async {}
}
