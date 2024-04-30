import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/features/posts/repository/post_repository.dart';

final postProvider = Provider((ref) {
  // this is going to make the functions in the PostRepository available using the provider
  return PostRepository();
});