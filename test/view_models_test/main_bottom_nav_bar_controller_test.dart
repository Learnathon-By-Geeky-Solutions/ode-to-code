import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MainBottomNavBarController Test', () {
    late MainBottomNavBarController controller;

    setUp(() {
      controller = MainBottomNavBarController();
    });

    test('Initial selectedIndex should be 0', () {
      expect(controller.selectedIndex, 0);
    });

    test('changeIndex should update selectedIndex', () {
      controller.changeIndex(2);
      expect(controller.selectedIndex, 2);
    });
  });
}
