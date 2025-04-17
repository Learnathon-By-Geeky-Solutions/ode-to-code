import 'package:edu_bridge_app/core/resources/export.dart';

class YouTubePlayerView extends StatefulWidget {
  const YouTubePlayerView({super.key, required this.link, required this.title});
  final String link;
  final String title;

  @override
  State<YouTubePlayerView> createState() => _YouTubePlayerViewState();
}

class _YouTubePlayerViewState extends State<YouTubePlayerView> {
  late YoutubePlayerController _controller;
  final List<String> _notes = [];
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.link) ?? '';

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        useHybridComposition: true,
      ),
    );
  }

  void seekForward() {
    final currentPosition = _controller.value.position;
    final duration = _controller.value.metaData.duration;
    if (currentPosition.inSeconds + 10 < duration.inSeconds) {
      _controller.seekTo(
        currentPosition + const Duration(seconds: 10),
      );
    }
  }

  void seekBackward() {
    final currentPosition = _controller.value.position;
    if (currentPosition.inSeconds - 10 > 0) {
      _controller.seekTo(currentPosition - const Duration(seconds: 10));
    }
  }

  void _addNote() {
    if (_noteController.text.trim().isNotEmpty) {
      setState(() {
        _notes.add(_noteController.text.trim());
        _noteController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            onReady: () {},
          ),
          // Seek buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: seekBackward,
                  icon:
                      const Icon(Icons.replay_10, size: 30, color: Colors.grey),
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: seekForward,
                  icon: const Icon(Icons.forward_10,
                      size: 30, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Notes UI
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📝 Notes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _noteController,
                          decoration: InputDecoration(
                            hintText: 'Type your note...',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _addNote,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: CustomText(text: 'add'.tr),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: _notes.isEmpty
                        ? Center(
                            child: CustomText(text: 'no_notes_yet'.tr),
                          )
                        : ListView.separated(
                            itemCount: _notes.length,
                            separatorBuilder: (_, __) => const Divider(),
                            itemBuilder: (context, index) => ListTile(
                              leading: const Icon(Icons.note),
                              title: Text(_notes[index]),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
