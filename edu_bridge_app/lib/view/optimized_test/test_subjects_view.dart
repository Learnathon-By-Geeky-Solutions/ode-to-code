import 'package:edu_bridge_app/view/optimized_test/test_chapters_view.dart';
import 'package:edu_bridge_app/view_model/test/subjects_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestSubjectsView extends StatelessWidget {
  final String categoryId;
  final String classId;
  final String classTitle;

  const TestSubjectsView({
    required this.categoryId,
    required this.classId,
    required this.classTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SubjectsController controller = Get.put(SubjectsController());

    // Fetch subjects on initial load
    controller.fetchSubjects(categoryId, classId);

    return Scaffold(
      appBar: AppBar(title: Text(classTitle)),
      body: Obx(() {
        if (controller.subjects.isEmpty) {
          return const Center(child: Text("No subjects available"));
        } else {
          return ListView.builder(
            itemCount: controller.subjects.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.subjects[index]),
                onTap: () {
                  Get.to(() => TestChaptersView(
                        categoryId: categoryId,
                        classId: classId,
                        subjectId: controller
                            .subjects[index], // Subject name used as ID
                        subjectTitle:
                            controller.subjects[index], // Subject title
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
            title: const Text("Add Subject"),
            content: TextField(
              controller: controller.subjectController,
              decoration: const InputDecoration(hintText: "Enter subject name"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.addSubject(categoryId, classId);
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
