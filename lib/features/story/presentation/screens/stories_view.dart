import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/app_colors.dart';
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
            child: SliverList.builder(
              itemCount: stories.length + 1,
              itemBuilder: (context, index) {
                if (index == 0 ) {
                  return const AddStoryTile();
                }

                final story = stories.elementAt(index - 1);

                return InkWell(
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
        return const  SliverToBoxAdapter(child: Loader());
      },
    );
  }
}
