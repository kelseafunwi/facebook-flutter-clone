import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/screens/error_screen.dart';
import 'package:practice_flutter/core/screens/loader.dart';
import 'package:practice_flutter/core/utils/utils.dart';
import 'package:practice_flutter/features/story/providers/story_provider.dart';
import 'package:practice_flutter/widgets/round_button.dart';

class CreateStoryScreen extends ConsumerStatefulWidget {
  const CreateStoryScreen({super.key});

  @override
  ConsumerState<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends ConsumerState<CreateStoryScreen> {

  Future<File?>? imageFuture;

  @override
  void initState() {
    super.initState();
    imageFuture = pickImage();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    return FutureBuilder(
      future: imageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }


        if (snapshot.data != null) {
          return Scaffold(
            body: Stack(
              children: [
                Center(
                  child: Image.file(snapshot.data!),
                ),
                Positioned(
                    bottom: 100,
                    left: 50,
                    right: 50,
                    child: isLoading ? const CircularProgressIndicator() :  RoundButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await ref.read(storyProvider).postStory(image: snapshot.data!).then((value) {
                          setState(() {
                            isLoading = false;
                          });
                        }).onError((error, stackTrace) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      label: "Post Story",
                    )
                ),
              ],
            ),
          );
        }

        return const ErrorScreen(error: "Error Occured");
      },
    );
  }
}
