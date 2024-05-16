import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/screens/error_screen.dart';
import 'package:practice_flutter/core/screens/loader.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/post_tile.dart';
import 'package:practice_flutter/features/posts/providers/get_all_videos_provider.dart';

class VideoScreen extends ConsumerWidget {
  const VideoScreen({super.key});

  static const routeName = '/post/videos';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(getAllVideoProvider);

    return posts.when(
      data: (postsData) {
        return ListView.separated(
          itemCount: postsData.length,
          itemBuilder: (context, int index) {

            final post = postsData.elementAt(index);

            return Row(
              children: [

                Expanded(child: PostTile(post: post)),

              ],
            );
          },

          separatorBuilder: (context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
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