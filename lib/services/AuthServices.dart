import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mun_care_app/models/UserM.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  UserM _userFromFirebase(User user) {
    return user != null ? UserM.setUID(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserM> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebase);
  }

  //sign in anaon - not using
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
  Future signIn(String email, String pass) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      var userRole = await getUserRole(userCredential.user.uid);

      new UserM(user: userCredential, data: userRole);
      return _userFromFirebase(userCredential.user);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> setUserMessageToken() async {
    _auth.authStateChanges().listen((User user) async {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        // Get the token for this device

        String uid = user.uid;
        new UserM.setUID(uid:user.uid);
        //getting firebase message token
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
        } else {
          print("firebase message token null");
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
      await setUserMessageToken();
      await setUserRole(userCredential.user.uid);

      print(userCredential.user.uid);
      return (_userFromFirebase(userCredential.user));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//set user role
  Future<void> setUserRole(String uid) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .set({'role': 'user'})
        .then((value) => print("user role added"))
        .catchError((err) => print(err));
  }

  //set user midwife
  Future<void> setUserMidwife(String uid) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .set({'role': 'midwife'})
        .then((value) => print("user role midwife added added"))
        .catchError((err) => print(err));
  }

  //get user role
  Future<Map<String, dynamic>> getUserRole(String uid) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data : ${documentSnapshot.data()}');
        return documentSnapshot.data();
      } else {
        print("document not exists");
        return null;
      }
    });
  }
}
