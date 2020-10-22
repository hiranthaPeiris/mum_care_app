import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mun_care_app/helpers/DataHolder.dart';
import 'package:mun_care_app/models/UserM.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  UserM _userFromFirebase(User user) {
    return user != null ? UserM(user.uid) : null;
  }

  //auth change user stream
  Stream<UserM> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebase);
  }

  //sign in anaon
  Future signAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email pass
  Future signIn(String email,String pass) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return _userFromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return null;
      }
      }catch (e) {
        print(e.toString());
        return null;
    }
  }
  void setUid () async{
       _auth.authStateChanges()
        .listen((User user) async{
      if (user == null) {
        print('User is currently signed out!');

      } else {
        print('User is signed in!');
        // Get the token for this device

        String uid = user.uid;
        DataHolder.uid = uid;
        String fcmToken = await _firebaseMessaging.getToken();

        // Save it to Firestore
        if (fcmToken != null) {
          var tokens = _firestore
              .collection('users')
              .doc(uid)
              .collection('tokens')
              .doc(fcmToken);

          await tokens.set({
            'token': fcmToken,
            'createdAt': FieldValue.serverTimestamp(), // optional
            'platform': Platform.operatingSystem // optional
          });
        }
      }
    });
  }

  //sign out
  Future SignOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //register
  Future Register(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential.user.uid);
      return (_userFromFirebase(userCredential.user));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
