import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Shelter/shelter_details_screen.dart';

import '../../constants.dart';

class ShelterRegisterScreen extends StatefulWidget {
  @override
  _ShelterRegisterScreenState createState() => _ShelterRegisterScreenState();
}

class _ShelterRegisterScreenState extends State<ShelterRegisterScreen> {
  final formKey = new GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // bool success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Create an account",
                      style: TextStyle(fontSize: 30, color: kPrimaryColor),
                      textAlign: TextAlign.left),
                  SizedBox(height: 20),
                  Text(
                    "We need need a little more detail about you in order to keep your account safe?? I don't know, something like that, correct me.",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Enter your email."),
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "This field cannot be empty.";
                      }

                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val);
                      if (!emailValid) {
                        return "This field has to be an email.";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration:
                        InputDecoration(labelText: "Enter your password"),
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "This field cannot be empty.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40),
                  MaterialButton(
                    onPressed: () {
                      // TO CHANGE; TODO
                      if (formKey.currentState.validate()) {
                        registerWithEmailAndPassword();
                      }
                    },
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

  // TODO display what kind of error occured during registration
  void registerWithEmailAndPassword() async {
    final User user = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((e) {
      print(e);
    }))
        .user;
    if (user != null) {
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShelterDetailsScreen(),
                settings: RouteSettings(arguments: emailController.text)));
      });
    }
  }
}