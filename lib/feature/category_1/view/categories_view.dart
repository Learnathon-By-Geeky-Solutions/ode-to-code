import 'package:edu_bridge_app/core/resources/export.dart';

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
            onPressed: showAddCategoryDialog,
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
                      return InkWell(
                        onTap: () {
                          Get.to(
                            () => ClassView(
                              categoryId:
                                  controller.categories[index].id.toString(),
                              className:
                                  controller.categories[index].categoryName,
                            ),
                          );
                          print(controller.categories[index].id.toString());
                          print(controller.categories[index].categoryName);
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
                                  controller.categories[index].imageUrl,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  void showAddCategoryDialog() {
    final TextEditingController categoryNameController =
        TextEditingController();

    Get.dialog(
      GetBuilder<CategoryController>(
        builder: (controller) {
          return AlertDialog(
            title: CustomText(text: 'add_categories'.tr),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: categoryNameController,
                    decoration:
                        const InputDecoration(hintText: "Enter Category name"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: controller.pickCategoryImage,
                    child: CustomText(text: 'add_image'.tr),
                  ),
                  const SizedBox(height: 10),
                  if (controller.categoryImage != null)
                    Image.file(
                      controller.categoryImage!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  bool success =
                      await controller.addCategory(categoryNameController.text);
                  if (success) {
                    Get.back();
                  }
                },
                child: CustomText(text: 'add'.tr),
              ),
            ],
          );
        },
      ),
    );
  }
}
