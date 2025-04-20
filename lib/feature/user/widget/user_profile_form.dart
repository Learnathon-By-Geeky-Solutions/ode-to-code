import 'package:edu_bridge_app/core/resources/export.dart';

class UserProfileForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController whatYouDoController;
  final TextEditingController accountTypeController;
  final TextEditingController dateOfBirthController;
  final TextEditingController genderController;

  const UserProfileForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.whatYouDoController,
    required this.accountTypeController,
    required this.dateOfBirthController,
    required this.genderController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        _buildDatePicker(dateOfBirthController),
        SizedBox(height: 1.h),
        _buildGenderDropdown(genderController),
      ],
    );
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

  Widget _buildDatePicker(TextEditingController controller) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () async {
          final selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (selectedDate != null) {
            controller.text = "${selectedDate.toLocal()}".split(' ')[0];
          }
        },
        child: IgnorePointer(
          child: CustomTextFormField(
            labelText: 'date_of_birth'.tr,
            controller: controller,
          ),
        ),
      );
    });
  }

  Widget _buildGenderDropdown(TextEditingController controller) {
    return DropdownButtonFormField<String>(
      value: controller.text.isEmpty ? null : controller.text,
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
      onChanged: (value) => controller.text = value!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your gender';
        }
        return null;
      },
    );
  }
}
