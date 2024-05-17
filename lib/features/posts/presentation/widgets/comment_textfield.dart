import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      child: Text('Textfield'),
    );
  }

  Future<void> makeComment() async {
    
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
