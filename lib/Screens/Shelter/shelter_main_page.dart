import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Welcome/welcome_screen.dart';
import 'package:gsc_project/Services/auth.dart';

import '../../constants.dart';

class ShelterMainPage extends StatelessWidget {
  const ShelterMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final ArgsSettings args = ModalRoute.of(context).settings.arguments;
    // print("SENT ARGUMENTS " + args.toString());

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kPrimaryColor),
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
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: kPrimaryColor,
                    child: ClipRect(
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                          "assets/icons/house.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Organisation's name",
                    style: TextStyle(
                        color: kPrimaryColor, fontSize: klargeFontSize),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
