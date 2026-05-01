import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class AuthenticationController extends GetxController with UiLoggy {
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      loggy.info('Login OK');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        loggy.warning('Login: user not found');
        return Future.error('User not found');
      } else if (e.code == 'wrong-password') {
        loggy.warning('Login: wrong password');
        return Future.error('Wrong password');
      }
      loggy.error('Login error: ${e.code}');
      return Future.error(e.message ?? 'Login failed');
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      loggy.info('SignUp OK');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return Future.error('The account already exists for that email.');
      }
      loggy.error('SignUp error: ${e.code}');
      return Future.error(e.message ?? 'Sign up failed');
    }
  }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  String userEmail() {
    return FirebaseAuth.instance.currentUser?.email ?? '';
  }

  String getUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}
