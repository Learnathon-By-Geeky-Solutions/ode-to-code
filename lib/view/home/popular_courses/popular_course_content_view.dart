import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/utils/reusable_content_view.dart';
import 'package:edu_bridge_app/view_model/popular_course_content_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      init: PopularCourseContentController(),
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
