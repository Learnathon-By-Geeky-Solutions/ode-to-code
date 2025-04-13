import 'package:edu_bridge_app/utils/reusable_content_view.dart';
import 'package:edu_bridge_app/view_model/content_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      init: CourseContentController(),
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
