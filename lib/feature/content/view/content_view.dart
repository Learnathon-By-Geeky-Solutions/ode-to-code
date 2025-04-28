import 'package:edu_bridge_app/core/export.dart';

class ContentView extends StatelessWidget {
  final String chapterTitle;
  final String chaptersId;

  const ContentView({
    super.key,
    required this.chapterTitle,
    required this.chaptersId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseContentController>(
      init: CourseContentController(
        repository: ContentRepository(networkCaller: NetworkCaller()),
      ),
      builder: (controller) {
        return ReusableContentView(
          title: chapterTitle,
          id: chaptersId,
          fetchContents: controller.fetchContents,
          getContents: () => controller.contents,
          isLoading: () => controller.inProgress,
          addContent: controller.addContent,
        );
      },
    );
  }
}
