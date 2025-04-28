import 'package:edu_bridge_app/core/resources/export.dart';

class AddSubjectDialog extends StatelessWidget {
  final String classId;

  const AddSubjectDialog({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController subjectNameController = TextEditingController();

    return GetBuilder<SubjectController>(
      builder: (controller) {
        return AlertDialog(
          title: CustomText(text: 'add_subject_name'.tr),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: subjectNameController,
                  decoration:
                      InputDecoration(hintText: "enter_subject_name".tr),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final name = subjectNameController.text.trim();
                if (name.isNotEmpty) {
                  final success = await controller.addSubject(classId, name);
                  if (success) {
                    controller.fetchSubjects(classId);
                    Get.back();
                  }
                } else {
                  SnackBarUtil.showError(
                      "Error", "Subject name cannot be empty");
                }
              },
              child: CustomText(text: 'add'.tr),
            ),
            TextButton(
              onPressed: Get.back,
              child: CustomText(text: 'cancel'.tr),
            ),
          ],
        );
      },
    );
  }
}
