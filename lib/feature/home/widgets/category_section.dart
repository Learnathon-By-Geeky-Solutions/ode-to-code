import 'package:edu_bridge_app/core/resources/export.dart';

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
