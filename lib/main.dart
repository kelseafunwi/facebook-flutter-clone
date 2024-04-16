import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practice_flutter/features/auth/presentation/screens/create_account_screen.dart';
import 'firebase_options.dart';
import 'package:practice_flutter/config/routes/routes.dart';


void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Facebook',
      home:  CreateAccountScreen(),
      // onGenerateRoute: Routes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
