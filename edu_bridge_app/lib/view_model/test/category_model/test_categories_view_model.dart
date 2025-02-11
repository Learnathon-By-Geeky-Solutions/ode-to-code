import 'dart:io';

import 'package:edu_bridge_app/repository/test/category_repository.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view_model/test/category_model/category_model.dart';

class TestCategoriesViewModel extends GetxController {
  final CategoryRepository _repository = CategoryRepository();
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      categories.value = await _repository.fetchCategories();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch categories: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addCategory(String title, File imageFile) async {
    try {
      isLoading.value = true;
      String imageUrl = await _repository.uploadImage(imageFile);
      await _repository.addCategory(title, imageUrl);
      await fetchCategories(); // Refresh the list
      Get.snackbar("Success", "Category added successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to add category: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
