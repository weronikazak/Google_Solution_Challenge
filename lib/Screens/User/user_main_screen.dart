import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

// THE PAGE THAT USER SEES AFTER REGISTERING

class MainUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double padding = 20;
    double imageSize = 90;

    return Scaffold(
        body: Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Choose Type",
              style: TextStyle(fontSize: 50, color: kPrimaryColor)),
          SizedBox(height: 20),
          RawMaterialButton(
            onPressed: () {},
            fillColor: kPrimaryColor,
            padding: EdgeInsets.all(padding),
            shape: CircleBorder(),
            child: Image.asset("assets/icons/coffee.png", height: imageSize),
          ),
          Text(
            "normal user",
            style: TextStyle(color: kPrimaryColor, fontSize: 25),
          ),
          SizedBox(
            height: 20,
          ),
          RawMaterialButton(
            onPressed: () {},
            fillColor: kPrimaryColor,
            padding: EdgeInsets.all(padding),
            shape: CircleBorder(),
            child: Image.asset("assets/icons/coffee.png", height: imageSize),
          ),
          Text(
            "shelter",
            style: TextStyle(color: kPrimaryColor, fontSize: 25),
          ),
          SizedBox(
            height: 20,
          ),
          RawMaterialButton(
            onPressed: () {},
            fillColor: kPrimaryColor,
            padding: EdgeInsets.all(padding),
            shape: CircleBorder(),
            child: Image.asset("assets/icons/coffee.png", height: imageSize),
          ),
        ],
      ),
    ));
  }
}
