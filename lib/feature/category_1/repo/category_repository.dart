import 'package:edu_bridge_app/core/resources/export.dart';

class CategoryRepository extends ICategoryRepository {
  final INetworkCaller _networkCaller;

  CategoryRepository({required INetworkCaller networkCaller})
      : _networkCaller = networkCaller;

  @override
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

  @override
  Future<bool> addCategory(CategoryModel category) async {
    final response = await _networkCaller.postRequest(
      tableName: 'categories',
      data: category.toMap(),
    );

    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await _networkCaller.getRequest(
      tableName: 'categories',
    );

    if (response.isSuccess) {
      return (response.responseData as List)
          .map((data) => CategoryModel.fromMap(data, data['id']))
          .toList();
    } else {
      return [];
    }
  }

  @override
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
      return [];
    }
  }
}
