import 'dart:io';
import 'package:edu_bridge_app/data/models/class_model.dart';
import 'package:edu_bridge_app/data/repositories/classes/i_classes_repository.dart';
import 'package:edu_bridge_app/data/service/i_network_caller.dart';
import 'package:edu_bridge_app/data/service/network_caller.dart';

class ClassRepository extends IClassRepository {
  ClassRepository({required INetworkCaller networkCaller});

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
      if (response.responseData != null && response.responseData.isNotEmpty) {
        // Filter the results explicitly by category_id if needed
        final filteredData = (response.responseData as List).where((data) {
          return data['category_id'] == categoryId;
        }).toList();

        if (filteredData.isNotEmpty) {
          print("Fetched filtered classes: $filteredData");
          return filteredData
              .map<ClassModel>((data) => ClassModel.fromMap(data))
              .toList();
        } else {
          print("No classes found for category_id: $categoryId");
          return [];
        }
      } else {
        print("No classes found for category_id: $categoryId");
        return [];
      }
    } else {
      print("Error fetching classes: ${response.errorMessage}");
      return [];
    }
  }
}
