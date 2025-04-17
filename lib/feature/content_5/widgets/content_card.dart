import 'package:edu_bridge_app/core/resources/export.dart';

class ContentCard extends StatelessWidget {
  final String number;
  final String title;
  final String? link;
  final String? note;
  const ContentCard({
    super.key,
    required this.number,
    required this.title,
    this.link,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    final hasLink = link?.isNotEmpty == true;
    final hasNote = note?.isNotEmpty == true;

    String content;
    if (hasLink) {
      content = link!;
    } else if (hasNote) {
      content = note!;
    } else {
      content = 'No content available';
    }

    final Widget iconWidget;
    if (hasLink) {
      iconWidget = Image.asset(
        AssetsPath.videPlayIcon,
        height: 28,
        width: 28,
      );
    } else if (hasNote) {
      iconWidget = Image.asset(
        AssetsPath.noteIcon,
        height: 28,
        width: 28,
      );
    } else {
      iconWidget = Image.asset(
        AssetsPath.videPlayIcon,
        height: 28,
        width: 28,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text(
                  number,
                  style: GoogleFonts.mulish(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.orange,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.mulish(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (content.isNotEmpty)
                      Text(
                        content,
                        style: GoogleFonts.mulish(
                          color: AppColors.blackGray,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
              iconWidget,
            ],
          ),
        ),
      ),
    );
  }
}
