import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/optimized_test/test_class_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CategoriesController extends GetxController {
  var categories = <Map<String, String>>[].obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _fetchCategories(); // Fetch categories when the controller is initialized
  }

  // Fetch categories from Firestore
  Future<void> _fetchCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      List<Map<String, String>> fetchedCategories = [];
      for (var doc in querySnapshot.docs) {
        fetchedCategories.add({
          'title': doc['title'],
          'imageUrl': doc['imageUrl'],
          'id': doc.id, // Add document ID
        });
      }
      categories.assignAll(fetchedCategories);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch categories: $e");
    }
  }

  // Pick and upload image to Firebase Storage
  Future<void> pickAndUploadImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File imageFile = File(image.path);

        // Upload the image to Firebase Storage
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageRef =
            FirebaseStorage.instance.ref('category_images/$fileName');

        UploadTask uploadTask = storageRef.putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask;
        String imageUrl = await snapshot.ref.getDownloadURL();

        // Show a dialog to get the title for the category
        String? title = await _showTitleDialog();
        if (title != null && title.isNotEmpty) {
          // Save the category data to Firestore
          DocumentReference docRef =
              await FirebaseFirestore.instance.collection('categories').add({
            'title': title,
            'imageUrl': imageUrl,
          });

          print("Category added with ID: ${docRef.id}");

          // Fetch updated categories after upload
          await _fetchCategories();

          Get.snackbar("Success", "Category Added Successfully!");
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to upload image: $e");
    }
  }

  // Show dialog to get the category title
  Future<String?> _showTitleDialog() async {
    TextEditingController titleController = TextEditingController();
    return await Get.dialog<String>(
      AlertDialog(
        title: const Text('Enter Category Title'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(hintText: "Title"),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              Get.back(result: titleController.text);
            },
          ),
        ],
      ),
    );
  }

  // Navigate to specific category view
  void navigateToView(int index) {
    if (index < categories.length) {
      Get.to(() => TestClassesView(
            categoryId: categories[index]['id']!,
            categoryTitle: categories[index]['title']!,
          ));
    }
  }
}
