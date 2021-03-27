import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gsc_project/Screens/User/user_thankyou.dart';

import '../../constants.dart';

class UserReportQuestionare extends StatefulWidget {
  LatLng userLocation;
  UserReportQuestionare(this.userLocation);

// const LatLng(52.76510085541201, -1.2320534015136977);
  @override
  _UserReportQuestionareState createState() => _UserReportQuestionareState();
}

@override
void initState() {}

class _UserReportQuestionareState extends State<UserReportQuestionare> {
  var age, sex;
  bool showDescription = false;
  TextEditingController extraInfoController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            "Tell us more",
            style: TextStyle(color: kPrimaryColor, fontSize: klargeFontSize),
            textAlign: TextAlign.center,
          ),
          Text(
            "Please fill the questionnaire below to make sure you're helping right person or getting rid of duplicated reports.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: ksmallFontSize),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  color: kPrimaryColor,
                  child: Text(
                    "AGE",
                    style: TextStyle(
                        color: Colors.white, fontSize: ksmallFontSize),
                  ),
                ),
              ),
              RadioListTile(
                value: "elder",
                groupValue: age,
                title: Text("Elder"),
                onChanged: (val) {
                  setState(() {
                    age = val;
                  });
                },
                activeColor: Colors.blue,
                selected: false,
              ),
              RadioListTile(
                value: "adult",
                groupValue: age,
                title: Text("Adult"),
                onChanged: (val) {
                  setState(() {
                    age = val;
                  });
                },
                activeColor: Colors.blue,
                selected: false,
              ),
              RadioListTile(
                value: "young",
                groupValue: age,
                title: Text("Young"),
                onChanged: (val) {
                  setState(() {
                    age = val;
                  });
                },
                activeColor: Colors.blue,
                selected: false,
              ),
              RadioListTile(
                value: "not sure",
                groupValue: age,
                title: Text("Not sure"),
                onChanged: (val) {
                  setState(() {
                    age = val;
                  });
                },
                activeColor: Colors.blue,
                selected: false,
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  color: kPrimaryColor,
                  child: Text(
                    "SEX",
                    style: TextStyle(
                        color: Colors.white, fontSize: ksmallFontSize),
                  ),
                ),
              ),
              RadioListTile(
                value: "man",
                groupValue: sex,
                title: Text("Man"),
                onChanged: (val) {
                  setState(() {
                    sex = val;
                  });
                },
                activeColor: Colors.blue,
                selected: false,
              ),
              RadioListTile(
                value: "woman",
                groupValue: sex,
                title: Text("Woman"),
                onChanged: (val) {
                  setState(() {
                    sex = val;
                  });
                },
                activeColor: Colors.blue,
                selected: false,
              ),
              RadioListTile(
                value: "not sure",
                groupValue: sex,
                title: Text("Not sure"),
                onChanged: (val) {
                  setState(() {
                    sex = val;
                  });
                },
                activeColor: Colors.blue,
                selected: false,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      showDescription = !showDescription;
                    });
                  },
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          showDescription
                              ? Icon(Icons.remove_circle, color: kPrimaryColor)
                              : Icon(Icons.add_circle, color: kPrimaryColor),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add additional information.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: kPrimaryColor, fontSize: ksmallFontSize),
                          ),
                        ],
                      ))),
              showDescription
                  ? TextField(
                      // textAlign: TextAlign.left,
                      // expands: true,
                      // style: TextStyle(height: 5),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: extraInfoController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                          ),
                          hintText: 'Add some information about the person.'),
                    )
                  : Container(),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  addToDatabase(context);
                },
                elevation: 0,
                height: 50,
                color: kPrimaryColor,
                minWidth: double.maxFinite,
                child: Text("SEND REPORT",
                    style: TextStyle(
                        color: Colors.white, fontSize: ksmallFontSize)),
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Future addToDatabase(BuildContext context) async {
    await FirebaseFirestore.instance.collection("raports").add({
      "latitude": widget.userLocation.latitude,
      "longitude": widget.userLocation.longitude,
      "age": age,
      "sex": sex,
      "description": extraInfoController.text,
      "number": FirebaseAuth.instance.currentUser.phoneNumber
    }).then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserThankYou())));
  }
}
