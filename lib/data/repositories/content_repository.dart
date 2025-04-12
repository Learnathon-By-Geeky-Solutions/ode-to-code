import 'package:edu_bridge_app/data/models/content_model.dart';
import 'package:edu_bridge_app/data/service/network_caller.dart';

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
      if (response.responseData != null && response.responseData.isNotEmpty) {
        // Filter the results explicitly by chapters_id if needed
        final filteredData = (response.responseData as List).where((data) {
          return data['chapters_id'] == chapterId;
        }).toList();

        if (filteredData.isNotEmpty) {
          print("Fetched filtered content: $filteredData");
          return filteredData
              .map<ContentModel>((data) => ContentModel.fromMap(data))
              .toList();
        } else {
          print("No content found for chapters_id: $chapterId");
          return [];
        }
      } else {
        print("No content found for chapters_id: $chapterId");
        return [];
      }
    } else {
      print("Error fetching content: ${response.errorMessage}");
      return [];
    }
  }
}
