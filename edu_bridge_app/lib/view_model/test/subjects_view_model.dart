import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';

class SubjectsController extends GetxController {
  final RxList<String> subjects = <String>[].obs;
  final TextEditingController subjectController = TextEditingController();

  Future<void> fetchSubjects(String categoryId, String classId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .collection('classes')
          .doc(classId)
          .collection('subjects')
          .get();

      subjects.value =
          querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch subjects: $e");
    }
  }

  Future<void> addSubject(String categoryId, String classId) async {
    if (subjectController.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(categoryId)
            .collection('classes')
            .doc(classId)
            .collection('subjects')
            .add({'name': subjectController.text});
        Get.snackbar("Success", "Subject added successfully!");
        subjectController.clear();
        await fetchSubjects(
            categoryId, classId); // Refresh the list after adding subject
      } catch (e) {
        Get.snackbar("Error", "Failed to add subject: $e");
      }
    }
  }
}
