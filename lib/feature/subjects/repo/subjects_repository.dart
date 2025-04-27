import 'package:edu_bridge_app/core/resources/export.dart';

class SubjectRepository extends ISubjectRepository {
  final INetworkCaller _networkCaller;

  SubjectRepository({required INetworkCaller networkCaller})
      : _networkCaller = networkCaller;

  @override
  Future<bool> addSubject(SubjectModel subjectModel) async {
    final response = await _networkCaller.postRequest(
      tableName: "subjects",
      data: subjectModel.toMap(),
    );

    return _handlePostResponse(response);
  }

  @override
  Future<List<SubjectModel>> fetchSubjectsByClassId(String classId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'subjects',
      eqColumn: 'class_id',
      eqValue: classId,
    );

    return _handleGetResponse(response, classId);
  }

  bool _handlePostResponse(ApiResponse response) {
    return response.isSuccess;
  }

  List<SubjectModel> _handleGetResponse(ApiResponse response, String classId) {
    if (response.isSuccess) {
      final List filteredData = (response.responseData as List).where((data) {
        return data['class_id'] == classId;
      }).toList();

      if (filteredData.isNotEmpty) {
        return filteredData
            .map<SubjectModel>((data) => SubjectModel.fromMap(data))
            .toList();
      }
    }
    return [];
  }
}
