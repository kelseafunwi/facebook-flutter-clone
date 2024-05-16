import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 5
      ),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 6,
        ),
      ),
    );
  }
}
