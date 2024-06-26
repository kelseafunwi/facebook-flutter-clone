import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:practice_flutter/core/constants/constants.dart";
import "package:practice_flutter/core/screens/home_screen.dart";
import "package:practice_flutter/features/auth/providers/auth_provider.dart";
import "package:practice_flutter/utils/utils.dart";
import "package:practice_flutter/widgets/round_button.dart";

class VerifyEmailScreen extends ConsumerWidget {
  final User user;

  const VerifyEmailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: Constants.defaultPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: Text(
                  // user.email
                  "${user.email}",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: Text(
                  // user.email
                  "Verify your email to continue",
                  style: TextStyle(
                      fontSize: 15,
                  ),
                ),
              ),
            ),

            RoundButton(
              onPressed: () async{
                await ref.read(authProvider).verifyEmail()
                  .then((value) {
                    if (value == null) {
                        showToastMessage(e: "Email Verification has been sent to your email");
                    }
                  });
              }, label: "Verify email"
            ),

            const SizedBox(
              height: 20,
            ),

            RoundButton(
                onPressed: ()  {
                  // reload the user information and then perform the inner task when we are doing that.
                  FirebaseAuth.instance.currentUser!.reload().then((value) {
                    final emailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
                    if (emailVerified == true) {
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                    }
                  });
                },
                label: "Refresh"
            ),

            const SizedBox(
              height: 20,
            ),

            RoundButton(
                onPressed: () {
                  ref.read(authProvider).signOut();
                },
                label: "Change Email"
            )
          ],
        ),
      ),
    );
  }
}
