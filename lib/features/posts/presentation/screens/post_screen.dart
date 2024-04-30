import 'package:flutter/material.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/make_post_widget.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  static const routeName = '/post/create';

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        FeedMakePostWidget()
      ],
    );
  }
}
