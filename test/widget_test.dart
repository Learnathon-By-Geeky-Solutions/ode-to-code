import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edu_bridge_app/user_main.dart'
    as app; // Adjust according to your import path
import 'package:edu_bridge_app/user_app.dart';

// Create a mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  // Initialize mocks before tests
  setUpAll(() {
    // Register SharedPreferences mock
    registerFallbackValue(MockSharedPreferences());
  });

  // Set up mock SharedPreferences before each test
  setUp(() {
    final mockPrefs = MockSharedPreferences();
    // Mock the behavior of SharedPreferences.getInstance
    when(() => mockPrefs.getString(any())).thenReturn(null); // Adjust as needed
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('App launches and shows home screen widget',
      (WidgetTester tester) async {
    // Run the app and test the widget
    await tester.pumpWidget(const EduBridgeUser());
    expect(find.byType(EduBridgeUser), findsOneWidget);
  });

  test('App initializes without errors', () async {
    // Test your initialization logic
    await app.initializeApp();
  });
}
