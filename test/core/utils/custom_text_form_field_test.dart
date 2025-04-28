import 'package:edu_bridge_app/core/export.dart'; // Make sure this imports your app's resources
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomTextFormField displays label text correctly',
      (WidgetTester tester) async {
    const labelText = 'Email';

    // Build the widget
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CustomTextFormField(labelText: labelText),
      ),
    ));

    // Verify the label text
    expect(find.text(labelText), findsOneWidget);
  });

  testWidgets('CustomTextFormField shows prefix and suffix icons',
      (WidgetTester tester) async {
    const labelText = 'Password';
    const prefixIcon = Icons.email;
    const suffixIcon = Icons.visibility;

    // Build the widget
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CustomTextFormField(
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    ));

    // Verify that the prefix and suffix icons are shown
    expect(find.byIcon(prefixIcon), findsOneWidget);
    expect(find.byIcon(suffixIcon), findsOneWidget);
  });

  testWidgets('CustomTextFormField calls validator when invalid input',
      (WidgetTester tester) async {
    final controller = TextEditingController();
    const labelText = 'Email';
    String? validator(String? value) {
      if (value == null || value.isEmpty) {
        return 'This field cannot be empty';
      }
      return null;
    }

    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Form(
          // Add the Form widget
          child: CustomTextFormField(
            labelText: labelText,
            controller: controller,
            validator: validator,
          ),
        ),
      ),
    ));

    // Simulate invalid input (empty text)
    await tester.enterText(find.byType(TextFormField), '');
    await tester.pump();

    // Trigger form validation
    final form = tester.state(find.byType(Form)) as FormState;
    expect(
        form.validate(), false); // Ensure validation is false for invalid input
  });

  testWidgets('CustomTextFormField shows correct text from controller',
      (WidgetTester tester) async {
    final controller = TextEditingController(text: 'test@example.com');
    const labelText = 'Email';

    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextFormField(
          labelText: labelText,
          controller: controller,
        ),
      ),
    ));

    // Verify that the text in the controller is shown
    expect(find.text('test@example.com'), findsOneWidget);
  });

  testWidgets('CustomTextFormField disables the field when enabled is false',
      (WidgetTester tester) async {
    const labelText = 'Email';

    // Build the widget
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CustomTextFormField(
          labelText: labelText,
          enabled: false,
        ),
      ),
    ));

    // Find the TextFormField widget and verify it is disabled
    final textFormField =
        tester.widget<TextFormField>(find.byType(TextFormField));
    expect(textFormField.enabled, false);
  });

  testWidgets('CustomTextFormField can trigger onTap',
      (WidgetTester tester) async {
    bool onTapCalled = false;

    const labelText = 'Email';

    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextFormField(
          labelText: labelText,
          onTap: () {
            onTapCalled = true;
          },
        ),
      ),
    ));

    // Simulate tapping the field
    await tester.tap(find.byType(TextFormField));
    await tester.pump();

    // Verify the onTap callback was triggered
    expect(onTapCalled, true);
  });
}
