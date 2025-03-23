import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/home/content/widget/web_view.dart';
import 'package:edu_bridge_app/view/home/content/widget/content_card.dart';
import 'package:edu_bridge_app/view/home/content/widget/youtube_view.dart';
import 'package:edu_bridge_app/view_model/content_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentView extends StatefulWidget {
  final String chapterTitle;
  final String chaptersId;

  const ContentView({
    super.key,
    required this.chapterTitle,
    required this.chaptersId,
  });

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  final CourseContentController _contentController =
      Get.put(CourseContentController());

  @override
  void initState() {
    super.initState();
    _contentController.fetchContents(widget.chaptersId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseContentController>(
      builder: (controller) {
        return CustomScaffold(
          name: widget.chapterTitle,
          body: controller.inProgress
              ? const Center(child: CircularProgressIndicator())
              : controller.contents.isEmpty
                  ? const Center(child: Text("No content available"))
                  : ListView.builder(
                      itemCount: controller.contents.length,
                      itemBuilder: (context, index) {
                        final content = controller.contents[index];
                        return InkWell(
                          onTap: () {
                            Get.to(() => YouTubePlayerView(link: content.link));
                          },
                          child: ContentCard(
                            number: content.number,
                            title: content.name,
                            link: content.link,
                          ),
                        );
                      },
                    ),
          floatingActionButton: FloatingActionButton(
            onPressed: _showAddContentDialog,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _showAddContentDialog() {
    final TextEditingController _contentTitleController =
        TextEditingController();
    final TextEditingController _contentLinkController =
        TextEditingController();
    final TextEditingController _numberController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text("Add Content"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(hintText: "Enter number"),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _contentTitleController,
              decoration: const InputDecoration(hintText: "Enter title"),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _contentLinkController,
              decoration: const InputDecoration(hintText: "Enter content link"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (_contentTitleController.text.isNotEmpty &&
                  _contentLinkController.text.isNotEmpty) {
                bool success = await _contentController.addContent(
                  widget.chaptersId,
                  _numberController.text,
                  _contentTitleController.text,
                  _contentLinkController.text,
                );
                if (success) {
                  _contentController.fetchContents(widget.chaptersId);
                  Get.back();
                }
              } else {
                Get.snackbar("Error", "Please enter both title and link");
              }
            },
            child: const Text("Add"),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
