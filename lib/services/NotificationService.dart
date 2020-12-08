import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mun_care_app/helpers/MessageStream.dart';
import 'package:mun_care_app/models/Notification.model.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/services/NavigationService.dart';
import 'package:uuid/uuid.dart';
import '../Locator.dart';
import 'package:http/http.dart' as http;

var uuid = Uuid();

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  MessageStream _messageStream = MessageStream.instance;
  UserM _userM = new UserM.get();

  StreamSubscription iosSubscription;

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
        _messageStream.addMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        store(message);
        _messageStream.addMessage(message);
      },
    );
  }

  Future<dynamic> subscribeTopic(String topicpro) async {
    return await _firebaseMessaging.subscribeToTopic("midwife1");
  }

  Future<List<NotificationM>> getNotifications() async {
    String uid = _userM.uid;
    List<NotificationM> notifications = [
      new NotificationM("Test header1", "test Content 1", "test topic date",
          "test topic ref", new DateTime(2000), "clinic")
    ];
    await _firestore
        .collection('notifications')
        .doc(uid)
        .collection('received')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.size > 0) {
        querySnapshot.docs.forEach((doc) {
          notifications.add(new NotificationM(
              doc['title'],
              doc['body'],
              doc['topicDate'],
              doc['topicRef'],
              new DateTime.now(),
              doc['type']));
          print(doc["createdAt"]);
        });
        print(notifications.length);
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
        'topicDate': notification['topicDate'],
        'topicRef': notification['topicRef'],
        'type':notification['type'],
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }

  final String serverToken =
      'AAAAqFEjYNg:APA91bE5WjAxNlmJyboK8iIQD8WCDRqleMfOQhBOuJJ0hHLe_cDGO__Qh0Q-bTnJt-JKd2MXIP71kGXCs1EWGqdIEGxkCaaonhlItDWiUhuaW7b3_MHkl_zj9yq0k1rQ4xRUwO-xucLf';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<void> sendAndRetrieveMessage(
      Map<String, dynamic> data, String token) async {
    // await firebaseMessaging.requestNotificationPermissions(
    //   const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    // );
    print(data['title']);
    return await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': data['title'],
            'title': data['body']
          },
          'priority': 'high',
          'data': data,
          'to': '$token',
        },
      ),
    );

    // final Completer<Map<String, dynamic>> completer =
    //    Completer<Map<String, dynamic>>();

    // firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     completer.complete(message);
    //   },
    // );

    //return completer.future;
  }

  Future<dynamic> sendMessageTopic(
      Map<String, dynamic> data, String topic) async {
    // await firebaseMessaging.requestNotificationPermissions(
    //   const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    // );
    print(data['title']);
    return await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': data['title'],
            'title': data['body']
          },
          'priority': 'high',
          'data': data,
          'topic': '$topic',
        },
      ),
    );

    // final Completer<Map<String, dynamic>> completer =
    //    Completer<Map<String, dynamic>>();

    // firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     completer.complete(message);
    //   },
    // );

    //return completer.future;
  }

  void _NavigateToNotification(Map<String, dynamic> message) {
    _navigationService.navigateTo('/notification');
  }
}
