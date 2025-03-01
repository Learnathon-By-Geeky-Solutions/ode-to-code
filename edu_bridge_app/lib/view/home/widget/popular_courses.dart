import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/home/popular_courses/popular_courses_view.dart';

class PopularCourses extends StatelessWidget {
  const PopularCourses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.9.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Popular Course",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => PopularCoursesView());
                  },
                  child: CustomText(
                    text: "SEE ALL",
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
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    color: AppColors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: "Graphic Design",
                                      color: AppColors.orange,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Icon(Icons.bookmark_border)
                                  ],
                                ),
                                CustomText(
                                  text: "Graphic Design Advanced",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                      text: "Price : 850/-",
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
