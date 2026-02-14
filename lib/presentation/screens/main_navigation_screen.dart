import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../repositories/user_repository.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'message_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  final UserRepository _userRepository = UserRepository();
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _userRepository.getMe();
  }

  void _navigateToProfile(User user) {
    if (user.userId == _currentUser.userId) {
      // Navigate to profile tab
      setState(() {
        _currentIndex = 4;
      });
    } else {
      // Navigate to other user's profile screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            user: user,
            isOwnProfile: false,
            onUserTap: _navigateToProfile,
          ),
        ),
      );
    }
  }

  void _navigateToMessages() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MessageScreen(
          onUserTap: (userId) {
            final user = _userRepository.getUserById(userId);
            if (user != null) {
              Navigator.of(context).pop();
              _navigateToProfile(user);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            onUserTap: _navigateToProfile,
            onMessageTap: _navigateToMessages,
          ),
          const PlaceholderScreen(title: 'Search'),
          const PlaceholderScreen(title: 'Reels'),
          const PlaceholderScreen(title: 'Shop'),
          ProfileScreen(
            user: _currentUser,
            isOwnProfile: true,
            onUserTap: _navigateToProfile,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home.png', width: 20, height: 20),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/search.png', width: 20, height: 20),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/reels.png', width: 20, height: 20),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/shop.png', width: 20, height: 20),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 10,
              backgroundImage: NetworkImage(_currentUser.avatar),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(title, style: TextStyle(color: Colors.black),),
        elevation: 0,
      ),
      body: Center(
        child: Text(title),
      ),
    );
  }
}

