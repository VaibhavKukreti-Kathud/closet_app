import 'package:closet_app/constants.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.isSent,
    required this.message,
  });
  final bool isSent;
  final String message;

  @override
  Widget build(BuildContext context) {
    final ThemeData currTheme = Theme.of(context);
    return Row(
      mainAxisAlignment:
          isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 2),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: !isSent
                ? kSecondaryColor
                : currTheme.textTheme.bodyMedium!.color!.withOpacity(0.03),
            border: Border.all(
              color: currTheme.textTheme.bodyMedium!.color!.withOpacity(0.03),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, 3),
                color: Colors.black.withOpacity(0.03),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: isSent ? Radius.circular(16) : Radius.circular(6),
              bottomRight: isSent ? Radius.circular(6) : Radius.circular(16),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: !isSent
                  ? Colors.white
                  : currTheme.textTheme.bodyMedium!.color,
              fontWeight: !isSent ? FontWeight.w600 : FontWeight.normal,
              letterSpacing: 0.85,
            ),
          ),
        ),
      ],
    );
  }
}
