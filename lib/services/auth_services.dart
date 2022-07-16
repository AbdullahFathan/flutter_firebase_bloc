import 'package:firebase_auth/firebase_auth.dart';

class AuthServies {
  var firebaseAuth = FirebaseAuth.instance;

  //* Login User
  Future<bool> login(String email, String password) async {
    try {
      final postLogin = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      print("Await firebase send {auth_services.dart}");
      return true;
    } on FirebaseAuthException catch (eror) {
      print("!! Eror at Login Method: ${eror.message}");
    }
    return false;
  }

  Future<bool> register(String email, String password) async {
    try {
      final registerResult = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (eror) {
      print("!! Eror at register Method: ${eror.message}");
    }
    return false;
  }

  //* Logout User
  void logout() async {
    await firebaseAuth.signOut();
  }

  //* Has the user sign in
  Future<bool> isHasSignIn() async {
    var currenUser = firebaseAuth.currentUser;
    return currenUser != null;
  }

  //* To get a current user log in
  Future<User?> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }
}
