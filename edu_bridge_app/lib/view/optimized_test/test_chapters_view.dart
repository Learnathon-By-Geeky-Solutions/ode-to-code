import 'package:edu_bridge_app/view/optimized_test/test_content_view.dart';
import 'package:edu_bridge_app/view_model/test/chapters_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestChaptersView extends StatelessWidget {
  final String categoryId;
  final String classId;
  final String subjectId;
  final String subjectTitle;

  const TestChaptersView({
    required this.categoryId,
    required this.classId,
    required this.subjectId,
    required this.subjectTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChaptersController controller = Get.put(ChaptersController());

    // Fetch chapters on initial load
    controller.fetchChapters(categoryId, classId, subjectId);

    return Scaffold(
      appBar: AppBar(title: Text(subjectTitle)),
      body: Obx(() {
        if (controller.chapters.isEmpty) {
          return const Center(child: Text("No chapters available"));
        } else {
          return ListView.builder(
            itemCount: controller.chapters.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.chapters[index]),
                onTap: () {
                  Get.to(() => TestContentView(
                        categoryId: categoryId,
                        classId: classId,
                        chapterId: controller
                            .chapters[index], // Pass chapter name as identifier
                        chapterTitle: controller.chapters[index],
                      ));
                },
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(AlertDialog(
            title: const Text("Add Chapter"),
            content: TextField(
              controller: controller.chapterController,
              decoration: const InputDecoration(hintText: "Enter chapter name"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.addChapter(categoryId, classId, subjectId);
                  Get.back();
                },
                child: const Text("Add"),
              ),
            ],
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
