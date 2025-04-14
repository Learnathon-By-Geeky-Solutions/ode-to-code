import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_text_field.dart';
import 'package:edu_bridge_app/view_model/popular_course_controller.dart';

class AddCourseDialog extends StatelessWidget {
  const AddCourseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final courseName = TextEditingController();
    final coursePrice = TextEditingController();
    final courseType = TextEditingController();

    return GetBuilder<PopularCourseController>(
      builder: (controller) {
        return AlertDialog(
          title: const Text("Add Course Details"),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    controller: courseName,
                    labelText: "Course Name",
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: coursePrice,
                    labelText: "Course Price",
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: courseType,
                    labelText: "Course Type",
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      controller.pickCourseImage();
                    },
                    child: const Text("Add Image"),
                  ),
                  const SizedBox(height: 10),
                  controller.courseImage != null
                      ? Image.file(
                          controller.courseImage!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image, size: 80, color: Colors.grey),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final courseTitleText = courseName.text.trim();
                final coursePriceText = coursePrice.text.trim();
                final courseTypeText = courseType.text.trim();

                if (courseTitleText.isNotEmpty &&
                    coursePriceText.isNotEmpty &&
                    courseTypeText.isNotEmpty &&
                    controller.courseImage != null) {
                  final success = await controller.addPopularCourse(
                    courseTitleText,
                    coursePriceText,
                    courseTypeText,
                  );
                  if (success) {
                    Get.back();
                  } else {
                    Get.snackbar(
                        "Error", "Please fill all fields and add an image.");
                  }
                } else {
                  Get.snackbar(
                      "Error", "Please fill all fields and add an image.");
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
