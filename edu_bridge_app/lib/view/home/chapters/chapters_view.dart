import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/home/content/content_view.dart';
import 'package:edu_bridge_app/view_model/chapters_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final ChapterController _controller = Get.put(ChapterController());

  @override
  void initState() {
    super.initState();
    _controller.fetchChapters(widget.subjectId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChapterController>(
      builder: (controller) {
        return CustomScaffold(
          title: widget.subjectName,
          body: controller.inProgress
              ? const Center(child: CircularProgressIndicator())
              : controller.errorMessage != null
                  ? Center(child: Text(controller.errorMessage!))
                  : Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(10.0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      chapterTitle: controller
                                          .chapters[index].chapterName,
                                      chaptersId:
                                          controller.chapters[index].id!));
                                },
                                child: buildContainer(
                                    controller.chapters[index].chapterName),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
            title: const Text("Add New Chapter"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: chapterController,
                  decoration: const InputDecoration(
                    hintText: "Enter chapter name",
                  ),
                ),
                /*const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: controller.pickChapterImage,
                  child: const Text("Add Image"),
                ),
                const SizedBox(height: 10),
                if (controller.chapterImage != null)
                  Image.file(
                    controller.chapterImage!,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),*/
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
                child: const Text("Add"),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Cancel"),
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
