import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/home/categories/categories_view.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
    required this.widgets,
  });

  final Widget widgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: "Categories",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                InkWell(
                  onTap: () {
                    Get.to(CategoriesView());
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
          Expanded(child: widgets),
        ],
      ),
    );
  }
}
