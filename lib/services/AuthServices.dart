import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/services/NotificationService.dart';
import 'package:mun_care_app/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final NotificationService _notification = NotificationService();
  var userInstance = new UserM.get();

  UserM _userFromFirebase(User user) {
    if (user != null) {
      return UserM.setUID(uid: user.uid, user: user);
    }
    return null;
    //return user != null ? UserM.setUID(uid: user.uid,user: user) : null;
  }

  //auth change user stream
  Stream<UserM> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebase);
  }

  // //sign in anaon - not using
  // Future signAnon() async {
  //   try {
  //     UserCredential userCredential = await _auth.signInAnonymously();
  //     User user = userCredential.user;
  //     return _userFromFirebase(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //sign in email pass
  Future<UserM> signIn(String email, String pass) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      Map<String, dynamic> customData =
          await getUserCustomData(userCredential.user.uid);
      await setUserMessageToken();
      new UserM(user: userCredential, data: customData);
      return _userFromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  DocumentReference getUserRef(String uid) {
    return _firestore.collection('users').doc(uid);
  }

  Future<void> setUserMessageToken() async {
    _auth.authStateChanges().listen((User user) async {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        // Get the token for this device

        String uid = user.uid;
        Map<String, dynamic> customData = await getUserCustomData(uid);

        new UserM.setListner(uid: user.uid, user: user, customData: customData);
        //getting firebase message token
        String fcmToken = await _firebaseMessaging.getToken();

        // Save it to Firestore
        if (fcmToken != null) {
          var tokens = _firestore.collection('users').doc(uid);

          await tokens.update({
            'token': fcmToken,
            'timeStamp': FieldValue.serverTimestamp(), // optional
          });
          print("token updated");
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
  Future register(UserModel userModel,String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userModel.email, password: password);
          userModel.uid = userCredential.user.uid;
      await setUserRole(userModel);
      await setUserMessageToken();
      _notification.subscribeTopic("general");
      
      print(userCredential.user.uid);
      return (_userFromFirebase(userCredential.user));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
//register as midwife
// Future<User> registerAsMidwife(String email, String password, String name,String role,String mobNumber) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//       await setUserRole(userModel);
//       await setUserMessageToken();
//       _notification.subscribeTopic("general");
      
//       print(userCredential.user.uid);
//       return userCredential.user;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//set user role
  Future<void> setUserRole(UserModel userModel) async {
    await _firestore
        .collection('users')
        .doc(userModel.uid)
         .set(userModel.toJson())
        //   {
        //   'name': name,
        //   'role': role,
        //   'area01': 'notSelect',
        //   'mohArea': "",
        //   'competencyFam': false,
        //   'PregnanctFam': false,
        //   'compApp': false,
        //   'pregApp': false,
        //   'midwifeID': 'null',
        //   'onDuty': false,
        //   'tel': mobileNum,
        //   'email':email,
        //   'token': "",
        //   'condition':"normal",
        //   'timeStamp': FieldValue.serverTimestamp(),
        //   'nameSearch': getSearchParam(name)
        // })
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
  Future<Map<String, dynamic>> getUserCustomData(String uid) async {
    return await _firestore
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        //print('Document data : ${documentSnapshot.data()}');
        return documentSnapshot.data();
      } else {
        print("user custom document not exists");
        return null;
      }
    });
  }

  //search data creator
  List<String> getSearchParam(String param) {
    List<String> searchList = List();
    String temp = "";
    for (int i = 0; i < param.length; i++) {
      temp = temp + param[i];
      searchList.add(temp);
    }
    return searchList;
  }

  Future<List<String>> getMyAssigns(String uid) async {
    List<String> mumIds = List();
    await _firestore
        .collection('users')
        .where('midwifeID', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.id);
        mumIds.add(element.id);
      });
    }).catchError((onError) => print(onError));
    return mumIds;
  }
}
