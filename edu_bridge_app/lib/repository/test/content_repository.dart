import 'package:cloud_firestore/cloud_firestore.dart';

class ContentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add content to Firestore
  Future<void> addContent({
    required String categoryId,
    required String classId,
    required String chapterId,
    required String title,
    required String body,
  }) async {
    await _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('classes')
        .doc(classId)
        .collection('chapters')
        .doc(chapterId)
        .collection('contents')
        .add({
      'title': title,
      'body': body,
    });
  }

  // Fetch content for a specific chapter
  Future<List<Map<String, String>>> fetchContents({
    required String categoryId,
    required String classId,
    required String chapterId,
  }) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('classes')
        .doc(classId)
        .collection('chapters')
        .doc(chapterId)
        .collection('contents')
        .get();

    return querySnapshot.docs.map((doc) {
      return {
        'title': doc['title'] as String,
        'body': doc['body'] as String,
      };
    }).toList();
  }
}
