// ignore_for_file: unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messinter_app/constants/firebase_constants.dart';

class FirebaseUtils extends ChangeNotifier {
  //sign in

  Future<UserCredential> signInwithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredentials = await FirebaseConstantss.auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredentials;
    } catch (e) {
      throw FirebaseAuthException(code: 'Something Went wrong');
    }
  }

  //sign out
  Future<void> userSignOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
