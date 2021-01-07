import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mun_care_app/models/MediModel.dart';

class MedicalReportService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Future<dynamic> inserting(MediData medi,String uid) async {
    DateTime date = DateTime.now();
    String dateConvert = date.year.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.day.toString();
    DocumentReference userDocRef =
        _firestore.collection('users').doc(uid);

    return await FirebaseFirestore.instance
        .collection("informMedical")
        .add(medi.toJson())
        .then((value) => print("record added"))
        .catchError((err) {
      return err;
    });
  }
}