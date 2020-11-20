import 'package:cloud_firestore/cloud_firestore.dart';

enum HOMEVISITSTATE { active, done, cancle, rescheduled }
enum HOMEVISITCONFM {accept,deny}
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class HomeVisitService {
  Future<void> addHomeVisit(
      String desc, String dateTime, String uid, String midwifeID) async {
    try {
      CollectionReference homeVisit =
          _firestore.collection("Bookings").doc(uid).collection('HomeVisits');

      CollectionReference midwifeVisit = _firestore
          .collection('Bookings')
          .doc(midwifeID)
          .collection('HomeVisits');

      DocumentReference userDocRef = _firestore.collection('users').doc(uid);
      //data for user's home visit collection
      await homeVisit.add({
        'description': desc,
        'dateTime': dateTime,
        'status': "pending",
        'confirmation': 'pending'
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
      HOMEVISITSTATE state, String uid, String docID, String midwifeID) async {
    DocumentReference userDocRef = _firestore
        .collection('bookings')
        .doc(uid)
        .collection('HomeVisit')
        .doc(docID);

    //midwife doc
    DocumentReference midwifeDocRef = _firestore
        .collection('bookings')
        .doc(midwifeID)
        .collection("HomeVisit")
        .doc(docID);

    WriteBatch batch = _firestore.batch();

    switch (state) {
      case HOMEVISITSTATE.active:
        batch.update(userDocRef, {'status': 'pending'});
        batch.update(midwifeDocRef, {'status': 'pending'});
        //await userDocRef.set();
        break;
      case HOMEVISITSTATE.done:
        batch.update(userDocRef, {'status': 'done'});
        batch.update(midwifeDocRef, {'status': 'done'});
        break;
      case HOMEVISITSTATE.cancle:
        batch.update(userDocRef, {'status': 'cancle'});
        batch.update(midwifeDocRef, {'status': 'cancle'});
        break;
      case HOMEVISITSTATE.rescheduled:
        batch.update(userDocRef, {'status': 'rescheduled'});
        batch.update(midwifeDocRef, {'status': 'rescheduled'});
        break;
      default:
        print("switch default");
    }
    await batch.commit();
  }

  Future<void> changeConfirmation(HOMEVISITCONFM confm,String uid, String docID, String midwifeID) async {
    DocumentReference userDocRef = _firestore
        .collection('bookings')
        .doc(uid)
        .collection('HomeVisit')
        .doc(docID);

    //midwife doc
    DocumentReference midwifeDocRef = _firestore
        .collection('bookings')
        .doc(midwifeID)
        .collection("HomeVisit")
        .doc(docID);

        WriteBatch batch = _firestore.batch();

    switch (confm) {
      case HOMEVISITCONFM.accept:
        batch.update(userDocRef, {'confirmation': 'accept'});
        batch.update(midwifeDocRef, {'confirmation': 'accept'});
        break;
      case HOMEVISITCONFM.deny:
        batch.update(userDocRef, {'confirmation': 'deny'});
        batch.update(midwifeDocRef, {'confirmation': 'deny'});
        break;
      
      default:
        print("switch default");
    }
    await batch.commit();
  }
}
