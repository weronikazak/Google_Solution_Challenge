import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Register/shelter_register_screen.dart';
import 'package:gsc_project/Screens/Register/user_register_screen.dart';
import 'package:gsc_project/Services/auth.dart';
import 'package:gsc_project/constants.dart';

class ProfileTypeScreen extends StatelessWidget {
  // const ProfileTypeScreen({Key key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double padding = 20;
    double imageSize = 90;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        // TODO: Title like: Choose your account type?
        body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                Container(
                  child: Text(
                    "Choose Type",
                    style: TextStyle(fontSize: 50, color: kPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: height - 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RawMaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NormalUserRegister()));
                        },
                        fillColor: kPrimaryColor,
                        padding: EdgeInsets.all(padding),
                        shape: CircleBorder(),
                        child: Image.asset("assets/icons/user_1.png",
                            height: imageSize),
                      ),
                      Text(
                        "normal user",
                        style: TextStyle(color: kPrimaryColor, fontSize: 25),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ShelterRegisterScreen()));
                        },
                        fillColor: kPrimaryColor,
                        padding: EdgeInsets.all(padding),
                        shape: CircleBorder(),
                        child: Image.asset("assets/icons/shelter.png",
                            height: imageSize),
                      ),
                      Text(
                        "shelter",
                        style: TextStyle(color: kPrimaryColor, fontSize: 25),
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
            )));
  }
}
