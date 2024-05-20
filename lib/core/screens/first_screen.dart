import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter/core/screens/home_screen.dart';
import 'package:practice_flutter/core/screens/loader.dart';
import 'package:practice_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:practice_flutter/features/auth/presentation/screens/verify_email_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  static const routeName = '/first';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Loader();
          }

          if (snapshot.hasData) {
            final user = snapshot.data;
            if (user!.emailVerified) {
              return const HomeScreen();
            } else {
              return VerifyEmailScreen(user: user);
            }
          }

          return const LoginScreen();
        }
    );
  }
}


