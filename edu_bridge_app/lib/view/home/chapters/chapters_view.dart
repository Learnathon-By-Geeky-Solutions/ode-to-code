import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';

class ChaptersView extends StatefulWidget {
  final String subject;

  const ChaptersView({super.key, required this.subject});

  @override
  State<ChaptersView> createState() => _ChaptersViewState();
}

class _ChaptersViewState extends State<ChaptersView> {
  final List<String> chapters = [];

  void _addChapter(String chapterName) {
    setState(() {
      chapters.add(chapterName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Chapters for ${widget.subject}",
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 4,
              ),
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                return buildContainer(chapters[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddChapterDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddChapterDialog() {
    TextEditingController chapterController = TextEditingController();
    Get.defaultDialog(
      title: "Add New Chapter",
      content: TextField(
        controller: chapterController,
        decoration: const InputDecoration(
          hintText: "Enter chapter name",
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (chapterController.text.trim().isNotEmpty) {
            _addChapter(chapterController.text.trim());
            Get.back();
          }
        },
        child: const Text("Add"),
      ),
    );
  }

  Widget buildContainer(String chapter) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.green,
      ),
      child: Center(
        child: CustomText(
          text: chapter,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
