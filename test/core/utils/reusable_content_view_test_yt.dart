import 'package:edu_bridge_app/core/resources/export.dart'; // Adjust the import based on your project structure
import 'package:flutter_test/flutter_test.dart';

void main() {
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
                id: '11',
                link: "xyx",
                createdAt: ""),
            ContentModel(
                name: 'Content 2',
                number: '2',
                note: 'This is content 2',
                chaptersId: "test 1",
                id: '12',
                link: "xyx",
                createdAt: ""),
          ];

      isLoading = () => false; // Simulate not loading state
      addContent = (id, number, title, {link, note}) async => true;

      // Initialize GetX for widget testing
      Get.testMode = true;
      Get.put(ThemeController()); // Put ThemeController if needed
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

    testWidgets('should navigate to AddContentView when FAB is tapped',
        (WidgetTester tester) async {
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

      // Find the floating action button
      final fab = find.byType(FloatingActionButton);

      // Tap the FAB to navigate
      await tester.tap(fab);
      await tester.pumpAndSettle(); // Wait for the navigation to complete

      // Verify that the AddContentView is displayed
      expect(find.byType(AddContentView), findsOneWidget);
    });
  });
}
