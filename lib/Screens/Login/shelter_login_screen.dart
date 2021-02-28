import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ShelterLoginScreen extends StatelessWidget {
  const ShelterLoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Create account",
              style: TextStyle(fontSize: 30, color: kPrimaryColor),
              textAlign: TextAlign.left),
          // Image(image: ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Enter your organisation name",
                icon: Icon(Icons.phone_iphone)),
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Enter your phone number",
                icon: Icon(Icons.phone_iphone)),
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
