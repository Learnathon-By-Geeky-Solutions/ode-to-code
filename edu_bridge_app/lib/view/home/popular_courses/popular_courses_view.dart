import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view_model/home/popular_course_controller.dart';

class PopularCoursesView extends StatefulWidget {
  const PopularCoursesView({super.key});

  @override
  State<PopularCoursesView> createState() => _PopularCoursesViewState();
}

class _PopularCoursesViewState extends State<PopularCoursesView> {
  final PopularCourseController courseController =
      Get.put(PopularCourseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const CustomText(
          text: "Popular Courses",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: Obx(() {
        if (courseController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (courseController.courseList.isEmpty) {
          return const Center(child: Text("No Courses Available"));
        }
        return SizedBox(
          // Adjust height to fit multiple cards
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: courseController.courseList.length,
            itemBuilder: (context, index) {
              var course = courseController.courseList[index];
              return popularCoursesCard(
                course["imageUrl"],
                course["type"],
                course["title"],
                course["price"],
              );
            },
          ),
        );
      }),
    );
  }

  Widget popularCoursesCard(
      String imageUrl, String type, String title, String price) {
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
            SizedBox(
              width: 130,
              height: 130,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: imageUrl.isEmpty
                    ? const Icon(Icons.add, color: AppColors.white, size: 40)
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: 130,
                        height: 130,
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: type,
                            color: AppColors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.bookmark_add,
                          color: Colors.green,
                        )
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
                          text: price,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.themeColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
