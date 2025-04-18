import 'package:edu_bridge_app/core/resources/export.dart';

class ContentRepository extends IContentRepository {
  final INetworkCaller _networkCaller;

  ContentRepository({required INetworkCaller networkCaller})
      : _networkCaller = networkCaller;

  @override
  Future<bool> addContent(ContentModel contentModel) async {
    final response = await _networkCaller.postRequest(
      tableName: "content",
      data: contentModel.toMap(),
    );

    return _handlePostResponse(response);
  }

  @override
  Future<List<ContentModel>> fetchContentsByChapterId(String chapterId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'content',
      eqColumn: 'chapters_id',
      eqValue: chapterId,
    );

    return _handleGetResponse(response, chapterId);
  }

  List<ContentModel> _handleGetResponse(
      ApiResponse response, String chapterId) {
    if (response.isSuccess) {
      if (response.responseData != null && response.responseData.isNotEmpty) {
        final filteredData = (response.responseData as List).where((data) {
          return data['chapters_id'] == chapterId;
        }).toList();

        if (filteredData.isNotEmpty) {
          return filteredData
              .map<ContentModel>((data) => ContentModel.fromMap(data))
              .toList();
        }
      }
    }
    return [];
  }

  bool _handlePostResponse(ApiResponse response) {
    return response.isSuccess;
  }
}
