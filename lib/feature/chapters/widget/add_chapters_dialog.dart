import 'package:edu_bridge_app/core/export.dart';

class AddChapterDialog extends StatelessWidget {
  final String subjectId;

  const AddChapterDialog({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController chapterController = TextEditingController();

    return GetBuilder<ChapterController>(
      builder: (controller) {
        return AlertDialog(
          title: CustomText(text: 'add_new_chapter'.tr),
          content: TextField(
            controller: chapterController,
            decoration: InputDecoration(hintText: 'enter_chapter_name'.tr),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final name = chapterController.text.trim();
                if (name.isNotEmpty) {
                  final success = await controller.addChapter(subjectId, name);
                  if (success) {
                    controller.fetchChapters(subjectId);
                    Get.back();
                  }
                } else {
                  SnackBarUtil.showError(
                      "Error", "Chapter name cannot be empty");
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
