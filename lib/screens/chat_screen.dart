import '../chats/new_message.dart';

import '../chats/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
        actions: <Widget>[
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(height: 10),
                      Text("Logut")
                    ],
                  ),
                ),
                value: "Logout",
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == "Logout") {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
              child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
      
    );
  }
}
