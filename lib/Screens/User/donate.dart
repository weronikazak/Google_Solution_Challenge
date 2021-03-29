import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';
import 'package:gsc_project/Screens/User/shelter_info.dart';

class Donate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference shelters =
        FirebaseFirestore.instance.collection('shelters');

    return StreamBuilder<QuerySnapshot>(
        stream: shelters.snapshots(),
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
                elevation: 0,
                title: Center(
                  child: Text("HOMELESS CHARITIES"),
                ),
                backgroundColor: kPrimaryColor,
              ),
              body: ListView(
                children: [
                  TextField(
                    // textAlign: TextAlign.left,
                    // expands: true,
                    // style: TextStyle(height: 5),
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        hintText: 'Search for shelter by city or street.',
                        prefixIcon: Icon(Icons.search)),
                  ),
                  Column(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot shelter) {
                      return new Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black45,
                            ),
                            color: Colors.white10,
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Row(children: <Widget>[
                            SizedBox(
                              width: 150,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(shelter.data()["name"],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: kmediumFontSize)),
                                    Text(
                                        shelter.data()["city"] +
                                            ", " +
                                            shelter.data()["street"],
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: ksmallFontSize)),
                                  ]),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RawMaterialButton(
                                      elevation: 0,
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            "Yet to come!",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: kskyColor,
                                        ));
                                      },
                                      fillColor: kPrimaryColor,
                                      padding: EdgeInsets.all(12),
                                      shape: CircleBorder(),
                                      child: Text(
                                        "£",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: kmediumFontSize),
                                      ),
                                    ),
                                    RawMaterialButton(
                                      elevation: 0,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ShelterInfo(
                                                      shelterId: shelter.id,
                                                    )));
                                      },
                                      fillColor: kPrimaryColor,
                                      padding: EdgeInsets.all(15),
                                      shape: CircleBorder(),
                                      child: Icon(Icons.arrow_forward_ios,
                                          color: Colors.white),
                                    ),
                                  ],
                                ))
                          ]));
                    }).toList(),
                  ),
                ],
              ));
        });
  }
}
