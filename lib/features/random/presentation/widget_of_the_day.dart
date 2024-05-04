import 'package:flutter/material.dart';

class WidgetOfTheDay extends StatelessWidget {
  const WidgetOfTheDay({super.key});

  Widget _buildGrid() => GridView.extent(
    maxCrossAxisExtent: 150,
    padding: const EdgeInsets.all(4),
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: const [
      Text(
        "hello world",
        style: TextStyle(
          fontSize: 20,
          color: Colors.blue,
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildGrid(),
          ],
        ),
      ),
    );
  }
}
