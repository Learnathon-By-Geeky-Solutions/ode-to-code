import 'package:edu_bridge_app/core/export.dart';

abstract class IContentRepository {
  Future<bool> addContent(ContentModel contentModel);
  Future<List<ContentModel>> fetchContentsByChapterId(String chapterId);
}
