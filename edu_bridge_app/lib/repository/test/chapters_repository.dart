import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/data/firestore_paths.dart';

class ChaptersRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addChapter(String categoryId, String classId, String subjectId,
      String chapterName) async {
    await _firestore
        .collection(
            FirestorePaths.chaptersCollection(categoryId, classId, subjectId))
        .add({'name': chapterName});
  }

  Future<List<String>> fetchChapters(
      String categoryId, String classId, String subjectId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(
            FirestorePaths.chaptersCollection(categoryId, classId, subjectId))
        .get();

    return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
  }
}
