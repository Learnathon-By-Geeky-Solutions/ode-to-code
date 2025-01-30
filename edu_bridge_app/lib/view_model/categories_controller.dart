import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CategoryController extends GetxController {
  RxList<String> categories =
      <String>['School', 'College', 'Creativity', 'English', 'Skills'].obs;
  RxString pickedImageUrl = ''.obs; // To store the picked image URL

  // Fetch categories from Firestore
  Future<void> fetchCategories() async {
    var result =
        await FirebaseFirestore.instance.collection('categories').get();
    categories.value =
        result.docs.map((doc) => doc['name'].toString()).toList();
  }

  // Add a new category with image to Firestore
  Future<void> addCategory(String categoryName) async {
    if (pickedImageUrl.value.isNotEmpty) {
      await FirebaseFirestore.instance.collection('categories').add({
        'name': categoryName,
        'image': pickedImageUrl.value,
      });
      fetchCategories(); // Refresh categories
    }
  }

  // Pick an image from gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Upload the image to Firebase Storage
      File imageFile = File(pickedFile.path);
      String fileName = pickedFile.name;
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('category_images/$fileName')
          .putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      pickedImageUrl.value = imageUrl; // Store the image URL
    }
  }
}
