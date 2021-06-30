import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Services/auth.dart';

import 'Screens/Login/login_screen.dart';
import 'Screens/Register/profile_type_screen.dart';
import 'Screens/Register/shelter_register_screen.dart';
import 'Screens/Register/user_register_screen.dart';
import 'Screens/User/user_main_screen.dart';

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
      initialRoute: "/",
      routes: {
        "/": (context) => AuthService().handleAuth(),
        "/login": (context) => LoginPage(),
        "/registrationType": (context) => ProfileTypePage(),
        "/registerUser": (context) => NormalUserRegister(),
        "/registerShelter": (context) => ShelterRegisterScreen(),
        // "/shelterDetails": (context) => ShelterDetailsScreen(),
        // "/shelterMain": (context) => ShelterMainPage(),
        "/userMain": (context) => UserMainScreen()
      },
      title: 'How are you?',
      theme: ThemeData(
        // fontFamily: "Nunito",
        fontFamily: 'Fjalla One',
      ),
      debugShowMaterialGrid: false,
      // home: AuthService().handleAuth(),
    );
  }
}
