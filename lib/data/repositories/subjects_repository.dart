import 'dart:io';
import 'package:edu_bridge_app/data/models/subject_model.dart';
import 'package:edu_bridge_app/data/network_caller/network_caller.dart';

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
      return (response.responseData as List)
          .map<SubjectModel>((data) => SubjectModel.fromMap(data))
          .toList();
    } else {
      print("Error fetching subjects: ${response.errorMessage}");
      return [];
    }
  }
}
