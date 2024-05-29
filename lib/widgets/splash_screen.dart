import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const routeName = "/splash";

  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/first');
    });

    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        child: Center(
          child: Text(
            "Facebook App",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
