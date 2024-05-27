import 'package:flutter/material.dart';
import 'package:practice_flutter/core/constants/constants.dart';

class AddStoryTile extends StatelessWidget {
  const AddStoryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 5,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          color: Colors.grey,
          height: 180,
          width: 100,
          child: Stack(
            children: [

              SizedBox(
                height: 120,
                width: 120,
                child: Image.network(
                  Constants.profilePicBlank,
                  fit: BoxFit.fitHeight,
                ),
              ),

              const Positioned(
                top: 100,
                left: 10,
                right: 10,
                child: CircleAvatar(
                  radius: 16,
                  child: Icon(Icons.add),
                )
              ),

              const Positioned(
                  top: 100,
                  left: 10,
                  right: 10,
                  child: Column(
                    children: [
                      Text('Create'),
                      Text('Story')
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
