import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mun_care_app/helpers/DataHolder.dart';
import 'package:mun_care_app/models/message.dart';
import 'package:mun_care_app/screens/Notification/NotificationScreen.dart';
import 'package:mun_care_app/services/NavigationService.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../Locator.dart';

var uuid = Uuid();


class NotificationService {
  final DataHolder _dataHolder = DataHolder();
  //final List<Message> message = [];
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription iosSubscription;
  final String serverToken =
      'AAAAqFEjYNg:APA91bGuprJ-teFPTKWvikO-2Fu98F1Ka0_7iBQmHRZT3bglGISOws_Iz1Hd0qyp6mEwxMRZoSjvg6HBDJH9l6GPd1VUZT7PL4muVH4Y7sofFbmVe0D9_UnS1kSP_GYloIiXFktKl6T_';

  Future InitalizeMessaging() async {
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        print(DataHolder.uid);
        store(DataHolder.uid, message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        store(DataHolder.uid, message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        store(DataHolder.uid, message);
      },
    );
  }

  void store(String uid, Map<String, dynamic> message) async {
    final notification = message['data'];
    String keyVal = uuid.v1();
    // Save it to Firestore
    if (notification != null) {
      var notifi = _firestore
          .collection('notifications')
          .doc(uid).collection("received").doc(keyVal);

      await notifi.set({
        'title': notification['title'],
        'body': notification['body'],
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }


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
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;
  }

  void _NavigateToNotification(Map<String, dynamic> message) {
    _navigationService.navigateTo('/notification');
  }
}
