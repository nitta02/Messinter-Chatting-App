import 'dart:async';

import 'package:flutter/material.dart';
import 'package:messinter_app/screens/login_screen.dart';

class SplashUtils {
  void splashUtils(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    });
  }
}
