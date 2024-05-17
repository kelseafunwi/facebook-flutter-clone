import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/config/themes/app_theme.dart';
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Facebook',
      theme: AppTheme.appTheme(),
      home: StreamBuilder(
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
      ),
      onGenerateRoute: Routes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
