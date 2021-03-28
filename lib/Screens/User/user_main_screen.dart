import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/User/donate.dart';
import 'package:gsc_project/Screens/User/user_report_map.dart';
import 'package:gsc_project/Screens/Welcome/welcome_screen.dart';
import 'package:gsc_project/Services/auth.dart';

import '../../constants.dart';

class UserMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double padding = 20;
    double imageSize = 90;

    return Scaffold(
        body: Center(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 70,
            width: double.infinity,
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.account_circle, color: kPrimaryColor),
                    iconSize: 30,
                    onPressed: () {}),
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: kPrimaryColor,
                  ),
                  iconSize: 30,
                  onPressed: () async {
                    await AuthService().signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()));
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              "CHOOSE ACTION",
              style: TextStyle(
                  fontSize: klargeFontSize,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Donate()));
                  },
                  fillColor: kSecondaryColor,
                  padding: EdgeInsets.all(padding),
                  shape: CircleBorder(),
                  child:
                      Image.asset("assets/icons/donate.png", height: imageSize),
                ),
                Text(
                  "donate",
                  style:
                      TextStyle(color: Colors.grey, fontSize: kmediumFontSize),
                ),
                SizedBox(
                  height: 40,
                ),
                RawMaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserReportMap()));
                  },
                  fillColor: kSecondaryColor,
                  padding: EdgeInsets.all(padding),
                  shape: CircleBorder(),
                  child:
                      Image.asset("assets/icons/help_1.png", height: imageSize),
                ),
                Text(
                  "report",
                  style:
                      TextStyle(color: Colors.grey, fontSize: kmediumFontSize),
                ),
                // SUSPENDED COFFEE THING
                // good thing it's flexible
                // SizedBox(
                //   height: 20,
                // ),
                // RawMaterialButton(
                //   onPressed: () {},
                //   fillColor: kPrimaryColor,
                //   padding: EdgeInsets.all(padding),
                //   shape: CircleBorder(),
                //   child:
                //       Image.asset("assets/icons/coffee.png", height: imageSize),
                // ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
