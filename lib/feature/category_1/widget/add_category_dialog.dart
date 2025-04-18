import 'package:edu_bridge_app/core/resources/export.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController categoryNameController =
        TextEditingController();

    return GetBuilder<CategoryController>(
      builder: (controller) {
        return AlertDialog(
          title: CustomText(text: 'add_categories'.tr),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: categoryNameController,
                  decoration:
                      const InputDecoration(hintText: "Enter Category name"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.pickCategoryImage,
                  child: CustomText(text: 'add_image'.tr),
                ),
                const SizedBox(height: 10),
                if (controller.categoryImage != null)
                  Image.file(
                    controller.categoryImage!,
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
                bool success =
                    await controller.addCategory(categoryNameController.text);
                if (success) Get.back();
              },
              child: CustomText(text: 'add'.tr),
            ),
          ],
        );
      },
    );
  }
}
