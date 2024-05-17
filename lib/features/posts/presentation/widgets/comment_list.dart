import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/screens/error_screen.dart';
import 'package:practice_flutter/core/screens/loader.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/comment_tile.dart';
import 'package:practice_flutter/features/posts/providers/get_all_comments_provider.dart';

class CommentList extends ConsumerWidget {

  final String postId;

  const CommentList({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(getAllCommentsProvider(postId));

    return Expanded(
      child: post.when(
        data: (commentList) {
          return ListView.builder(
            itemCount: commentList.length,
            itemBuilder: (context, index) {
              final comment = commentList.elementAt(index);
              return CommentTile(comment: comment);
            },
          );
        },
        error: (error,stackTrace) {
          return ErrorScreen(error: error.toString());
        },
        loading: () {
          return const Loader();
        }
      )
    );
  }
}
