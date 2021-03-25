import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  final TextEditingController extraInfoController = new TextEditingController();

  double latitude = 0.0;
  double longitude = 0.0;
  String city = "";

  String shelterKey;

  @override
  Widget build(BuildContext context) {
    final email = widget.email;
    final GlobalKey<FormState> formValidator = GlobalKey<FormState>();

    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Form(
              key: formValidator,
              child: Expanded(
                child: Center(
                  child: ListView(shrinkWrap: true,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Add more details",
                            style: TextStyle(
                                fontSize: klargeFontSize, color: kPrimaryColor),
                            textAlign: TextAlign.center),
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
                          style: TextStyle(color: Colors.grey),
                          decoration: InputDecoration(
                              labelText: "Your email", enabled: false),
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration:
                              InputDecoration(labelText: "Organisation name"),
                          validator: (String val) {
                            if (val.isEmpty) {
                              return "This field cannot be empty";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          inputFormatters: [UpperCaseTextFormatter()],
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
                            ? Column(
                                children: [
                                  TextFormField(
                                    // initialValue: city,
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
                                        InputDecoration(labelText: "Street"),
                                    validator: (String val) {
                                      if (val.isEmpty) {
                                        return "This field cannot be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  TextField(
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    controller: extraInfoController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                        hintText:
                                            'Add some information about your institution.'),
                                  )
                                ],
                              )
                            : Container(),
                        SizedBox(height: 40),
                        postCodeValidated
                            ? MaterialButton(
                                onPressed: () {
                                  if (formValidator.currentState.validate()) {
                                    addToDatabase(context);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShelterMainPage(
                                                    shelterId: shelterKey)));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Something went wrong")));
                                  }
                                },
                                elevation: 0,
                                height: 50,
                                color: kPrimaryColor,
                                minWidth: double.maxFinite,
                                child: Text("CREATE ACCOUNT",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ksmallFontSize)),
                                textColor: Colors.white,
                              )
                            : MaterialButton(
                                onPressed: () {
                                  if (checkThePostCode(
                                          postcodeController.text) !=
                                      null) {
                                    postCodeValidated = true;
                                  }
                                },
                                elevation: 0,
                                height: 50,
                                color: kPrimaryColor,
                                minWidth: double.maxFinite,
                                child: Text("CHECK POSTCODE",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ksmallFontSize)),
                                textColor: Colors.white,
                              ),
                      ]),
                ),
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
      "image": "¯\\_(ツ)_/¯ working on it",
      "description": extraInfoController.text,
      "latitude": latitude,
      "longitude": longitude
    }).then((value) => this.shelterKey = value.id);

    // String fileName = basename(image.path);
    // Reference firebaseReference =
    //     FirebaseStorage.instance.ref().child(fileName);
    // UploadTask uploadTask = firebaseReference.putFile(image);
    // TaskSnapshot taskSnapshot =
    //     await uploadTask.whenComplete(() => {print("woooo")});

    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile created succesfully!")));
    });

    print("IMAGE " + image.toString());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => ShelterMainPage(
                  shelterId: shelterKey,
                ),
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
    postcode = postcode.replaceAll(" ", "").toLowerCase();
    // final response = await http.get(Uri.https("https://api.getAddress.io/find",
    //     "$postcode?api-key=5ChLN7u9NkKJoEBMbiQIbA30704&expand=true"));
    postcode = postcode.replaceAll(" ", "");
    final response =
        await http.get(Uri.https("api.postcodes.io", "postcodes/$postcode"));

    if (response.statusCode == 200) {
      Shelter shelter = Shelter.fromJson(jsonDecode(response.body));
      print("!!!!!RESPONSE " + jsonDecode(response.body).toString());

      setState(() {
        this.longitude = shelter.longitude;
        this.latitude = shelter.latitude;
        this.city = shelter.city;
        this.cityController.text = shelter.city;
      });
      print(longitude.toString() + " " + latitude.toString() + " " + city);
      return shelter;
    } else {
      setState(() {
        postCodeValidated = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text('Incorrect postcode.')));
      return null;
    }
  }

  void checkPostCode(postcode) {}
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
