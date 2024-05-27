import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/features/story/repository/story_repository.dart';

final storyProvider = Provider((ref) {
  // the story provider is going to return the repository to make the creation methods available.
  return StoryRepository();
});