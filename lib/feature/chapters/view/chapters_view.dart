import 'package:edu_bridge_app/core/export.dart';
import 'package:edu_bridge_app/feature/chapters/widget/add_chapters_dialog.dart';
import 'package:edu_bridge_app/feature/chapters/widget/chapters_grid_item.dart';

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
  final isAdmin = Get.find<UserProfileController>().isAdmin;

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
          floatingActionButton: isAdmin
              ? OutlinedButton(
                  onPressed: () => Get.dialog(
                    AddChapterDialog(subjectId: widget.subjectId),
                  ),
                  child: const Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }

  Widget _buildBody(ChapterController controller) {
    if (controller.inProgress) {
      return const Center(child: CircularProgressIndicator());
    } else if (controller.chapters.isEmpty) {
      return Center(child: CustomText(text: 'no_content_available'.tr));
    } else {
      return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 4,
        ),
        itemCount: controller.chapters.length,
        itemBuilder: (context, index) {
          return ChapterGridItem(chapterModel: controller.chapters[index]);
        },
      );
    }
  }
}
