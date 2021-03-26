import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';

class ShelterInfo extends StatelessWidget {
  String shelterId;
  ShelterInfo({Key key, @required this.shelterId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference shelters =
        FirebaseFirestore.instance.collection('shelters');

    return FutureBuilder<DocumentSnapshot>(
        future: shelters.doc(shelterId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            var display = "There's been an error";
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            var display = data['description'];
            var shelter = data['name'];

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
                          child: Text(shelter,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 40))),
                      Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 5.0,
                                  color: Colors.black45,
                                ),
                                color: Colors.white10,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(display,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                            ),
                          ))
                    ]))),
                Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0),
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text("DONATE TO THIS CHARITY",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0)),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kPrimaryColor),
                            minimumSize:
                                MaterialStateProperty.all(Size(350, 60)),
                            elevation: MaterialStateProperty.all(10.0))))
              ],
            ));
          } else {
            return Center(
                child:
                    Text("Loading...", style: TextStyle(color: kPrimaryColor)));
          }
        });
  }
}
