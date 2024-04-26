import "package:flutter/material.dart";
import "package:practice_flutter/core/constants/constants.dart";
import "package:practice_flutter/widgets/round_button.dart";

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: Constants.defaultPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundButton(onPressed: () {}, label: "Verify email"),

            const SizedBox(
              height: 10,
            ),

            RoundButton(onPressed: () {}, label: "Refresh"),

            const SizedBox(
              height: 10,
            ),

            RoundButton(onPressed: () {}, label: "Change Email")
          ],
        ),
      ),
    );
  }
}
