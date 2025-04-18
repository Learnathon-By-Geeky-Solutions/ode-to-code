import 'package:edu_bridge_app/core/resources/export.dart';

class CategoryGridItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryGridItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ClassView(
              categoryId: category.id.toString(),
              className: category.categoryName,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Card(
            elevation: 3,
            color: AppColors.white,
            child: Center(
              child: Image.network(
                category.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
