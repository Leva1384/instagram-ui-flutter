import 'package:flutter/material.dart';
import '../../models/post.dart';
import '../../models/story.dart';
import '../../models/user.dart';
import '../../repositories/post_repository.dart';
import '../../repositories/story_repository.dart';
import '../../repositories/user_repository.dart';
import '../widgets/story_widget.dart';
import '../widgets/post_widget.dart';

class HomeScreen extends StatefulWidget {
  final Function(User) onUserTap;
  final VoidCallback onMessageTap;

  const HomeScreen({
    super.key,
    required this.onUserTap,
    required this.onMessageTap,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostRepository _postRepository = PostRepository();
  final StoryRepository _storyRepository = StoryRepository();
  final UserRepository _userRepository = UserRepository();
  late List<Post> _posts;
  late List<Story> _stories;
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _posts = _postRepository.getPosts();
    _stories = _storyRepository.getStories();
    _currentUser = _userRepository.getMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset('assets/icons/instagram_logo.png', width: 100, height: 36),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/icons/add.png', width: 20, height: 20),
            ),
          ),
          InkWell(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/icons/heart.png', width: 20, height: 20),
            ),
          ),
          InkWell(
            onTap: widget.onMessageTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/icons/share.png', width: 20, height: 20),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Stories Section
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              itemCount: _stories.length + 1, // +1 for "Your Story"
              itemBuilder: (context, index) {
                if (index == 0) {
                  // "Your Story" widget
                  return StoryWidget(
                    user: _currentUser,
                    isYourStory: true,
                    onTap: () {},
                  );
                }
                return StoryWidget(
                  user: _stories[index - 1].user,
                  isYourStory: false,
                  seen: _stories[index - 1].seen,
                  onTap: () {},
                );
              },
            ),
          ),
          // Posts Section
          ..._posts.map((post) => PostWidget(
                post: post,
                onUserTap: widget.onUserTap,
              )),
        ],
      ),
    );
  }
}

