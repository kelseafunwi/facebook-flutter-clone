import 'package:flutter/material.dart';
import 'package:practice_flutter/features/posts/presentation/widgets/post_video_view.dart';

class PostImageVideoView extends StatelessWidget {
  const PostImageVideoView({super.key, required this.fileType, required this.fileUrl});

  final String fileType;
  final String fileUrl;

  @override
  Widget build(BuildContext context) {
    if (fileType == 'image') {
      return Image.network(fileUrl);
    } else {
      return PostVideoView(videoUrl: fileUrl);
    }
  }
}

