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

  void _seek(int seconds) {
    final currentPosition = _controller.value.position;
    final duration = _controller.value.metaData.duration;
    final newPosition = currentPosition + Duration(seconds: seconds);
    if (newPosition.inSeconds >= 0 && newPosition <= duration) {
      _controller.seekTo(newPosition);
    }
  }

  void _addNote() {
    final noteText = _noteController.text.trim();
    if (noteText.isNotEmpty) {
      setState(() {
        _notes.add(noteText);
        _noteController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          _buildPlayer(),
          _buildSeekButtons(),
          _buildNotesSection(),
        ],
      ),
    );
  }

  Widget _buildPlayer() {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blueAccent,
    );
  }

  Widget _buildSeekButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => _seek(-10),
            icon: const Icon(Icons.replay_10, size: 30, color: Colors.grey),
          ),
          const SizedBox(width: 30),
          IconButton(
            onPressed: () => _seek(10),
            icon: const Icon(Icons.forward_10, size: 30, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📝 Notes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildNoteInput(),
            const SizedBox(height: 15),
            _buildNoteList(),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _noteController,
            decoration: InputDecoration(
              hintText: 'Type your note...',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
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
    );
  }

  Widget _buildNoteList() {
    return Expanded(
      child: _notes.isEmpty
          ? Center(child: CustomText(text: 'no_notes_yet'.tr))
          : ListView.separated(
              itemCount: _notes.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.note),
                title: Text(_notes[index]),
              ),
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
