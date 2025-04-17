import 'package:edu_bridge_app/core/resources/export.dart';

class PopularCoursesView extends StatelessWidget {
  const PopularCoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: CustomText(
          text: 'popular_course'.tr,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: GetBuilder<PopularCourseController>(
        init: PopularCourseController(
            repository:
                PopularCourseRepository(networkCaller: NetworkCaller())),
        builder: (controller) {
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage != null) {
            return Center(
              child: Text(controller.errorMessage!),
            );
          }

          if (controller.popularCourses.isEmpty) {
            return Center(child: CustomText(text: 'no_content_available'.tr));
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.popularCourses.length,
                    itemBuilder: (context, index) {
                      final course = controller.popularCourses[index];
                      return popularCoursesCard(course);
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget popularCoursesCard(PopularCourseModel course) {
    return Card(
      color: AppColors.white,
      elevation: 4,
      child: Container(
        width: 360,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: NetworkImage(course.imageLink),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: course.type,
                            color: AppColors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(
                          Icons.bookmark_add,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    CustomText(
                      text: course.title,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: '${'price'.tr} : ${course.price}',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.themeColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
