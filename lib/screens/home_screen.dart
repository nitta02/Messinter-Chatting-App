import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messinter_app/constants/firebase_constants.dart';
import 'package:messinter_app/screens/login_screen.dart';
import 'package:messinter_app/screens/userChat_screen.dart';
import 'package:messinter_app/utils/firebase_utils.dart';
import 'package:provider/provider.dart';

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
    final userSignOut = Provider.of<FirebaseUtils>(context, listen: false);
    userSignOut.userSignOut().then((value) {
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
      drawer: const Drawer(
        backgroundColor: Colors.black,
      ),
      appBar: AppBar(
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
      body: _buildUserLists(),
    );
  }

  Widget _buildUserLists() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Icon(
              Icons.error_outline,
              size: 80,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _individualUserLists(doc))
              .toList(),
        );
      },
    );
  }

  //individuals user lists
  Widget _individualUserLists(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data()! as Map<String, dynamic>?;

    if (FirebaseConstantss.auth.currentUser!.email != data?['email']) {
      return Card(
        elevation: 3.0,
        margin: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Text(data?['email']),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserChatScreen(
                    userEmail: data?['email'],
                    userID: data?['uid'],
                  ),
                ));
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
