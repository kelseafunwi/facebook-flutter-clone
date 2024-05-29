import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/app_colors.dart';
import 'package:practice_flutter/core/constants/constants.dart';
import 'package:practice_flutter/core/constants/extensions.dart';
import 'package:practice_flutter/core/screens/error_screen.dart';
import 'package:practice_flutter/core/screens/loader.dart';
import 'package:practice_flutter/features/auth/providers/get_user_info_by_id_as_stream_provider.dart';
import 'package:practice_flutter/features/friends/presentation/widgets/add_friend_button.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/icon_text_button.dart';
import 'package:practice_flutter/widgets/round_button.dart';

// this component is going to be used to display the profile page for any of our users

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key, this.userId});

  static const routeName = '/profile';

  final String? userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myUid = FirebaseAuth.instance.currentUser!.uid;
    final currentId = userId ?? myUid;
    final userInfo = ref.watch(getUserInfoByIdAsStreamProvider(currentId));

    // when method is used when we want to display data from a stream
    // and does the particular action each time we receive the data from the backend
    return userInfo.when(data: (user) {
      return SafeArea(
        child: Scaffold(
        appBar: userId != myUid ? AppBar(
          elevation: 0,
          backgroundColor: AppColors.realWhiteColor,
          title: const Text("Profile Screen"),
        ) : null,
        backgroundColor: AppColors.realWhiteColor,
        body: Padding(
          padding: Constants.defaultPadding,
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  minRadius: 50,
                  backgroundImage: NetworkImage(user.profilePicUrl),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                user.fullName,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 21,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              user.uid != myUid ? AddFriendButton(user: user) : _buildAddStoryButton(),

              _buildProfileInfo(email: user.email, birthday: user.birthday, gender: user.gender),
            ],
          ),
        ),
      ));
    }, error: (error, stackTrace) {
      return const ErrorScreen(error: "Error occured");
    }, loading: () {
      return const Loader();
    });
  }

  _buildAddStoryButton() =>
      RoundButton(onPressed: () {}, label: "Add to story");

  _buildProfileInfo(
          {required String email,
          required String gender,
          required DateTime birthday}) =>
      Column(
        children: [
          IconTextButton(
              icon: gender == 'male' ? Icons.male : Icons.female, label: gender),

          IconTextButton(
              icon: Icons.cake, label: birthday.yMMMEd()),

          IconTextButton(
              icon: Icons.email, label: email)
        ],
      );
}
