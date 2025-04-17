import 'package:edu_bridge_app/core/resources/export.dart';

class ChaptersView extends StatefulWidget {
  final String subjectId;
  final String subjectName;

  const ChaptersView({
    super.key,
    required this.subjectId,
    required this.subjectName,
  });

  @override
  State<ChaptersView> createState() => _ChaptersViewState();
}

class _ChaptersViewState extends State<ChaptersView> {
  final ChapterController _controller = Get.find();

  @override
  void initState() {
    super.initState();
    _controller.fetchChapters(widget.subjectId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChapterController>(
      builder: (controller) {
        Widget content;
        if (controller.inProgress) {
          content = const Center(child: CircularProgressIndicator());
        } else if (controller.chapters.isEmpty) {
          content = Center(child: CustomText(text: 'no_content_available'.tr));
        } else {
          content = Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 4,
                  ),
                  itemCount: controller.chapters.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => ContentView(
                            chapterTitle:
                                controller.chapters[index].chapterName,
                            chaptersId: controller.chapters[index].id!));
                      },
                      child: buildContainer(
                          controller.chapters[index].chapterName),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return CustomScaffold(
          name: widget.subjectName,
          body: content,
          floatingActionButton: OutlinedButton(
            onPressed: _showAddChapterDialog,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _showAddChapterDialog() {
    TextEditingController chapterController = TextEditingController();
    Get.dialog(
      GetBuilder<ChapterController>(
        builder: (controller) {
          return AlertDialog(
            title: CustomText(text: 'add_new_chapter'.tr),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: chapterController,
                  decoration: InputDecoration(
                    hintText: 'enter_chapter_name'.tr,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if (chapterController.text.isNotEmpty) {
                    bool success = await controller.addChapter(
                      widget.subjectId,
                      chapterController.text,
                    );
                    if (success) {
                      controller.fetchChapters(widget.subjectId);
                      Get.back();
                    }
                  } else {
                    Get.snackbar("Error",
                        "Please enter a chapter name and select an image");
                  }
                },
                child: CustomText(text: 'add'.tr),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: CustomText(text: 'cancel'.tr),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildContainer(String chapter) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.green,
      ),
      child: Center(
        child: CustomText(
          text: chapter,
          customStyle: GoogleFonts.mulish(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
