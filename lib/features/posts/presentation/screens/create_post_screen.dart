import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/app_colors.dart';
import 'package:practice_flutter/core/constants/constants.dart';
import 'package:practice_flutter/core/utils/utils.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/image_video_view.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/pick_file_widget.dart';
import 'dart:io';
import 'package:practice_flutter/features/posts/presentation/widgets/profile_info.dart';
import 'package:practice_flutter/features/posts/providers/post_provider.dart';
import 'package:practice_flutter/utils/utils.dart';
import 'package:practice_flutter/widgets/round_button.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  static const routeName = '/create-post';

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {

  late final TextEditingController _postController;

  File? file;
  late String fileType;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _postController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _postController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Future makePost() async {
      isLoading = true;
      setState(() {});
      ref.read(postProvider).makePost(
        content: _postController.text,
        file: file!,
        postType: fileType,
      ).then((value) {

        isLoading = false;
        setState(() {});

        Navigator.of(context).pop();
      }).catchError((_)  {
        showToastMessage(e: "Error occurred");
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: makePost,
            child: const Text(
              "Post",
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: Constants.defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileInfoWidget(),

              TextField(
                decoration: const InputDecoration(
                  hintText: "What's on your mind",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: AppColors.darkGreyColor,
                    fontSize: 20,
                  )
                ),
                controller: _postController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 10,
              ),

              const SizedBox(
                height: 20,
              ),

              file != null ?

                ImageVideoView(
                    file: file!,
                    fileType: fileType
                ):

                PickFileWidget(
                    pickImage: () async {
                      file = await pickImage();
                      fileType = 'image';
                      setState(() {

                      });
                    },
                    pickVideo: () async {
                      file = await pickVideo();
                      fileType = 'video';
                      setState(() {});
                    }
                ),

              const SizedBox(
                height: 20,
              ),

              isLoading ?
                 const Center(
                   child: CircularProgressIndicator() ,
                 ):
                RoundButton(
                    onPressed: makePost,
                    label: "Post"
                ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )
    );
  }
}

