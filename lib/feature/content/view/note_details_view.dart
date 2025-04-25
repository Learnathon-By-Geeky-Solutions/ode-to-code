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
  bool isBookmarked = false;
  final UserProfileController _userProfileController = Get.find();
  final UserSavedItemController _userSavedItemController = Get.find();
  String? userId;

  @override
  void initState() {
    super.initState();
    UserProfileUtils.fetchProfileData(_userProfileController).then((_) {
      setState(() {
        userId = _userProfileController.userProfile?.id;
      });
    });

    _userProfileController.addListener(() {
      final profile = _userProfileController.userProfile;
      if (profile != null) {
        setState(() {
          userId = profile.id;
        });
      }
    });
  }

  void _saveItem() async {
    if (userId == null) {
      SnackBarUtil.showError("Error", "User profile not found.");
      return;
    }

    final isSuccess = await _userSavedItemController.addSavedItem(
      userId!,
      "note",
      widget.title,
      note: widget.note,
    );

    if (isSuccess) {
      setState(() {
        isBookmarked = !isBookmarked;
      });
    } else {
      SnackBarUtil.showError("Error", "Failed to save bookmark.");
    }
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
        GetBuilder<UserSavedItemController>(builder: (controller) {
          return IconButton(
            icon: Icon(
              Icons.bookmark,
              color: isBookmarked ? Colors.green : AppColors.blackGray,
            ),
            onPressed: _saveItem,
          );
        }),
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
}
