import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class UserReportQuestionare extends StatefulWidget {
  UserReportQuestionare({Key key}) : super(key: key);

  @override
  _UserReportQuestionareState createState() => _UserReportQuestionareState();
}

class _UserReportQuestionareState extends State<UserReportQuestionare> {
  String age, sex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20),
      child: Column(
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
            "Just to make sure you're helping right person or getting rid of duplicated reports smth smth smth",
            style: TextStyle(color: Colors.grey, fontSize: ksmallFontSize),
          ),
          SizedBox(
            height: 40,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Text("AGE:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: kPrimaryColor, fontSize: ksmallFontSize)),
                CheckboxListTile(
                  title: Text("Old"),
                  value: false,
                  onChanged: (val) {},
                ),
                CheckboxListTile(
                  title: Text("Adult"),
                  value: false,
                  onChanged: (val) {},
                ),
                CheckboxListTile(
                  title: Text("Young"),
                  value: false,
                  onChanged: (val) {},
                ),
                CheckboxListTile(
                  title: Text("Not sure"),
                  value: false,
                  onChanged: (val) {},
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "SEX:",
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(color: kPrimaryColor, fontSize: ksmallFontSize),
                ),
                CheckboxListTile(
                  title: Text("Man"),
                  value: false,
                  onChanged: (val) {},
                ),
                CheckboxListTile(
                  title: Text("Woman"),
                  value: false,
                  onChanged: (val) {},
                ),
                CheckboxListTile(
                  title: Text("Not sure"),
                  value: false,
                  onChanged: (val) {},
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {},
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
          )
        ],
      ),
    ));
  }
}
