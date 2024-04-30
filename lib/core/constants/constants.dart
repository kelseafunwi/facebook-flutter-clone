import 'package:flutter/material.dart';
import 'package:practice_flutter/features/posts/presentation/screens/post_screen.dart';

class Constants {

  static const defaultPadding = EdgeInsets.symmetric(
    horizontal: 15,
    vertical: 10,
  );

  static const maleProfileUser = "https://jeremyveldman.com/wp-content/uploads/2019/08/Generic-Profile-Pic.jpg";
  static const profilePicBlank = "https://t3.ftcdn.net/jpg/05/16/27/58/240_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO45SsWv.jpg";

  static List<Tab> getHomeScreenTabs(int index) {
    return [
      Tab(
        icon: Icon(
          index == 0 ? Icons.home : Icons.home_outlined,
          color: Colors.blue,
        ),
      ),

      Tab(
        icon: Icon(
          index == 1 ? Icons.group : Icons.group_outlined,
          color: Colors.blue,
        ),
      ),

      Tab(
        icon: Icon(
          index == 2 ? Icons.smart_display : Icons.smart_display_outlined,
          color: Colors.blue,
        ),
      ),

      Tab(
        icon: Icon(
          index == 3 ? Icons.account_circle : Icons.account_circle_outlined,
          color: Colors.blue,
        ),
      ),

      Tab(
        icon: Icon(
          index == 4 ? Icons.density_medium : Icons.density_medium_outlined,
          color: Colors.blue,
        ),
      ),
    ];
  }

  static List<Widget> screens = [

    const PostScreen(),

    const Center(
      child: Text("view 2")
    ),

    const Center(
      child: Text("view 3")
    ),

    const Center(
      child: Text("view 4")
    ),

    const Center(
      child: Text("view 5")
    ),
  ];

  // need to research why we seem to do this under every class.
  Constants._();
}