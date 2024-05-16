import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/features/posts/repository/post_repository.dart';

final postProvider = Provider((ref) {
  return PostRepository();
});