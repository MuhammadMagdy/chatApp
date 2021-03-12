import 'file:///C:/Users/Magdy/AndroidStudioProjects/chat_app/lib/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final docs = snapShot.data.docs;
          final user =  FirebaseAuth.instance.currentUser;
          return ListView.builder(
            itemCount: docs.length,
            reverse: true,
            itemBuilder: (context, index) => MessageBubbles(
              docs[index]['text'],
              docs[index]['username'],
              docs[index]['userImage'],
              docs[index]['userId'] == user.uid,
              key: ValueKey(user.uid),
            ),
          );
        });
  }
}
