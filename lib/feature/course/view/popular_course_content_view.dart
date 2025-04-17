import 'package:edu_bridge_app/core/resources/export.dart';

class PopularCourseContentView extends StatelessWidget {
  final String chapterTitle;
  final String courseId;

  const PopularCourseContentView({
    super.key,
    required this.chapterTitle,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularCourseContentController>(
      init: PopularCourseContentController(
          repository:
              PopularCourseContentRepository(networkCaller: NetworkCaller())),
      builder: (controller) {
        return ReusableContentView(
          title: chapterTitle,
          id: courseId,
          fetchContents: controller.fetchContents,
          getContents: () => controller.contents,
          isLoading: () => controller.inProgress,
          addContent: controller.addContent,
        );
      },
    );
  }
}
