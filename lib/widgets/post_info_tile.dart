import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/extensions.dart';
import 'package:practice_flutter/core/screens/loader.dart';
import 'package:practice_flutter/core/screens/profile_screen.dart';
import 'package:practice_flutter/features/auth/providers/get_user_info_by_id.dart';

class PostInfoTile extends ConsumerWidget {
  const PostInfoTile(
      {super.key, required this.datePublished, required this.userId});

  final DateTime datePublished;
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(getUserInfoByIdProvider(userId));

    return userInfo.when(data: (user) {
      return GestureDetector(
        onTap: () {
          if (kDebugMode) {
            print("User switched to the other user");
          }
          Navigator.of(context)
              .pushNamed(ProfileScreen.routeName, arguments: userId);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (user.profilePicUrl.isNotEmpty)
                CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePicUrl),
                  backgroundColor: Colors.grey,
                )
              else
                GestureDetector(
                  child: const CircleAvatar(
                    backgroundColor: Colors.grey,
                  ),
                ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    datePublished.fromNow(),
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_horiz),
            ],
          ),
        ),
      );
    }, error: (error, stackTrace) {
      if (kDebugMode) {
        print(stackTrace.toString());
      }
      return const SizedBox(height: 10);
    }, loading: () {
      return const Loader();
    });
  }
}
