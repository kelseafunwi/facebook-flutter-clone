import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/screens/error_screen.dart';
import 'package:practice_flutter/core/screens/loader.dart';
import 'package:practice_flutter/features/friends/presentation/widgets/friend_tile.dart';
import 'package:practice_flutter/features/friends/providers/get_all_friends_provider.dart';

class FriendsList extends ConsumerStatefulWidget {
  const FriendsList({super.key});

  @override
  ConsumerState<FriendsList> createState() => _RequestsListState();
}

class _RequestsListState extends ConsumerState<FriendsList> {
  @override
  Widget build(BuildContext context) {
    final friendsList = ref.watch(getAllFriendsProvider);

    return friendsList.when(data: (requests) {
      return SliverList.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            // get the index of each of the request.
            final userId = requests.elementAt(index);
            return FriendTile(
                userId: userId
            );
          });
    }, error: (error, stacktrace) {
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
