import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../repositories/post_repository.dart';

class ProfilePostsGrid extends StatelessWidget {
  final User user;
  final PostRepository _postRepository = PostRepository();

  ProfilePostsGrid({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final posts = _postRepository
        .getPosts()
        .where((post) => post.user.userId == user.userId)
        .toList();

    if (posts.isEmpty) {
      return const Center(
        child: Text('No posts yet'),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Image.network(
          posts[index].postImage,
          fit: BoxFit.cover,
        );
      },
    );
  }
}

