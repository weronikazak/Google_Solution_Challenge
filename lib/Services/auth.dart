import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gsc_project/Screens/User/user_main_screen.dart';
import 'package:gsc_project/Screens/Welcome/welcome_screen.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return MainUserScreen();
          } else {
            return WelcomeScreen();
          }
        });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verID) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verID, smsCode: smsCode);
    signIn(authCreds);
  }
}
