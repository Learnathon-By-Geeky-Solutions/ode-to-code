import 'package:edu_bridge_app/core/export.dart';

class AddClassDialog extends StatelessWidget {
  final String categoryId;

  const AddClassDialog({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController classNameController = TextEditingController();

    return GetBuilder<ClassController>(
      builder: (controller) {
        return AlertDialog(
          title: CustomText(text: 'add_class'.tr),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: classNameController,
                  decoration: InputDecoration(hintText: 'enter_class_name'.tr),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.pickClassImage,
                  child: CustomText(text: 'add_image'.tr),
                ),
                const SizedBox(height: 10),
                if (controller.classImage != null)
                  Image.file(
                    controller.classImage!,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final name = classNameController.text.trim();
                if (name.isNotEmpty) {
                  final success = await controller.addClass(categoryId, name);
                  if (success) {
                    controller.fetchClasses(categoryId);
                    Get.back();
                  }
                } else {
                  SnackBarUtil.showError("Error", "Class name cannot be empty");
                }
              },
              child: CustomText(text: 'add'.tr),
            ),
            TextButton(
              onPressed: Get.back,
              child: CustomText(text: 'cancel'.tr),
            ),
          ],
        );
      },
    );
  }
}
