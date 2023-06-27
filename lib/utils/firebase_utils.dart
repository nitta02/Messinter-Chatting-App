// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messinter_app/constants/firebase_constants.dart';

class FirebaseUtils extends ChangeNotifier {
  //sign in

  Future<UserCredential> signInwithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseConstantss.auth
          .signInWithEmailAndPassword(email: email, password: password);

      //user documents
      FirebaseConstantss.fireStore
          .collection('users')
          .doc(
            userCredential.user!.uid,
          )
          .set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw ('Something went wrong');
    }
  }

  //sign out
  Future<void> userSignOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  //new User Sign Up

  Future<UserCredential> signUpwithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseConstantss.auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //user documents
      FirebaseConstantss.fireStore
          .collection('users')
          .doc(
            userCredential.user!.uid,
          )
          .set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw ('Fill all the informations');
    }
  }
}
