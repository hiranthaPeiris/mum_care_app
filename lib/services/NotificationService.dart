import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mun_care_app/helpers/MessageStream.dart';
import 'package:mun_care_app/models/Notification.model.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/services/NavigationService.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../Locator.dart';

var uuid = Uuid();

class NotificationService {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  MessageStream _messageStream = MessageStream.instance;
  UserM _userM = new UserM.get();

  StreamSubscription iosSubscription;
  final String serverToken =
      "AAAAqFEjYNg:APA91bE5WjAxNlmJyboK8iIQD8WCDRqleMfOQhBOuJJ0hHLe_cDGO__Qh0Q-bTnJt-JKd2MXIP71kGXCs1EWGqdIEGxkCaaonhlItDWiUhuaW7b3_MHkl_zj9yq0k1rQ4xRUwO-xucLf";

  Future InitalizeMessaging() async {
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        print(new UserM.get().uid);
        store(message);
        _messageStream.addMessage(message);
      },
     onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        store(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        store(message);
      },
    );
  }

  Future<List<NotificationM>> getNotifications() async {
    String uid = _userM.uid;
    List<NotificationM> notifications = [
      new NotificationM("Test header1", "test Content 1", new DateTime(2000))
    ];
    await _firestore
        .collection('notifications')
        .doc(uid)
        .collection('received')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.size > 0) {
        querySnapshot.docs.forEach((doc) {
          notifications.add(
              new NotificationM(doc['title'], doc['body'], new DateTime.now()));
          //print(doc["createdAt"]);
        });
        //print(notifications.length);
      }
    });
    return notifications;
  }

  void store(Map<String, dynamic> message) async {
    final notification = message['data'];
    var user = new UserM.get();
    String keyVal = uuid.v1();
    // Save it to Firestore
    if (notification != null) {
      var notifi = _firestore
          .collection('notifications')
          .doc(user.uid)
          .collection("received")
          .doc(keyVal);

      await notifi.set({
        'title': notification['title'],
        'body': notification['body'],
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }
/*
  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': await _firebaseMessaging.getToken(),
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async =>
          completer.complete(message),
    );
    return completer.future;
  }
*/
  void _NavigateToNotification(Map<String, dynamic> message) {
    _navigationService.navigateTo('/notification');
  }
}
