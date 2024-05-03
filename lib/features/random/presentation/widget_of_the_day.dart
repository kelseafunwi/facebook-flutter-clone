import 'package:flutter/material.dart';

class WidgetOfTheDay extends StatelessWidget {
  const WidgetOfTheDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Hello worlds"),
      ),
    );
  }
}
