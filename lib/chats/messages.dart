import 'package:chat_app/chats/message_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
              stream: Firestore.instance
                  .collection("chat")
                  .orderBy("createdAt", descending: true)
                  .snapshots(),
              builder: (ctx, chatSnapshots) {
                if (chatSnapshots.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    reverse: true,
                    itemCount: chatSnapshots.data.documents.length,
                    itemBuilder: (ctx, index) {
                      return MessageBubble(
                        chatSnapshots.data.documents[index]["text"],
                        chatSnapshots.data.documents[index]["userId"] ==
                            futureSnapshot.data.uid,
                        chatSnapshots.data.documents[index]["userName"],
                        key: ValueKey(
                            chatSnapshots.data.documents[index].documentID),
                      );
                    });
              });
        });
  }
}
