import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/User/user_map.dart';
import 'package:gsc_project/Screens/Welcome/welcome_screen.dart';
import 'package:gsc_project/Services/auth.dart';

import '../../constants.dart';

// THE PAGE THAT USER SEES AFTER REGISTERING

class UserMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double padding = 20;
    double imageSize = 90;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kPrimaryColor),
          title: Text("Go back"),
          foregroundColor: kPrimaryColor,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                    onPressed: () async {
                      await AuthService().signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()));
                    },
                    icon: Icon(Icons.logout));
              },
            )
          ],
        ),
        body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {},
                fillColor: kPrimaryColor,
                padding: EdgeInsets.all(padding),
                shape: CircleBorder(),
                child:
                    Image.asset("assets/icons/donation.png", height: imageSize),
              ),
              Text(
                "donate",
                style: TextStyle(color: kPrimaryColor, fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserReportMap()));
                },
                fillColor: kPrimaryColor,
                padding: EdgeInsets.all(padding),
                shape: CircleBorder(),
                child:
                    Image.asset("assets/icons/help_2.png", height: imageSize),
              ),
              Text(
                "report",
                style: TextStyle(color: kPrimaryColor, fontSize: 25),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // RawMaterialButton(
              //   onPressed: () {},
              //   fillColor: kPrimaryColor,
              //   padding: EdgeInsets.all(padding),
              //   shape: CircleBorder(),
              //   child: Image.asset("assets/icons/coffee.png", height: imageSize),
              // ),
            ],
          ),
        ));
  }
}
