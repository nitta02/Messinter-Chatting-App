// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:messinter_app/screens/login_screen.dart';
import 'package:messinter_app/utils/firebase_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //userSignOut
  void signOut() {
    FirebaseUtils().userSignOut().then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text("Messinter"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: signOut,
              icon: const Icon(
                Icons.logout_sharp,
              ))
        ],
      ),
    );
  }
}
