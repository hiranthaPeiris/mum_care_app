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
