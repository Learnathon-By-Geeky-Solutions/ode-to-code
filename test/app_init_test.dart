import 'package:edu_bridge_app/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  setUpAll(() {
    registerFallbackValue(MockSharedPreferences());
  });

  test('App initializes without errors', () async {
    final mockSharedPreferences = MockSharedPreferences();
    when(() => mockSharedPreferences.getString(any())).thenReturn(null);
    SharedPreferences.setMockInitialValues({});
    await app.initializeApp();
  });
}
