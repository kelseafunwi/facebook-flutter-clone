import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/screens/error_screen.dart';
import 'package:practice_flutter/core/screens/loader.dart';
import 'package:practice_flutter/features/friends/presentation/widgets/request_tile.dart';
import 'package:practice_flutter/features/friends/providers/get_all_friend_requests_provider.dart';

class RequestsList extends ConsumerStatefulWidget {
  const RequestsList({super.key});

  @override
  ConsumerState<RequestsList> createState() => _RequestsListState();
}

class _RequestsListState extends ConsumerState<RequestsList> {
  @override
  Widget build(BuildContext context) {
    final requestsList = ref.watch(getAllFriendRequestsProvider);

    return requestsList.when(data: (requests) {
      return SliverList.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            // get the index of each of the request.
            final userId = requests.elementAt(index);
            return RequestTile(
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
