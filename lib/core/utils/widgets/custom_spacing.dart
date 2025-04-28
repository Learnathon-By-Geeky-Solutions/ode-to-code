import 'package:edu_bridge_app/core/export.dart';

class VerticalSpacing extends StatelessWidget {
  final double height;
  const VerticalSpacing(this.height, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class HorizontalSpacing extends StatelessWidget {
  final double width;
  const HorizontalSpacing(this.width, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
