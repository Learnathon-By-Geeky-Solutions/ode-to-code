import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view_model/popular_course_controller.dart';

class AddPopularCourse extends StatefulWidget {
  const AddPopularCourse({super.key});

  @override
  State<AddPopularCourse> createState() => _AddPopularCourseState();
}

class _AddPopularCourseState extends State<AddPopularCourse> {
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
                text: "Popular Course",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              InkWell(
                onTap: () {},
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
        InkWell(
          onTap: () {
            showAddCourse();
          },
          child: courseCard(),
        ),
      ],
    );
  }

  Widget courseCard() {
    return InkWell(
      onTap: () {
        showAddCourse();
      },
      child: Card(
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
                    child: const Icon(Icons.add,
                        color: AppColors.white, size: 40)),
              ],
            ),
            Container(
              width: 280,
              height: 95,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              )),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Add Course Type",
                          color: AppColors.orange,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        Icon(Icons.bookmark_border)
                      ],
                    ),
                    CustomText(
                      text: "Add Course Title",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: "Add Price",
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
      ),
    );
  }

  void showAddCourse() {
    final TextEditingController courseName = TextEditingController();
    final TextEditingController coursePrice = TextEditingController();
    final TextEditingController courseType = TextEditingController();

    Get.dialog(
      GetBuilder<PopularCourseController>(
        builder: (controller) {
          return AlertDialog(
            title: const Text("Add Course Details"),
            content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: courseName,
                      decoration:
                          const InputDecoration(hintText: "Course Name"),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: coursePrice,
                      decoration:
                          const InputDecoration(hintText: "Course price"),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: courseType,
                      decoration:
                          const InputDecoration(hintText: "Course type"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        controller.pickCourseImage();
                      },
                      child: const Text("Add Image"),
                    ),
                    const SizedBox(height: 10),
                    controller.courseImage != null
                        ? Image.file(
                            controller.courseImage!,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image, size: 80, color: Colors.grey),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  final courseTitleText = courseName.text.trim();
                  final coursePriceText = coursePrice.text.trim();
                  final courseTypeText = courseType.text.trim();

                  if (courseTitleText.isNotEmpty &&
                      coursePriceText.isNotEmpty &&
                      courseTypeText.isNotEmpty &&
                      controller.courseImage != null) {
                    final success = await controller.addPopularCourse(
                      courseTitleText,
                      coursePriceText,
                      courseTypeText,
                    );
                    if (success) {
                      Get.back();
                    }
                  } else {
                    Get.snackbar(
                        "Error", "Please fill all fields and add an image.");
                  }
                },
                child: const Text("Add"),
              ),
            ],
          );
        },
      ),
    );
  }
}
