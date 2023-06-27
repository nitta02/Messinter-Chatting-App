import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messinter_app/constants/firebase_constants.dart';
import 'package:messinter_app/model/message_model.dart';

class ChatServices extends ChangeNotifier {
  //Send Message
  Future<void> sendMessage(String receiverId, String message) async {
    //create a new message
    MessageModel messageModel = MessageModel(
      senderId: FirebaseConstantss.currentUserId,
      senderEmail: FirebaseConstantss.currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: FirebaseConstantss.timeStamp,
    );

    //chat room for currentUser and receiverUser
    List<String> ids = [FirebaseConstantss.currentUserId, receiverId];
    ids.sort();
    String chatRoom = ids.join('_');

    //new Database For ChatRoom
    await FirebaseConstantss.fireStore
        .collection('chat_room')
        .doc(chatRoom)
        .collection('messages')
        .add(messageModel.toMap());
  }

  //Get The message from the database
  Stream<QuerySnapshot> getMessage(String userId, String otheruserId) {
    List<String> ids = [userId, otheruserId];
    ids.sort();
    String chatRoom = ids.join('_');
    return FirebaseConstantss.fireStore
        .collection('chat_room')
        .doc(chatRoom)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
