import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Shelter/shelter_main_page.dart';

import '../constants.dart';

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
                      style: TextStyle(fontSize: 30, color: kPrimaryColor),
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
                      if (formKey.currentState.validate()) {
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
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    textColor: Colors.white,
                  ),
                ],
              ),
            )));
  }

  void loginWithEmailAndPassword() async {
    final User user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: phoneEmail, password: password))
        .user;

    if (user != null) {
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ShelterMainPage()));
      });
    } else {
      print("Something went wrong");
    }
  }

  void loginWithPhoneNumber() async {
    ConfirmationResult confirmationResult = await FirebaseAuth.instance
        .signInWithPhoneNumber(
            phoneEmail,
            RecaptchaVerifier(
                container: "recaptcha",
                size: RecaptchaVerifierSize.compact,
                theme: RecaptchaVerifierTheme.dark));
  }
}
