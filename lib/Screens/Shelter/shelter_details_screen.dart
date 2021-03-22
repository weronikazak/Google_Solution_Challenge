import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Classes/shelter.dart';
import 'package:gsc_project/Screens/Shelter/arguments.dart';
import 'package:gsc_project/Screens/Shelter/shelter_main_page.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';
import 'package:http/http.dart' as http;

class ShelterDetailsScreen extends StatefulWidget {
  ShelterDetailsScreen(this.email);
  String email;
  @override
  ShelterDetailsScreenState createState() => ShelterDetailsScreenState();
}

class ShelterDetailsScreenState extends State<ShelterDetailsScreen> {
  File image;
  String email;
  bool imageUploaded = false;
  bool postCodeValidated = false;

  final formKey = new GlobalKey<FormState>();
  final TextEditingController postcodeController = new TextEditingController();
  final TextEditingController cityController = new TextEditingController();
  final TextEditingController streetController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final email = widget.email;
    var globalSearch;

    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Add more details",
                      style: TextStyle(
                          fontSize: klargeFontSize, color: kPrimaryColor),
                      textAlign: TextAlign.left),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 65,
                        backgroundColor: kPrimaryColor,
                        child: (image != null)
                            ? ClipOval(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.file(
                                    image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : ClipRect(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
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
                            getImages();
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
                    decoration: InputDecoration(
                        labelText: "Your email", enabled: false),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Organisation name"),
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: postcodeController,
                    decoration: InputDecoration(labelText: "Post Code"),
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
                  ),
                  postCodeValidated
                      ? ListView(
                          children: [
                            TextFormField(
                              controller: cityController,
                              decoration:
                                  InputDecoration(labelText: "Your city"),
                              validator: (String val) {
                                if (val.isEmpty) {
                                  return "This field cannot be empty";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: streetController,
                              decoration:
                                  InputDecoration(labelText: "Street number"),
                              validator: (String val) {
                                if (val.isEmpty) {
                                  return "This field cannot be empty";
                                }
                                return null;
                              },
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(height: 40),
                  MaterialButton(
                    onPressed: () {
                      // addToDatabase(context);
                      // check if the address is correct
                    },
                    elevation: 0,
                    height: 50,
                    color: kPrimaryColor,
                    minWidth: double.maxFinite,
                    child: Text("CREATE ACCOUNT",
                        style: TextStyle(
                            color: Colors.white, fontSize: ksmallFontSize)),
                    textColor: Colors.white,
                  ),
                ],
              ),
            )));
  }

  Future addToDatabase(BuildContext context) async {
    FirebaseFirestore.instance.collection("shelters").add({
      "email": email,
      "name": nameController.text,
      "city": cityController.text,
      "street": streetController.text,
      "postcode": postcodeController.text,
      "image": "¯\\_(ツ)_/¯ working on it"
    });

    // String fileName = basename(image.path);
    // Reference firebaseReference =
    //     FirebaseStorage.instance.ref().child(fileName);
    // UploadTask uploadTask = firebaseReference.putFile(image);
    // TaskSnapshot taskSnapshot =
    //     await uploadTask.whenComplete(() => {image_uploaded = true});

    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile created succesfully!")));
    });

    print("IMAGE " + image.toString());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => ShelterMainPage(),
            settings: RouteSettings(
                arguments:
                    ArgsSettings(nameController.text, Image.file(image)))),
        ModalRoute.withName("/shelterMain"));
  }

  final picker = ImagePicker();
  Future getImages() async {
    var galleryImg = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      image = File(galleryImg.path);
    });
  }

  Future<Shelter> checkThePostCode(String postcode) async {
    final response = await http
        .get(Uri.https('https://api.postcodes.io/postcodes', postcode));
    if (response.statusCode == 200) {
      var map = Shelter.fromJson(json.decode(response.body));
      return map;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text('Incorrect postcode.')));
      return null;
    }
  }

  void checkPostCode(postcode) {}
}
