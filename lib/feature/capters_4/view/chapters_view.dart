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
        return CustomScaffold(
          name: widget.subjectName,
          body: _buildBody(controller),
          floatingActionButton: OutlinedButton(
            onPressed: _showAddChapterDialog,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildBody(ChapterController controller) {
    if (controller.inProgress) {
      return const Center(child: CircularProgressIndicator());
    }
    if (controller.chapters.isEmpty) return _buildNoContentMessage();
    return _buildChapterGrid(controller);
  }

  Widget _buildNoContentMessage() {
    return Center(child: CustomText(text: 'no_content_available'.tr));
  }

  Widget _buildChapterGrid(ChapterController controller) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 4,
      ),
      itemCount: controller.chapters.length,
      itemBuilder: (context, index) => _buildChapterItem(controller, index),
    );
  }

  Widget _buildChapterItem(ChapterController controller, int index) {
    return InkWell(
      onTap: () => _onChapterTap(controller, index),
      child: buildContainer(controller.chapters[index].chapterName),
    );
  }

  void _onChapterTap(ChapterController controller, int index) {
    Get.to(() => ContentView(
          chapterTitle: controller.chapters[index].chapterName,
          chaptersId: controller.chapters[index].id!,
        ));
  }

  void _showAddChapterDialog() {
    TextEditingController chapterController = TextEditingController();
    Get.dialog(
      GetBuilder<ChapterController>(
        builder: (controller) => AlertDialog(
          title: CustomText(text: 'add_new_chapter'.tr),
          content: _buildAddChapterDialogContent(chapterController),
          actions: _buildAddChapterDialogActions(controller, chapterController),
        ),
      ),
    );
  }

  Widget _buildAddChapterDialogContent(
      TextEditingController chapterController) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: chapterController,
          decoration: InputDecoration(
            hintText: 'enter_chapter_name'.tr,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildAddChapterDialogActions(
      ChapterController controller, TextEditingController chapterController) {
    return [
      TextButton(
        onPressed: () => _addChapter(controller, chapterController),
        child: CustomText(text: 'add'.tr),
      ),
      TextButton(
        onPressed: () => Get.back(),
        child: CustomText(text: 'cancel'.tr),
      ),
    ];
  }

  Future<void> _addChapter(ChapterController controller,
      TextEditingController chapterController) async {
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
      Get.snackbar("Error", "Please enter a chapter name and select an image");
    }
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
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
