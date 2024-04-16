import "package:flutter/cupertino.dart";
import "package:practice_flutter/core/constants/app_colors.dart";
import "package:practice_flutter/core/constants/constants.dart";
import "gender_radio_tile.dart";

class GenderPicker extends StatelessWidget {
  const GenderPicker({super.key, this.gender, required this.onChanged});

  final String? gender;
  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Constants.defaultPadding,
      decoration: BoxDecoration(
        color: AppColors.darkWhiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          GenderRadioTile(
            title: "Male",
            value: "male",
            selectedValue: gender!,
            onChanged: onChanged,
          ),
          GenderRadioTile(
            title: "Female",
            value: "female",
            selectedValue: gender!,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
