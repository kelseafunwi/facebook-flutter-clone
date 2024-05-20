import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/app_colors.dart';
import 'package:practice_flutter/core/constants/extensions.dart';
import 'package:practice_flutter/core/screens/error_screen.dart';
import 'package:practice_flutter/core/screens/loader.dart';
import 'package:practice_flutter/features/auth/providers/get_user_info_by_id.dart';
import 'package:practice_flutter/features/posts/models/comment.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/round_like_button.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/round_profile_tile_widget.dart';
import 'package:practice_flutter/features/posts/providers/post_provider.dart';

class CommentTile extends StatelessWidget {

  final Comment comment;

  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          //  comment header
          CommentHeader(comment: comment),

          // comment footer
          CommentFooter(comment: comment),
        ],
      ),
    );
  }
}


class CommentHeader extends ConsumerWidget {
  final Comment comment;

  const CommentHeader({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(getUserInfoByIdProvider(comment.authorId));
    return userInfo.when(
      data: (userData) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            RoundProfileTile(url: userData.profilePicUrl),

            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData.fullName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )
                    ),

                    Text(
                      "${comment.createdAt.toString()} ${comment.text}",
                    ),
                  ],
                ),
              )
            )
          ],
        );
      },
      error: (error,stackTrace) {
        return ErrorScreen(error: error.toString());
      },
      loading: () {
        return const Loader();
      }
    );
  }
}



class CommentFooter extends StatelessWidget {
  final Comment comment;

  const CommentFooter({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final isLiked = comment.likes.contains(FirebaseAuth.instance.currentUser!.uid);

    return Consumer(
      builder: (context, ref, child) {
        return Row(
          children: [
            Text(
              comment.createdAt.fromNow(),
            ),

            TextButton(
              onPressed: () async {
                await ref.read(postProvider).likeOrDislikeComment(commentId: comment.commentId, likes: comment.likes);
              },
              child: Text(
                "like",
                style: TextStyle(
                  color: isLiked ? AppColors.blueColor : AppColors.darkGreyColor,
                ),
              ),
            ),

            const SizedBox(
              width: 15,
            ),

            const RoundLikeButton(),

            const SizedBox(
              width: 5,
            ),

            Text(comment.likes.length.toString())

          ],
        );
      },
    );
  }
}
