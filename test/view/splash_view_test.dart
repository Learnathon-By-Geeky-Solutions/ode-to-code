import 'dart:io';

import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
  });

  Widget createTestWidget(Widget child) {
    return GetMaterialApp(
      home: child,
    );
  }

  testWidgets('SplashView displays logo and FadeTransition', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const SplashView()));

    expect(find.byType(FadeTransition), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byWidgetPredicate(
          (widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == AssetsPath.appLogo2,
    ), findsOneWidget);
  });

  testWidgets('SplashView does not navigate automatically in test mode', (WidgetTester tester) async {
    // Temporarily simulate test mode for Platform.environment
    final originalEnv = Platform.environment;
    await tester.pumpWidget(createTestWidget(const SplashView()));
    await tester.pump(const Duration(seconds: 4)); // simulate time passage

    // Since we're in test mode, it should not navigate
    // So the SplashView should still be in the widget tree
    expect(find.byType(SplashView), findsOneWidget);
  });
}
