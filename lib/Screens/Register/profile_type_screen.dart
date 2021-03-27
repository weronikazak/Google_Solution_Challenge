import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Register/shelter_register_screen.dart';
import 'package:gsc_project/Screens/Register/user_register_screen.dart';
import 'package:gsc_project/Screens/Register/user_register_screen_email.dart';
import 'package:gsc_project/constants.dart';

class ProfileTypePage extends StatefulWidget {
  ProfileTypePage({Key key}) : super(key: key);

  @override
  _ProfileTypePageState createState() => _ProfileTypePageState();
}

class _ProfileTypePageState extends State<ProfileTypePage> {
  double imageSize = 90;

  bool userMode = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            child: Text(
              "CHOOSE ACCOUNT TYPE",
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
              "Some way longer text here because this page looks so awkward and empty.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: ksmallFontSize),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side: userMode
                                        ? BorderSide(color: kPrimaryColor)
                                        : BorderSide(color: Colors.grey)))),
                        onPressed: () {
                          setState(() {
                            userMode = true;
                          });

                          print(userMode);
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: userMode
                                ? Image.asset("assets/icons/user_1.png",
                                    height: imageSize)
                                : ColorFiltered(
                                    colorFilter: ColorFilter.matrix(<double>[
                                      0.2126,
                                      0.7152,
                                      0.0722,
                                      0,
                                      0,
                                      0.2126,
                                      0.7152,
                                      0.0722,
                                      0,
                                      0,
                                      0.2126,
                                      0.7152,
                                      0.0722,
                                      0,
                                      0,
                                      0,
                                      0,
                                      0,
                                      1,
                                      0,
                                    ]),
                                    child: Image.asset(
                                        "assets/icons/user_1.png",
                                        height: imageSize),
                                  ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "normal user",
                        style: userMode
                            ? TextStyle(
                                color: kPrimaryColor, fontSize: kmediumFontSize)
                            : TextStyle(
                                color: Colors.grey, fontSize: kmediumFontSize),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                ),
                Column(
                  children: [
                    TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side: userMode
                                        ? BorderSide(color: Colors.grey)
                                        : BorderSide(color: kPrimaryColor)))),
                        onPressed: () {
                          setState(() {
                            userMode = false;
                          });

                          print(userMode);
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: userMode
                                ? ColorFiltered(
                                    colorFilter: ColorFilter.matrix(<double>[
                                      0.2126,
                                      0.7152,
                                      0.0722,
                                      0,
                                      0,
                                      0.2126,
                                      0.7152,
                                      0.0722,
                                      0,
                                      0,
                                      0.2126,
                                      0.7152,
                                      0.0722,
                                      0,
                                      0,
                                      0,
                                      0,
                                      0,
                                      1,
                                      0,
                                    ]),
                                    child: Image.asset(
                                        "assets/icons/shelter.png",
                                        height: imageSize),
                                  )
                                : Image.asset("assets/icons/shelter.png"),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "shelter",
                        style: userMode
                            ? TextStyle(
                                color: Colors.grey, fontSize: kmediumFontSize)
                            : TextStyle(
                                color: kPrimaryColor,
                                fontSize: kmediumFontSize),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
            width: 40,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => userMode
                            ? NormalUserRegister()
                            : ShelterRegisterScreen()));
              },
              elevation: 0,
              height: 50,
              color: kPrimaryColor,
              minWidth: double.maxFinite,
              child: Text("NEXT", style: TextStyle(fontSize: ksmallFontSize)),
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    ));
  }
}
