import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
          'https://firebasestorage.googleapis.com/v0/b/codeit-d447b.appspot.com/o/images%2FWhatsApp%20Video%202020-09-25%20at%209.17.56%20PM.mp4?alt=media&token=56924fc6-c66e-4f6b-a41f-6b955eb0baa1'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your video'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FlickVideoPlayer(
          flickManager: flickManager,
        ),
      ),
    );
  }
}
