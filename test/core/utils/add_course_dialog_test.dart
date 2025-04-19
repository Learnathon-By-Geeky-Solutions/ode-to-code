import 'dart:io';

import 'package:edu_bridge_app/core/resources/export.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularCourseController extends GetxController
    with Mock
    implements PopularCourseController {}

void main() {
  late MockPopularCourseController mockController;

  setUp(() {
    mockController = MockPopularCourseController();
    Get.put<PopularCourseController>(mockController);
  });

  testWidgets(
      'AddCourseDialog shows input fields and triggers addPopularCourse',
      (WidgetTester tester) async {
    // Stub the image and addPopularCourse method
    when(() => mockController.courseImage).thenReturn(File('dummy_path.jpg'));
    when(() => mockController.pickCourseImage()).thenAnswer((_) async {});
    when(() => mockController.addPopularCourse(any(), any(), any()))
        .thenAnswer((_) async => true);

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const AddCourseDialog(),
                ),
                child: const Text('Open Dialog'),
              );
            },
          ),
        ),
      ),
    );

    // Tap to open the dialog
    await tester.tap(find.text('Open Dialog'));
    await tester.pumpAndSettle();

    // Enter course data
    await tester.enterText(find.byType(TextFormField).at(0), 'Flutter Basics');
    await tester.enterText(find.byType(TextFormField).at(1), '100');
    await tester.enterText(find.byType(TextFormField).at(2), 'Beginner');

    // Tap 'Add' button
    await tester.tap(find.text('add')); // assumes localization returns 'add'
    await tester.pumpAndSettle();

    // Expect the controller method to be called
    verify(() => mockController.addPopularCourse(
        'Flutter Basics', '100', 'Beginner')).called(1);
  });
}
