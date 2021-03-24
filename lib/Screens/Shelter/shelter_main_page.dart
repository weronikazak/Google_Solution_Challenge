import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Shelter/shelter_report_map.dart';
import 'package:gsc_project/Screens/Welcome/welcome_screen.dart';
import 'package:gsc_project/Services/auth.dart';
import 'dart:math' show cos, sqrt, asin;

import '../../constants.dart';

class ShelterMainPage extends StatelessWidget {
  String shelterId;
  ShelterMainPage({Key key, this.shelterId}) : super(key: key);
  // FirebaseAuth.instance.s
  String orgName = "Organisation";

  @override
  Widget build(BuildContext context) {
    CollectionReference reports =
        FirebaseFirestore.instance.collection('raports');

    double calculateDistance(lat1, lon1, lat2, lon2) {
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    }

    return StreamBuilder<QuerySnapshot>(
        stream: reports.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                  child: Text(
                "Something went horribly wrong and we don't know what.",
                style: TextStyle(color: Colors.red),
              )),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                  child: Text("Loading",
                      style: TextStyle(
                          color: kPrimaryColor, fontSize: kmediumFontSize))),
            );
          }

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
              body: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: CircleAvatar(
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
                        ),
                        Text(
                          "Organisation's name",
                          style: TextStyle(
                              color: kPrimaryColor, fontSize: klargeFontSize),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      color: kPrimaryColor,
                      child: Text(
                        "LATEST RAPORTS",
                        style: TextStyle(
                            color: Colors.white, fontSize: ksmallFontSize),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot raport) {
                        return new Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kSecondaryColor,
                              ),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Row(children: <Widget>[
                              Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(10.0, 0, 20.0, 0),
                                  child: Icon(
                                    Icons.house,
                                    color: kPrimaryColor,
                                    size: 30.0,
                                  )),
                              Text(
                                calculateDistance(
                                            raport.data()["lat"],
                                            raport.data()["lng"],
                                            // TO CHANGE
                                            12.000,
                                            12.000)
                                        .toString() +
                                    " KM AWAY",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: ksmallFontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 40.0),
                                child: RawMaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShelterReportMap(
                                                  raportId: raport.id,
                                                  shelterId: shelterId,
                                                )));
                                  },
                                  fillColor: kPrimaryColor,
                                  padding: EdgeInsets.all(20),
                                  shape: CircleBorder(),
                                  child: Icon(Icons.arrow_forward_ios),
                                ),
                              )
                            ]));
                      }).toList(),
                    ),
                  ))
                ],
              ));
        });
  }

  // Future<void> _getUserName() async {
  //       await FirebaseAuth.instance.currentUser();
  //           .then((value) {
  //         setState(() {
  //           _userName = value.data['name'].toString();
  //         });
  //       });
  //     }
}
