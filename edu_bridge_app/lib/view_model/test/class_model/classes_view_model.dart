import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';

class ClassesController extends GetxController {
  final RxList<String> classes = <String>[].obs;
  final TextEditingController classController = TextEditingController();

  Future<void> fetchClasses(String categoryId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .collection('classes')
          .get();

      classes.value =
          querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch classes: $e");
    }
  }

  Future<void> addClass(String categoryId) async {
    if (classController.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(categoryId)
            .collection('classes')
            .add({'name': classController.text});
        Get.snackbar("Success", "Class added successfully!");
        classController.clear();
        await fetchClasses(categoryId); // Refresh the list after adding class
      } catch (e) {
        Get.snackbar("Error", "Failed to add class: $e");
      }
    }
  }
}
