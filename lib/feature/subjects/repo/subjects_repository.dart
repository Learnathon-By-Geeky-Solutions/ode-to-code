import 'package:edu_bridge_app/core/resources/export.dart';

class SubjectRepository extends ISubjectRepository {
  final INetworkCaller _networkCaller;

  SubjectRepository({required INetworkCaller networkCaller})
      : _networkCaller = networkCaller;

  @override
  Future<String?> uploadSubjectImage(File imageFile) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = 'subject_images/$fileName';

    final response = await _networkCaller.uploadFile(
      bucketName: 'subject_images',
      filePath: filePath,
      file: imageFile,
    );

    return _handleFileUploadResponse(response);
  }

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

    return _handleGetResponse(response);
  }

  String? _handleFileUploadResponse(ApiResponse response) {
    if (response.isSuccess) {
      return response.responseData;
    }
    return null;
  }

  bool _handlePostResponse(ApiResponse response) {
    return response.isSuccess;
  }

  List<SubjectModel> _handleGetResponse(ApiResponse response) {
    if (response.isSuccess && response.responseData != null) {
      return (response.responseData as List)
          .map<SubjectModel>((data) => SubjectModel.fromMap(data))
          .toList();
    }
    return [];
  }
}
