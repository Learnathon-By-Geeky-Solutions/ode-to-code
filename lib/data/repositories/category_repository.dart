import 'dart:io';
import 'package:edu_bridge_app/data/models/category_model.dart';
import 'package:edu_bridge_app/data/network_caller/network_caller.dart';

class CategoryRepository {
  final NetworkCaller _networkCaller = NetworkCaller();

  // Method to upload category image to Supabase Storage
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

  // Method to add a new category to the database
  Future<bool> addCategory(CategoryModel category) async {
    final response = await _networkCaller.postRequest(
      tableName: 'categories',
      data: category.toMap(),
    );

    if (response.isSuccess) {
      return true;
    } else {
      // You might want to log the error for debugging
      print('Error adding category: ${response.errorMessage}');
      return false;
    }
  }

  // Method to fetch all categories from the database
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await _networkCaller.getRequest(
      tableName: 'categories',
    );

    if (response.isSuccess) {
      return (response.responseData as List)
          .map((data) => CategoryModel.fromMap(data, data['id']))
          .toList();
    } else {
      // Return empty list on error and log the issue
      print('Error fetching categories: ${response.errorMessage}');
      return [];
    }
  }

  // Optional: Add method to fetch categories with specific conditions
  Future<List<CategoryModel>> fetchCategoriesWithCondition({
    required String column,
    required dynamic value,
  }) async {
    final response = await _networkCaller.getRequest(
      tableName: 'categories',
      eqColumn: column,
      eqValue: value,
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
