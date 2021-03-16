import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';
import 'package:gsc_project/Screens/User/donate.dart';
import '../../constants.dart';

class ShelterInfo extends StatefulWidget {
  ShelterInfo({Key key}) : super(key: key);

  @override
  _ShelterInfo createState() => _ShelterInfo();
}

class _ShelterInfo extends State<ShelterInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Center(
            heightFactor: 1.3,
            child: Container(
                child: Icon(Icons.night_shelter,
                    size: 200.0, color: kPrimaryColor))),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
                child: Column(children: [
              Center(
                  child: Text("Charity Name",
                      style: TextStyle(color: Colors.black, fontSize: 40))),
              Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 5.0,
                          color: Colors.black45,
                        ),
                        color: Colors.white10,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                        "This is where all the information about the charity would go. Blah blah blah blah blah blah blah. Filler, filler, filler, filler, filler, filler, filler. We should probably put a word limit on this thought so that all pages look the same",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                        )),
                  ))
            ]))),
        Padding(
            padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0),
            child: ElevatedButton(
                onPressed: () {},
                child: Text("DONATE TO THIS CHARITY",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20.0)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kPrimaryColor),
                    minimumSize: MaterialStateProperty.all(Size(350, 60)),
                    elevation: MaterialStateProperty.all(10.0))))
      ],
    ));
  }
}
