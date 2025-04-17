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
              _buildProfileImage(),
              SizedBox(height: 2.h),
              _buildTextField(nameController, "full_name".tr),
              SizedBox(height: 1.h),
              _buildTextField(emailController, 'email'.tr,
                  validator: Validators.emailValidator),
              SizedBox(height: 1.h),
              _buildTextField(passwordController, 'password'.tr,
                  obscureText: true, validator: Validators.passwordValidator),
              SizedBox(height: 1.h),
              _buildTextField(whatYouDoController, 'what_you_do'.tr),
              SizedBox(height: 1.h),
              _buildTextField(accountTypeController, 'account_type'.tr,
                  enabled: false),
              SizedBox(height: 1.h),
              _buildDatePicker(),
              SizedBox(height: 1.h),
              _buildGenderDropdown(),
              const SizedBox(height: 20),
              _buildSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return GetBuilder<UserProfileController>(builder: (controller) {
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
                  backgroundImage: FileImage(controller.profileImage!),
                )
              else
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  child:
                      const Icon(Icons.person, size: 95, color: Colors.white),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool obscureText = false,
      String? Function(String?)? validator,
      bool enabled = true}) {
    return CustomTextFormField(
      labelText: label,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      enabled: enabled,
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
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
          labelText: 'date_of_birth'.tr,
          controller: dateOfBirthController,
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: genderController.text.isEmpty ? null : genderController.text,
      decoration: InputDecoration(
        labelText: 'gender'.tr,
        border: const OutlineInputBorder(),
      ),
      items: ['Male', 'Female'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) => genderController.text = value!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your gender';
        }
        return null;
      },
    );
  }

  Widget _buildSignUpButton() {
    return GetBuilder<UserProfileController>(builder: (profileController) {
      return GetBuilder<SignUpController>(builder: (signUpController) {
        return profileController.inProgress || signUpController.inProgress
            ? const Center(child: CircularProgressIndicator())
            : CustomButton(
                onPressed: () async {
                  if (_isFormValid(profileController)) {
                    bool signUpSuccess = await signUpController.signUp(
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
                        _clearControllers();
                        Get.snackbar("Success",
                            "Sign-up and profile creation successful!");
                      }
                    }
                  }
                },
                text: "Sign Up",
              );
      });
    });
  }

  bool _isFormValid(UserProfileController profileController) {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        whatYouDoController.text.isNotEmpty &&
        dateOfBirthController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        profileController.profileImage != null;
  }

  void _clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    whatYouDoController.clear();
    dateOfBirthController.clear();
    genderController.clear();
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
