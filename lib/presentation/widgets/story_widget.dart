import 'package:flutter/material.dart';
import '../../models/user.dart';

class StoryWidget extends StatelessWidget {
  final User user;
  final bool isYourStory;
  final bool seen;
  final VoidCallback onTap;

  const StoryWidget({
    super.key,
    required this.user,
    this.isYourStory = false,
    this.seen = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isYourStory
                      ? Colors.grey.shade400
                      : (seen ? Colors.grey.shade400 : Colors.red),
                  width: 2.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(user.avatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: isYourStory
                      ? Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isYourStory ? 'Your story' : user.username,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

