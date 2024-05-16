import 'package:flutter/material.dart';

class ProfileStack extends StatelessWidget {
  const ProfileStack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const  EdgeInsets.all(8.0),
        child: Stack(
          alignment: const Alignment(0.6, 0.6),
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/figma.png'),
              radius: 100,
            ),
      
            Container(
              color: Colors.black45,
              child: const Text(
                "Hello world",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
