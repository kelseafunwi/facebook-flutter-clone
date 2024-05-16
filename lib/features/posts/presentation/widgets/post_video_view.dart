import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostVideoView extends StatefulWidget {
  const PostVideoView({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<PostVideoView> createState() => _PostVideoViewState();
}

class _PostVideoViewState extends State<PostVideoView> {

  late final VideoPlayerController _videoController;
  bool isPlaying = false;

  @override
  void initState() {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
    ..initialize().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _videoController.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer(_videoController),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: IconButton(
                onPressed: () {
                  if (isPlaying) {
                    _videoController.pause();
                  } else {
                    _videoController.play();
                  }
                  isPlaying = !isPlaying;
                  setState(() {

                  });
                },
                icon: Icon(
                  isPlaying ? Icons.pause_circle : Icons.play_circle,
                  size: 50,
                  color: Colors.white,
                ),
              )
          )
        ],
      ),
    );
  }
}
