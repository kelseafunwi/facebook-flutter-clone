import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/features/auth/providers/auth_provider.dart';

class ProfileInfoWidget extends ConsumerWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return FutureBuilder(
        future: ref.read(authProvider).getUserInfo(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasData) {
            final user = snapshot.data;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(user!.profilePicUrl),
                ),

                const SizedBox( width : 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        user.fullName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)
                    ),

                    const Text(
                      "Public",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            );
          }

          return Text(
            snapshot.error.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          );
        }
    );
  }
}
