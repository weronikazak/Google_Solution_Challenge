import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ShelterDetailsScreen extends StatefulWidget {
  @override
  ShelterDetailsScreenState createState() => ShelterDetailsScreenState();
}

class ShelterDetailsScreenState extends State<ShelterDetailsScreen> {
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
                  Text("Add more details",
                      style: TextStyle(fontSize: 30, color: kPrimaryColor),
                      textAlign: TextAlign.left),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: kPrimaryColor,
                        child: ClipOval(
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: Image.asset(
                              "assets/icons/user_2.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: Colors.grey,
                          ),
                          iconSize: 30,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Organisation name"),
                  ),
                  TextFormField(
                    // CHANGE TO SOME MAPS API
                    decoration: InputDecoration(
                        labelText: "There should be an address"),
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
            )));
  }
}
