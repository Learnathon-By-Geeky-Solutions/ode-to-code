import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view_model/mentor_controller.dart';

class AddTopMentor extends StatefulWidget {
  const AddTopMentor({super.key});

  @override
  State<AddTopMentor> createState() => _AddTopMentorState();
}

class _AddTopMentorState extends State<AddTopMentor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: "Top Mentor",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              InkWell(
                onTap: () {},
                child: CustomText(
                  text: "SEE ALL",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            showAddMentor();
          }, // Add your image picker logic here
          child: topMentor(),
        ),
      ],
    );
  }

  Widget topMentor() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 85,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Icon(
                Icons.add,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        const CustomText(
          text: "Add Mentor Name",
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }

  void showAddMentor() {
    final TextEditingController name = TextEditingController();
    final TextEditingController designation = TextEditingController();
    final TextEditingController whatHeDo = TextEditingController();
    final TextEditingController description = TextEditingController();

    Get.dialog(
      GetBuilder<MentorController>(builder: (controller) {
        return AlertDialog(
          title: const Text("Add Mentor Information"),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: name,
                    decoration: const InputDecoration(hintText: "Name"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: designation,
                    decoration: const InputDecoration(hintText: "Designation"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: whatHeDo,
                    decoration: const InputDecoration(hintText: "What he do"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: description,
                    decoration: const InputDecoration(hintText: "Description"),
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

                // Validate input fields
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
                    Get.back(); // Close the dialog on success
                  } else {
                    // Optionally handle the error (e.g., display a Snackbar)
                    Get.snackbar(
                        "Error", "Failed to add mentor. Please try again.");
                  }
                } else {
                  // Display a warning if any fields are empty
                  Get.snackbar("Warning", "Please fill in all fields.");
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      }),
    );
  }
}
