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
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: name,
                  labelText: 'label_name'.tr,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: designation,
                  labelText: 'label_designation'.tr,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: whatHeDo,
                  labelText: 'label_what_he_do'.tr,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: description,
                  labelText: 'label_description'.tr,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    controller.pickMentorImage();
                  },
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
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final nameText = name.text.trim();
              final designationText = designation.text.trim();
              final whatHeDoText = whatHeDo.text.trim();
              final descriptionText = description.text.trim();

              if (nameText.isNotEmpty &&
                  designationText.isNotEmpty &&
                  whatHeDoText.isNotEmpty &&
                  descriptionText.isNotEmpty) {
                final success = await controller.addMentor(
                  nameText,
                  designationText,
                  whatHeDoText,
                  descriptionText,
                );
                if (success) {
                  Get.back();
                } else {
                  Get.snackbar(
                      "Error", "Failed to add mentor. Please try again.");
                }
              } else {
                Get.snackbar("Warning", "Please fill in all fields.");
              }
            },
            child: CustomText(text: 'add'.tr),
          ),
        ],
      );
    });
  }
}
