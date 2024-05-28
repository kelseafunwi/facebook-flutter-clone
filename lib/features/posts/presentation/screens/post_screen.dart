import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/screens/error_screen.dart';
import 'package:practice_flutter/core/screens/loader.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/make_post_widget.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/post_tile.dart';
import 'package:practice_flutter/features/posts/providers/get_all_post_provider.dart';
import 'package:practice_flutter/features/story/presentation/screens/stories_view.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  static const routeName = '/post/create';

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        FeedMakePostWidget(),

        SliverToBoxAdapter(
          child: SizedBox(
            height: 8,
          ),
        ),

        // story view
        StoriesView(),

        SliverToBoxAdapter(
          child: SizedBox(
            height: 8,
          ),
        ),

        PostList(),
      ],
    );
  }
}

class PostList extends ConsumerWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(getAllPostProvider);

    return posts.when(data: (postsData) {
      if (kDebugMode) {
        print("Post Data $postsData");
      }

      return SliverList.separated(
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
    }, error: (error, stackTrace) {
      return SliverToBoxAdapter(
        child: ErrorScreen(error: error.toString()),
      );
    }, loading: () {
      return const SliverToBoxAdapter(
        child: Loader(),
      );
    });
  }
}
