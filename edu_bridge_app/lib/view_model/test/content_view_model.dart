import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';

class ContentController extends GetxController {
  final String categoryId;
  final String classId;
  final String chapterId;

  ContentController({
    required this.categoryId,
    required this.classId,
    required this.chapterId,
  });

  var contentTitleController = TextEditingController();
  var contentBodyController = TextEditingController();
  var contentNumberController = TextEditingController();
  var contents = <Map<String, String>>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;

  // Add Content to Firestore
  Future<void> addContent() async {
    if (contentTitleController.text.isNotEmpty &&
        contentBodyController.text.isNotEmpty) {
      isLoading(true);
      try {
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(categoryId)
            .collection('classes')
            .doc(classId)
            .collection('chapters')
            .doc(chapterId)
            .collection('contents')
            .add({
          'number': contentNumberController.text,
          'title': contentTitleController.text,
          'body': contentBodyController.text,
        });
        Get.snackbar("Success", "Content added successfully!");
        contentNumberController.clear();
        contentTitleController.clear();
        contentBodyController.clear();
        fetchContents();
      } catch (e) {
        Get.snackbar("Error", "Failed to add content: $e");
      } finally {
        isLoading(false);
      }
    } else {
      Get.snackbar("Error", "Both title and content are required!");
    }
  }

  // Fetch Content for a specific chapter
  Future<void> fetchContents() async {
    isLoading(true);
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .collection('classes')
          .doc(classId)
          .collection('chapters')
          .doc(chapterId)
          .collection('contents')
          .get();

      contents.value = querySnapshot.docs.map((doc) {
        return {
          'number': doc['number'] as String,
          'title': doc['title'] as String,
          'body': doc['body'] as String,
        };
      }).toList();
      isError(false);
    } catch (e) {
      isError(true);
      Get.snackbar("Error", "Failed to fetch contents: $e");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchContents();
  }

  @override
  void onClose() {
    contentTitleController.dispose();
    contentBodyController.dispose();
    super.onClose();
  }
}
