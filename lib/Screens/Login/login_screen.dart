import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Shelter/shelter_main_page.dart';
import 'package:gsc_project/Screens/User/user_main_screen.dart';

import '../../constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  String phoneEmail, password;

  bool shelterLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Login",
                      style: TextStyle(
                          fontSize: klargeFontSize, color: kPrimaryColor),
                      textAlign: TextAlign.left),
                  SizedBox(height: 20),
                  Text(
                    "Login to your account using email or phone number.",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Enter your phone number or email",
                        icon: Icon(Icons.phone_iphone)),
                    onChanged: (val) {
                      setState(() {
                        if (val.contains("@")) {
                          shelterLogin = true;
                        } else {
                          shelterLogin = false;
                        }
                        this.phoneEmail = val;
                      });
                    },
                  ),
                  shelterLogin
                      ? Padding(
                          padding: EdgeInsets.only(left: 40, right: 10),
                          child: TextFormField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                                hintText: "Enter your password"),
                            onChanged: (val) {
                              setState(() {
                                this.password = val;
                              });
                            },
                          ))
                      : Container(),
                  SizedBox(height: 40),
                  MaterialButton(
                    onPressed: () {
                      if (phoneEmail != "" && formKey.currentState.validate()) {
                        if (shelterLogin) {
                          loginWithEmailAndPassword();
                        } else {
                          loginWithPhoneNumber();
                        }
                      }
                    },
                    elevation: 0,
                    height: 50,
                    color: kPrimaryColor,
                    minWidth: double.maxFinite,
                    child: Text("LOGIN",
                        style: TextStyle(
                            color: Colors.white, fontSize: ksmallFontSize)),
                    textColor: Colors.white,
                  ),
                ],
              ),
            )));
  }

  void createScaffold(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(text)));
  }

  void loginWithEmailAndPassword() async {
    try {
      UserCredential userCreds = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: phoneEmail, password: password)
          .catchError((e) {
        createScaffold(e);
      });

      await instance
          .collection("shelters")
          .where("email", isEqualTo: phoneEmail)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          String shelterId = value.docs.first.id;

          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
                  ShelterMainPage(shelterId: shelterId)));
        }
      });
    } catch (e) {
      // if (e.code == "user-not-found") {
      //   createScaffold("No user found for that email.");
      // } else if (e.code == "wrong-password") {
      //   createScaffold("Wrong password provided for that user.");
      // } else {
      createScaffold(e);
      // }
    }
  }

  void loginWithPhoneNumber() async {
    try {
      await instance
          .collection("users")
          .where("phonenumber", isEqualTo: phoneEmail)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          var pn = value.docs.first.data()["phonenumber"];
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => UserMainScreen()));
        } else {
          createScaffold("Such user doesn't exist.");
        }
      }).catchError((e) {
        createScaffold(e);
      });
    } catch (e) {
      createScaffold("Failed to login. Details: ${e}");
    }
  }
}
