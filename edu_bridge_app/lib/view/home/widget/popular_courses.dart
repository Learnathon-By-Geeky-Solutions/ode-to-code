import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/home/popular_courses/popular_courses_view.dart';
import 'package:edu_bridge_app/view_model/home/popular_course_controller.dart';

class PopularCourse extends StatelessWidget {
  PopularCourse({super.key});

  final PopularCourseController courseController =
      Get.put(PopularCourseController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: "Popular Courses",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => PopularCoursesView());
                },
                child: const CustomText(
                  text: "SEE ALL",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(() {
          if (courseController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (courseController.courseList.isEmpty) {
            return const Center(child: Text("No Courses Available"));
          }
          return SizedBox(
            height: 240, // Adjust height to fit multiple cards
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: courseController.courseList.length,
              itemBuilder: (context, index) {
                var course = courseController.courseList[index];
                return courseCard(
                  course["imageUrl"],
                  course["type"],
                  course["title"],
                  course["price"],
                );
              },
            ),
          );
        }),
      ],
    );
  }

  Widget courseCard(String imageUrl, String type, String title, String price) {
    return Card(
      color: AppColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 280,
                height: 134,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: Colors.black,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                  child: imageUrl.isEmpty
                      ? const Icon(Icons.add, color: AppColors.white, size: 40)
                      : Image.network(
                          imageUrl,
                          height: 134,
                          width: 280,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          ),
          Container(
            width: 280,
            height: 95,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: type,
                        color: AppColors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      const Icon(Icons.bookmark_border)
                    ],
                  ),
                  CustomText(
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "\$$price",
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.themeColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
