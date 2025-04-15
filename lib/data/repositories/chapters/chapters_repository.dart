import 'package:edu_bridge_app/data/models/chapter_model.dart';
import 'package:edu_bridge_app/data/repositories/chapters/i_chapters_repository.dart';
import 'package:edu_bridge_app/data/service/i_network_caller.dart';
import 'package:edu_bridge_app/data/service/network_caller.dart';

class ChapterRepository extends IChapterRepository {
  ChapterRepository({required INetworkCaller networkCaller});
  final NetworkCaller _networkCaller = NetworkCaller();

  @override
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

  @override
  Future<List<ChapterModel>> fetchChaptersBySubjectId(String subjectId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'chapters',
      queryParams: {
        'subject_id': subjectId,
      },
    );

    if (response.isSuccess) {
      final filteredData = (response.responseData as List)
          .where((data) => data['subject_id'] == subjectId)
          .toList();

      return filteredData
          .map<ChapterModel>((data) => ChapterModel.fromMap(data))
          .toList();
    } else {
      print("Error fetching chapters: ${response.errorMessage}");
      return [];
    }
  }
}
