import 'package:edu_bridge_app/data/models/content_model.dart';
import 'package:edu_bridge_app/data/network_caller/network_caller.dart';

class ContentRepository {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<bool> addContent(ContentModel contentModel) async {
    final response = await _networkCaller.postRequest(
      tableName: "content",
      data: contentModel.toMap(),
    );

    if (response.isSuccess) {
      print("Content added successfully!");
      return true;
    } else {
      print("Error adding content: ${response.errorMessage}");
      return false;
    }
  }

  Future<List<ContentModel>> fetchContentsByChapterId(String chapterId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'content',
      eqColumn: 'chapters_id',
      eqValue: chapterId,
    );

    if (response.isSuccess) {
      return (response.responseData as List)
          .map<ContentModel>((data) => ContentModel.fromMap(data))
          .toList();
    } else {
      print("Error fetching content: ${response.errorMessage}");
      return [];
    }
  }
}
