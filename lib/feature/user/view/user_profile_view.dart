import 'package:edu_bridge_app/core/export.dart';
import 'package:edu_bridge_app/feature/user/widget/profile_image_picker.dart';
import 'package:edu_bridge_app/feature/user/widget/user_profile_form.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController whatYouDoController = TextEditingController();
  final TextEditingController accountTypeController =
      TextEditingController(text: 'Student');
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomHeaderText(
                  text1: "Getting Started.!".tr,
                  text2: "Create an Account to Start Your Learning"
                      .tr, // Add key in localization
                ),
                SizedBox(height: 2.h),
                const ProfileImagePicker(),
                SizedBox(height: 2.h),
                UserProfileForm(
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  whatYouDoController: whatYouDoController,
                  accountTypeController: accountTypeController,
                  dateOfBirthController: dateOfBirthController,
                  genderController: genderController,
                ),
                const SizedBox(height: 20),
                _buildSignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return GetBuilder<UserProfileController>(
      builder: (profileController) {
        return GetBuilder<SignUpController>(
          builder: (signUpController) {
            return Visibility(
              visible: !profileController.inProgress,
              replacement: const CircularProgressIndicator(),
              child: CustomButton(
                onPressed: () =>
                    _handleSignUp(profileController, signUpController),
                text: "Sign Up",
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _handleSignUp(UserProfileController profileController,
      SignUpController signUpController) async {
    if (!_isFormValid(profileController)) return;

    final isSignUpSuccessful = await signUpController.signUp(
        emailController.text, passwordController.text);
    if (!isSignUpSuccessful) return;

    final isProfileCreated = await profileController.addUserProfile(
      fullName: nameController.text,
      email: emailController.text,
      whatYouDo: whatYouDoController.text,
      accountType: accountTypeController.text,
      dateOfBirth: dateOfBirthController.text,
      gender: genderController.text,
    );

    if (isProfileCreated) {
      _clearControllers();
      SnackBarUtil.showSuccess(
          "Success", "Sign-up and profile creation successful!");
    }
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
  }
}
