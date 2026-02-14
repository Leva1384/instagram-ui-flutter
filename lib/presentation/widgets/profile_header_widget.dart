import 'package:flutter/material.dart';
import '../../models/user.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final User user;
  final bool isOwnProfile;

  const ProfileHeaderWidget({
    super.key,
    required this.user,
    this.isOwnProfile = false,
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(user.avatar),
              ),
              const SizedBox(width: 20),
              // Stats
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatColumn(_formatNumber(user.totalPosts), 'Posts'),
                    _buildStatColumn(
                        _formatNumber(user.totalFollowers), 'Followers'),
                    _buildStatColumn(
                        _formatNumber(user.totalFollowings), 'Following'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Name
          Text(
            user.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          // Bio
          if (user.bio.isNotEmpty)
            Text(
              user.bio,
              style: const TextStyle(fontSize: 14),
            ),
          const SizedBox(height: 12),
          // Edit Profile Button
          if (isOwnProfile)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),
          // Highlights
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildHighlight('New', Icons.add),
                _buildHighlight('Friends', null),
                _buildHighlight('Sport', null),
                _buildHighlight('Design', null),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildHighlight(String label, IconData? icon) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: icon != null
                ? Icon(icon, color: Colors.black, size: 30)
                : null,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

