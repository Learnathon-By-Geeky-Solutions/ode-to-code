import 'package:edu_bridge_app/core/export.dart'; // Adjust the import based on your project structure
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/mock_in_app.dart';

void main() {
  // Mocking platform-specific code for in-app webview and YouTubePlayer
  setUpAll(() {
    // Mocking the in-app webview platform for testing
    InAppWebViewPlatform.instance =
        MockInAppWebViewPlatform(); // Mock class that you'll need to define

    // Initialize GetX for widget testing
    Get.testMode = true;
    Get.put(ThemeController()); // Put ThemeController if needed
  });

  // Set up a test group
  group('ReusableContentView Widget Test', () {
    late Future<void> Function(String id) fetchContents;
    late List<dynamic> Function() getContents;
    late bool Function() isLoading;
    late Future<bool> Function(String id, String number, String title,
        {String? link, String? note}) addContent;

    setUp(() {
      // Mock the functions to provide dummy data
      fetchContents = (String id) async {};
      getContents = () => [
            ContentModel(
                name: 'Content 1',
                number: '1',
                note: 'This is content 1',
                chaptersId: "test 1",
                id: '11', // id as a string
                link: "xyx",
                createdAt: ""),
            ContentModel(
                name: 'Content 2',
                number: '2',
                note: 'This is content 2',
                chaptersId: "test 1",
                id: '12', // id as a string
                link: "xyx",
                createdAt: ""),
          ];

      isLoading = () => false; // Simulate not loading state
      addContent = (id, number, title, {link, note}) async => true;
    });

    testWidgets('should show loading indicator when loading is true',
        (WidgetTester tester) async {
      // Mock loading state
      isLoading = () => true;

      // Build the widget for testing
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: ReusableContentView(
              title: 'Test Title',
              id: '1',
              fetchContents: fetchContents,
              getContents: getContents,
              isLoading: isLoading,
              addContent: addContent,
            ),
          ),
        ),
      );

      // Verify that the loading indicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show no content message when contents list is empty',
        (WidgetTester tester) async {
      // Mock empty content list
      getContents = () => [];

      // Build the widget for testing
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: ReusableContentView(
              title: 'Test Title',
              id: '1',
              fetchContents: fetchContents,
              getContents: getContents,
              isLoading: isLoading,
              addContent: addContent,
            ),
          ),
        ),
      );

      // Verify the "no content available" message is displayed
      expect(find.text('no_content_available'.tr), findsOneWidget);
    });

    testWidgets('should display content list when content is available',
        (WidgetTester tester) async {
      // Build the widget for testing with mock content
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: ReusableContentView(
              title: 'Test Title',
              id: '1',
              fetchContents: fetchContents,
              getContents: getContents,
              isLoading: isLoading,
              addContent: addContent,
            ),
          ),
        ),
      );

      // Verify that content items are displayed
      expect(find.byType(ContentCard),
          findsNWidgets(2)); // Assuming we have 2 items in getContents
    });
  });
}
