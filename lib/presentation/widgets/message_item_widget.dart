import 'package:flutter/material.dart';
import '../../models/message.dart';

class MessageItemWidget extends StatelessWidget {
  final Message message;
  final String timeString;
  final VoidCallback onTap;

  const MessageItemWidget({
    super.key,
    required this.message,
    required this.timeString,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(message.user.avatar),
            ),
            const SizedBox(width: 12),
            // Message content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.user.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message.lastMessage,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        timeString,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ],
              ),
            ),
            // Camera icon
            IconButton(
              icon: Image.asset('assets/icons/picture.png', width: 24, height: 24),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

