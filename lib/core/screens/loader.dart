import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/vscode.png',
              width: 200,
            ),
          ),

          const SizedBox(
            height: 10
          ),

          const Text(
            "Please wait while we load the application",
          )
        ],
      ),
    );
  }
}
