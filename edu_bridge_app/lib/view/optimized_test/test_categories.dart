import 'dart:io';

import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/test/classes/classes_view.dart';
import 'package:edu_bridge_app/view_model/test/category_model/category_model.dart';
import 'package:edu_bridge_app/view_model/test/category_model/test_categories_view_model.dart';
import 'package:image_picker/image_picker.dart';

class TestCategoriesView2 extends StatelessWidget {
  final TestCategoriesViewModel viewModel = Get.put(TestCategoriesViewModel());
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndUploadImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File imageFile = File(image.path);
        String? title = await _showTitleDialog();
        if (title != null && title.isNotEmpty) {
          await viewModel.addCategory(title, imageFile);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to upload image: $e");
    }
  }

  Future<String?> _showTitleDialog() async {
    TextEditingController titleController = TextEditingController();
    return showDialog<String>(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Category Title'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Get.back(),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () => Get.back(result: titleController.text),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "All Categories",
      body: Obx(() {
        if (viewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModel.categories.isEmpty) {
          return const Center(child: Text("No categories found"));
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 1,
            ),
            itemCount: viewModel.categories.length,
            itemBuilder: (context, index) {
              final category = viewModel.categories[index];
              return CategoryCard(category: category);
            },
          );
        }
      }),
      floatingActionButton: OutlinedButton(
        onPressed: _pickAndUploadImage,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ClassesView(
            categoryId: category.id,
            categoryTitle: category.title,
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Card(
            elevation: 3,
            color: AppColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.network(
                  category.imageUrl,
                  fit: BoxFit.cover,
                  width: 107,
                  height: 72,
                ),
                const SizedBox(height: 8),
                Text(
                  category.title,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
