// lib/widgets/custom_text_message_widget.dart
import 'package:bloc_learn/widgets/read_more_by_visual_lines.dart';
import 'package:bloc_learn/widgets/read_more_lines.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

class CustomTextMessageWidget extends StatelessWidget {
  final CustomMessage message;
  final bool isMe;

  const CustomTextMessageWidget({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isMe ? Colors.purple[800] : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isMe ? 12 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 12),
          ),
        ),
        // child: ReadMoreByVisualLines(text: message.metadata?['text']),
        child: ReadMoreLines(text: message.metadata?['text']),
        // child: Text(
        //   message.metadata?['text'] ?? "no text",
        //   style: TextStyle(
        //     color: isMe ? Colors.white : Colors.black87,
        //     fontSize: 15,
        //   ),
        // ),
      ),
    );
  }
}
