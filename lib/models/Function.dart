
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> dutyChecking() async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser.uid)
        .update({'onDuty': true})
        .then((value) => print('duty is available'))
        .catchError((err) => print(err));
  }

  Future<void> noDutyChecking() async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser.uid)
        .update({'onDuty': false})
        .then((value) => print('duty is not available'))
        .catchError((err) => print(err));
  }