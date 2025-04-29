import 'package:edu_bridge_app/core/export.dart'; // Adjust the path
import 'package:flutter_test/flutter_test.dart';

// Mock for BannerController
class MockBannerController extends GetxController implements BannerController {
  @override
  File? bannerImage;

  bool pickBannerImageCalled = false;

  @override
  void pickBannerImage() {
    pickBannerImageCalled = true;
  }

  @override
  Future<bool> addBanner(String details) {
    throw UnimplementedError();
  }

  @override
  List<BannerModel> get banners => throw UnimplementedError();

  @override
  void clearFields() {}

  @override
  String? get errorMessage => throw UnimplementedError();

  @override
  Future<void> fetchBanners() {
    throw UnimplementedError();
  }

  @override
  bool get inProgress => throw UnimplementedError();
}

void main() {
  late MockBannerController mockController;
  late TextEditingController textController;

  setUp(() {
    mockController = MockBannerController();
    textController = TextEditingController();
  });

  testWidgets('renders form and triggers image picker on button press',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: AddBannerForm(
            bannerTitleController: textController,
            controller: mockController,
          ),
        ),
      ),
    );

    // Check for TextField and Button
    expect(find.byType(CustomTextFormField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('add_image'),
        findsOneWidget); // Assuming no translation applied in test

    // Initially, should show "no_image_selected"
    expect(find.text('no_image_selected'), findsOneWidget);

    // Tap the add image button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Check if the image picker method was called
    expect(mockController.pickBannerImageCalled, isTrue);
  });

  testWidgets('displays selected image if bannerImage is not null',
      (WidgetTester tester) async {
    // Provide a dummy File object
    mockController.bannerImage = File('dummy/path/to/image.png');

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: AddBannerForm(
            bannerTitleController: textController,
            controller: mockController,
          ),
        ),
      ),
    );

    // Check that the image widget is present instead of 'no_image_selected'
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('no_image_selected'), findsNothing);
  });
}
