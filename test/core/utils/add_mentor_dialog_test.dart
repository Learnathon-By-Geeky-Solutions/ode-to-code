
import 'package:edu_bridge_app/core/resources/export.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMentorController extends GetxController
    with Mock
    implements MentorController {}

void main() {
  late MockMentorController mockController;

  setUp(() {
    mockController = MockMentorController();
    Get.put<MentorController>(mockController);
  });

  testWidgets('AddMentorDialog renders form and calls addMentor',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockController.mentorImage).thenReturn(File('dummy.jpg'));
    when(() => mockController.pickMentorImage()).thenAnswer((_) async {});
    when(() => mockController.addMentor(any(), any(), any(), any()))
        .thenAnswer((_) async => true);

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const AddMentorDialog(),
                );
              },
              child: const Text('Open Dialog'),
            );
          }),
        ),
      ),
    );

    // Act: open the dialog
    await tester.tap(find.text('Open Dialog'));
    await tester.pumpAndSettle();

    // Fill the form
    final textFields = find.byType(TextFormField);
    expect(textFields, findsNWidgets(4));

    await tester.enterText(textFields.at(0), 'John Doe');
    await tester.enterText(textFields.at(1), 'Senior Developer');
    await tester.enterText(textFields.at(2), 'Teaches Flutter');
    await tester.enterText(textFields.at(3), '10 years of experience');

    // Tap the "Add" button
    await tester.tap(find.text('add')); // assumes localization = 'add'
    await tester.pumpAndSettle();

    // Assert
    verify(() => mockController.addMentor(
          'John Doe',
          'Senior Developer',
          'Teaches Flutter',
          '10 years of experience',
        )).called(1);
  });
}
