import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter/core/constants/app_colors.dart';
import 'package:practice_flutter/core/constants/constants.dart';
import 'package:practice_flutter/features/friends/presentation/widgets/friends_list.dart';
import 'package:practice_flutter/features/friends/presentation/widgets/requests_list.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  static const routeName = '/friends';

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.realWhiteColor,
      body: Padding(
        padding: Constants.defaultPadding,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text("Request",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  )),
            ),

            RequestsList(),

            SliverToBoxAdapter(
              child: Divider(
                height: 15,
                color: Colors.black,
                thickness: 3,
              ),
            ),

            SliverToBoxAdapter(
              child: Text("Friends",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  )),
            ),

            FriendsList(),
          ],
        ),
      ),
    );
  }
}
