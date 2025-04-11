import 'package:edu_bridge_app/data/models/chapter_model.dart';
import 'package:edu_bridge_app/data/network_caller/network_caller.dart';

class ChapterRepository {
  final NetworkCaller _networkCaller = NetworkCaller();

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

  Future<List<ChapterModel>> fetchChaptersBySubjectId(String subjectId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'chapters',
      eqColumn: 'subject_id',
      eqValue: subjectId,
    );

    if (response.isSuccess) {
      return (response.responseData as List)
          .map<ChapterModel>((data) => ChapterModel.fromMap(data))
          .toList();
    } else {
      print("Error fetching chapters: ${response.errorMessage}");
      return [];
    }
  }
}
