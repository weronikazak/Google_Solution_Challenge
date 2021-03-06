import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Welcome/welcome_screen.dart';
import 'package:gsc_project/Services/auth.dart';
import 'package:gsc_project/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Title is to change ofc, I couldn't think of nothing
      // else
      title: 'Kind-Hearted',
      theme: ThemeData(
          primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
      debugShowMaterialGrid: false,
      // home: AuthService().handleAuth(),
      home: WelcomeScreen(),
    );
  }
}
