import 'package:edu_bridge_app/data/models/content_model.dart';
import 'package:edu_bridge_app/data/models/popular_course_content_model.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/home/content/widget/content_card.dart';
import 'package:edu_bridge_app/view/home/content/widget/youtube_view.dart';
import 'package:edu_bridge_app/view_model/content_controller.dart';

class ReusableContentView extends StatefulWidget {
  final String title;
  final String id;
  final Future<void> Function(String id) fetchContents;
  final List<dynamic> Function() getContents;
  final bool Function() isLoading;
  final Future<bool> Function(
      String id, String number, String title, String link) addContent;

  const ReusableContentView({
    super.key,
    required this.title,
    required this.id,
    required this.fetchContents,
    required this.getContents,
    required this.isLoading,
    required this.addContent,
  });

  @override
  State<ReusableContentView> createState() => _ReusableContentViewState();
}

class _ReusableContentViewState extends State<ReusableContentView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.fetchContents(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final contents = widget.getContents();
    final loading = widget.isLoading();

    return CustomScaffold(
      name: widget.title,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : contents.isEmpty
              ? const Center(child: Text("No content available"))
              : ListView.builder(
                  itemCount: contents.length,
                  itemBuilder: (context, index) {
                    final content = contents[index];

                    // Handle both ContentModel and PopularCourseContentModel
                    final title = _getContentTitle(content);
                    final link = content.link ?? '';
                    final number = content.number ?? '';

                    return InkWell(
                      onTap: () => link.isNotEmpty
                          ? Get.to(() => YouTubePlayerView(
                                link: link,
                                title: title,
                              ))
                          : null,
                      child: ContentCard(
                        number: number,
                        title: title,
                        link: link,
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddContentDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  String _getContentTitle(dynamic content) {
    // Handle both models' title properties
    if (content is PopularCourseContentModel) {
      return content.title ?? 'Untitled';
    } else if (content is ContentModel) {
      return content.name ?? 'Untitled';
    }
    // Fallback for any other model type
    return content.title ?? content.name ?? 'Untitled';
  }

  void _showAddContentDialog() {
    final titleController = TextEditingController();
    final linkController = TextEditingController();
    final numberController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text("Add Content"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: numberController,
              decoration: const InputDecoration(hintText: "Enter number"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Enter title/name",
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: linkController,
              decoration: const InputDecoration(
                hintText: "Enter YouTube or content link",
              ),
              keyboardType: TextInputType.url,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty &&
                  linkController.text.isNotEmpty &&
                  numberController.text.isNotEmpty) {
                final success = await widget.addContent(
                  widget.id,
                  numberController.text,
                  titleController.text,
                  linkController.text,
                );
                if (success && mounted) {
                  await widget.fetchContents(widget.id);
                  Get.back();
                }
              } else {
                Get.snackbar(
                  "Error",
                  "Please fill all fields",
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: const Text("Add Content"),
          ),
        ],
      ),
    );
  }
}
