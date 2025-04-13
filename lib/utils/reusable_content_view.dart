import 'package:edu_bridge_app/data/models/content_model.dart';
import 'package:edu_bridge_app/data/models/popular_course_content_model.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/home/content/add_content_view/add_content_view.dart';
import 'package:edu_bridge_app/view/home/content/widget/content_card.dart';
import 'package:edu_bridge_app/view/home/content/widget/youtube_view.dart';
import 'package:edu_bridge_app/view_model/content_controller.dart';

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
      return content.title ?? 'Untitled';
    } else if (content is ContentModel) {
      return content.name ?? 'Untitled';
    }
    return content.title ?? content.name ?? 'Untitled';
  }

  @override
  Widget build(BuildContext context) {
    final contents = widget.getContents();
    final loading = widget.isLoading();

    return CustomScaffold(
      name: widget.title,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : contents.isEmpty
              ? const Center(child: Text("No content available"))
              : ListView.builder(
                  itemCount: contents.length,
                  itemBuilder: (context, index) {
                    final content = contents[index];
                    final title = _getContentTitle(content);
                    final link = content.link ?? '';
                    final number = content.number ?? '';

                    return InkWell(
                      onTap: () => link.isNotEmpty
                          ? Get.to(
                              () => YouTubePlayerView(link: link, title: title))
                          : null,
                      child: ContentCard(
                        number: number,
                        title: title,
                        link: link,
                        note: content.note ?? '',
                      ),
                    );
                  },
                ),
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
