import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/feature/content_5/view/note_details_view.dart';
import 'package:edu_bridge_app/feature/user_saved_item/model/user_saved_item_model.dart';

class ReusableContentView extends StatefulWidget {
  final String title;
  final String id;
  final Future<void> Function(String id) fetchContents;
  final List<dynamic> Function() getContents;
  final bool Function() isLoading;
  final Future<bool> Function(
      String id,
      String number,
      String title, {
      String? link,
      String? note,
      }) addContent;
  final bool forceShowAddButton;

  const ReusableContentView({
    super.key,
    required this.title,
    required this.id,
    required this.fetchContents,
    required this.getContents,
    required this.isLoading,
    required this.addContent,
    this.forceShowAddButton = true,
  });

  @override
  State<ReusableContentView> createState() => _ReusableContentViewState();
}

class _ReusableContentViewState extends State<ReusableContentView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.fetchContents(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final contents = widget.getContents();
    final loading = widget.isLoading();

    return CustomScaffold(
      name: widget.title,
      body: _buildContentBody(loading, contents),
      floatingActionButton:
      _shouldShowFAB(contents) ? _buildFloatingActionButton() : null,
    );
  }

  Widget _buildContentBody(bool loading, List<dynamic> contents) {
    if (loading) return const Center(child: CircularProgressIndicator());
    if (contents.isEmpty) {
      return Center(child: CustomText(text: "no_content_available".tr));
    }
    return _buildContentList(contents);
  }

  Widget _buildContentList(List<dynamic> contents) {
    return ListView.builder(
      itemCount: contents.length,
      itemBuilder: (context, index) => _buildContentTile(contents[index]),
    );
  }

  Widget _buildContentTile(dynamic content) {
    final title = _getContentTitle(content);
    final link = content.link ?? '';
    final number = content.number?.toString() ?? '';
    final note = content.note ?? '';

    return InkWell(
      onTap: () => _handleContentTap(link, title, note),
      child: ContentCard(
        number: number,
        title: title,
        link: link,
        note: note,
      ),
    );
  }

  void _handleContentTap(String link, String title, String note) {
    if (link.isNotEmpty) {
      Get.to(() => YouTubePlayerView(link: link, title: title));
    } else {
      Get.to(() => NoteDetailsView(title: title, note: note));
    }
  }

  String _getContentTitle(dynamic content) {
    if (content is PopularCourseContentModel) return content.title;
    if (content is ContentModel) return content.name;
    return content.title ?? content.name ?? 'Untitled';
  }

  bool _shouldShowFAB(List<dynamic> contents) {
    if (contents.isEmpty) return widget.forceShowAddButton;
    return contents.first is! UserSavedItemModel;
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => Get.to(() => AddContentView(
        id: widget.id,
        addContent: widget.addContent,
        fetchContents: widget.fetchContents,
      )),
      child: const Icon(Icons.add),
    );
  }
}
