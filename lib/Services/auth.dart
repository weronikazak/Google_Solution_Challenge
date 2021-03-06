import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gsc_project/Screens/User/user_main_screen.dart';
import 'package:gsc_project/Screens/Welcome/welcome_screen.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            return UserMainScreen();
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
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verID, smsCode: smsCode);
    signIn(authCreds);
  }
}
