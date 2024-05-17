import 'package:flutter/material.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/comment_list.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/comment_textfield.dart';

class CommentsScreen extends StatelessWidget {
  final String postId;

  const CommentsScreen({super.key, required this.postId});

  static const routeName = '/comments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comment Section"),
      ),
      body: Column(
        children: [

          CommentList(postId: postId),

          CommentTextField(postId: postId),
        ],
      ),
    );
  }
}
