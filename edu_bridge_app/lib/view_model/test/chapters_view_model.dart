import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';

class ChaptersController extends GetxController {
  final RxList<String> chapters = <String>[].obs;
  final TextEditingController chapterController = TextEditingController();

  Future<void> fetchChapters(
      String categoryId, String classId, String subjectId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .collection('classes')
          .doc(classId)
          .collection('subjects')
          .doc(subjectId)
          .collection('chapters')
          .get();

      chapters.value =
          querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch chapters: $e");
    }
  }

  Future<void> addChapter(
      String categoryId, String classId, String subjectId) async {
    if (chapterController.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(categoryId)
            .collection('classes')
            .doc(classId)
            .collection('subjects')
            .doc(subjectId)
            .collection('chapters')
            .add({'name': chapterController.text});
        Get.snackbar("Success", "Chapter added successfully!");
        chapterController.clear();
        await fetchChapters(categoryId, classId,
            subjectId); // Refresh the list after adding chapter
      } catch (e) {
        Get.snackbar("Error", "Failed to add chapter: $e");
      }
    }
  }
}
