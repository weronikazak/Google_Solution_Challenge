import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gsc_project/Screens/Welcome/welcome_screen.dart';

class AuthService {
  // String phoneNumber = "";
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          // if (snapshot.hasData) {
          //   // TODO, if email address is null, go to User Main Page
          //   // otherwise, go to Shelter Main Page

          //   // print("SNAPSHOT SNAPSHOT 1 " + snapshot.data.toString());
          //   // print("SNAPSHOT SNAPSHOT 2 " + snapshot.data.email.toString());
          //   // print("SNAPSHOT SNAPSHOT 3" + snapshot.data.uid.toString());

          //   if (snapshot.data.email.toString() != "") {
          //     return ShelterMainPage(shelterId: snapshot.data.uid.toString());
          //   } else {
          //     return UserMainScreen();
          //   }
          // } else {
          return WelcomeScreen();
          // }
        });
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential authCreds) async {
    await FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verID) {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verID, smsCode: smsCode);
    signIn(authCreds);
  }
}
