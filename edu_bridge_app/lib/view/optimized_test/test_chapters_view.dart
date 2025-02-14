import 'package:edu_bridge_app/resources/app_colors.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/optimized_test/test_content_view.dart';
import 'package:edu_bridge_app/view_model/test/chapters_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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

    return CustomScaffold(
      title: subjectTitle,
      body: Obx(() {
        if (controller.chapters.isEmpty) {
          return const Center(child: Text("No chapters available"));
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of items per row
              crossAxisSpacing: 10.0, // Space between items horizontally
              mainAxisSpacing: 10.0, // Space between items vertically
              childAspectRatio: 4, // Aspect ratio for each grid item
            ),
            itemCount:
                controller.chapters.length, // Total number of items in the grid
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // Navigate to TestContentView with the selected chapter
                  Get.to(() => TestContentView(
                        categoryId: categoryId,
                        classId: classId,
                        chapterId: controller
                            .chapters[index], // Pass chapter name as identifier
                        chapterTitle:
                            controller.chapters[index], // Pass chapter title
                      ));
                },
                child: Card(
                  elevation: 3,
                  color: AppColors.green,
                  child: Center(
                    child: Text(
                      controller.chapters[index], // Chapter name as text
                      textAlign: TextAlign.center,
                      style: GoogleFonts.murecho(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white),
                    ),
                  ),
                ),
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
