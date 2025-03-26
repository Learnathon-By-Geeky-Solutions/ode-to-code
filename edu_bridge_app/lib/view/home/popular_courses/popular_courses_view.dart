import 'package:edu_bridge_app/data/models/popular_course_model.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view_model/popularcourse_controller.dart';
import 'package:get/get.dart'; // Ensure Get is imported

class PopularCoursesView extends StatelessWidget {
  const PopularCoursesView({super.key});

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
      body: GetBuilder<PopularCourseController>(
        init: PopularCourseController(), // Initialize the controller
        builder: (controller) {
          // Show a loading spinner while the courses are being fetched
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show an error message if something goes wrong
          if (controller.errorMessage != null) {
            return Center(
              child: Text(controller.errorMessage!),
            );
          }

          // If courses are fetched, display them in a list
          return controller.inProgress
              ? const Center(child: CircularProgressIndicator())
              : controller.popularCourses.isEmpty
                  ? const Center(child: Text("No content available"))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.popularCourses
                                .length, // Dynamically use the length of fetched courses
                            itemBuilder: (context, index) {
                              final course = controller.popularCourses[index];
                              return popularCoursesCard(
                                  course); // Pass the course data to the card widget
                            },
                          ),
                        ),
                      ],
                    );
        },
      ),
    );
  }

  // Modify this to accept the actual course data
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
            // Image will be loaded dynamically if it exists
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
                            text: course.type, // Dynamic course type
                            color: AppColors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.bookmark_add,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    CustomText(
                      text: course.title, // Dynamic course title
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text:
                              "Price : ${course.price}", // Dynamic course price
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
