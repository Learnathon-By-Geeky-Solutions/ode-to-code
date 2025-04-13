import 'dart:io';
import 'package:edu_bridge_app/data/models/subject_model.dart';
import 'package:edu_bridge_app/data/service/network_caller.dart';

class SubjectRepository {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<String?> uploadSubjectImage(File imageFile) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = 'subject_images/$fileName';

    final response = await _networkCaller.uploadFile(
      bucketName: 'subject_images',
      filePath: filePath,
      file: imageFile,
    );

    return response.isSuccess ? response.responseData : null;
  }

  Future<bool> addSubject(SubjectModel subjectModel) async {
    final response = await _networkCaller.postRequest(
      tableName: "subjects",
      data: subjectModel.toMap(),
    );

    if (response.isSuccess) {
      print("Subject added successfully!");
      return true;
    } else {
      print("Error adding subject: ${response.errorMessage}");
      return false;
    }
  }

  Future<List<SubjectModel>> fetchSubjectsByClassId(String classId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'subjects',
      eqColumn: 'class_id',
      eqValue: classId,
    );

    if (response.isSuccess) {
      if (response.responseData != null && response.responseData.isNotEmpty) {
        // Filter the results explicitly by class_id if needed
        final filteredData = (response.responseData as List).where((data) {
          return data['class_id'] == classId;
        }).toList();

        if (filteredData.isNotEmpty) {
          print("Fetched filtered subjects: $filteredData");
          return filteredData
              .map<SubjectModel>((data) => SubjectModel.fromMap(data))
              .toList();
        } else {
          print("No subjects found for class_id: $classId");
          return [];
        }
      } else {
        print("No subjects found for class_id: $classId");
        return [];
      }
    } else {
      print("Error fetching subjects: ${response.errorMessage}");
      return [];
    }
  }
}
