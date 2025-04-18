import 'package:edu_bridge_app/core/resources/export.dart';

class AddMentorDialog extends StatelessWidget {
  const AddMentorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final designation = TextEditingController();
    final whatHeDo = TextEditingController();
    final description = TextEditingController();

    return GetBuilder<MentorController>(builder: (controller) {
      return AlertDialog(
        title: CustomText(text: 'add_mentor_info'.tr),
        content:
            _buildForm(name, designation, whatHeDo, description, controller),
        actions: [
          TextButton(
            onPressed: () => _handleAddMentor(
                name, designation, whatHeDo, description, controller),
            child: CustomText(text: 'add'.tr),
          ),
        ],
      );
    });
  }

  Widget _buildForm(
      TextEditingController name,
      TextEditingController designation,
      TextEditingController whatHeDo,
      TextEditingController description,
      MentorController controller) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildInputField(name, 'label_name'.tr),
            _buildInputField(designation, 'label_designation'.tr),
            _buildInputField(whatHeDo, 'label_what_he_do'.tr),
            _buildInputField(description, 'label_description'.tr),
            const SizedBox(height: 10),
            _buildImagePicker(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String labelText) {
    return CustomTextFormField(
      controller: controller,
      labelText: labelText,
    );
  }

  Widget _buildImagePicker(MentorController controller) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: controller.pickMentorImage,
          child: CustomText(text: 'add_image'.tr),
        ),
        const SizedBox(height: 10),
        controller.mentorImage != null
            ? Image.file(
                controller.mentorImage!,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              )
            : CustomText(text: 'no_image_selected'.tr),
      ],
    );
  }

  void _handleAddMentor(
      TextEditingController name,
      TextEditingController designation,
      TextEditingController whatHeDo,
      TextEditingController description,
      MentorController controller) async {
    final nameText = name.text.trim();
    final designationText = designation.text.trim();
    final whatHeDoText = whatHeDo.text.trim();
    final descriptionText = description.text.trim();

    if (_validateFields(
        nameText, designationText, whatHeDoText, descriptionText)) {
      final success = await controller.addMentor(
          nameText, designationText, whatHeDoText, descriptionText);
      if (success) {
        Get.back();
      } else {
        Get.snackbar("Error", "Failed to add mentor. Please try again.");
      }
    } else {
      Get.snackbar("Warning", "Please fill in all fields.");
    }
  }

  bool _validateFields(
      String name, String designation, String whatHeDo, String description) {
    return name.isNotEmpty &&
        designation.isNotEmpty &&
        whatHeDo.isNotEmpty &&
        description.isNotEmpty;
  }
}
