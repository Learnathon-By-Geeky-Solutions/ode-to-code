import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view_model/test/categories_view_model.dart';

class TestCategoriesView2 extends StatelessWidget {
  const TestCategoriesView2({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller
    final CategoriesController controller = Get.put(CategoriesController());

    return CustomScaffold(
      title: "All Categories",
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          // Using Obx to reactively update the UI
          if (controller.categories.isEmpty) {
            return const Center(child: Text("No categories found"));
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 1,
              ),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => controller.navigateToView(index),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Card(
                        elevation: 3,
                        color: AppColors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.network(
                              controller.categories[index]['imageUrl']!,
                              fit: BoxFit.cover,
                              width: 107,
                              height: 72,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.categories[index]['title']!,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
      floatingActionButton: OutlinedButton(
        onPressed: controller.pickAndUploadImage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
