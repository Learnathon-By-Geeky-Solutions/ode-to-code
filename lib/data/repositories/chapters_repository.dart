import 'package:edu_bridge_app/data/models/chapter_model.dart';
import 'package:edu_bridge_app/data/service/network_caller.dart';

class ChapterRepository {
  final NetworkCaller _networkCaller = NetworkCaller();

  // Add a new chapter
  Future<bool> addChapter(ChapterModel chapterModel) async {
    final response = await _networkCaller.postRequest(
      tableName: "chapters",
      data: chapterModel.toMap(),
    );

    if (response.isSuccess) {
      print("Chapter added successfully!");
      return true;
    } else {
      print("Error adding chapter: ${response.errorMessage}");
      return false;
    }
  }

  // Fetch chapters by subject_id
  Future<List<ChapterModel>> fetchChaptersBySubjectId(String subjectId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'chapters',
      queryParams: {
        'subject_id': subjectId,
      },
    );

    if (response.isSuccess) {
      if (response.responseData != null && response.responseData.isNotEmpty) {
        // Filter the results explicitly by subject_id if needed
        final filteredData = (response.responseData as List).where((data) {
          return data['subject_id'] == subjectId;
        }).toList();

        if (filteredData.isNotEmpty) {
          return filteredData
              .map<ChapterModel>((data) => ChapterModel.fromMap(data))
              .toList();
        } else {
          return [];
        }
      } else {
        return [];
      }
    } else {
      print("Error fetching chapters: ${response.errorMessage}");
      return [];
    }
  }
}
