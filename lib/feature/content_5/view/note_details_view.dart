import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/utils/user_profile_utils.dart';
import 'package:edu_bridge_app/feature/user_saved_item/controller/user_saved_item_controller.dart';

class NoteDetailsView extends StatefulWidget {
  final String title;
  final String? note;

  const NoteDetailsView({
    super.key,
    required this.title,
    required this.note,
  });

  @override
  NoteDetailsViewState createState() => NoteDetailsViewState();
}

class NoteDetailsViewState extends State<NoteDetailsView> {
  bool isBookmarked = false; // Track bookmark state
  final UserProfileController _userProfileController = Get.find();
  final UserSavedItemController _userSavedItemController = Get.find();

  @override
  void initState() {
    super.initState();
    // Fetch user profile data when the view initializes
    UserProfileUtils.fetchProfileData(_userProfileController);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      name: "Notes",
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _buildContent(),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.bookmark,
            color: isBookmarked ? Colors.green : AppColors.blackGray,
          ),
          onPressed: _onBookmarkTapped,
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: _buildNoteContent(),
      ),
    );
  }

  Widget _buildNoteContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _getNoteText(),
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  String _getNoteText() {
    return widget.note?.trim().isNotEmpty == true
        ? widget.note!
        : "No description available.";
  }

  void _onBookmarkTapped() async {
    final userId = _userProfileController.userProfile?.id;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not found. Please log in.")),
      );
      return;
    }

    if (!isBookmarked) {
      final success = await _userSavedItemController.addSavedItem(
        userId,
        "Note",
        widget.title,
        link: "", // No link, since it's just a note
        note: widget.note,
      );

      if (success) {
        setState(() {
          isBookmarked = true;
        });
      }
    } else {
      // Optionally handle un-bookmarking
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Already bookmarked.")),
      );
    }
  }
}
