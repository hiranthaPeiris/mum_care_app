import 'package:firebase_auth/firebase_auth.dart';
import 'package:mun_care_app/models/UserM.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  //sign out
  Future SignOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
