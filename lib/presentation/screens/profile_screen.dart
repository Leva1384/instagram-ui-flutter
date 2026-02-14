import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../repositories/user_repository.dart';
import '../widgets/profile_header_widget.dart';
import '../widgets/profile_posts_grid.dart';

class ProfileScreen extends StatefulWidget {
  final User? user;
  final bool isOwnProfile;
  final Function(User) onUserTap;

  const ProfileScreen({
    super.key,
    this.user,
    this.isOwnProfile = false,
    required this.onUserTap,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _displayUser;
  final UserRepository _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    _displayUser = widget.user ?? _userRepository.getMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: widget.isOwnProfile
            ? null
            : IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isOwnProfile) const Icon(Icons.lock, color: Colors.black, size: 18),
            if (widget.isOwnProfile) const SizedBox(width: 4),
            Text(
              _displayUser.username,
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
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ProfileHeaderWidget(
                    user: _displayUser,
                    isOwnProfile: widget.isOwnProfile,
                  ),
                ],
              ),
            ),
            const TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.person_pin)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ProfilePostsGrid(user: _displayUser),
                  const Center(child: Text('Tagged posts')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

