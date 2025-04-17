import 'package:edu_bridge_app/core/resources/export.dart';

class ClassRepository extends IClassRepository {
  ClassRepository({required INetworkCaller networkCaller});

  final NetworkCaller _networkCaller = NetworkCaller();
  @override
  Future<String?> uploadClassImage(File imageFile) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = 'class_images/$fileName';

    final response = await _networkCaller.uploadFile(
      bucketName: 'class_images',
      filePath: filePath,
      file: imageFile,
    );

    return response.isSuccess ? response.responseData : null;
  }

  @override
  Future<bool> addClass(ClassModel classModel) async {
    final response = await _networkCaller.postRequest(
      tableName: "classes",
      data: classModel.toMap(),
    );

    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<ClassModel>> fetchClassesByCategoryId(String categoryId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'classes',
      eqColumn: 'category_id',
      eqValue: categoryId,
    );

    if (response.isSuccess) {
      if (response.responseData != null && response.responseData.isNotEmpty) {
        final filteredData = (response.responseData as List).where((data) {
          return data['category_id'] == categoryId;
        }).toList();

        if (filteredData.isNotEmpty) {
          return filteredData
              .map<ClassModel>((data) => ClassModel.fromMap(data))
              .toList();
        } else {
          return [];
        }
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}
