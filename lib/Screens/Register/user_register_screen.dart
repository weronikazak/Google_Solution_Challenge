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

  bool phoneFilled = false;

  bool codeSent = false;
  SmsAutoFill smsAutoFill = SmsAutoFill();

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
                    "We need your phone number just to make sure that you're not a robot / different creature / no idea for this description but something like that",
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
                  codeSent
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(hintText: "OTP Code"),
                            onChanged: (code) {
                              setState(() {
                                this.smsCode = code;
                                // phoneFilled = true;
                              });
                            },
                          ))
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  (!phoneFilled)
                      ? MaterialButton(
                          onPressed: () async => {
                            this.phoneNumber = await smsAutoFill.hint,
                            this.phoneController.text = this.phoneNumber,
                            phoneFilled = true
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
                  codeSent
                      ? MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserMainScreen()));
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
                            verifyPhone(phoneController.text);
                            codeSent = true;
                          },
                          elevation: 0,
                          height: 50,
                          color: kPrimaryColor,
                          minWidth: double.maxFinite,
                          child: Text("SEND OTP CODE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ksmallFontSize)),
                          textColor: Colors.white,
                        ),
                ],
              ),
            )));
  }

  Future<void> verifyPhone(String phoneNumber) async {
    final PhoneVerificationCompleted verified =
        (PhoneAuthCredential authResult) async {
      await FirebaseAuth.instance.signInWithCredential(authResult);
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
              'Phone number verification failed. Message: ${authException.message}')));
    };

    PhoneCodeSent smsSent = (String verID, [int forceResend]) async {
      this.verificationID = verID;
      setState(() {
        this.codeSent = true;
      });
    };

    PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verID) {
      this.verificationID = verID;
    };

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Failed to Verify Number: ${e}')));
    }
  }
}
