import 'package:edu_bridge_app/core/resources/export.dart';

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
                labelText: "full_name".tr,
                controller: nameController,
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                labelText: 'email'.tr,
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter_email'.tr;
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$')
                      .hasMatch(value)) {
                    return 'enter_valid_email'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                labelText: 'password'.tr,
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter_password'.tr;
                  }
                  if (value.length < 6) {
                    return 'password_min_length'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                labelText: 'what_you_do'.tr,
                controller: whatYouDoController,
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                labelText: 'account_type'.tr,
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
                        "\${selectedDate.toLocal()}".split(' ')[0];
                  }
                },
                child: IgnorePointer(
                  child: CustomTextFormField(
                    labelText: 'date_of_birth'.tr,
                    controller: dateOfBirthController,
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              DropdownButtonFormField<String>(
                value: genderController.text.isEmpty
                    ? null
                    : genderController.text,
                decoration: InputDecoration(
                  labelText: 'gender'.tr,
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
