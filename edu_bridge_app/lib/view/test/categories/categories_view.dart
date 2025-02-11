import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/test/classes/classes_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final List<Widget> views = [];
  final ImagePicker _picker = ImagePicker();
  List<Map<String, String>> categories = []; // List to store category data

  @override
  void initState() {
    super.initState();
    _fetchCategories(); // Fetch categories from Firestore on init
  }

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
      setState(() {
        categories = fetchedCategories;
      });
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch categories: $e");
    }
  }

  Future<void> _pickAndUploadImage() async {
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

  Future<String?> _showTitleDialog() async {
    TextEditingController titleController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Category Title'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(context).pop(titleController.text);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "All Categories",
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: categories.isEmpty
            ? const Center(child: Text("No categories found"))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => navigateToView(index),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Card(
                          elevation: 3,
                          color: AppColors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.network(
                                categories[index]['imageUrl']!,
                                fit: BoxFit.cover,
                                width: 107,
                                height: 72,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                categories[index]['title']!,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: OutlinedButton(
        onPressed: _pickAndUploadImage,
        child: const Icon(Icons.add),
      ),
    );
  }

  void navigateToView(int index) {
    if (index < categories.length) {
      Get.to(() => ClassesView(
            categoryId: categories[index]['id']!,
            categoryTitle: categories[index]['title']!,
          ));
    }
  }
}
