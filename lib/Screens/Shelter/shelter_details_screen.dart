import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';

import '../../constants.dart';
import 'package:path/path.dart';

class ShelterDetailsScreen extends StatefulWidget {
  @override
  ShelterDetailsScreenState createState() => ShelterDetailsScreenState();
}

class ShelterDetailsScreenState extends State<ShelterDetailsScreen> {
  File image;

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context).settings.arguments;

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
                        child: (image != null)
                            ? ClipOval(
                                child: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: Image.file(
                                    image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : ClipRect(
                                child: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: Image.asset(
                                    "assets/icons/house.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: IconButton(
                          onPressed: () {
                            uploadImage(context);
                          },
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
                    initialValue: email,
                    decoration: InputDecoration(enabled: false),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Organisation name"),
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Your city"),
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Street number"),
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText:
                            "Post Code? Seriously guys, I don't know how this section should look like on British standards angry emoji"),
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
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

  Future uploadImage(BuildContext context) async {
    String fileName = basename(image.path);
    // DocumentReference files = Firebase
  }

  Future getImages() async {
    var gallery_img = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = gallery_img;
    });
  }
}
