import 'package:edu_bridge_app/core/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Set up test with a simple font or system font
  setUpAll(() {
    // You can override font loading here or mock font loading behavior
  });

  group('AppThemes', () {
    testWidgets('should have correct light theme primary color',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppThemes.lightTheme,
        home: const Scaffold(),
      ));

      expect(AppThemes.lightTheme.primaryColor, AppColors.primary);
    });

    testWidgets('should have correct light theme secondary color',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppThemes.lightTheme,
        home: const Scaffold(),
      ));

      expect(AppThemes.lightTheme.colorScheme.secondary, AppColors.secondary);
    });

    testWidgets('should have correct light theme background color',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppThemes.lightTheme,
        home: const Scaffold(),
      ));

      expect(AppThemes.lightTheme.colorScheme.surface, AppColors.background);
    });

    testWidgets('should have correct dark theme primary color',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppThemes.darkTheme,
        home: const Scaffold(),
      ));

      expect(AppThemes.darkTheme.primaryColor, AppColors.darkPrimary);
    });

    testWidgets('should have correct dark theme secondary color',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppThemes.darkTheme,
        home: const Scaffold(),
      ));

      expect(
          AppThemes.darkTheme.colorScheme.secondary, AppColors.darkSecondary);
    });

    // More tests for other theme properties...
  });
}
