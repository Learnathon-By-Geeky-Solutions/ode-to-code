import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/image_picker_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxList<String> categories = <String>[].obs; // Start with an empty list
  RxString pickedImageUrl = ''.obs;

  final ImagePickerService _imagePickerService =
      ImagePickerService(); // Create instance of ImagePickerService

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

  // Pick an image using the ImagePickerService
  Future<void> pickImage() async {
    String imageUrl =
        await _imagePickerService.pickImage(folderName: "category_images");
    if (imageUrl.isNotEmpty) {
      pickedImageUrl.value = imageUrl; // Store the image URL
    }
  }
}
