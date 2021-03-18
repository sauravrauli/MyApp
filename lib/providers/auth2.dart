import 'package:firebase_auth/firebase_auth.dart';
import 'package:myhealthapp/helpers/database.dart';
import 'package:myhealthapp/models/user.dart';

class AuthService {
  final FirebaseAuth _auth =
      FirebaseAuth.instance; //create instance of firebase authentication.

//create user obj based on firebaseuser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

//auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

//sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      if (user.isEmailVerified) return user.uid;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and pass
  Future registerWithEmailAndPassword(
    String email,
    String password,
    String firstName,
    String lastName,
    String dateOfBirth,
    String phoneNo,
  ) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await user.sendEmailVerification();

      //create new document for user with the uid. (dont add to this uid) - MANUALLY HARD CODES THIS DURING SIGNUP
      // await DBService(uid: user.uid).updateCommentData(
      //   firstName,
      //   lastName,
      //   'comment', //**THIS IS WHERE COMMENT WILL BE ADDED.
      //   'image',
      //   'dateTime',
      // );

      //create new user document with uid. This changes the "" field in collection.
      await DBService(uid: user.uid).updateUserData(
        firstName,
        lastName,
        email,
        password,
        dateOfBirth, //DUMMY DATA (WHERE DOB WILL BE ADDED.)
        user.photoUrl,
        phoneNo,
      );
      //call this function in DB service, create shift collection when user signs up.
      await DBService(uid: user.uid)
          .updateShiftData(firstName, lastName, 'dateTime');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
