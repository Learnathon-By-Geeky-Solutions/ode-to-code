import 'package:edu_bridge_app/core/utils/centered_app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sizer/sizer.dart';

void main() {
  testWidgets('CenteredAppLogo renders with default spacing',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Sizer(
        builder: (context, orientation, deviceType) {
          return const MaterialApp(
            home: Scaffold(
              body: CenteredAppLogo(),
            ),
          );
        },
      ),
    );

    await tester.pumpAndSettle(); // let animations/layouts complete

    expect(find.byType(Image), findsOneWidget); // check that the logo renders
  });
}
