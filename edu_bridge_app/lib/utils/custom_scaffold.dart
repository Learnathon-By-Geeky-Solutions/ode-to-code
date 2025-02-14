import 'package:edu_bridge_app/resources/export.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions; // New actions parameter

  const CustomScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF5F9FF),
        title: CustomText(
          text: title,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        actions: actions, // Pass the actions list here
      ),
      backgroundColor: Color(0xffF5F9FF),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
