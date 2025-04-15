import 'dart:io';
import 'package:edu_bridge_app/data/models/category_model.dart';
import 'package:edu_bridge_app/data/repositories/category/i_category_repository.dart';
import 'package:edu_bridge_app/data/service/i_network_caller.dart';
import 'package:edu_bridge_app/data/service/network_caller.dart';

class CategoryRepository extends ICategoryRepository {
  CategoryRepository({required INetworkCaller networkCaller});
  final NetworkCaller _networkCaller = NetworkCaller();

  // Upload category image to Supabase Storage
  Future<String?> uploadCategoryImage(File imageFile) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = 'category_images/$fileName';

    final response = await _networkCaller.uploadFile(
      bucketName: 'category_images',
      filePath: filePath,
      file: imageFile,
    );

    return response.isSuccess ? response.responseData : null;
  }

  // Add a new category to the database
  Future<bool> addCategory(CategoryModel category) async {
    final response = await _networkCaller.postRequest(
      tableName: 'categories',
      data: category.toMap(),
    );

    if (response.isSuccess) {
      return true;
    } else {
      print('Error adding category: ${response.errorMessage}');
      return false;
    }
  }

  // Fetch all categories from the database
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await _networkCaller.getRequest(
      tableName: 'categories',
    );

    if (response.isSuccess) {
      return (response.responseData as List)
          .map((data) => CategoryModel.fromMap(data, data['id']))
          .toList();
    } else {
      print('Error fetching categories: ${response.errorMessage}');
      return [];
    }
  }

  // Fetch categories with specific condition
  Future<List<CategoryModel>> fetchCategoriesWithCondition({
    required String column,
    required dynamic value,
  }) async {
    final response = await _networkCaller.getRequest(
      tableName: 'categories',
      queryParams: {
        column: value,
      },
    );

    if (response.isSuccess) {
      return (response.responseData as List)
          .map((data) => CategoryModel.fromMap(data, data['id']))
          .toList();
    } else {
      print(
          'Error fetching categories with condition: ${response.errorMessage}');
      return [];
    }
  }
}
