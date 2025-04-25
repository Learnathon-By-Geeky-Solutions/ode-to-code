import 'package:edu_bridge_app/core/resources/export.dart';

abstract class IContentRepository {
  Future<bool> addContent(ContentModel contentModel);
  Future<List<ContentModel>> fetchContentsByChapterId(String chapterId);
}
