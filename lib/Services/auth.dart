import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gsc_project/Screens/Shelter/shelter_main_page.dart';
import 'package:gsc_project/Screens/User/user_main_screen.dart';
import 'package:gsc_project/Screens/Welcome/welcome_screen.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            // TODO, if email address is null, go to User Main Page
            // otherwise, go to Shelter Main Page
            print("SNAPSHOT SNAPSHOT " + snapshot.data.toString());
            print("SNAPSHOT SNAPSHOT " + snapshot.data.email);

            if (snapshot.data.email != null) {
              return ShelterMainPage();
            } else {
              return UserMainScreen();
            }
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
