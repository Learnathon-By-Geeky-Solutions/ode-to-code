import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/utils/custom_spacing.dart';
import 'package:edu_bridge_app/utils/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String? _selectedGender;
  String? _profileImageUrl;
  File? _selectedImage;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  /// Fetch user profile from Firestore
  Future<void> _fetchUserProfile() async {
    String userId = _auth.currentUser!.uid;
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userId).get();

    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      setState(() {
        _fullNameController.text = userData['fullName'] ?? '';
        _nickNameController.text = userData['nickName'] ?? '';
        _emailController.text = userData['email'] ?? '';
        _dobController.text = userData['dob'] ?? '';
        _selectedGender = userData['gender'];
        _profileImageUrl = userData['profileImageUrl']; // Load profile image
      });
    }
  }

  /// Select an image using Image Picker
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      await _uploadImage(); // Upload after picking
    }
  }

  /// Uploads image to Firebase Storage and updates Firestore
  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    try {
      String userId = _auth.currentUser!.uid;
      Reference ref = _storage.ref().child('profile_images/$userId.jpg');

      UploadTask uploadTask = ref.putFile(_selectedImage!);
      TaskSnapshot snapshot = await uploadTask;

      String imageUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore with new image URL
      await _firestore.collection('users').doc(userId).update({
        'profileImageUrl': imageUrl,
      });

      setState(() {
        _profileImageUrl = imageUrl;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Picture Updated!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image Upload Failed: $e")),
      );
    }
  }

  /// Save updated profile data to Firestore
  Future<void> _updateUserProfile() async {
    String userId = _auth.currentUser!.uid;

    await _firestore.collection('users').doc(userId).set({
      'fullName': _fullNameController.text.trim(),
      'nickName': _nickNameController.text.trim(),
      'dob': _dobController.text.trim(),
      'gender': _selectedGender,
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile Updated Successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Edit Profile",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Profile Picture with Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _profileImageUrl != null
                      ? NetworkImage(_profileImageUrl!) as ImageProvider
                      : _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : null,
                  child: _profileImageUrl == null && _selectedImage == null
                      ? const Icon(Icons.person, size: 50, color: Colors.grey)
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              const Text("Tap to Change Picture",
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              VerticalSpacing(2.h),

              // Full Name
              CustomTextFormField(
                labelText: "Full Name",
                controller: _fullNameController,
              ),
              VerticalSpacing(2.h),

              // Nick Name
              CustomTextFormField(
                labelText: "Nick Name",
                controller: _nickNameController,
              ),
              VerticalSpacing(2.h),

              // Date of Birth
              CustomTextFormField(
                labelText: "Date Of Birth",
                controller: _dobController,
                readOnly: true,
                prefixIcon: Icons.calendar_month,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    _dobController.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  }
                },
              ),
              VerticalSpacing(2.h),

              // Email (Read-Only)
              CustomTextFormField(
                labelText: "Email",
                controller: _emailController,
                readOnly: true,
                //enabled: false, // Disables interaction
              ),
              VerticalSpacing(2.h),

              // Gender Selection
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: "Gender"),
                value: _selectedGender,
                items: ["Male", "Female"]
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              VerticalSpacing(2.h),

              // Update Button
              CustomButton(
                text: "Update",
                onPressed: _updateUserProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
