
import "package:flutter/material.dart";
import "package:practice_flutter/core/constants/app_colors.dart";
import "package:practice_flutter/core/constants/extensions.dart";

class BirthdayPicker extends StatefulWidget {
  final DateTime birthday;

  final VoidCallback onPressed;


  const BirthdayPicker({super.key, required this.birthday, required this.onPressed});

  @override
  State<BirthdayPicker> createState() => _BirthdayPickerState();
}

class _BirthdayPickerState extends State<BirthdayPicker> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // gesture detector for our components.
      onTap: widget.onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.blackColor,
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Birthday (${DateTime.now().year - widget.birthday.year } years old)',
              style: const TextStyle(
                color: AppColors.blackColor,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            Text(
              widget.birthday.yMMMEd(),
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
