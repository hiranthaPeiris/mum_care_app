import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:mun_care_app/services/NotificationService.dart';
import 'package:mun_care_app/models/Notification.model.dart';

enum CLINICSTATE { active, done, cancle, rescheduled }
enum CLINICCONFM { accept, deny }

class ClinicService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NotificationService _notificationService = NotificationService();

  Future<void> saveClinics(String desc, String dateTime, String midUID) async {
    //get list of mothers assigned for midwife
    QuerySnapshot query = await getMotherList(midUID);

    //user list for midwife
    List<DocumentReference> userList = List();

    //user clinic list for ref
    List<DocumentReference> userClinicRefList = List();

    CollectionReference midwifeVisit =
        _firestore.collection('Bookings').doc(midUID).collection('Clinics');

    NotificationM notification = NotificationM("New Clinic assigned", desc,
        dateTime, "doc.id", new DateTime.now(), "clinic","New Clinic");

    await Future.forEach(query.docs, (doc) async {
      userList.add(_firestore.collection('users').doc(doc.id));
      CollectionReference clinic =
          _firestore.collection("Bookings").doc(doc.id).collection('Clinics');

      DocumentReference docRef = await clinic.add({
        'description': desc,
        'dateTime': dateTime,
        'status': "active",
        'confirmation': 'pending'
      }).then((docRef) {
        return docRef;
      }).catchError((err) => print(err));

      print("clinic added $docRef");
      userClinicRefList.add(docRef);
    });

    if (userClinicRefList.isNotEmpty) {
      await midwifeVisit.add({
        'description': desc,
        'dateTime': dateTime,
        'status': "active",
        'count': 0,
        'users': userList,
        'userClinicRef': userClinicRefList
      }).then((docRef) async {
        //adding reference data of clinics userRef <--> clinicRef
        CollectionReference clinicRef = _firestore.collection('ClinicRef');
        print(userClinicRefList);
        await clinicRef.add({
          'midwifeClinicRef': docRef,
          'userClinicRef': userClinicRefList
        }).then((value) {
          print("references added $value");
        }).catchError((err) => print(err));
      }).catchError((err) => print(err));
    } else {
      print("list empty");
    }

    Response rst = await _notificationService.sendMessageTopic(
        notification.getMap(), "midwife1");
    print(rst.body);
  }

//Done by only midwife
  Future<QuerySnapshot> getMotherList(String midUID) async {
    return await _firestore
        .collection('users')
        .where('midwifeID', isEqualTo: midUID)
        .where("competencyFam", isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      return querySnapshot;
    });
  }

//Clinic status update by midwife
  Future<void> updateStatus(String midUID, String docID, CLINICSTATE status,
      List<DocumentReference> userClinicRefList, String remarks) async {
    //docID - midwife's clinic record id

    WriteBatch batch = _firestore.batch();
    DocumentReference midwifeClinic = _firestore
        .collection("Bookings")
        .doc(midUID)
        .collection('Clinics')
        .doc(docID);

    //updating Midwifes clinic recrod
    switch (status) {
      case CLINICSTATE.active:
        //batch.update(clinic, {'status': "active"});
        batch.update(midwifeClinic, {'status': "active"});
        break;
      case CLINICSTATE.cancle:
        //batch.update(clinic, {'status': "active"});
        batch.update(midwifeClinic, {'status': "cancle"});
        break;
      case CLINICSTATE.done:
        //batch.update(clinic, {'status': "active"});
        batch.update(midwifeClinic, {'status': "done"});
        break;
      default:
    }

    //updating each mothers clinic recrod
    userClinicRefList.forEach((docRef) {
      print(docRef);
      switch (status) {
        case CLINICSTATE.active:
          batch.update(docRef, {'status': "active"});
          //batch.update(midwifeClinic, {'status': "active"});
          break;
        case CLINICSTATE.cancle:
          batch.update(docRef, {'status': "cancle"});
          //batch.update(midwifeClinic, {'status': "active"});
          break;
        case CLINICSTATE.done:
          batch.update(docRef, {'status': "done"});
          //batch.update(midwifeClinic, {'status': "active"});
          break;
        default:
      }
    });

    await batch.commit().then((value) => print("Status updated to $status"));
  }

  //clinic reshcedule
  Future<dynamic> clinicReschedule(String midUID, String docID, String desc,
      String dateTime, List<DocumentReference> userClinicRefList) async {
    //docID - midwife's clinic record id

    WriteBatch batch = _firestore.batch();
    DocumentReference midwifeClinic = _firestore
        .collection("Bookings")
        .doc(midUID)
        .collection('Clinics')
        .doc(docID);

    //updating Midwifes clinic recrod
    batch.update(midwifeClinic, {
      'description': desc,
      'dateTime': dateTime,
      'status': "reschedule",
    });

    //updating each mothers clinic recrod
    userClinicRefList.forEach((docRef) {
      batch.update(docRef, {
        'description': desc,
        'dateTime': dateTime,
        'status': "reschedule",
      });
    });

    return await batch.commit().then((value) => print("Reschedule Done"));
  }

  //increase or decreace clinic count - trigger by user(mother)
  Future<int> changeConfirmation(
      String uID, CLINICCONFM confm, DocumentReference userClinicRef) async {
    QueryDocumentSnapshot doc = await _firestore
        .collection('ClinicRef')
        .where('userClinicRef', arrayContains: userClinicRef)
        .limit(1)
        .get()
        .then(((QuerySnapshot querySnapshot) {
      return querySnapshot.docs[0];
    })).catchError((err) => print(err));

    DocumentReference midwifeClinicRef = doc['midwifeClinicRef'];
    print(doc.data());
    print(midwifeClinicRef);

    return _firestore.runTransaction((transaction) async {
      // Get the document
      DocumentSnapshot snapshot = await transaction.get(midwifeClinicRef);

      if (!snapshot.exists) {
        throw Exception("midwife record does not exist!");
      }
      int newCount;
      if (confm == CLINICCONFM.accept) {
        // Update the follower count based on the current count
        newCount = snapshot.data()['count'] + 1;

        // Perform an update on the document
        transaction.update(midwifeClinicRef, {'count': newCount});
      } else {
        // Update the follower count based on the current count
        newCount = snapshot.data()['count'] - 1;

        // Perform an update on the document
        transaction.update(midwifeClinicRef, {'count': newCount});
      }
      // Return the new count
      return newCount;
    }).then((value) {
      print("count updated to $value");
      String conf = confm.toString();
      userClinicRef.update({'confirmation': conf}).then(
          (value) => print("confirmation changed to $conf"));
    }).catchError((error) => print("Failed to update user followers: $error"));
  }
}
