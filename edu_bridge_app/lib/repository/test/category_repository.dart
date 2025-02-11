import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/view_model/test/category_model/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Fetch all categories
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('categories').get();
      return querySnapshot.docs.map((doc) {
        return CategoryModel.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch categories: $e");
    }
  }

  // Add a new category
  Future<void> addCategory(String title, String imageUrl) async {
    try {
      await _firestore.collection('categories').add({
        'title': title,
        'imageUrl': imageUrl,
      });
    } catch (e) {
      throw Exception("Failed to add category: $e");
    }
  }

  // Upload image to Firebase Storage
  Future<String> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = _storage.ref('category_images/$fileName');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception("Failed to upload image: $e");
    }
  }
}
