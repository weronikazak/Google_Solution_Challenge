import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/User/user_main_screen.dart';
import 'package:gsc_project/constants.dart';
import 'package:sms_autofill/sms_autofill.dart';

class NormalUserRegister extends StatefulWidget {
  @override
  _NormalUserRegisterState createState() => _NormalUserRegisterState();
}

class _NormalUserRegisterState extends State<NormalUserRegister> {
  final formKey = new GlobalKey<FormState>();

  TextEditingController phoneController = new TextEditingController(text: "");
  String phoneNumber = "";
  String verificationID, smsCode;

  SmsAutoFill smsAutoFill = SmsAutoFill();

  String verificationId;
  String otp, authStatus = "";

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
                      style: TextStyle(
                          fontSize: klargeFontSize, color: kPrimaryColor),
                      textAlign: TextAlign.left),
                  SizedBox(height: 20),
                  Text(
                    "We need your phone number just to make sure that you're not a robot or any other suspicious creature.",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        labelText: "Phone number: (+xx xxx-xxx-xxx)",
                        icon: Icon(Icons.phone_iphone)),
                    onChanged: (number) {
                      setState(() {
                        this.phoneNumber = number;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  (phoneController.text == "")
                      ? MaterialButton(
                          onPressed: () async => {
                            this.phoneNumber = await smsAutoFill.hint,
                            this.phoneController.text = this.phoneNumber,
                          },
                          elevation: 0,
                          height: 50,
                          color: kPrimaryColor,
                          minWidth: double.maxFinite,
                          child: Text("Get current number",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ksmallFontSize)),
                          textColor: Colors.white,
                        )
                      : Container(),
                  SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () {
                      (phoneNumber == null || phoneNumber == "")
                          ? null
                          : verifyPhoneNumber(context);
                    },
                    elevation: 0,
                    height: 50,
                    color: kPrimaryColor,
                    minWidth: double.maxFinite,
                    child: Text("SEND OTP CODE",
                        style: TextStyle(
                            color: Colors.white, fontSize: ksmallFontSize)),
                    textColor: Colors.white,
                  ),
                ],
              ),
            )));
  }

  Future<void> signIn(String otp) async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    ))
        .then((value) {
      addToDatabase();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserMainScreen()));
    });
  }

  Future<void> verifyPhoneNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 15),
      verificationCompleted: (AuthCredential authCredential) {
        setState(() {
          authStatus = "Your account is successfully verified";
        });
      },
      verificationFailed: (FirebaseAuthException authException) {
        setState(() {
          authStatus = "Authentication failed";
        });
      },
      codeSent: (String verId, [int forceCodeResent]) {
        verificationId = verId;
        setState(() {
          authStatus = "OTP has been successfully send";
        });
        otpDialogBox(context).then((value) {});
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        setState(() {
          authStatus = "TIMEOUT";
        });
      },
    );
  }

  otpDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter your OTP'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorHeight: kmediumFontSize,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                ),
                onChanged: (value) {
                  otp = value;
                },
              ),
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  signIn(otp);
                },
                elevation: 0,
                height: 50,
                color: kPrimaryColor,
                minWidth: double.maxFinite,
                child: Text("CREATE ACCOUNT",
                    style: TextStyle(
                        color: Colors.white, fontSize: ksmallFontSize)),
                textColor: Colors.white,
              )
            ],
          );
        });
  }

  Future addToDatabase() async {
    await FirebaseFirestore.instance
        .collection("users")
        .add({"phonenumber": phoneNumber});
  }
}
