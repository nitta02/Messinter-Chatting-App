import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseConstantss {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static String currentUserId = auth.currentUser!.uid;
  static String currentUserEmail = auth.currentUser!.email.toString();
  static Timestamp timeStamp = Timestamp.now();
}
