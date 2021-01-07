import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mun_care_app/models/MidwifeLeave.dart';

class MidLeaveService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<dynamic> leaveFormAdd(LeaveFormDB leaveData) async {
    //FirebaseAuth _auth = FirebaseAuth.instance;
    DateTime date = DateTime.now();
    String dateConvert = date.year.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.day.toString();

    try {
      return await _firestore
          .collection("MidwifeLeaveforms")
          .add(leaveData.toJson());
    } catch (err) {
      print(err.toString());
      return err;
    }
  }

  Future<void> setAcceptTrue(String id) async {
    await FirebaseFirestore.instance
        .collection('MidwifeLeaveforms')
        .doc(id)
        .update({
          '_accept': true,
        })
        .then((value) => print("Leave Accepted"))
        .catchError((err) => print(err));
  }

  Future<void> setRejectTrue(String id) async {
    await FirebaseFirestore.instance
        .collection('MidwifeLeaveforms')
        .doc(id)
        .update({
          '_reject': true,
        })
        .then((value) => print("Leave Rejected"))
        .catchError((err) => print(err));
  }
}
