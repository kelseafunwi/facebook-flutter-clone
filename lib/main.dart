import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/screens/home_screen.dart';
import 'package:practice_flutter/core/screens/loader.dart';
import 'package:practice_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:practice_flutter/features/auth/presentation/screens/verify_email_screen.dart';
import 'firebase_options.dart';
import 'package:practice_flutter/config/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (error) {
    if (kDebugMode) {
      print(error);
    }
  }
  runApp(const ProviderScope(child: MyApp()) );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});t

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      title: 'Facebook',
      // i can pass the FirebaseAuth.instance.authStatechanges function to the stream and receive the snapshot and perform some changes in my application
      // home: StreamBuilder(
      //     stream: FirebaseAuth.instance.authStateChanges(),
      //     builder: (context, snapshot) {
      //       // puts the loading icon if the application is still waiting to be connected to firebase.
      //      if (snapshot.connectionState == ConnectionState.waiting){
      //        return const Loader();
      //      }
      //
      //      // if some data was returned from firebase
      //      if (snapshot.hasData) {
      //        // since we use FirebaseAu
      //        final user = snapshot.data;
      //        if (user!.emailVerified) {
      //          return const HomeScreen();
      //        } else {
      //          return const VerifyEmailScreen();
      //        }
      //      }
      //
      //      // if absolutely nothing is returned from firebase then we are going to take the user to the login screen
      //       return const LoginScreen();
      //     }
      // ),
      home: HomeScreen(),
      onGenerateRoute: Routes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
