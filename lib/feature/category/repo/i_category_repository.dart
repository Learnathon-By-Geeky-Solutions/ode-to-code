import 'package:edu_bridge_app/core/resources/export.dart';

abstract class ICategoryRepository {
  Future<String?> uploadCategoryImage(File imageFile);
  Future<bool> addCategory(CategoryModel category);
  Future<List<CategoryModel>> fetchCategories();
  Future<List<CategoryModel>> fetchCategoriesWithCondition({
    required String column,
    required dynamic value,
  });
}
