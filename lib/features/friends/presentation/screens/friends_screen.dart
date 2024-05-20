import 'package:flutter/material.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  static const routeName = '/friends';

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  double boxHeight = 100;
  double boxWidth = 200;
  Color containerColor  = Colors.yellow;
  double posX = -1;
  double posY = -1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _changeColor();
        _changeSize();
        _changePosition();
      },
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(seconds: 3),
          alignment: Alignment(posX, posY),
          color: containerColor,
          height: boxHeight,
          width: boxWidth,
        ),
      ),
    );
  }

  void _changeSize() {
    setState(() {
      boxHeight = 300;
      boxWidth = 300;
    });
  }

  void _changeColor() {
    setState(() {
      containerColor = Colors.green;
    });
  }

  void _changePosition() {
    setState(() {
      posX = 0;
      posY = 0;
    });
  }

}
