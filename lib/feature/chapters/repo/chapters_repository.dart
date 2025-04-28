import 'package:edu_bridge_app/core/export.dart';

class ChapterRepository extends IChapterRepository {
  final INetworkCaller _networkCaller;

  ChapterRepository({required INetworkCaller networkCaller})
      : _networkCaller = networkCaller;

  @override
  Future<bool> addChapter(ChapterModel chapterModel) async {
    final response = await _networkCaller.postRequest(
      tableName: "chapters",
      data: chapterModel.toMap(),
    );

    return response.isSuccess; // Return the result directly
  }

  @override
  Future<List<ChapterModel>> fetchChaptersBySubjectId(String subjectId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'chapters',
      queryParams: {
        'subject_id': subjectId,
      },
    );

    return _handleGetResponse(response, subjectId);
  }

  List<ChapterModel> _handleGetResponse(
      ApiResponse response, String subjectId) {
    if (response.isSuccess && response.responseData != null) {
      final List filteredData = (response.responseData as List).where((data) {
        return data['subject_id'] == subjectId;
      }).toList();

      if (filteredData.isNotEmpty) {
        return filteredData
            .map<ChapterModel>((data) => ChapterModel.fromMap(data))
            .toList();
      }
    }
    return [];
  }
}
