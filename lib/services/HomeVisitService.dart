import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> addBook(String desc, String dateTime, String uid) async {
  // HomeShedule she1 = HomeShedule(
  //     description: description.text,
  //     dateTime: _
  //     mothername: montherval);
  try {
    var homeVisit = _firestore
        .collection("Bookings")
        .doc(uid)
        .collection('HomeVisits');

    await homeVisit.add({'description': desc, 'dateTime': dateTime});
  } catch (e) {
    print(e.toString());
  }
}