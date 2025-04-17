import 'package:edu_bridge_app/core/resources/export.dart';

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
          title: CustomText(text: 'add_course_details'.tr),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    controller: courseName,
                    labelText: 'course_name_hint'.tr,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: coursePrice,
                    labelText: 'course_price_hint'.tr,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: courseType,
                    labelText: 'course_type_hint'.tr,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      controller.pickCourseImage();
                    },
                    child: CustomText(
                      text: 'add_image'.tr,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
              child: Text('add'.tr),
            ),
          ],
        );
      },
    );
  }
}
