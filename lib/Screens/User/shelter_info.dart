import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';

class ShelterInfo extends StatelessWidget {
  String shelterId;
  ShelterInfo({Key key, @required this.shelterId}) : super(key: key);

  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    CollectionReference shelters =
        FirebaseFirestore.instance.collection('shelters');

    return FutureBuilder<DocumentSnapshot>(
        future: shelters.doc(shelterId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                  child: Text(
                "Something went horribly wrong and we don't know what.",
                style: TextStyle(color: Colors.red),
              )),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();

            return Scaffold(
                body: Center(
              child: ListView(
                padding: EdgeInsets.all(00),
                // shrinkWrap: true,
                children: [
                  Container(
                      // decoration: BoxDecoration(
                      //   border: Border.all(
                      //     color: kSecondaryColor,
                      //   ),
                      //   borderRadius: BorderRadius.all(Radius.circular(10)),
                      //   color: Colors.white10,
                      // ),
                      color: kSecondaryColor,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              child: ClipRect(
                                child: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: Image.asset(
                                    "assets/icons/shelter.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            data['name'],
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: klargeFontSize),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          showDetails
                              ? TextField(
                                  // textAlign: TextAlign.left,
                                  // expands: true,
                                  // style: TextStyle(height: 5),
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2),
                                      ),
                                      hintText:
                                          'Add some information about the person.'),
                                )
                              : Container(),
                          Container(
                            // color: kPrimaryColor,
                            alignment: Alignment.center,
                            child: Wrap(
                              children: [
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  child: Icon(
                                    Icons.link,
                                    color: Colors.white,
                                  ),
                                  decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(100.0)),
                                    border: new Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                // CircleAvatar(
                                //     radius: 30,
                                //     foregroundColor: Colors.white,
                                //     backgroundColor: kPrimaryColor,
                                //     child: Icon(Icons.link)),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                  decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(100.0)),
                                    border: new Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                // CircleAvatar(
                                //     radius: 30,
                                //     foregroundColor: Colors.white,
                                //     backgroundColor: kPrimaryColor,
                                //     child: Icon(Icons.phone)),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  child: Icon(
                                    Icons.navigation,
                                    color: Colors.white,
                                  ),
                                  decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(100.0)),
                                    border: new Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                // CircleAvatar(
                                //     radius: 30,
                                //     foregroundColor: Colors.white,
                                //     backgroundColor: kPrimaryColor,
                                //     child: Icon(Icons.navigation)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                  Center(
                    child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        color: Colors.grey,
                        child: Column(
                          children: [
                            Text(
                              // data['postcode'] +
                              //     "        " +
                              data['city'] + ", " + data["street"],
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: ksmallFontSize),
                            ),
                            // Text(
                            //   data['postcode'],
                            //   style: TextStyle(
                            //       color: Colors.black87,
                            //       fontSize: ksmallFontSize),
                            // ),
                          ],
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                          child: Column(children: [
                        // Center(
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     width: double.infinity,
                        //     padding: EdgeInsets.all(10),
                        //     color: Colors.grey,
                        //     child: Text(
                        //       "DESCRIPTION",
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: ksmallFontSize),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(data['description'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: ksmallFontSize,
                              )),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        MaterialButton(
                          height: 50,
                          minWidth: double.infinity,
                          elevation: 0,
                          color: kPrimaryColor,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Yet to come!",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: kskyColor,
                            ));
                          },
                          child: Text("DONATE TO THIS CHARITY",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0)),
                        )
                      ]))),
                ],
              ),
            ));
          } else {
            return Scaffold(
              body: Center(
                  child: Text("Loading",
                      style: TextStyle(
                          color: kPrimaryColor, fontSize: kmediumFontSize))),
            );
          }
        });
  }
}
