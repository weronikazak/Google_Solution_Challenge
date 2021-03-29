import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/User/donate.dart';
import 'package:gsc_project/Screens/User/user_report_map.dart';

import '../../constants.dart';

class UserMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double imageSize = 90;

    return Scaffold(
        body: Center(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          // Container(
          //   height: 70,
          //   width: double.infinity,
          //   alignment: Alignment.bottomRight,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       IconButton(
          //           icon: Icon(Icons.account_circle, color: kPrimaryColor),
          //           iconSize: 30,
          //           onPressed: () {}),
          //       IconButton(
          //         icon: Icon(
          //           Icons.logout,
          //           color: kPrimaryColor,
          //         ),
          //         iconSize: 30,
          //         onPressed: () async {
          //           await AuthService().signOut();
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => WelcomeScreen()));
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(height: 20),
          Container(
            child: Text(
              "HOW DO YOU WANT TO HELP?",
              style: TextStyle(
                  fontSize: klargeFontSize,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam pharetra est eu facilisis ornare.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: ksmallFontSize),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: kPrimaryColor)))),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Donate()));
                    },
                    child: Container(
                        width: 300,
                        height: 120,
                        child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: Image.asset("assets/icons/donate.png",
                                    height: imageSize)),
                            Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Text("donate to \n charity",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: kmediumFontSize)),
                            ),
                          ],
                        ))),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: kPrimaryColor)))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserReportMap()));
                    },
                    child: Container(
                        width: 300,
                        height: 120,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("report a person\n in need",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: kmediumFontSize)),
                            ),
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: Image.asset("assets/icons/help_1.png",
                                    height: imageSize)),
                          ],
                        ))),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: kPrimaryColor,
                                    )))),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Yet to come!",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: kskyColor,
                      ));
                    },
                    child: Container(
                        width: 300,
                        height: 120,
                        child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: Image.asset("assets/icons/coffee.png",
                                    height: imageSize)),
                            Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Text("buy a coffe",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: kmediumFontSize)),
                            ),
                          ],
                        ))),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
