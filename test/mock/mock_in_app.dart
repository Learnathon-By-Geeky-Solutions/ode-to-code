import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MockInAppWebViewPlatform extends InAppWebViewPlatform {
  Future<void> initialize() async {
  }

  Future<void> create(
      {required String id,
        required String url,
        required String userAgent,
        required bool isInApp}) async {
    // Mock any platform method logic if needed
  }

}
