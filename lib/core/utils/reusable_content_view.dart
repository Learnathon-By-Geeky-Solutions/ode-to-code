import 'package:edu_bridge_app/core/resources/export.dart';

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

  const ReusableContentView({
    super.key,
    required this.title,
    required this.id,
    required this.fetchContents,
    required this.getContents,
    required this.isLoading,
    required this.addContent,
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

  String _getContentTitle(dynamic content) {
    if (content is PopularCourseContentModel) {
      return content.title;
    } else if (content is ContentModel) {
      return content.name;
    }
    return content.title ?? content.name ?? 'Untitled';
  }

  @override
  Widget build(BuildContext context) {
    final contents = widget.getContents();
    final loading = widget.isLoading();

    Widget bodyContent;
    if (loading) {
      bodyContent = const Center(child: CircularProgressIndicator());
    } else if (contents.isEmpty) {
      bodyContent = Center(child: CustomText(text: "no_content_available".tr));
    } else {
      bodyContent = ListView.builder(
        itemCount: contents.length,
        itemBuilder: (context, index) {
          final content = contents[index];
          final title = _getContentTitle(content);
          final link = content.link ?? '';
          final number = content.number ?? '';
          return InkWell(
            onTap: () => link.isNotEmpty
                ? Get.to(() => YouTubePlayerView(link: link, title: title))
                : null,
            child: ContentCard(
              number: number,
              title: title,
              link: link,
              note: content.note ?? '',
            ),
          );
        },
      );
    }

    return CustomScaffold(
      name: widget.title,
      body: bodyContent,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddContentView(
              id: widget.id,
              addContent: widget.addContent,
              fetchContents: widget.fetchContents,
            )),
        child: const Icon(Icons.add),
      ),
    );
  }
}
