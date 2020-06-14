
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final key;
  final String userName;
  MessageBubble(this.message, this.isMe, this.userName, {this.key});
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
                    Text(

                      userName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor),
                    ),
                  
              Container(
                width: 140,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color:
                        isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft:
                            !isMe ? Radius.circular(0) : Radius.circular(12),
                        bottomRight:
                            isMe ? Radius.circular(0) : Radius.circular(12))),
                child: Text(message,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline1
                                .color),
                    textAlign: isMe ? TextAlign.end : TextAlign.start),
              ),
            ],
          ),
        ]);
  }
}
