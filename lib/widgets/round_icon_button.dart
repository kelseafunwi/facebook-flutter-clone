import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practice_flutter/core/constants/app_colors.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;

  const RoundIconButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5
      ),
      child: CircleAvatar(
        backgroundColor: AppColors.grey,
        radius: 20,
        child:  FaIcon(
          icon,
          size: 20,
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}
