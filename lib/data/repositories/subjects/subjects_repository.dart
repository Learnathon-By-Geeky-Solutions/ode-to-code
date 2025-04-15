import 'dart:io';
import 'package:edu_bridge_app/data/models/subject_model.dart';
import 'package:edu_bridge_app/data/repositories/subjects/i_subjects_repository.dart';
import 'package:edu_bridge_app/data/service/i_network_caller.dart';

class SubjectRepository extends ISubjectRepository {
  SubjectRepository({required INetworkCaller networkCaller})
      : _networkCaller = networkCaller;

  final INetworkCaller _networkCaller;

  @override
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

  @override
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

  @override
  Future<List<SubjectModel>> fetchSubjectsByClassId(String classId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'subjects',
      eqColumn: 'class_id',
      eqValue: classId,
    );

    if (response.isSuccess) {
      if (response.responseData != null && response.responseData.isNotEmpty) {
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
