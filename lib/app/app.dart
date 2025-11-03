import 'package:flutter/material.dart';
import 'package:flutter_techhelp_app/modules/auth/view/register_screen.dart';
import 'package:flutter_techhelp_app/modules/home/view/home_screen.dart';
import '../modules/auth/view/login_screen.dart';

class TechhelpApp extends StatelessWidget {
  const TechhelpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TechHelp",
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
      ),
      home: HomeScreen(),
      routes: {
         "login": (context) => LoginScreen(),
         "register": (context) => RegisterScreen(),
      },
    );
  }
}
