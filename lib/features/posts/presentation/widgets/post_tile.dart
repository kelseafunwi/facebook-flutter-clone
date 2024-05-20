import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practice_flutter/core/constants/app_colors.dart';
import 'package:practice_flutter/features/posts/models/post.dart';
import 'package:practice_flutter/features/posts/presentation/screens/comments_screen.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/icon_text_button.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/post_image_video_view.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/round_like_button.dart';
import 'package:practice_flutter/features/posts/providers/post_provider.dart';
import 'package:practice_flutter/widgets/post_info_tile.dart';

class PostTile extends StatelessWidget {

  final Post post;

  const PostTile({super.key,required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          PostInfoTile(datePublished: post.datePublished, userId: post.posterId),

          if (post.content.isNotEmpty)
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(post.content),
            ),

          if (post.fileUrl.isNotEmpty) PostImageVideoView(fileType: post.postType, fileUrl: post.fileUrl),

          Column(
            children: [

              PostStats(likes: post.likes),

              const Divider(),

              PostButtons(post: post),
            ],
          ),

        ],
      ),
    );
  }
}

class PostStats extends StatelessWidget {
  const PostStats({super.key, required this.likes});

  final List<String> likes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: Row(
        children: [
          const RoundLikeButton(),

          const SizedBox(width: 5),

          Text(
            "${likes.length}",
            style: const TextStyle(

            ),
          )
        ],
      ),
    );
  }
}

class PostButtons extends ConsumerWidget {
  const PostButtons({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isLiked = post.likes.contains(FirebaseAuth.instance.currentUser!.uid);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconTextButton(
            icon: isLiked ? FontAwesomeIcons.solidThumbsUp :  FontAwesomeIcons.thumbsUp,
            color: isLiked ? AppColors.blueColor: AppColors.blackColor,
            label: "Like",
            onPressed: () {
              ref.read(postProvider).likeOrDislikePost(postId: post.postId, likes: post.likes);
            },
          ),
          IconTextButton(
            icon: FontAwesomeIcons.solidMessage,
            label: "Comment",
            onPressed: () {
              try {
                Navigator.of(context).pushNamed(CommentsScreen.routeName, arguments: post.postId);
              } catch (error) {
                if(kDebugMode) {
                  print("Error ${error.toString()}");
                }
              }
            }
          ),
          const IconTextButton(icon: FontAwesomeIcons.share, label: "Share"),
        ],
      ),
    );
  }
}
