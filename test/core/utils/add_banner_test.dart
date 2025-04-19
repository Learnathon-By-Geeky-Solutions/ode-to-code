import 'package:edu_bridge_app/core/resources/export.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBannerController extends Mock implements BannerController {}

void main() {
  late MockBannerController mockController;

  setUp(() {
    mockController = MockBannerController();
  });

  testWidgets(
      'renders form with text field and button, shows no image selected text',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        translations: TestTranslations(),
        locale: const Locale('en'),
        home: Scaffold(
          body: AddBannerForm(
            bannerTitleController: TextEditingController(),
            controller: mockController,
          ),
        ),
      ),
    );

    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('Add Image'), findsOneWidget); // From translation
    expect(find.text('No image selected'), findsOneWidget); // From translation
  });

  testWidgets('calls pickBannerImage when button is tapped',
      (WidgetTester tester) async {
    when(() => mockController.bannerImage).thenReturn(null);
    when(() => mockController.pickBannerImage()).thenReturn(null);

    await tester.pumpWidget(
      GetMaterialApp(
        translations: TestTranslations(),
        locale: const Locale('en'),
        home: Scaffold(
          body: AddBannerForm(
            bannerTitleController: TextEditingController(),
            controller: mockController,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    verify(() => mockController.pickBannerImage()).called(1);
  });

  testWidgets('shows image when bannerImage is not null',
      (WidgetTester tester) async {
    final fakeImage = File('test/assets/sample.jpg'); // Simulate image file
    when(() => mockController.bannerImage).thenReturn(fakeImage);

    await tester.pumpWidget(
      GetMaterialApp(
        translations: TestTranslations(),
        locale: const Locale('en'),
        home: Scaffold(
          body: AddBannerForm(
            bannerTitleController: TextEditingController(),
            controller: mockController,
          ),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });
}

// Mocks translations
class TestTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'add_image': 'Add Image',
          'no_image_selected': 'No image selected',
        },
      };
}
