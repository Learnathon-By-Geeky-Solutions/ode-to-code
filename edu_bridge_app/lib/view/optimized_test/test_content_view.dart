import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/test/web/webview.dart';
import 'package:edu_bridge_app/view_model/test/content_view_model.dart';

class TestContentView extends StatelessWidget {
  final String categoryId;
  final String classId;
  final String chapterId;
  final String chapterTitle;

  const TestContentView({
    required this.categoryId,
    required this.classId,
    required this.chapterId,
    required this.chapterTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final ContentController controller = Get.put(
      ContentController(
        categoryId: categoryId,
        classId: classId,
        chapterId: chapterId,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(chapterTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchContents,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.isError.value) {
          return const Center(child: Text("Error fetching contents"));
        } else if (controller.contents.isEmpty) {
          return const Center(child: Text("No contents available"));
        } else {
          return ListView.builder(
            itemCount: controller.contents.length,
            itemBuilder: (context, index) {
              final content = controller.contents[index];
              return InkWell(
                onTap: () {
                  Get.to(() => WebViewScreen(link: content['body'] ?? ''));
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text(content['title'] ?? ''),
                    subtitle: Text(content['body'] ?? ''),
                  ),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(AlertDialog(
            title: const Text("Add Content"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller.contentTitleController,
                  decoration: const InputDecoration(hintText: "Enter title"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller.contentBodyController,
                  decoration: const InputDecoration(hintText: "Enter content"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  controller.addContent();
                },
                child: const Text("Add"),
              ),
            ],
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
