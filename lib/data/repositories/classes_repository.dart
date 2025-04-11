import 'dart:io';
import 'package:edu_bridge_app/data/models/class_model.dart';
import 'package:edu_bridge_app/data/network_caller/network_caller.dart';

class ClassRepository {
  final NetworkCaller _networkCaller = NetworkCaller();

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

  Future<bool> addClass(ClassModel classModel) async {
    final response = await _networkCaller.postRequest(
      tableName: "classes",
      data: classModel.toMap(),
    );

    if (response.isSuccess) {
      print("Class added successfully!");
      return true;
    } else {
      print("Error adding class: ${response.errorMessage}");
      return false;
    }
  }

  Future<List<ClassModel>> fetchClassesByCategoryId(String categoryId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'classes',
      eqColumn: 'category_id',
      eqValue: categoryId,
    );

    if (response.isSuccess) {
      return (response.responseData as List)
          .map<ClassModel>((data) => ClassModel.fromMap(data))
          .toList();
    } else {
      print("Error fetching classes: ${response.errorMessage}");
      return [];
    }
  }
}
