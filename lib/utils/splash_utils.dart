import 'dart:async';
import 'package:flutter/material.dart';
import 'package:messinter_app/constants/firebase_constants.dart';
import 'package:messinter_app/screens/home_screen.dart';
import 'package:messinter_app/services/auth/loginORregister.dart';

class SplashUtils {
  void splashUtils(BuildContext context) {
    if (FirebaseConstantss.auth.currentUser != null) {
      Timer(const Duration(seconds: 5), () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      });
    } else {
      Timer(const Duration(seconds: 5), () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginORregister(),
            ));
      });
    }
  }
}
