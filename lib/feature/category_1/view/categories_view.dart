import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/feature/category_1/widget/add_category_dialog.dart';
import 'package:edu_bridge_app/feature/category_1/widget/category_grid_item.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        return CustomScaffold(
          name: "All Categories",
          floatingActionButton: OutlinedButton(
            onPressed: () {
              Get.dialog( AddCategoryDialog());
            },
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: controller.inProgress
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 1,
                    ),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      return CategoryGridItem(
                          category: controller.categories[index]);
                    },
                  ),
          ),
        );
      },
    );
  }
}
