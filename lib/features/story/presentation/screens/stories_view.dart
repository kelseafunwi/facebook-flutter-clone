import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/app_colors.dart';
import 'package:practice_flutter/features/story/presentation/screens/story_view_screen.dart';
import 'package:practice_flutter/features/story/presentation/widgets/add_story_tile.dart';
import 'package:practice_flutter/features/story/presentation/widgets/story_tile.dart';
import 'package:practice_flutter/features/story/providers/get_all_stories_provider.dart';

import '../../../../core/screens/error_screen.dart';
import '../../../../core/screens/loader.dart';

class StoriesView extends ConsumerWidget {
  const StoriesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storyData = ref.watch(getAllStoriesProvider);

    return storyData.when(
      data: (stories) {

        return SliverToBoxAdapter(
          child: Container(
            height: 200,
            color: AppColors.realWhiteColor,
            //  we return the ListView.builder since this sis a container and not a CustomerScrollView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stories.length + 1,
              itemBuilder: (context, index) {

                // we are going to put that add story widget as the first thing.
                if (index == 0 ) {
                  return const AddStoryTile();
                }

                final story = stories.elementAt(index - 1);

                return InkWell(
                  onTap: () {
                    // a click of this will take us to the story view.
                    Navigator.of(context).pushNamed(StoryViewScreen.routeName, arguments: stories.toList());
                  },
                  child: StoryTile(imageUrl: story.imageUrl),
                );
              }
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return SliverToBoxAdapter(
            child: ErrorScreen(error: error.toString()));
      },
      loading: () {
        return const SliverToBoxAdapter(child: Loader());
      },
    );
  }
}
