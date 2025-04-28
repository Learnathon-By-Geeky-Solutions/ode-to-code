import 'package:edu_bridge_app/core/export.dart';
import 'package:edu_bridge_app/core/utils/user_profile_utils.dart';

class ReusableContentView extends StatefulWidget {
  final String title;
  final String id;
  final Future<void> Function(String id) fetchContents;
  final List<dynamic> Function() getContents;
  final bool Function() isLoading;
  final bool isSavedItemsView;

  final Future<bool> Function(
    String id,
    String number,
    String title, {
    String? link,
    String? note,
  }) addContent;
  final bool forceShowAddButton;

  const ReusableContentView({
    super.key,
    required this.title,
    required this.id,
    required this.fetchContents,
    required this.getContents,
    required this.isLoading,
    required this.addContent,
    this.forceShowAddButton = true,
    this.isSavedItemsView = false, // Default to false
  });

  @override
  State<ReusableContentView> createState() => _ReusableContentViewState();
}

class _ReusableContentViewState extends State<ReusableContentView> {
  late final UserSavedItemController _savedItemController;
  late bool isAdmin = false;
  final UserProfileController userController =
      Get.find<UserProfileController>();

  @override
  void initState() {
    super.initState();
    _savedItemController = Get.find<UserSavedItemController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.fetchContents(widget.id);
    });
    UserProfileUtils.fetchProfileData(userController).then((_) {
      setState(() {
        isAdmin = userController.isAdmin;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final contents = widget.getContents();
    final isLoading = widget.isLoading();

    return CustomScaffold(
      name: widget.title,
      body: isLoading ? _buildLoadingView() : _buildContentView(contents),
      floatingActionButton: _shouldShowFAB(contents) && isAdmin
          ? _buildFloatingActionButton()
          : null,
    );
  }

  Widget _buildLoadingView() =>
      const Center(child: CircularProgressIndicator());

  Widget _buildContentView(List<dynamic> contents) {
    if (contents.isEmpty) {
      return Center(child: CustomText(text: "no_content_available".tr));
    }
    return ListView.builder(
      itemCount: contents.length,
      itemBuilder: (context, index) => _buildContentTile(contents[index]),
    );
  }

  Widget _buildContentTile(dynamic content) {
    final title = _getContentTitle(content);
    final link = content.link ?? '';
    final number = content.number?.toString() ?? '';
    final note = content.note ?? '';

    // Special handling for saved items
    if (widget.isSavedItemsView) {
      return InkWell(
        onTap: () => _handleContentTap(link, title, note),
        child: ContentCard(
          number: number,
          title: title,
          link: link,
          note: note,
          onDelete: () => _handleDelete(content),
          isSavedItem: true, // Add this flag
        ),
      );
    }

    // Default handling for other content types
    return InkWell(
      onTap: () => _handleContentTap(link, title, note),
      child: ContentCard(
        number: number,
        title: title,
        link: link,
        note: note,
        onDelete:
            content is UserSavedItemModel ? () => _handleDelete(content) : null,
      ),
    );
  }

  void _handleContentTap(String link, String title, String note) {
    if (link.isNotEmpty) {
      Get.to(() => VideoPlayerView(link: link, title: title));
    } else {
      Get.to(() => NoteDetailsView(title: title, note: note));
    }
  }

  String _getContentTitle(dynamic content) {
    if (content is PopularCourseContentModel) return content.title;
    if (content is ContentModel) return content.name;
    return content.title ?? content.name ?? 'Untitled';
  }

  bool _shouldShowFAB(List<dynamic> contents) {
    if (contents.isEmpty) return widget.forceShowAddButton;
    return contents.first is! UserSavedItemModel;
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => Get.to(() => AddContentView(
            id: widget.id,
            addContent: widget.addContent,
            fetchContents: widget.fetchContents,
          )),
      child: const Icon(Icons.add),
    );
  }

  Future<void> _handleDelete(UserSavedItemModel item) async {
    final confirmed = await _showDeleteConfirmationDialog();
    if (!confirmed) return;

    final success = await _savedItemController.deleteSavedItem(item.id!);
    final message =
        success ? 'Item deleted successfully!' : 'Failed to delete item';

    widget.fetchContents(widget.id);

    SnackBarUtil.showSuccess(success ? 'Success' : 'Error', message);
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Are you sure?"),
            content: const Text("Do you want to delete this item?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Delete"),
              ),
            ],
          ),
        )) ??
        false;
  }
}
