import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

enum HOMEVISITSTATE { active, done, cancle, rescheduled }
enum HOMEVISITCONFM { accept, deny }
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final dateTimeNow = DateTime.now();
class HomeVisitService {
  Future<void> addHomeVisit(
      String desc, DateTime dateTime, TimeOfDay time, String uid, String midwifeID) async {
    CollectionReference homeVisit = _firestore.collection('HomeVisits');
    DocumentReference userDocRef = _firestore.collection('users').doc(uid);

    String dateTimeSlug = getDateSlug(dateTime,time);
    // CollectionReference midwifeVisit = _firestore
    //     .collection('Bookings')
    //     .doc(midwifeID)
    //     .collection('HomeVisits');

    // DocumentReference userDocRef = _firestore.collection('users').doc(uid);
    // //data for midwife's home visit collection
    // String midDocID = await midwifeVisit.add({
    //   'description': desc,
    //   'dateTime': dateTime,
    //   'status': "pending",
    //   'confirmation': 'pending',
    //   'userDocRef': userDocRef
    // }).then((value) {
    //   return value.id;
    // });
    //data for user's home visit collection
    await homeVisit
        .add({
          'description': desc,
          'remarks':"",
          'dateTime': dateTimeSlug,
          'scheduleData':dateTimeNow.format(DateTimeFormats.american).toString(),
          'day':dateTime.day,
          'month':dateTime.month,
          'year':dateTime.year,
          'status': "active",
          'confirmation': 'pending',
          'midwifeID': midwifeID,
          'userID':uid,
          'userDocRef': userDocRef
        })
        .then((value) => print("home visit added $value"))
        .catchError((err) => print(err));
  }

  Future<void> chageStatus(HOMEVISITSTATE state, String uid, String docID,
      String midDocID, String midwifeID) async {
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
    await batch
        .commit()
        .then((value) => print("updated home visit status"))
        .catchError((err) => print(err));
  }

  Future<void> changeConfirmation(HOMEVISITCONFM confm, 
      String docID, String midwifeID) async {
    DocumentReference userDocRef = _firestore
        .collection('HomeVisits')
        .doc(docID);

    //midwife doc
    // DocumentReference midwifeDocRef = _firestore
    //     .collection('Bookings')
    //     .doc(midwifeID)
    //     .collection('HomeVisits')
    //     .doc(midDocID);

    WriteBatch batch = _firestore.batch();

    switch (confm) {
      case HOMEVISITCONFM.accept:
        batch.update(userDocRef, {'confirmation': 'accept'});
        //batch.update(midwifeDocRef, {'confirmation': 'accept'});
        break;
      case HOMEVISITCONFM.deny:
        batch.update(userDocRef, {'confirmation': 'deny'});
        //batch.update(midwifeDocRef, {'confirmation': 'deny'});
        break;

      default:
        print("switch default");
    }
    await batch
        .commit()
        .then((value) => print("updated home visit confm"))
        .catchError((err) => print(err));
  }

  String getDateSlug(DateTime _date, TimeOfDay _time) {
    return DateTimeFormat.format(
        new DateTime(
            _date.year, _date.month, _date.day, _time.hour, _time.minute),
        format: DateTimeFormats.american);
  }
}
