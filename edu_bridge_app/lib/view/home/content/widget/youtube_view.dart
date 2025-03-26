import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerView extends StatefulWidget {
  const YouTubePlayerView({super.key, required this.link});
  final String link;

  @override
  State<YouTubePlayerView> createState() => _YouTubePlayerViewState();
}

class _YouTubePlayerViewState extends State<YouTubePlayerView> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Extract the video ID from the YouTube URL
    final videoId = YoutubePlayer.convertUrlToId(widget.link) ?? '';

    // Initialize the YouTube player controller
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        useHybridComposition: true, // Add this
      ),
    );
  }

  // Method to seek forward 10 seconds
  void seekForward() {
    final currentPosition = _controller.value.position;
    final duration = _controller.value.metaData.duration;
    if (currentPosition.inSeconds + 10 < duration.inSeconds) {
      _controller.seekTo(
        currentPosition + const Duration(seconds: 10),
      );
    }
  }

  // Method to seek backward 10 seconds
  void seekBackward() {
    final currentPosition = _controller.value.position;
    if (currentPosition.inSeconds - 10 > 0) {
      _controller.seekTo(currentPosition - const Duration(seconds: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Player'),
      ),
      body: Stack(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true, // Show progress indicator
            progressIndicatorColor:
                Colors.blueAccent, // Customize progress bar color
            onReady: () {
              print('Player is ready.'); // Callback when the player is ready
            },
          ),
          Positioned(
            top: 100,
            right: 100,
            left: 100,
            bottom: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: seekBackward,
                  icon: const Icon(Icons.replay_10,
                      size: 30, color: Colors.white54),
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: seekForward,
                  icon: const Icon(Icons.forward_10,
                      size: 30, color: Colors.white54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the widget tree
    _controller.dispose();
    super.dispose();
  }
}
