import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edu_bridge_app/user_main.dart'
    as app; // Adjust according to your import path
import 'package:edu_bridge_app/user_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Create a mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({}); // 🔧 must come first

    await Supabase.initialize(
      url: 'https://dummy.supabase.co',
      anonKey: 'dummy-anon-key',
    );
  });

  testWidgets('App launches and shows home screen widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EduBridgeUser()));
    await tester.pump();

    expect(find.byType(EduBridgeUser), findsOneWidget);
  });
}
