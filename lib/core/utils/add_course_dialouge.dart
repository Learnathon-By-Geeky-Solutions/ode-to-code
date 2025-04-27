import 'package:edu_bridge_app/core/resources/export.dart';

class AddCourseDialog extends StatelessWidget {
  const AddCourseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final courseName = TextEditingController();
    final coursePrice = TextEditingController();
    final courseType = TextEditingController();

    return GetBuilder<PopularCourseController>(builder: (controller) {
      return AlertDialog(
        backgroundColor: AppColors.bg,
        title: CustomText(text: 'add_course_details'.tr),
        content: _buildForm(courseName, coursePrice, courseType, controller),
        actions: [
          TextButton(
            onPressed: () => _handleAddCourse(
                courseName, coursePrice, courseType, controller),
            child: Text('add'.tr),
          ),
        ],
      );
    });
  }

  Widget _buildForm(
      TextEditingController courseName,
      TextEditingController coursePrice,
      TextEditingController courseType,
      PopularCourseController controller) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildInputField(courseName, 'course_name_hint'.tr),
            SizedBox(height: 1.h),
            _buildInputField(coursePrice, 'course_price_hint'.tr),
            SizedBox(height: 1.h),
            _buildInputField(courseType, 'course_type_hint'.tr),
            SizedBox(height: 1.h),
            const SizedBox(height: 10),
            _buildImagePicker(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String labelText) {
    return CustomTextFormField(
      controller: controller,
      labelText: labelText,
    );
  }

  Widget _buildImagePicker(PopularCourseController controller) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: controller.pickCourseImage,
          child: CustomText(
              text: 'add_image'.tr, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        controller.courseImage != null
            ? Image.file(
                controller.courseImage!,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image, size: 40),
      ],
    );
  }

  void _handleAddCourse(
      TextEditingController courseName,
      TextEditingController coursePrice,
      TextEditingController courseType,
      PopularCourseController controller) async {
    final name = courseName.text.trim();
    final price = coursePrice.text.trim();
    final type = courseType.text.trim();

    if (_validateFields(name, price, type)) {
      final success = await controller.addPopularCourse(name, price, type);
      if (success) {
        Get.back();
      } else {
        SnackBarUtil.showError(
            "Error", "Failed to add course. Please try again.");
      }
    } else {
      SnackBarUtil.showError("Warning", "Please fill in all fields.");
    }
  }

  bool _validateFields(String name, String price, String type) {
    return name.isNotEmpty && price.isNotEmpty && type.isNotEmpty;
  }
}
