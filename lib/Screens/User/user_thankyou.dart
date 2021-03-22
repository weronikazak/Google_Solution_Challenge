import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/User/user_main_screen.dart';

import '../../constants.dart';

class UserThankYou extends StatefulWidget {
  UserThankYou({Key key}) : super(key: key);

  @override
  _UserThankYouState createState() => _UserThankYouState();
}

class _UserThankYouState extends State<UserThankYou> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "THANK YOU!",
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
              "Thank you for helping. We will take a look at that report and convey it to the nearest shelter.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: ksmallFontSize),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Image.asset(
            "assets/images/help.png",
            height: 250,
          ),
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserMainScreen()));
              },
              elevation: 0,
              height: 60,
              color: kPrimaryColor,
              minWidth: double.maxFinite,
              child:
                  Text("REGISTER", style: TextStyle(fontSize: ksmallFontSize)),
              textColor: Colors.white,
            ),
          ),
        ]),
      ),
    );
  }
}
