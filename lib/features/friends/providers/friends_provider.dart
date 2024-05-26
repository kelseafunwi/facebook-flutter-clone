import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/features/friends/repository/friends_repository.dart';

// the provider is used to make the Friends information available to the rest of the code
final friendProvider = Provider((ref) {
  // this provider is used by use to make all the methods and variables
  // in this section available any where in the code.
  return FriendsRepository();
});