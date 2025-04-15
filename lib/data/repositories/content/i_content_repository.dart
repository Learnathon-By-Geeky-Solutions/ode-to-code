import 'package:edu_bridge_app/data/models/content_model.dart';

abstract class IContentRepository {
  Future<bool> addContent(ContentModel contentModel);
  Future<List<ContentModel>> fetchContentsByChapterId(String chapterId);
}
