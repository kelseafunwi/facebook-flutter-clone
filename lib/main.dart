import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook',
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // puts the loading icon if the application is still waiting to be connnected to firebase.
           if (snapshot.connectionState == ConnectionState.waiting){
             return const Loader();
           }

           // if some data was returned from firebase
           if (snapshot.hasData) {
             // since we use FirebaseAu
             final user = snapshot.data;
             if (user!.emailVerified) {
               return const HomeScreen();
             } else {
               return const VerifyEmailScreen();
             }
           }

           // if absolutely nothing is returned from firebase then we are going to take the user to the login screen
            return const LoginScreen();
          }
      ),
      onGenerateRoute: Routes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
