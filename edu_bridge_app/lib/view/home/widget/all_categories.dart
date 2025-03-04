import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view_model/category_controller.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        if (controller.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.categories.isEmpty) {
          return const Center(
            child: Text(
              'No categories available',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: 6.h,
            child: ListView.builder(
              itemCount: controller.categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Image.network(
                    controller.categories[index].imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
