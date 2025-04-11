import 'dart:io';

import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/utils/custom_text_field.dart';
import 'package:edu_bridge_app/view_model/user_profile_controller.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:edu_bridge_app/view_model/auth/sign_up_controller.dart'; // Import SignUpController

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final UserProfileController profileController =
      Get.put(UserProfileController());
  final SignUpController signUpController = Get.put(SignUpController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController whatYouDoController = TextEditingController();
  final TextEditingController accountTypeController =
      TextEditingController(text: 'Student');
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController fetchEmailController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      name: 'Sign Up & User Profile',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                labelText: 'Password',
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
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
                enabled: false,
              ),
              SizedBox(height: 1.h),
              // Date of Birth Picker
              InkWell(
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    dateOfBirthController.text =
                        "${selectedDate.toLocal()}".split(' ')[0];
                  }
                },
                child: IgnorePointer(
                  child: CustomTextFormField(
                    labelText: 'Date of Birth',
                    controller: dateOfBirthController,
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              DropdownButtonFormField<String>(
                value: genderController.text.isEmpty
                    ? null
                    : genderController.text,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: ['Male', 'Female'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  genderController.text = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              GetBuilder<UserProfileController>(
                builder: (profileController) {
                  return GetBuilder<SignUpController>(
                    builder: (signUpController) {
                      return profileController.inProgress ||
                              signUpController.inProgress
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              onPressed: () async {
                                if (nameController.text.isEmpty ||
                                    emailController.text.isEmpty ||
                                    passwordController.text.isEmpty ||
                                    whatYouDoController.text.isEmpty ||
                                    dateOfBirthController.text.isEmpty ||
                                    genderController.text.isEmpty ||
                                    profileController.profileImage == null) {
                                  Get.snackbar("Error",
                                      "Please fill in all fields and select a profile image.");
                                  return;
                                }

                                bool signUpSuccess =
                                    await signUpController.signUp(
                                  emailController.text,
                                  passwordController.text,
                                );

                                if (signUpSuccess) {
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
                                    nameController.clear();
                                    emailController.clear();
                                    passwordController.clear();
                                    whatYouDoController.clear();
                                    dateOfBirthController.clear();
                                    genderController.clear();
                                    Get.snackbar("Success",
                                        "Sign-up and profile creation successful!");
                                  }
                                }
                              },
                              text: "Sign Up",
                            );
                    },
                  );
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
