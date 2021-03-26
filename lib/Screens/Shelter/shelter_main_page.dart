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

  @override
  void initState() {
    instance.collection("shelters").doc(widget.shelterId).get().then((value) {
      shelterName = value.data()["name"];
      shelterLon = value.data()["longitude"];
      shelterLat = value.data()["latitude"];
      // print("AAAAAA " + shelterLat.toString());
    }).catchError((error) => print("Error again :("));
  }

  @override
  Widget build(BuildContext context) {
    Query reports =
        instance.collection('raports').orderBy("time", descending: true);

    double calculateDistance(lat1, lon1, lat2, lon2) {
      var p = 0.017453292519943295;
      var c = cos;
      double a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      double result = 12742 * asin(sqrt(a));

      return num.parse(result.toStringAsFixed(2));
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
                      child: Padding(
                    padding: EdgeInsets.all(20),
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
                                padding: EdgeInsets.all(10),
                                child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.orange,
                                    child: Text(
                                      "!",
                                      style: TextStyle(
                                          fontSize: klargeFontSize,
                                          color: Colors.white),
                                    )),
                                // child: Icon(
                                //   Icons.report_problem,
                                //   size: 50,
                                //   color: Colors.orange,
                                // )
                                // child: Image.asset(
                                //   "assets/icons/homeless.png",
                                //   width: 40,
                                //   height: 40,
                                //   color: kPrimaryColor,
                                //   fit: BoxFit.fill,
                                // ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      calculateDistance(
                                                  raport.data()["lat"],
                                                  raport.data()["lon"],
                                                  // TO CHANGE
                                                  shelterLat,
                                                  shelterLon)
                                              // 12.0,
                                              // 12.0)
                                              .toString() +
                                          " KM AWAY",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: ksmallFontSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      timeago
                                          .format(
                                              raport.data()["time"].toDate())
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: ksmallFontSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 40.0),
                                child: RawMaterialButton(
                                  elevation: 0,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShelterReportMap(
                                                  raportId: raport.id,
                                                  shelterId: widget.shelterId,
                                                )));
                                  },
                                  fillColor: kPrimaryColor,
                                  padding: EdgeInsets.all(15),
                                  shape: CircleBorder(),
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.white),
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
}

// class ShelterMainPage extends StatelessWidget {
//   String shelterId;
//   ShelterMainPage({Key key, @required this.shelterId}) : super(key: key);
//   double shelterLon;
//   double shelterLat;
//   // @override
//   // void initState() {

//   // }

//   @override
//   Widget build(BuildContext context) {
//     Query reports =
//         instance.collection('raports').orderBy("time", descending: true);

//     String shelterName = "Name";

//     instance.collection("shelters").doc(shelterId).get().then((value) {
//       shelterName = value.data()["name"];
//       shelterLon = value.data()["lon"];
//       shelterLat = value.data()["lat"];
//     }).catchError((error) => print("Error again :("));

//     double calculateDistance(lat1, lon1, lat2, lon2) {
//       var p = 0.017453292519943295;
//       var c = cos;
//       double a = 0.5 -
//           c((lat2 - lat1) * p) / 2 +
//           c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//       double result = 12742 * asin(sqrt(a));

//       return num.parse(result.toStringAsFixed(2));
//     }

//     return StreamBuilder<QuerySnapshot>(
//         stream: reports.snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Scaffold(
//               body: Center(
//                   child: Text(
//                 "Something went horribly wrong and we don't know what.",
//                 style: TextStyle(color: Colors.red),
//               )),
//             );
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Scaffold(
//               body: Center(
//                   child: Text("Loading",
//                       style: TextStyle(
//                           color: kPrimaryColor, fontSize: kmediumFontSize))),
//             );
//           }

//           return Scaffold(
//               appBar: AppBar(
//                 iconTheme: IconThemeData(color: kPrimaryColor),
//                 foregroundColor: kPrimaryColor,
//                 backgroundColor: Colors.white,
//                 elevation: 0,
//                 actions: <Widget>[
//                   Builder(
//                     builder: (BuildContext context) {
//                       return IconButton(
//                           onPressed: () async {
//                             await AuthService().signOut();
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => WelcomeScreen()));
//                           },
//                           icon: Icon(Icons.logout));
//                     },
//                   ),
//                 ],
//               ),
//               body: Column(
//                 children: <Widget>[
//                   Container(
//                       child: Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       children: <Widget>[
//                         Padding(
//                           padding: EdgeInsets.all(10),
//                           child: CircleAvatar(
//                             radius: 50,
//                             backgroundColor: kPrimaryColor,
//                             child: ClipRect(
//                               child: SizedBox(
//                                 width: 65,
//                                 height: 65,
//                                 child: Image.asset(
//                                   "assets/icons/shelter.png",
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Text(
//                           shelterName,
//                           style: TextStyle(
//                               color: kPrimaryColor, fontSize: klargeFontSize),
//                         ),
//                       ],
//                     ),
//                   )),
//                   Center(
//                     child: Container(
//                       alignment: Alignment.center,
//                       width: double.infinity,
//                       padding: EdgeInsets.all(10),
//                       color: kPrimaryColor,
//                       child: Text(
//                         "LATEST RAPORTS",
//                         style: TextStyle(
//                             color: Colors.white, fontSize: ksmallFontSize),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                       child: Container(
//                     child: ListView(
//                       children:
//                           snapshot.data.docs.map((DocumentSnapshot raport) {
//                         return new Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: kSecondaryColor,
//                               ),
//                             ),
//                             padding: const EdgeInsets.all(20),
//                             child: Row(children: <Widget>[
//                               Padding(
//                                 padding: EdgeInsets.all(10),
//                                 child: CircleAvatar(
//                                     radius: 25,
//                                     backgroundColor: Colors.orange,
//                                     child: Text(
//                                       "!",
//                                       style: TextStyle(
//                                           fontSize: klargeFontSize,
//                                           color: Colors.white),
//                                     )),
//                                 // child: Icon(
//                                 //   Icons.report_problem,
//                                 //   size: 50,
//                                 //   color: Colors.orange,
//                                 // )
//                                 // child: Image.asset(
//                                 //   "assets/icons/homeless.png",
//                                 //   width: 40,
//                                 //   height: 40,
//                                 //   color: kPrimaryColor,
//                                 //   fit: BoxFit.fill,
//                                 // ),
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                       calculateDistance(
//                                                   raport.data()["lat"],
//                                                   raport.data()["lon"],
//                                                   // TO CHANGE
//                                                   12.000,
//                                                   12.000)
//                                               .toString() +
//                                           " KM AWAY",
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: ksmallFontSize,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       timeago
//                                           .format(
//                                               raport.data()["time"].toDate())
//                                           .toString(),
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: ksmallFontSize,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(left: 40.0),
//                                 child: RawMaterialButton(
//                                   elevation: 0,
//                                   onPressed: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 ShelterReportMap(
//                                                   raportId: raport.id,
//                                                   shelterId: shelterId,
//                                                 )));
//                                   },
//                                   fillColor: kPrimaryColor,
//                                   padding: EdgeInsets.all(15),
//                                   shape: CircleBorder(),
//                                   child: Icon(Icons.arrow_forward_ios,
//                                       color: Colors.white),
//                                 ),
//                               )
//                             ]));
//                       }).toList(),
//                     ),
//                   ))
//                 ],
//               ));
//         });
//   }

//   // Future<void> _getUserName() async {
//   //       await FirebaseAuth.instance.currentUser();
//   //           .then((value) {
//   //         setState(() {
//   //           _userName = value.data['name'].toString();
//   //         });
//   //       });
//   //     }
// }
