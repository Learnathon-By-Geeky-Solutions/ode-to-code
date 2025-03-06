import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/home/content/widget/web_view.dart';
import 'package:edu_bridge_app/view/home/content/widget/content_card.dart';
import 'package:edu_bridge_app/view/home/content/widget/youtube_view.dart';
import 'package:edu_bridge_app/view_model/content_controller.dart';
import 'package:edu_bridge_app/view_model/popular_course_content_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularCourseContentView extends StatefulWidget {
  final String chapterTitle;
  final String courseId;

  const PopularCourseContentView({
    super.key,
    required this.chapterTitle,
    required this.courseId,
  });

  @override
  State<PopularCourseContentView> createState() =>
      _PopularCourseContentViewState();
}

class _PopularCourseContentViewState extends State<PopularCourseContentView> {
  final PopularCourseContentController _popularCourseContentController =
      Get.put(PopularCourseContentController());

  @override
  void initState() {
    super.initState();
    _popularCourseContentController.fetchContents(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularCourseContentController>(
      builder: (controller) {
        return CustomScaffold(
          title: widget.chapterTitle,
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
                            title: content.title,
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
                bool success = await _popularCourseContentController.addContent(
                  widget.courseId,
                  _numberController.text,
                  _contentTitleController.text,
                  _contentLinkController.text,
                );
                if (success) {
                  _popularCourseContentController
                      .fetchContents(widget.courseId);
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
