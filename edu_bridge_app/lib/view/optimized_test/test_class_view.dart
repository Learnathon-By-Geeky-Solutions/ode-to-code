import 'package:edu_bridge_app/resources/app_colors.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
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

    return CustomScaffold(
      title: categoryTitle,
      body: Obx(() {
        if (controller.classes.isEmpty) {
          return const Center(child: Text("No classes available"));
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Adjust the number of columns
              crossAxisSpacing: 1.0, // Space between columns
              mainAxisSpacing: 1.0, // Space between rows
              childAspectRatio: 1.2, // Adjust the aspect ratio if needed
            ),
            itemCount:
                controller.classes.length, // The number of items in the grid
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(
                    () => TestSubjectsView(
                      categoryId: categoryId,
                      classId: controller.classes[index],
                      classTitle: controller.classes[index],
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Card(
                      elevation: 3,
                      color: AppColors.white,
                      child: Center(
                        child: Text(
                          controller.classes[index], // Display the class name
                          textAlign: TextAlign.center,
                        ),
                      ),
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
