import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media/helper/helper_function.dart';
import 'package:social_media/service/database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//log in
  Future logInWithUserNameAndPassword(String email, String password) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

//registor
  Future regsterUserWithEMailAndPassword(
      String userName, String email, String password) async {
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        await DatabaseService(uid: user.uid).savingUserData(userName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future sighnOut() async {
    try {
      // await HelperFunction.saveUserLogedInStus(false);
      // await HelperFunction.saveUserEmailSf("");
      // await HelperFunction.saveUserNameSf("");

      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future sighnInWithGoogle() async {
    try {
      final GoogleSignIn googleSighnIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSighnIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSighnInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSighnInAuthentication.accessToken,
          idToken: googleSighnInAuthentication.idToken,
        );
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
