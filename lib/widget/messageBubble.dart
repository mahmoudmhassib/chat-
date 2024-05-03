import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final bool isMe;
  final Key key;

  const MessageBubble(this.message, this.username, this.isMe,
      { required this.key,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: !isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: !isMe ? Colors.grey[300] : Colors.greenAccent,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(14),
              topRight: const Radius.circular(14),
              bottomLeft:
                  isMe ? const Radius.circular(0) : const Radius.circular(14),
              bottomRight:
                  !isMe ? const Radius.circular(0) : const Radius.circular(14),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: !isMe ? Colors.black : Colors.green,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  color:! isMe ? Colors.black : Colors.green,
                ),
                textAlign: !isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
