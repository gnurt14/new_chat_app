import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerItem({super.key, required this.videoUrl});

  @override
  State<StatefulWidget> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late CachedVideoPlayerController videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = CachedVideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Refresh the state to show the first frame of the video
        videoPlayerController.setVolume(1);
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          videoPlayerController.value.isInitialized
              ? CachedVideoPlayer(videoPlayerController)
              : const Center(child: CircularProgressIndicator()),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (isPlay) {
                    videoPlayerController.pause();
                  } else {
                    videoPlayerController.play();
                  }
                  isPlay = !isPlay;
                });
              },
              icon: Icon(isPlay ? Icons.pause_circle : Icons.play_circle),
            ),
          ),
        ],
      ),
    );
  }
}
