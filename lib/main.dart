import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practice_flutter/features/auth/presentation/screens/create_account_screen.dart';
import 'package:practice_flutter/features/auth/presentation/screens/login_screen.dart';
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
    return const MaterialApp(
      title: 'Facebook',
      home:  LoginScreen(),
      onGenerateRoute: Routes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
