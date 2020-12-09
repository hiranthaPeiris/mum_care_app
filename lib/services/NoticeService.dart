import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mun_care_app/models/NoticeModel.dart';

class NoticeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final dateTimeNow = DateTime.now();

  Future<dynamic> sendNotice(NoticeModel noticeModel) async {
    return await _firestore
        .collection("Notice")
        .add(noticeModel.toJson())
        .then((value) => print(value))
        .catchError((err) {
      print(err);
    });
  }
}
