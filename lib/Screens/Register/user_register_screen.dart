import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Services/auth.dart';
import 'package:gsc_project/constants.dart';

class NormalUserRegister extends StatefulWidget {
  @override
  _NormalUserRegisterState createState() => _NormalUserRegisterState();
}

class _NormalUserRegisterState extends State<NormalUserRegister> {
  final formKey = new GlobalKey<FormState>();

  String phoneNumber, verificationID, smsCode;

  bool codeSent = false;

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
                  Text("Create an account",
                      style: TextStyle(fontSize: 30, color: kPrimaryColor),
                      textAlign: TextAlign.left),
                  SizedBox(height: 20),
                  Text(
                    "We need your phone number just to make sure that you're not a robot / different creature / no idea for this description but something like that",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Enter your phone number",
                        icon: Icon(Icons.phone_iphone)),
                    onChanged: (number) {
                      setState(() {
                        this.phoneNumber = number;
                      });
                    },
                  ),
                  codeSent
                      ? TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(hintText: "Enter OTP"),
                          onChanged: (code) {
                            setState(() {
                              this.smsCode = code;
                            });
                          },
                        )
                      : Container(),
                  SizedBox(height: 40),
                  MaterialButton(
                    onPressed: () {
                      codeSent
                          ? AuthService().signInWithOTP(smsCode, verificationID)
                          : verifyPhone(phoneNumber);
                    },
                    elevation: 0,
                    height: 50,
                    color: kPrimaryColor,
                    minWidth: double.maxFinite,
                    child: codeSent
                        ? Text("SENT CODE",
                            style: TextStyle(color: Colors.white, fontSize: 16))
                        : Text("CREATE ACCOUNT",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                    textColor: Colors.white,
                  ),
                ],
              ),
            )));
  }

  Future<void> verifyPhone(String phoneNumber) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print("${authException.message}");
    };

    final PhoneCodeSent smsSent = (String verID, [int forceResend]) {
      this.verificationID = verID;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verID) {
      this.verificationID = verID;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }
}
