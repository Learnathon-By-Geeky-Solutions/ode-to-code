import 'package:edu_bridge_app/data/models/chapter_model.dart';

abstract class IChapterRepository {
  Future<bool> addChapter(ChapterModel chapterModel);
  Future<List<ChapterModel>> fetchChaptersBySubjectId(String subjectId);
}
