// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messinter_app/chats/chat_bubble.dart';
import 'package:messinter_app/chats/chat_services.dart';
import 'package:messinter_app/constants/firebase_constants.dart';
import 'package:messinter_app/widgets/textform.dart';
import 'package:velocity_x/velocity_x.dart';

class UserChatScreen extends StatefulWidget {
  final String userEmail;
  final String userID;
  const UserChatScreen({
    Key? key,
    required this.userEmail,
    required this.userID,
  }) : super(key: key);

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatServices _chatServices = ChatServices();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(widget.userID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userEmail),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          //Messagesss
          Expanded(
            child: _messageList(),
          ),

          //user send message
          _usersendMessage(),
        ],
      ),
    );
  }

  Widget _messageList() {
    return StreamBuilder(
      stream: _chatServices.getMessage(
          widget.userID, FirebaseConstantss.auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Icon(
            Icons.error,
            size: 50,
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _messageItems(document))
              .toList(),
        );
      },
    );
  }

  Widget _messageItems(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var aligment =
        (data['senderId'] == FirebaseConstantss.auth.currentUser!.uid)
            ? Alignment.centerRight
            : Alignment.centerLeft;

    return Container(
      alignment: aligment,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            (data['senderId'] == FirebaseConstantss.auth.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
        mainAxisAlignment:
            (data['senderId'] == FirebaseConstantss.auth.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        children: [
          Text(
            data['senderEmail'],
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w300,
            ),
          ),
          4.heightBox,
          ChatBubble(
            text: data['message'],
          ),
        ],
      ),
    );
  }

  Widget _usersendMessage() {
    return Row(
      children: [
        Expanded(
          child: CustomTextForm(
            hintText: 'Send Message',
            prefixIcon: const Icon(Icons.message_outlined),
            controller: _messageController,
            obscureText: false,
          ),
        ),
        IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              size: 30,
            ))
      ],
    );
  }
}
