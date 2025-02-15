import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_spacing.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddTopMentor extends StatefulWidget {
  const AddTopMentor({super.key});

  @override
  State<AddTopMentor> createState() => _AddTopMentorState();
}

class _AddTopMentorState extends State<AddTopMentor> {
  final TextEditingController _mentorNameController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();

  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
      //_showAddMentorDialog();
      _showAddCourseSnackbar();
    }
  }

  // Function to upload mentor details to Firebase
  Future<void> _uploadMentorDetails() async {
    if (_selectedImage == null ||
        _mentorNameController.text.isEmpty ||
        _specialtyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please provide a mentor name and image")),
      );
      return;
    }

    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child("mentors/${DateTime.now().millisecondsSinceEpoch}.jpg");
      await storageRef.putFile(File(_selectedImage!.path));
      final imageUrl = await storageRef.getDownloadURL();

      // Save mentor data in Firestore
      await FirebaseFirestore.instance.collection("mentors").add({
        "name": _mentorNameController.text,
        'specialty': _specialtyController.text,
        "imageUrl": imageUrl,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Top Mentor added successfully!")),
      );

      // Clear inputs
      setState(() {
        _selectedImage = null;
        _mentorNameController.clear();
        _specialtyController.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  // Show dialog for entering mentor name
  /*void _showAddMentorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Mentor Name"),
          content: Column(
            children: [
              TextField(
                controller: _mentorNameController,
                decoration: InputDecoration(hintText: "Mentor Name"),
              ),
              VerticalSpacing(1.h),
              TextField(
                controller: _specialtyController,
                decoration: InputDecoration(hintText: "Mentor Specialty"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _uploadMentorDetails();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }*/
  void _showAddCourseSnackbar() {
    Get.snackbar(
      'Add Top Mentor',
      '',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      duration: Duration(minutes: 1),
      mainButton: TextButton(
        onPressed: () {
          _uploadMentorDetails();
          Get.closeCurrentSnackbar(); // Close the snackbar
        },
        child: const Text('Add'),
      ),
      messageText: Column(
        children: [
          TextField(
            controller: _mentorNameController,
            decoration: InputDecoration(hintText: "Mentor Name"),
          ),
          VerticalSpacing(1.h),
          TextField(
            controller: _specialtyController,
            decoration: InputDecoration(hintText: "Mentor Specialty"),
          ),
        ],
      ),
    );
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
                text: "Top Mentor",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              InkWell(
                onTap: () {},
                child: CustomText(
                  text: "SEE ALL",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: _pickImage,
          child: topMentor(),
        ),
      ],
    );
  }

  Widget topMentor() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 85,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
                image: _selectedImage != null
                    ? DecorationImage(
                        image: FileImage(File(_selectedImage!.path)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            if (_selectedImage == null)
              const Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
          ],
        ),
        const CustomText(
          text: "Add Mentor Name",
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
