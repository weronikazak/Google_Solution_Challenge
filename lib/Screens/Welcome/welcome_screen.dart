import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Register/profile_type_screen.dart';
import 'package:gsc_project/Services/auth.dart';
import 'package:gsc_project/constants.dart';

class WelcomeScreen extends StatelessWidget {
  double buttonHeight = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Image
          Image.asset(
            "assets/images/tochange_1.png",
            height: 250,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Hello!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Help thousands of people just in one click!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: MaterialButton(
              onPressed: () {
                // AuthService().signIn(authCreds);
              },
              elevation: 0,
              height: buttonHeight,
              color: kPrimaryColor,
              minWidth: double.maxFinite,
              child: Text("LOGIN",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              textColor: Colors.white,
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileTypeScreen()));
              },
              elevation: 0,
              height: buttonHeight,
              color: Colors.grey,
              minWidth: double.maxFinite,
              child: Text("REGISTER",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
