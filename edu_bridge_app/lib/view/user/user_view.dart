import 'package:edu_bridge_app/resources/app_colors.dart';
import 'package:edu_bridge_app/utils/custom_button.dart';
import 'package:edu_bridge_app/utils/custom_text_field.dart';
import 'package:edu_bridge_app/view_model/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:edu_bridge_app/data/models/user_model.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final UserController _controller = Get.put(UserController());
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _whatYouDoController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _accountTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.fetchUsers(); // Fetch users on initialization
  }

  // Function to handle adding or updating user
  void _handleUpdateUser() async {
    String fullName = _fullNameController.text;
    String email = _emailController.text;
    String dateOfBirth = _dobController.text;
    String whatYouDo = _whatYouDoController.text;
    String gender = _genderController.text;
    String accountType = _accountTypeController.text;

    if (fullName.isEmpty ||
        email.isEmpty ||
        whatYouDo.isEmpty ||
        gender.isEmpty ||
        accountType.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    bool isSuccess = false;

    if (_controller.users.isNotEmpty) {
      // Update existing user
      UserModel user =
          _controller.users[0]; // Assuming updating the first user for now
      user = user.copyWith(
        fullName: fullName,
        email: email,
        dateOfBirth: dateOfBirth,
        whatYouDo: whatYouDo,
        gender: gender,
        accountType: accountType,
      );
      isSuccess = await _controller.updateUser(user);
    } else {
      // Add new user
      isSuccess = await _controller.addUser(
          fullName, email, whatYouDo, gender, accountType);
    }

    if (isSuccess) {
      Get.snackbar("Success",
          "User ${_controller.users.isNotEmpty ? 'updated' : 'added'} successfully!");
    } else {
      Get.snackbar("Error",
          "Failed to ${_controller.users.isNotEmpty ? 'update' : 'add'} user.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        title: const Text(
          "Fill Your Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: GetBuilder<UserController>(
          builder: (controller) {
            // Get the first user for demonstration. You can adjust this as per your need.
            final user =
                controller.users.isNotEmpty ? controller.users[0] : null;

            // If user is null, we can show a placeholder or just leave fields empty
            if (user != null) {
              _fullNameController.text = user.fullName ?? '';
              _emailController.text = user.email ?? '';
              _dobController.text = user.dateOfBirth ?? '';
              _whatYouDoController.text = user.whatYouDo ?? '';
              _genderController.text = user.gender ?? '';
              _accountTypeController.text = user.accountType ?? '';
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xffE8F1FF),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 95,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    controller: _fullNameController,
                    labelText: "Full Name",
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    controller: _emailController,
                    labelText: "Email",
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    controller: _dobController,
                    labelText: "Date Of Birth",
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    controller: _whatYouDoController,
                    labelText: "What You Do",
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    controller: _genderController,
                    labelText: "Gender",
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    controller: _accountTypeController,
                    labelText: "Account Type",
                  ),
                  SizedBox(height: 2.h),
                  CustomButton(
                    text: "Update User",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    onPressed: _handleUpdateUser,
                    backgroundColor: AppColors.themeColor,
                    textColor: Colors.white,
                    icon: Icons.arrow_forward,
                    buttonType: ButtonType.elevated, // Elevated button style
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
