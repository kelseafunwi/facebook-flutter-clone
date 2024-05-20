import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/app_colors.dart';
import 'package:practice_flutter/features/posts/providers/post_provider.dart';

class CommentTextField extends ConsumerStatefulWidget {

  final String postId;

  const CommentTextField({super.key, required this.postId});

  @override
  ConsumerState<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends ConsumerState<CommentTextField> {

  late final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(
          left: 15,
        ),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Write your comment",
            border: InputBorder.none,
            suffix: IconButton(
              onPressed: makeComment,
              icon: const Icon(Icons.send),
            )
          ),
        ),
      ),
    );
  }

  Future<void> makeComment() async {
    final text = controller.text.trim();
    controller.clear();
    await ref.read(postProvider).makeComment(text: text, postId: widget.postId);
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
