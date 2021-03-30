import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Shelter/shelter_report_map.dart';
import 'package:gsc_project/Screens/Welcome/welcome_screen.dart';
import 'package:gsc_project/Services/auth.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:timeago/timeago.dart' as timeago;

import '../../constants.dart';

var instance = FirebaseFirestore.instance;

// ignore: must_be_immutable
class ShelterMainPage extends StatefulWidget {
  String shelterId;
  ShelterMainPage({Key key, @required this.shelterId}) : super(key: key);

  @override
  _ShelterMainPageState createState() => _ShelterMainPageState();
}

class _ShelterMainPageState extends State<ShelterMainPage> {
  double shelterLon;
  double shelterLat;
  String shelterName = "Name";
  String shelterAddress = "Address";
  TextEditingController distanceController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    instance.collection("shelters").doc(widget.shelterId).get().then((value) {
      shelterName = value.data()["name"];
      shelterLon = value.data()["longitude"];
      shelterLat = value.data()["latitude"];
      shelterAddress = value.data()['city'] + ", " + value.data()['street'];
    }).catchError((error) => print("Error again :("));

    distanceController.text = "15";
  }

  @override
  Widget build(BuildContext context) {
    Query reports =
        instance.collection('raports').orderBy("time", descending: true);

    double calculateDistance(lat1, lon1, lat2, lon2) {
      try {
        var p = 0.017453292519943295;
        var c = cos;
        double a = 0.5 -
            c((lat2 - lat1) * p) / 2 +
            c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
        double result = 12742 * asin(sqrt(a));

        return num.parse(result.toStringAsFixed(2));
      } catch (e) {
        return 0;
      }
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
              body: Column(
            children: <Widget>[
              Container(
                height: 70,
                width: double.infinity,
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.account_circle, color: kPrimaryColor),
                        iconSize: 30,
                        onPressed: () {}),
                    IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: kPrimaryColor,
                      ),
                      iconSize: 30,
                      onPressed: () async {
                        await AuthService().signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen()));
                      },
                    ),
                  ],
                ),
              ),
              Container(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: kPrimaryColor,
                        child: ClipRect(
                          child: SizedBox(
                            width: 65,
                            height: 65,
                            child: Image.asset(
                              "assets/icons/shelter.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      shelterName,
                      style: TextStyle(
                          color: kPrimaryColor, fontSize: klargeFontSize),
                    ),
                    Text(
                      shelterAddress,
                      style: TextStyle(
                          color: Colors.grey, fontSize: kmediumFontSize),
                    ),
                  ],
                ),
              )),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  color: kPrimaryColor,
                  child: Text(
                    "LATEST REPORTS",
                    style: TextStyle(
                        color: Colors.white, fontSize: ksmallFontSize),
                  ),
                ),
              ),
              new Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    width: 300,
                    color: Colors.grey,
                    child: Text(
                      "Distance from target (in km)",
                      style: TextStyle(
                          color: Colors.black, fontSize: ksmallFontSize),
                    ),
                  ),
                  new Flexible(
                    child: new TextFormField(
                      keyboardType: TextInputType.number,
                      controller: distanceController,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        fillColor: Colors.white24,
                        focusColor: Colors.black,
                        hoverColor: Colors.black,
                        suffixIcon: Icon(Icons.explore, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Container(
                child: Column(
                  children: snapshot.data.docs.map((DocumentSnapshot raport) {
                    return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kSecondaryColor,
                          ),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(children: <Widget>[
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  calculateDistance(
                                              raport.data()["latitude"],
                                              raport.data()["longitude"],
                                              shelterLat,
                                              shelterLon)
                                          .toString() +
                                      " KM AWAY",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: ksmallFontSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  timeago
                                      .format(raport.data()["time"].toDate())
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ksmallFontSize,
                                  ),
                                ),
                              ],
                            ),
                          )),
                          Padding(
                            padding: EdgeInsets.only(left: 60.0),
                            child: RawMaterialButton(
                              elevation: 0,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShelterReportMap(
                                            targetLat:
                                                raport.data()["latitude"],
                                            targetLon:
                                                raport.data()["longitude"],
                                            shelterLat: shelterLat,
                                            shelterLon: shelterLon)));
                              },
                              fillColor: kPrimaryColor,
                              padding: EdgeInsets.all(15),
                              shape: CircleBorder(),
                              child: Icon(Icons.arrow_forward_ios,
                                  color: Colors.white),
                            ),
                          )
                          // Padding(
                          //   padding: EdgeInsets.only(left: 40.0),
                          //   child: TextButton(
                          //       style: ButtonStyle(
                          //         backgroundColor:
                          //             MaterialStateProperty.all<Color>(
                          //                 kPrimaryColor),
                          //         elevation: MaterialStateProperty.all(0),
                          //       ),
                          //       onPressed: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     ShelterReportMap(
                          //                       raportId: raport.id,
                          //                       shelterId: widget.shelterId,
                          //                     )));
                          //       },
                          //       child: Text(
                          //         "More Info",
                          //         style: TextStyle(
                          //             color: Colors.black,
                          //             fontSize: ksmallFontSize),
                          //       )),
                          // )
                        ]));
                  }).toList(),
                ),
              ))
            ],
          ));
        });
  }
}
