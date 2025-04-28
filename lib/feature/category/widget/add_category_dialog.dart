import 'package:edu_bridge_app/core/export.dart';

class AddCategoryDialog extends StatelessWidget {
  AddCategoryDialog({super.key});
  final TextEditingController _categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (controller) => AlertDialog(
        title: CustomText(text: 'add_categories'.tr),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCategoryNameField(),
              const SizedBox(height: 10),
              _buildImagePicker(controller),
              const SizedBox(height: 10),
              if (controller.categoryImage != null)
                _buildImagePreview(controller),
            ],
          ),
        ),
        actions: [_buildAddButton(controller)],
      ),
    );
  }

  Widget _buildCategoryNameField() {
    return TextField(
      controller: _categoryNameController,
      decoration: const InputDecoration(hintText: "Enter Category name"),
    );
  }

  Widget _buildImagePicker(CategoryController controller) {
    return ElevatedButton(
      onPressed: controller.pickCategoryImage,
      child: CustomText(text: 'add_image'.tr),
    );
  }

  Widget _buildImagePreview(CategoryController controller) {
    return Image.file(
      controller.categoryImage!,
      height: 80,
      width: 80,
      fit: BoxFit.cover,
    );
  }

  Widget _buildAddButton(CategoryController controller) {
    return TextButton(
      onPressed: () async {
        final name = _categoryNameController.text.trim();
        if (name.isEmpty) {
          SnackBarUtil.showError("Error", "Category name cannot be empty");
          return;
        }
        final success = await controller.addCategory(name);
        if (success) Get.back();
      },
      child: CustomText(text: 'add'.tr),
    );
  }
}
