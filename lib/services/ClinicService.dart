import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getMotherList(String midUID) async {
    return await _firestore
        .collection('users')
        .where('midwifeID', isEqualTo: midUID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      return querySnapshot;
    });
  }

  Future<void> SaveClinic(String desc, String dateTime, String midUID) async {
    QuerySnapshot query = await getMotherList(midUID);
    query.docs.forEach((doc) async {
      try {
        var clinic =
            _firestore.collection("Bookings").doc(doc.id).collection('Clinics');

        var midwifeVisit = _firestore
            .collection('Bookings')
            .doc(midUID)
            .collection('Clinics');

        await clinic.add({
          'description': desc,
          'dateTime': dateTime,
          'status': "pending",
          'confirmation': 'pending'
        });
      } catch (err) {
        print(err);
      }
    });
  }
}
