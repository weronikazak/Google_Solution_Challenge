import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Screens/Shelter/shelter_main_page.dart';
import 'package:gsc_project/Services/auth.dart';

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
      // initialRoute: "/",
      // routes: {
      //   "/": (context) => AuthService().handleAuth(),
      //   "/login": (context) => LoginPage(),
      //   "/registrationType": (context) => ProfileTypeScreen(),
      //   "/registerUser": (context) => NormalUserRegister(),
      //   "/registerShelter": (context) => ShelterRegisterScreen(),
      //   "/shelterDetails": (context) => ShelterDetailsScreen(),
      //   "/shelterMain": (context) => ShelterMainPage(),
      //   "/userMain": (context) => UserMainScreen()
      // },
      routes: {"/shelterMain": (context) => ShelterMainPage()},
      title: 'Kind-Hearted',
      theme: ThemeData(
        // fontFamily: "Nunito",
        fontFamily: 'Fjalla One',
      ),
      debugShowMaterialGrid: false,
      home: AuthService().handleAuth(),
    );
  }
}
