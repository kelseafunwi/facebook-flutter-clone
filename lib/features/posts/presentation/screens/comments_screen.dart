import 'package:flutter/material.dart';

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
      body: const Column(
        children: [

          // comment place

          // comment text field
        ],
      ),
    );
  }
}
