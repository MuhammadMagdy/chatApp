import 'package:flutter/material.dart';

class MessageBubbles extends StatelessWidget {
  MessageBubbles(this.message, this.username, this.userImage, this.isMe,
      {this.key});

  final Key key;
  final String message;
  final String username;
  final String userImage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 5,
          left: isMe ? 3 : null,
          right: !isMe ? 3 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
            radius: 12,
          ),
        ),
        Row(
          mainAxisAlignment:
              !isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: !isMe ? Color(0xFFdbedf3) : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: isMe ? Radius.circular(0) : Radius.circular(15),
                  bottomRight: !isMe ? Radius.circular(0) : Radius.circular(15),
                ),
              ),
              width: 150,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Column(
                crossAxisAlignment:
                    !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: !isMe ? Colors.black : Colors.white,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: !isMe ? Colors.black : Colors.white,
                    ),
                    textAlign: !isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
