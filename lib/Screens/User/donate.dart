import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';
import 'package:gsc_project/Screens/User/shelter_info.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Donate extends StatefulWidget {
  Donate({Key key}) : super(key: key);

  @override
  _Donate createState() => _Donate();
}

class _Donate extends State<Donate> {
  @override
  Widget build(BuildContext context) {
    // CollectionReference shelters =
    //     FirebaseFirestore.instance.collection('shelters');
    // shelters.get();
    // print(shelters);
    List<int> s = [1, 2, 3, 4, 5, 6];

    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'HOMELESS CHARITIES',
          )),
          backgroundColor: kPrimaryColor,
        ),
        body: Column(
          children: <Widget>[
            for (var i in s)
              Container(
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
                      "Name Of Charity",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kPrimaryColor),
                            elevation: MaterialStateProperty.all(5.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShelterInfo()),
                            );
                          },
                          child: Text(
                            "More Info...",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )),
                    )
                  ])),
          ],
        ));
  }
}
