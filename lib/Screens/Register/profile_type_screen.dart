import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Register/shelter_register_screen.dart';
import 'package:gsc_project/Screens/Register/user_register_screen.dart';
import 'package:gsc_project/constants.dart';

class ProfileTypeScreen extends StatelessWidget {
  // const ProfileTypeScreen({Key key}) : super(key: key);

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
                SizedBox(height: 20),
                Container(
                  child: Text(
                    "CHOOSE TYPE",
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
                    style:
                        TextStyle(color: Colors.grey, fontSize: ksmallFontSize),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NormalUserRegister()));
                        },
                        fillColor: kSecondaryColor,
                        padding: EdgeInsets.all(padding),
                        shape: CircleBorder(),
                        child: Image.asset("assets/icons/user_1.png",
                            height: imageSize),
                      ),
                      Text(
                        "normal user",
                        style: TextStyle(
                            color: Colors.grey, fontSize: kmediumFontSize),
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
                        fillColor: kSecondaryColor,
                        padding: EdgeInsets.all(padding),
                        shape: CircleBorder(),
                        child: Image.asset("assets/icons/shelter.png",
                            height: imageSize),
                      ),
                      Text(
                        "shelter",
                        style: TextStyle(
                            color: Colors.grey, fontSize: kmediumFontSize),
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
