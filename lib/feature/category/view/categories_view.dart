import 'package:edu_bridge_app/core/export.dart';
import 'package:edu_bridge_app/core/utils/user_profile_utils.dart';
import 'package:edu_bridge_app/feature/category/widget/add_category_dialog.dart';
import 'package:edu_bridge_app/feature/category/widget/category_grid_item.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  late bool isAdmin = false;
  final UserProfileController userController =
      Get.find<UserProfileController>();

  @override
  void initState() {
    super.initState();
    UserProfileUtils.fetchProfileData(userController).then((_) {
      setState(() {
        isAdmin = userController.isAdmin;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        return CustomScaffold(
          name: "All Categories",
          floatingActionButton: isAdmin
              ? OutlinedButton(
                  onPressed: () {
                    Get.dialog(AddCategoryDialog());
                  },
                  child: const Icon(Icons.add),
                )
              : null,
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
                        category: controller.categories[index],
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
