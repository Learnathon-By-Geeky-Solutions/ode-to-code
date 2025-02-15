import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddPopularCourse extends StatefulWidget {
  const AddPopularCourse({super.key});

  @override
  State<AddPopularCourse> createState() => _AddPopularCourseState();
}

class _AddPopularCourseState extends State<AddPopularCourse> {
  final picker = ImagePicker();
  XFile? _image;
  TextEditingController courseTypeController = TextEditingController();
  TextEditingController courseTitleController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  // Function to pick an image
  Future<void> _uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });

      // Show Snackbar with input fields
      _showAddCourseSnackbar();
    }
  }

  // Function to show Snackbar for course input
  void _showAddCourseSnackbar() {
    Get.snackbar(
      'Add Course',
      '',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      duration: const Duration(minutes: 1),
      mainButton: TextButton(
        onPressed: () {
          _addCourse();
          Get.closeCurrentSnackbar();
        },
        child: const Text('Add'),
      ),
      messageText: Column(
        children: [
          TextField(
            controller: courseTypeController,
            decoration: const InputDecoration(
              hintText: "Enter Course Type",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: courseTitleController,
            decoration: const InputDecoration(
              hintText: "Enter Course Title",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Enter Course Price",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  // Function to upload course details to Firebase
  Future<void> _addCourse() async {
    if (_image != null &&
        courseTypeController.text.isNotEmpty &&
        courseTitleController.text.isNotEmpty &&
        priceController.text.isNotEmpty) {
      try {
        // Upload Image to Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('courses/${DateTime.now().millisecondsSinceEpoch}');
        await storageRef.putFile(File(_image!.path));
        final imageUrl = await storageRef.getDownloadURL();

        // Store Course details in Firestore
        await FirebaseFirestore.instance.collection('courses').add({
          'type': courseTypeController.text,
          'title': courseTitleController.text,
          'price': priceController.text,
          'imageUrl': imageUrl,
        });

        // Show Success Snackbar
        Get.snackbar('Success', 'Course added successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } catch (e) {
        Get.snackbar('Error', 'Failed to add course: $e',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } else {
      Get.snackbar('Error', 'Please fill all fields and select an image.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: "Popular Course",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              InkWell(
                onTap: () {},
                child: const CustomText(
                  text: "SEE ALL",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: _uploadImage,
          child: courseCard(),
        ),
      ],
    );
  }

  Widget courseCard() {
    return Card(
      color: AppColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 280,
                height: 134,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: Colors.black,
                ),
                child: _image == null
                    ? const Icon(Icons.add, color: AppColors.white, size: 40)
                    : Image.file(File(_image!.path),
                        height: 134, width: 280, fit: BoxFit.cover),
              ),
            ],
          ),
          Container(
            width: 280,
            height: 95,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: courseTypeController.text.isEmpty
                            ? "Add Course Type"
                            : courseTypeController.text,
                        color: AppColors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      const Icon(Icons.bookmark_border)
                    ],
                  ),
                  CustomText(
                    text: courseTitleController.text.isEmpty
                        ? "Add Course Title"
                        : courseTitleController.text,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: priceController.text.isEmpty
                            ? "Add Price"
                            : "\$${priceController.text}",
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.themeColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
