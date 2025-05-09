import 'package:edu_bridge_app/core/export.dart';
// ignore_for_file: prefer_const_constructors_in_immutables

class PopularCourses extends StatelessWidget {
  const PopularCourses({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<PopularCourseController>().fetchPopularCourses();
    return SizedBox(
      height: 32.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'popular_courses'.tr,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const PopularCoursesView());
                  },
                  child: CustomText(
                    text: 'see_all'.tr,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.themeColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          Expanded(
            child: GetBuilder<PopularCourseController>(
              builder: (controller) {
                if (controller.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.errorMessage != null) {
                  return Center(child: Text(controller.errorMessage!));
                }
                return ListView.builder(
                  itemCount: controller.popularCourses.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => PopularCourseContentView(
                              chapterTitle:
                                  controller.popularCourses[index].title,
                              courseId: controller.popularCourses[index].id!,
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: popularCourseCard(controller, index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget popularCourseCard(PopularCourseController controller, int index) {
    final course = controller.popularCourses[index];

    return Card(
      color: AppColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 68.w,
            height: 16.h,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              image: DecorationImage(
                image: CachedNetworkImageProvider(course.imageLink),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Course Info
          Container(
            width: 68.w,
            height: 10.h,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              color: AppColors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: course.type,
                    color: AppColors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: course.title,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),

                  // Course Price
                  Row(
                    children: [
                      Flexible(
                        child: CustomText(
                          text: "${'price'.tr} : ${'not_a_penny'.tr} 🍦",
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.themeColor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
