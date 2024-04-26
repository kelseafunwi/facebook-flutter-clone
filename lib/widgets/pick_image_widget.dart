import "dart:io";

import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import "package:practice_flutter/core/constants/constants.dart";

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({super.key, required this.image});

  final File? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
          width: 3
        )
      ),
      child: Stack(
        children: [
          image != null
            ?
          CircleAvatar(
            radius: 50,
              backgroundImage: FileImage(image!),
            )
            :
          const CircleAvatar(
            radius: 50,
            child: Icon(
              Icons.supervised_user_circle
            ),
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: FaIcon(
              FontAwesomeIcons.camera,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}