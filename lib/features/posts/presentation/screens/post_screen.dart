import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/screens/error_screen.dart';
import 'package:practice_flutter/core/screens/loader.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/make_post_widget.dart';
import 'package:practice_flutter/features/posts/providers/get_all_post_provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  static const routeName = '/post/create';

  @override
  Widget build(BuildContext context) {
    // why choose to use the slivers properties of the CustomerScrollView
    // does it offer us some extra functionality or extra styling to the page.
    return const CustomScrollView(
      slivers: [
        FeedMakePostWidget(),

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

    posts.when(
        data: (postsData) {
          return SliverList.separated(
            itemCount: postsData.length,
            itemBuilder: (context, int index) {
              final post = postsData.elementAt(index);
              return Text(
                post.content,
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
          return SliverToBoxAdapter(
            child: ErrorScreen(error: error.toString()),
          );
        },
        loading: () {
          return const SliverToBoxAdapter(
            child: Loader(),
          );
        }
    );

    return const SliverToBoxAdapter(
      child: Text("The main component did not load")
    );
  }
}
