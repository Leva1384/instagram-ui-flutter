import 'package:flutter/material.dart';
import '../../models/post.dart';
import '../../models/user.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final Function(User) onUserTap;

  const PostWidget({
    super.key,
    required this.post,
    required this.onUserTap,
  });

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Post Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => onUserTap(post.user),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(post.user.avatar),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => onUserTap(post.user),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.user.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      if (post.subtitle.isNotEmpty)
                        Text(
                          post.subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              InkWell(
                child: const Icon(Icons.more_horiz),
                onTap: () {},
              ),
            ],
          ),
        ),
        // Post Image
        AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            post.postImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        // Action Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: [
              InkWell(
                child: Image.asset('assets/icons/heart.png', width: 24, height: 24),
                onTap: () {},
              ),
              SizedBox(width: 12),
              InkWell(
                child: Image.asset('assets/icons/comment.png', width: 24, height: 24),
                onTap: () {},
              ),
              SizedBox(width: 12),
              InkWell(
                child: Image.asset('assets/icons/share.png', width: 24, height: 24),
                onTap: () {},
              ),
              const Spacer(),
              InkWell(
                child: Image.asset('assets/icons/bookmark.png', width: 24, height: 24),
                onTap: () {},
              ),
            ],
          ),
        ),
        // Likes
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (post.likedBy != null)
                GestureDetector(
                  onTap: () => onUserTap(post.likedBy!),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        const TextSpan(
                          text: 'Liked by ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: post.likedBy!.username,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        if (post.totalLikes > 1)
                          TextSpan(
                            text: ' and ${_formatNumber(post.totalLikes - 1)} others',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                      ],
                    ),
                  ),
                )
              else
                Text(
                  '${_formatNumber(post.totalLikes)} likes',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              const SizedBox(height: 4),
              // Caption
              GestureDetector(
                onTap: () => onUserTap(post.user),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(
                        text: '${post.user.username} ',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: post.caption),
                    ],
                  ),
                ),
              ),
              if (post.totalComments > 0) ...[
                const SizedBox(height: 4),
                Text(
                  'View all ${post.totalComments} comments',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

