import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edu_bridge_app/user_main.dart' as app;

// Create a mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  // Register a fallback value for SharedPreferences mock
  setUpAll(() {
    registerFallbackValue(MockSharedPreferences());
  });

  test('App initializes without errors', () async {
    // Mock SharedPreferences.getInstance to return a mock instance
    final mockSharedPreferences = MockSharedPreferences();
    when(() => mockSharedPreferences.getString(any())).thenReturn(null);
    SharedPreferences.setMockInitialValues({});

    await app
        .initializeApp(); // Now your app should run without the MissingPluginException
  });
}
