import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/add_course_dialouge.dart';

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
              CustomText(
                text: 'popular_course'.tr,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              InkWell(
                onTap: () {},
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
        InkWell(
          onTap: () {
            Get.dialog(const AddCourseDialog());
          },
          child: courseCard(),
        ),
      ],
    );
  }

  Widget courseCard() {
    return InkWell(
      onTap: () {
        Get.dialog(const AddCourseDialog());
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
                  child:
                      const Icon(Icons.add, color: AppColors.white, size: 40),
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
                          text: 'add_course_type'.tr,
                          color: AppColors.orange,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        const Icon(Icons.bookmark_border)
                      ],
                    ),
                    CustomText(
                      text: 'add_course_title'.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: 'add_price'.tr,
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
}
