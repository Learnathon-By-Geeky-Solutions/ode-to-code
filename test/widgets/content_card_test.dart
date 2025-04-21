import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  Widget createTestWidget(Widget child) {
    return GetMaterialApp(
      translations: TestTranslations(),
      locale: const Locale('en'),
      home: Scaffold(body: child),
    );
  }

  testWidgets('ContentCard shows title, number and link', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const ContentCard(
      number: '1',
      title: 'Intro to Biology',
      link: 'https://youtube.com/video',
    )));

    expect(find.text('1'), findsOneWidget);
    expect(find.text('Intro to Biology'), findsOneWidget);
    expect(find.text('https://youtube.com/video'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('ContentCard shows note if link is not available', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const ContentCard(
      number: '2',
      title: 'Chapter Notes',
      note: 'Detailed summary notes',
    )));

    expect(find.text('2'), findsOneWidget);
    expect(find.text('Chapter Notes'), findsOneWidget);
    expect(find.text('Detailed summary notes'), findsOneWidget);
  });

  testWidgets('ContentCard shows fallback text when neither link nor note is available',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const ContentCard(
          number: '3',
          title: 'Empty Content',
        )));

        expect(find.text('3'), findsOneWidget);
        expect(find.text('Empty Content'), findsOneWidget);
        expect(find.text('No content available'), findsOneWidget);
      });
}

// Mock translations for '.tr'
class TestTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'no_content_available': 'No content available',
    }
  };
}
