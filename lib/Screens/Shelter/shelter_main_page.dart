import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Shelter/shelter_report_map.dart';
import 'package:gsc_project/Screens/Welcome/welcome_screen.dart';
import 'package:gsc_project/Services/auth.dart';

import '../../constants.dart';

class ShelterMainPage extends StatelessWidget {
  const ShelterMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference reports =
        FirebaseFirestore.instance.collection('reports');

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
            body: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot report) {
                return new Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black45,
                        ),
                        color: Colors.white10,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.all(20),
                    child: Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0, 20.0, 0),
                          child: Icon(
                            Icons.house,
                            color: kPrimaryColor,
                            size: 30.0,
                          )),
                      Text(
                        report.data()["name"],
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
                                    builder: (context) => ShelterReportMap()));
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
          );
        });

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
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
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
                  Text(
                    "Organisation's name",
                    style: TextStyle(
                        color: kPrimaryColor, fontSize: klargeFontSize),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[],
        ));
  }
}
