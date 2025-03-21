/*
import 'package:edu_bridge_app/resources/app_colors.dart';
import 'package:edu_bridge_app/utils/custom_button.dart';
import 'package:edu_bridge_app/utils/custom_text_field.dart';
import 'package:edu_bridge_app/view_model/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({
    super.key,
  });

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _whatYouDoController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _accountTypeController = TextEditingController();
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
        child: SingleChildScrollView(
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
                  child: GetBuilder<UserController>(
                    init: UserController(),
                    builder: (controller) {
                      return controller.profileImage == null
                          ? const Icon(
                              Icons.person,
                              size: 95,
                              color: Colors.white,
                            )
                          : ClipOval(
                              child: Image.file(
                                controller.profileImage!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            );
                    },
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              // Image picker button
              GetBuilder<UserController>(
                init: UserController(),
                builder: (controller) {
                  return CustomButton(
                    text: "Pick Profile Image",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    onPressed: () {
                      controller.pickProfileImage();
                    },
                    backgroundColor: AppColors.themeColor,
                    textColor: Colors.white,
                    icon: Icons.photo_camera,
                    buttonType: ButtonType.elevated,
                  );
                },
              ),
              SizedBox(height: 2.h),
              GetBuilder<UserController>(
                init: UserController(),
                initState: (_) {},
                builder: (controller) {
                  // Display the fetched data in the text fields
                  return Column(
                    children: [
                      CustomTextFormField(
                        controller: TextEditingController(
                            text: controller.user?.fullName ?? ''),
                        labelText: "Full Name",
                      ),
                      SizedBox(height: 2.h),
                      CustomTextFormField(
                        controller: TextEditingController(
                            text: controller.user?.email ?? ''),
                        labelText: "Email",
                      ),
                      SizedBox(height: 2.h),
                      CustomTextFormField(
                        controller: TextEditingController(
                            text: controller.user?.dateOfBirth ?? ''),
                        labelText: "Date Of Birth",
                      ),
                      SizedBox(height: 2.h),
                      CustomTextFormField(
                        controller: TextEditingController(
                            text: controller.user?.whatYouDo ?? ''),
                        labelText: "What You Do",
                      ),
                      SizedBox(height: 2.h),
                      CustomTextFormField(
                        controller: TextEditingController(
                            text: controller.user?.gender ?? ''),
                        labelText: "Gender",
                      ),
                      SizedBox(height: 2.h),
                      CustomTextFormField(
                        controller: TextEditingController(
                            text: controller.user?.accountType ?? ''),
                        labelText: "Account Type",
                      ),
                      SizedBox(height: 2.h),
                      CustomButton(
                        text: "Update User",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        onPressed: () async {
                          final success = await controller.addUser(
                            _fullNameController.text,
                            _emailController.text,
                            _whatYouDoController.text,
                            _accountTypeController.text,
                            _dobController.text,
                            _genderController.text,
                          );
                          if (success) {
                            // Handle success (e.g., show a message, navigate, etc.)
                          }
                        },
                        backgroundColor: AppColors.themeColor,
                        textColor: Colors.white,
                        icon: Icons.arrow_forward,
                        buttonType:
                            ButtonType.elevated, // Elevated button style
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
