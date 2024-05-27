import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/screens/error_screen.dart';
import 'package:practice_flutter/core/screens/profile_screen.dart';
import 'package:practice_flutter/features/auth/providers/get_user_info_by_id_as_stream_provider.dart';

import '../../../../core/screens/loader.dart';

class FriendTile extends ConsumerWidget {
  final String userId;

  const FriendTile({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(getUserInfoByIdAsStreamProvider(userId));
    return userData.when(data: (user) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProfileScreen.routeName,
                        arguments: user.uid);
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user.profilePicUrl),
                  ),
                )),
            const SizedBox(height: 15),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }, error: (error, stackTrace) {
      return ErrorScreen(error: error.toString());
    }, loading: () {
      return const Loader();
    });
  }
}
