import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/home/categories/categories_view.dart';
import 'package:edu_bridge_app/view/home/widget/all_categories.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(),
        const AllCategories(),
      ],
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: 'categories'.tr,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          InkWell(
            onTap: () {
              Get.to(() => const CategoriesView());
            },
            child: CustomText(
              text: 'see_all'.tr,
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
