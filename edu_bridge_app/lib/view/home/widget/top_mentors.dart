import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/home/top_mentors/top_mentors_view.dart';

class TopMentorSection extends StatelessWidget {
  const TopMentorSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 14.0.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: "Top Mentor",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => TopMentorsView());
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
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 80,
                    height: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
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
