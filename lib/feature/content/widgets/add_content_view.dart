import 'package:edu_bridge_app/core/resources/export.dart';

class AddContentView extends StatefulWidget {
  final String id;
  final Future<bool> Function(
    String id,
    String number,
    String title, {
    String? link,
    String? note,
  }) addContent;
  final Future<void> Function(String id) fetchContents;

  const AddContentView({
    super.key,
    required this.id,
    required this.addContent,
    required this.fetchContents,
  });

  @override
  State<AddContentView> createState() => _AddContentScreenState();
}

class _AddContentScreenState extends State<AddContentView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController numberController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    numberController.dispose();
    titleController.dispose();
    linkController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void _submit() async {
    final currentTab = _tabController.index;
    final isNote = currentTab == 1;
    final number = numberController.text.trim();
    final title = titleController.text.trim();
    final link = linkController.text.trim();
    final note = noteController.text.trim();

    if (number.isEmpty || title.isEmpty || (!isNote && link.isEmpty)) {
      SnackBarUtil.showError(
        "Error",
        "Please fill all fields",
      );
      return;
    }

    final success = await widget.addContent(
      widget.id,
      number,
      title,
      link: isNote ? null : link,
      note: isNote ? note : null,
    );

    if (success) {
      await widget.fetchContents(widget.id);
      Get.back();
      SnackBarUtil.showSuccess(
        "Success",
        "Content added successfully",
      );
    } else {
      SnackBarUtil.showError(
        "Error",
        "Failed to add content",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'add_content'.tr),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          indicatorColor: Colors.greenAccent,
          dividerColor: Colors.grey,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
          tabs: const [
            Tab(text: "Video"),
            Tab(text: "Note"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildContentForm(isNote: false),
          _buildContentForm(isNote: true),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submit,
        icon: const Icon(Icons.check_circle_outline),
        label: CustomText(text: 'submit'.tr),
        backgroundColor: Colors.teal,
      ),
    );
  }

  // Common method to build content form
  Widget _buildContentForm({required bool isNote}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildTextField(
                    controller: numberController,
                    label: "Number",
                    keyboardType: TextInputType.number),
                const SizedBox(height: 16),
                _buildTextField(
                    controller: titleController,
                    label: isNote ? "Note Title" : "Video Title"),
                const SizedBox(height: 16),
                isNote
                    ? _buildTextField(
                        controller: noteController,
                        label: "Note (Optional)",
                        maxLines: 8)
                    : _buildTextField(
                        controller: linkController,
                        label: "YouTube/Content Link",
                        keyboardType: TextInputType.url),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Common method to build text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    int? maxLines,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}
