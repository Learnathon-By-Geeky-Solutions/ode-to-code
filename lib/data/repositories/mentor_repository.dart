import 'dart:io';
import 'package:edu_bridge_app/data/models/mentor_model.dart';
import 'package:edu_bridge_app/data/service/network_caller.dart';

class MentorRepository {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<String?> uploadMentorImage(File imageFile) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = 'mentor_images/$fileName';

    final response = await _networkCaller.uploadFile(
      bucketName: 'mentor_images',
      filePath: filePath,
      file: imageFile,
    );

    return response.isSuccess ? response.responseData : null;
  }

  Future<bool> addMentor(MentorModel mentor) async {
    final response = await _networkCaller.postRequest(
      tableName: "mentors",
      data: mentor.toMap(),
    );

    if (response.isSuccess) {
      print("Mentor added successfully!");
      return true;
    } else {
      print("Error adding mentor: ${response.errorMessage}");
      return false;
    }
  }

  Future<List<MentorModel>> fetchMentors() async {
    final response = await _networkCaller.getRequest(
      tableName: 'mentors',
    );

    if (response.isSuccess) {
      return (response.responseData as List)
          .map((data) => MentorModel.fromMap(data))
          .toList();
    } else {
      print("Error fetching mentors: ${response.errorMessage}");
      return [];
    }
  }
}
