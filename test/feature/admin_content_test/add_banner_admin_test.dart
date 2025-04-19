import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:edu_bridge_app/feature/home/view/banner/view_model/banner_controller.dart';

void main() {
  testWidgets('AddOfferSlider opens dialog on tap',
      (WidgetTester tester) async {
    // Put dummy controller with GetX
    Get.put<BannerController>(
        BannerController(repository: DummyBannerRepository()));

    await tester.pumpWidget(
      GetMaterialApp(
        translations: DummyTranslations(),
        locale: const Locale('en'),
        home: Scaffold(
          body: Center(
            // Make sure widget is visible and centered
            child: SizedBox(
              width: 200,
              height: 200,
              child: AddOfferSlider(),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle(); // Let the widget build

    // Find the AddOfferSlider
    final addOfferFinder = find.byType(AddOfferSlider);
    expect(addOfferFinder, findsOneWidget);

    // Try tapping it
    await tester.tap(addOfferFinder);
    await tester.pumpAndSettle(); // Wait for dialog

    // Verify dialog contents
    expect(find.text('Add Banner'), findsOneWidget);
    expect(find.text('Add'), findsOneWidget);
    expect(find.text('Add Image'), findsOneWidget);
  });
}

// Dummy banner repo for mocking
class DummyBannerRepository implements IBannerRepository {
  @override
  Future<bool> addBanner(BannerModel banner) async => true;

  @override
  Future<List<BannerModel>> fetchBanners() async => [];

  @override
  Future<String?> uploadBannerImage(File image) async => "dummy_url";
}

// Dummy translations for the test
class DummyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'add_banner': 'Add Banner',
          'add_image': 'Add Image',
          'add': 'Add',
          'no_image_selected': 'No image selected',
          'insert_banner_instruction': 'Tap to insert banner',
        }
      };
}
