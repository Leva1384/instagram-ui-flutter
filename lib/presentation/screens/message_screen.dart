import 'package:flutter/material.dart';
import '../../models/message.dart';
import '../../repositories/message_repository.dart';
import '../../repositories/user_repository.dart';
import '../widgets/message_item_widget.dart';

class MessageScreen extends StatefulWidget {
  final Function(int) onUserTap;

  const MessageScreen({
    super.key,
    required this.onUserTap,
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final MessageRepository _messageRepository = MessageRepository();
  final UserRepository _userRepository = UserRepository();
  late List<Message> _messages;
  late String _currentUsername;

  @override
  void initState() {
    super.initState();
    _messages = _messageRepository.getMessages();
    _currentUsername = _userRepository.getMe().username;
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _currentUsername,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          return MessageItemWidget(
            message: message,
            timeString: _formatTime(message.date),
            onTap: () => widget.onUserTap(message.user.userId),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, color: Colors.blue.shade600, size: 28),
            const SizedBox(width: 8),
            const Text(
              'Camera',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

