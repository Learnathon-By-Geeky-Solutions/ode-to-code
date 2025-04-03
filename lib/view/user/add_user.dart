import 'dart:io';

import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edu_bridge_app/view_model/user_profile_controller.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:edu_bridge_app/view_model/auth/sign_up_controller.dart'; // Import SignUpController

class UserProfileView extends StatefulWidget {
  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final UserProfileController profileController =
      Get.put(UserProfileController());
  final SignUpController signUpController =
      Get.put(SignUpController()); // Add SignUpController

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController =
      TextEditingController(); // Add password field
  final TextEditingController whatYouDoController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController fetchEmailController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      name: 'User Profile',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign Up & Add User Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Profile Image Picker
              GetBuilder<UserProfileController>(
                builder: (controller) {
                  return InkWell(
                    onTap: () async {
                      final pickedFile =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        controller.setProfileImage(File(pickedFile.path));
                      }
                    },
                    child: SizedBox(
                      child: Column(
                        children: [
                          if (controller.profileImage != null)
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(
                                controller.profileImage!,
                              ),
                            )
                          else
                            CircleAvatar(
                              radius: 50,
                              child: Icon(
                                Icons.person,
                                size: 95,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.grey.shade300,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 2.h),
              CustomTextFormField(
                labelText: "Full Name",
                controller: nameController,
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                labelText: 'Email',
                controller: emailController,
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                labelText: 'Password',
                controller: passwordController,
                obscureText: true, // Hide password input
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                labelText: 'What You Do',
                controller: whatYouDoController,
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                labelText: 'Account Type',
                controller: accountTypeController,
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                labelText: 'Date of Birth',
                controller: dateOfBirthController,
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                labelText: 'Gender',
                controller: genderController,
              ),

              SizedBox(height: 20),
              // Sign Up & Add User Button
              GetBuilder<UserProfileController>(
                builder: (profileController) {
                  return GetBuilder<SignUpController>(
                    builder: (signUpController) {
                      return profileController.inProgress ||
                              signUpController.inProgress
                          ? Center(child: CircularProgressIndicator())
                          : CustomButton(
                              onPressed: () async {
                                // Validate all fields
                                if (nameController.text.isEmpty ||
                                    emailController.text.isEmpty ||
                                    passwordController.text.isEmpty ||
                                    whatYouDoController.text.isEmpty ||
                                    accountTypeController.text.isEmpty ||
                                    dateOfBirthController.text.isEmpty ||
                                    genderController.text.isEmpty ||
                                    profileController.profileImage == null) {
                                  Get.snackbar("Error",
                                      "Please fill in all fields and select a profile image.");
                                  return;
                                }

                                // Perform sign-up
                                bool signUpSuccess =
                                    await signUpController.signUp(
                                  emailController.text,
                                  passwordController.text,
                                );

                                if (signUpSuccess) {
                                  // Add user profile after successful sign-up
                                  bool profileSuccess =
                                      await profileController.addUserProfile(
                                    fullName: nameController.text,
                                    email: emailController.text,
                                    whatYouDo: whatYouDoController.text,
                                    accountType: accountTypeController.text,
                                    dateOfBirth: dateOfBirthController.text,
                                    gender: genderController.text,
                                  );

                                  if (profileSuccess) {
                                    // Clear all fields and show success message
                                    nameController.clear();
                                    emailController.clear();
                                    passwordController.clear();
                                    whatYouDoController.clear();
                                    accountTypeController.clear();
                                    dateOfBirthController.clear();
                                    genderController.clear();
                                    Get.snackbar("Success",
                                        "Sign-up and profile creation successful!");
                                  }
                                }
                              },
                              text: "Sign Up & Add Profile",
                            );
                    },
                  );
                },
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Text(
                'Fetch User Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: fetchEmailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              // Fetch User Button
              GetBuilder<UserProfileController>(
                builder: (controller) {
                  return controller.inProgress
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            final email = fetchEmailController.text;

                            if (email.isEmpty) {
                              Get.snackbar("Error", "Please enter email");
                              return;
                            }

                            await controller.fetchUserProfile(email);
                          },
                          child: Text('Fetch User'),
                        );
                },
              ),
              SizedBox(height: 20),
              // Display fetched user profile
              GetBuilder<UserProfileController>(
                builder: (controller) {
                  if (controller.userProfile != null) {
                    final profile = controller.userProfile!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (profile.image != null)
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(profile.image!),
                          ),
                        Text('Name: ${profile.name}',
                            style: TextStyle(fontSize: 16)),
                        Text('Email: ${profile.email}',
                            style: TextStyle(fontSize: 16)),
                        Text('What You Do: ${profile.whatYouDo}',
                            style: TextStyle(fontSize: 16)),
                        Text('Account Type: ${profile.accountType}',
                            style: TextStyle(fontSize: 16)),
                        Text('Date of Birth: ${profile.dateOfBirth}',
                            style: TextStyle(fontSize: 16)),
                        Text('Gender: ${profile.gender}',
                            style: TextStyle(fontSize: 16)),
                      ],
                    );
                  } else if (controller.errorMessage != null) {
                    return Text(
                      controller.errorMessage!,
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    return Text(
                      'No user profile found.',
                      style: TextStyle(color: Colors.grey),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    whatYouDoController.dispose();
    accountTypeController.dispose();
    dateOfBirthController.dispose();
    genderController.dispose();
    fetchEmailController.dispose();
  }
}
