import 'package:edu_bridge_app/core/resources/export.dart';

abstract class IChapterRepository {
  Future<bool> addChapter(ChapterModel chapterModel);
  Future<List<ChapterModel>> fetchChaptersBySubjectId(String subjectId);
}
