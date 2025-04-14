import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_text_field.dart';
import 'package:edu_bridge_app/view_model/mentor_controller.dart';

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
        title: const Text("Add Mentor Information"),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: name,
                  labelText: "Name",
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: designation,
                  labelText: "Designation",
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: whatHeDo,
                  labelText: "What he do",
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: description,
                  labelText: "Description",
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    controller.pickMentorImage();
                  },
                  child: const Text("Add Image"),
                ),
                const SizedBox(height: 10),
                controller.mentorImage != null
                    ? Image.file(
                        controller.mentorImage!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      )
                    : const Text('No image selected'),
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
            child: const Text("Add"),
          ),
        ],
      );
    });
  }
}
