import 'package:edu_bridge_app/core/resources/export.dart';

class ClassRepository extends IClassRepository {
  final INetworkCaller _networkCaller;

  ClassRepository({required INetworkCaller networkCaller})
      : _networkCaller = networkCaller;

  @override
  Future<String?> uploadClassImage(File imageFile) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = 'class_images/$fileName';

    final response = await _networkCaller.uploadFile(
      bucketName: 'class_images',
      filePath: filePath,
      file: imageFile,
    );

    return _handleFileUploadResponse(response);
  }

  @override
  Future<bool> addClass(ClassModel classModel) async {
    final response = await _networkCaller.postRequest(
      tableName: "classes",
      data: classModel.toMap(),
    );

    return _handlePostResponse(response);
  }

  @override
  Future<List<ClassModel>> fetchClassesByCategoryId(String categoryId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'classes',
      eqColumn: 'category_id',
      eqValue: categoryId,
    );

    return _handleGetResponse(response, categoryId);
  }

  List<ClassModel> _handleGetResponse(ApiResponse response, String categoryId) {
    if (response.isSuccess) {
      final List filteredData = (response.responseData as List).where((data) {
        return data['category_id'] == categoryId;
      }).toList();

      if (filteredData.isNotEmpty) {
        return filteredData
            .map<ClassModel>((data) => ClassModel.fromMap(data))
            .toList();
      }
    }
    return [];
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
}
