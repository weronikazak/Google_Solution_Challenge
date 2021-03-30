import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Register/profile_type_screen.dart';
import 'package:gsc_project/Screens/Login/login_screen.dart';
import 'package:gsc_project/Services/auth.dart';
import 'package:gsc_project/constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double buttonHeight = 60;

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      AuthService().signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            "HOW ARE YOU?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: klargeFontSize,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "An app to help hundreds of people in just one click. Be a part of something big.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: ksmallFontSize),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Image.asset(
            "assets/images/tochange_1.png",
            height: 250,
          ),
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: MaterialButton(
              onPressed: () {
                // Navigator.pushNamed(context, "/registrationType");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileTypePage()));
              },
              elevation: 0,
              height: buttonHeight,
              color: kPrimaryColor,
              minWidth: double.maxFinite,
              child:
                  Text("REGISTER", style: TextStyle(fontSize: ksmallFontSize)),
              textColor: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: MaterialButton(
              onPressed: () {
                // Navigator.pushNamed(context, "/login");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              elevation: 0,
              height: buttonHeight,
              color: Colors.grey,
              minWidth: double.maxFinite,
              child: Text("LOGIN",
                  style:
                      TextStyle(color: Colors.white, fontSize: ksmallFontSize)),
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
