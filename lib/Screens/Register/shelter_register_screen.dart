import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Shelter/shelter_details_screen.dart';

import '../../constants.dart';

class ShelterRegisterScreen extends StatefulWidget {
  @override
  _ShelterRegisterScreenState createState() => _ShelterRegisterScreenState();
}

class _ShelterRegisterScreenState extends State<ShelterRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Create an account",
                      style: TextStyle(fontSize: 30, color: kPrimaryColor),
                      textAlign: TextAlign.left),
                  SizedBox(height: 20),
                  Text(
                    "We need need a little more detail about you in order to keep your account safe?? I don't know, something like that, correct me.",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: "Enter your email number"),
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: "Enter your password"),
                  ),
                  SizedBox(height: 40),
                  MaterialButton(
                    onPressed: () {
                      // TO CHANGE; TODO
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShelterDetailsScreen()));
                    },
                    elevation: 0,
                    height: 50,
                    color: kPrimaryColor,
                    minWidth: double.maxFinite,
                    child: Text("CREATE ACCOUNT",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    textColor: Colors.white,
                  ),
                ],
              ),
            )));
  }
}
