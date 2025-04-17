import 'package:edu_bridge_app/core/resources/export.dart';

class ContentRepository extends IContentRepository {
  ContentRepository({required INetworkCaller networkCaller});
  final NetworkCaller _networkCaller = NetworkCaller();

  @override
  Future<bool> addContent(ContentModel contentModel) async {
    final response = await _networkCaller.postRequest(
      tableName: "content",
      data: contentModel.toMap(),
    );

    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<ContentModel>> fetchContentsByChapterId(String chapterId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'content',
      eqColumn: 'chapters_id',
      eqValue: chapterId,
    );

    if (response.isSuccess) {
      if (response.responseData != null && response.responseData.isNotEmpty) {
        // Filter the results explicitly by chapters_id if needed
        final filteredData = (response.responseData as List).where((data) {
          return data['chapters_id'] == chapterId;
        }).toList();

        if (filteredData.isNotEmpty) {
          return filteredData
              .map<ContentModel>((data) => ContentModel.fromMap(data))
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
