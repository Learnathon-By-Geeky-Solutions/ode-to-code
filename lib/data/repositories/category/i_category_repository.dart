import 'dart:io';
import 'package:edu_bridge_app/data/models/category_model.dart';

abstract class ICategoryRepository {
  Future<String?> uploadCategoryImage(File imageFile);
  Future<bool> addCategory(CategoryModel category);
  Future<List<CategoryModel>> fetchCategories();
  Future<List<CategoryModel>> fetchCategoriesWithCondition({
    required String column,
    required dynamic value,
  });
}
