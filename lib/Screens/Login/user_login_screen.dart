import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsc_project/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class NormalUserLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Create account",
              style: TextStyle(fontSize: 30, color: kPrimaryColor),
              textAlign: TextAlign.left),
          SizedBox(height: 20),
          Text(
            "We need your phone number just to make sure that you're not a robot / different creature / no idea for this description but something like that",
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.left,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Enter your phone number",
                icon: Icon(Icons.phone_iphone)),
          ),
          SizedBox(height: 40),
          MaterialButton(
            onPressed: () {},
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
    ));
  }
}
