import 'package:flutter_test/flutter_test.dart';
import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sizer/sizer.dart';

// Mock class for LocalizationController
class MockLocalizationController extends Mock
    implements LocalizationController {}

void main() {
  group('LanguageSwitch Widget', () {
    late MockLocalizationController mockLocalizationController;

    setUp(() {
      // Initialize the mock controller
      mockLocalizationController = MockLocalizationController();

      // Initialize GetX and register the mock controller
      Get.testMode = true;
      Get.put<LocalizationController>(mockLocalizationController);
    });

    tearDown(() {
      // Clean up GetX after each test
      Get.reset();
    });

    testWidgets('should show language options and switch language on selection',
        (tester) async {
      // Initialize Sizer for proper widget sizing
      await tester.pumpWidget(
        Sizer(
          builder: (context, orientation, deviceType) => MaterialApp(
            home: Scaffold(
              body: LanguageSwitch(),
            ),
          ),
        ),
      );

      // Verify that the dropdown button is visible
      expect(find.byType(DropdownButton<String>), findsOneWidget);

      // Verify the initial value is 'en' (English)
      expect(find.text('English'), findsOneWidget);
      expect(find.text('বাংলা'), findsOneWidget);

      // Tap to open the dropdown
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      // Simulate selecting the 'বাংলা' option
      await tester.tap(find.text('বাংলা').last);
      await tester.pumpAndSettle();

      // Verify that the changeLocale method was called with 'bn' as the argument
      verify(() => mockLocalizationController.changeLocale('bn')).called(1);
    });
  });
}
