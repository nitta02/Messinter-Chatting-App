// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:messinter_app/screens/login_screen.dart';
import 'package:messinter_app/screens/register_screen.dart';

class LoginORregister extends StatefulWidget {
  const LoginORregister({super.key});

  @override
  State<LoginORregister> createState() => _LoginORregisterState();
}

class _LoginORregisterState extends State<LoginORregister> {
  //initially show the login screen
  bool showLoginPage = true;

  //tooggle between login and register page
  void tooglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        onTap: tooglePages,
      );
    } else {
      return RegisterScreen(
        onTap: tooglePages,
      );
    }
  }
}
