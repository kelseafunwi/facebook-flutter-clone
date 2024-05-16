import 'package:flutter/material.dart';
import 'package:practice_flutter/core/constants/app_colors.dart';

class RoundProfileTile extends StatelessWidget {
  final String url;

  const RoundProfileTile({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    if (url.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.grey,
          backgroundImage: NetworkImage(url),
        ),
      );
    }

    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.grey,
      ),
    );
  }
}
