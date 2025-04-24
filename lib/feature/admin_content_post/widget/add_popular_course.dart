import 'package:edu_bridge_app/core/resources/export.dart';

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
        const CustomText(
          text: "Add Course Here",
          fontSize: 22,
        ),
        SizedBox(height: 2.h),
        _buildInkWell(courseCard),
      ],
    );
  }

  // A helper method to create InkWell widgets.
  Widget _buildInkWell(Widget Function() childWidget) {
    return InkWell(
      onTap: () {
        Get.dialog(const AddCourseDialog());
      },
      child: childWidget(),
    );
  }

  // Reusable method for creating CustomText widgets
  Widget _buildCustomText(String text, {Color? color, double fontSize = 18}) {
    return CustomText(
      text: text,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      color: color ?? Colors.black,
    );
  }

  Widget courseCard() {
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
                child: const Icon(Icons.add, color: AppColors.white, size: 40),
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
                      _buildCustomText('add_course_type'.tr,
                          color: AppColors.orange, fontSize: 12),
                      const Icon(Icons.bookmark_border)
                    ],
                  ),
                  _buildCustomText('add_course_title'.tr, fontSize: 16),
                  Row(
                    children: [
                      _buildCustomText(
                        'add_price'.tr,
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
    );
  }
}
