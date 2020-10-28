import 'package:firebase_auth/firebase_auth.dart';

//Singleton user class
class UserM {
  static final UserM _userM = UserM._internal();

//default with user credentials and data map
  factory UserM({UserCredential user,Map<String,dynamic> data}) {
    _userM.userCredential = user;
    _userM.userCustomData = data;
    return _userM;
  }

//set constructor for uid
  factory UserM.setUID({String uid}) {
    _userM.uid = uid;
    return _userM;
  }

//constructor for get userM
  factory UserM.get() {
    return _userM;
  }

  UserM._internal();

  //properties
  String uid;
  UserCredential userCredential;
  var userCustomData = new Map<String,dynamic>();
}
