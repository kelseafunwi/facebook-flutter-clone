import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/screens/error_screen.dart';
import 'package:practice_flutter/core/screens/profile_screen.dart';
import 'package:practice_flutter/features/auth/providers/get_user_info_by_id_as_stream_provider.dart';
import 'package:practice_flutter/features/friends/providers/friends_provider.dart';
import 'package:practice_flutter/widgets/round_button.dart';

import '../../../../core/screens/loader.dart';

class RequestTile extends ConsumerWidget {
  final String userId;

  const RequestTile({super.key, required this.userId});

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
                    Navigator.of(context).pushNamed(ProfileScreen.routeName, arguments: user.uid);
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user.profilePicUrl),
                  ),
                )
            ),

            const SizedBox(height: 15),

            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.fullName, style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: RoundButton(onPressed: () async {
                          await ref.read(friendProvider).acceptFriendRequest(uid: user.uid);
                        }, label: "Accept", height: 30),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: RoundButton(onPressed: () async {
                          await ref.read(friendProvider).removeFriendRequest(userId: user.uid);
                        }, label: "Reject", height: 30),
                      )
                    ],
                  )
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
