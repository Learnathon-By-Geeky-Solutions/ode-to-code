import 'package:edu_bridge_app/core/resources/export.dart';

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
      return true;
    } else {
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
          return filteredData
              .map<SubjectModel>((data) => SubjectModel.fromMap(data))
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
