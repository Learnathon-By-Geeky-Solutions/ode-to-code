import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/home/categories/categories_view.dart';
import 'package:edu_bridge_app/view/home/widget/all_categories.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 14.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          const AllCategories(),
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
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
              Get.to(() => const CategoriesView());
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
    );
  }
}
