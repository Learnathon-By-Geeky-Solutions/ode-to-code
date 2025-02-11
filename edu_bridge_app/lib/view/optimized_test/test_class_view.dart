import 'package:edu_bridge_app/view/optimized_test/test_subjects_view.dart';
import 'package:edu_bridge_app/view_model/test/class_model/classes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestClassesView extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;

  const TestClassesView({
    required this.categoryId,
    required this.categoryTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ClassesController controller = Get.put(ClassesController());

    // Fetch classes on initial load
    controller.fetchClasses(categoryId);

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: Obx(() {
        if (controller.classes.isEmpty) {
          return const Center(child: Text("No classes available"));
        } else {
          return ListView.builder(
            itemCount: controller.classes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.classes[index]),
                onTap: () {
                  Get.to(() => TestSubjectsView(
                        categoryId: categoryId,
                        classId: controller.classes[index],
                        classTitle: controller.classes[index],
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
            title: const Text("Add Class"),
            content: TextField(
              controller: controller.classController,
              decoration: const InputDecoration(hintText: "Enter class name"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.addClass(categoryId);
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
