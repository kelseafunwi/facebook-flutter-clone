import 'package:flutter/material.dart';

class PickFileWidget extends StatelessWidget {
  const PickFileWidget({super.key, required this.pickImage, required this.pickVideo});

  final VoidCallback pickImage;
  final VoidCallback pickVideo;

  @override
  Widget build(BuildContext context) {
    return (
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: pickImage, child: const Text("Pick Image")),

            const Divider(),

            TextButton(
                onPressed: pickVideo,
                child: const Text("Pick Video")
            ),
          ],
        )
    );
  }
}
