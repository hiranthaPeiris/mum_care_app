import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:mun_care_app/models/NoticeModel.dart';
import 'package:mun_care_app/models/Notification.model.dart';
import 'package:mun_care_app/screens/SpecialNotice/SendNotice.dart';
import 'package:mun_care_app/services/NotificationService.dart';
import 'package:mun_care_app/services/UserDataService.dart';

class NoticeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NotificationService _notification = NotificationService();
  final dateTimeNow = DateTime.now();
  final UserDataSevice _userDataService = UserDataSevice();

  Future<dynamic> sendNotice(NoticeModel noticeModel) async {
    DocumentReference ref = await _firestore
        .collection("Notice")
        .add(noticeModel.toJson())
        .then((value) {
      return value;
    }).catchError((err) {
      print(err);
      return null;
    });
    
    if(ref!=null){
      Response response =  await sendNotification(noticeModel, ref);
      print(response);
    }
    return ref;  
  }

  Future<Response> sendNotification(
      NoticeModel noticeModel, DocumentReference ref) async {
    NotificationM notification = NotificationM(
        "Special Notice",
        noticeModel.description,
        "dateTime",
        ref.toString(),
        new DateTime.now(),
        "notice",
        noticeModel.title);
    List<String> tokenList = new List<String>();

    switch (noticeModel.audiance) {
      case "NoticeAudiance.General":
        Response rst = await _notification.sendMessageTopic(
            notification.getMap(), "general");
        return rst;
        break;
      case "NoticeAudiance.Midwife":
        Response rst = await _notification.sendMessageTopic(
            notification.getMap(), noticeModel.midwifeID);
        return rst;
        break;
      case "NoticeAudiance.Eligible":
        List<QueryDocumentSnapshot> userList =
            await _userDataService.getMyCompFams(noticeModel.midwifeID);

        tokenList = userList.map((doc) => doc['token'].toString()).toList();

        Response rst = await _notification.sendMessageToList(
            notification.getMap(), tokenList);
        return rst;
        break;
      case "NoticeAudiance.Pregnancy":
        List<QueryDocumentSnapshot> userList =
            await _userDataService.getMyPregMums(noticeModel.midwifeID);
        tokenList = userList.map((doc) => doc['token'].toString()).toList();

        Response rst = await _notification.sendMessageToList(
            notification.getMap(), tokenList);
        return rst;
        break;
      default:
        print("def");
        return null;
    }
  }
}
